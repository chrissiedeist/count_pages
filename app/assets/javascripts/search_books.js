$(document).ready(function () {
    $("#txtBookSearch").autocomplete({ 
        // define source of the data
        source: function (request, response) {
            // url link to google books, including text entered by user (request.term)
            var booksUrl = "https://www.googleapis.com/books/v1/volumes?printType=books&q=" + encodeURIComponent(request.term);
            $.ajax({
                url: booksUrl,
                dataType: "jsonp",
                success: function(data) {
                    response($.map(data.items, function (item) {
                        if (item.volumeInfo.authors && item.volumeInfo.title && item.volumeInfo.industryIdentifiers && item.volumeInfo.publishedDate)
                        {
                            return {
                                // label value will be shown in the suggestions
                                label: item.volumeInfo.title + ', ' + item.volumeInfo.authors[0] + ', ' + item.volumeInfo.publishedDate,
                                // value is what gets put in the textbox once an item selected
                                value: item.volumeInfo.title,
                                // other individual values to use later
                                title: item.volumeInfo.title,
                                author: item.volumeInfo.authors[0],
                                isbn: item.volumeInfo.industryIdentifiers,
                                publishedDate: item.volumeInfo.publishedDate,
                                image: (item.volumeInfo.imageLinks == null ? "" : item.volumeInfo.imageLinks.thumbnail),
                                description: item.volumeInfo.description,
                                pageCount: item.volumeInfo.pageCount,
                            };
                        }
                    }));
                }
            });
        },
        select: function (event, ui) {
            $('#divDescription').empty();

            $('#divDescription').append('<p><b>Title:</b> ' + ui.item.title  + '</p>');
            $('#divDescription').append('<p><b>Author:</b> ' + ui.item.author  + '</p>');
            $('#divDescription').append('<p><b>First published year:</b> ' + ui.item.publishedDate  + '</p>');          
            $('#divDescription').append('<p><b>Page count:</b> ' + ui.item.pageCount  + '</p>');          
            $('#divDescription').append('<p><b>Description:</b> ' + ui.item.description  + '</p>');

            $('#book_title').val(ui.item.title);
            $('#book_num_pages').val(ui.item.pageCount);
            $('#book_author').val(ui.item.author);

            if (ui.item.isbn && ui.item.isbn[0].identifier)
            {
                $('#divDescription').append('<P><b>ISBN:</b> ' + ui.item.isbn[0].identifier + '</p>');
                $('#divDescription').append('<a href="http://www.worldcat.org/isbn/' + ui.item.isbn[0].identifier + '" target="_blank">View item on worldcat</a>');
                $('#book_isbn').val(ui.item.isbn[0].identifier);
            }
        },
        minLength: 2 // set minimum length of text the user must enter
    });
});
