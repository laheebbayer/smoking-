<?php

if ($_SERVER['REQUEST_METHOD']== 'POST'){

    $postIdForTotalComments=$_POST['post_id'];

    // Add config file
    require_once 'config.php';

    $tempData = array();
    $tempData2 = array();
    //sleep(0.5);
    $sql = "SELECT 
    COUNT(comments.post_id) AS Total_comments
    FROM posts
    LEFT JOIN comments ON posts.post_id = comments.post_id
    WHERE posts.post_id=".$postIdForTotalComments."
    GROUP BY posts.post_id";
    $result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
  // output data of each row
    while($row = mysqli_fetch_assoc($result)) {
        $tempData  = $row["Total_comments"];
        }
} else {
    $tempData = array();
}

    // http_response_code(200);
    // header('Content-Type:application/json');
    // //echo json_encode($tempData);
    // echo $tempData;
    $sql2="UPDATE posts
    SET total_comments = '".$tempData."'
    WHERE posts.post_id = ".$postIdForTotalComments."";
    $result2 = mysqli_query($conn, $sql2);

    
        http_response_code(200);
        header('Content-Type:application/json');
        echo '{ "message": "Total Comments updated in posts table"}';
mysqli_close($conn);


}else{
    http_response_code(404);
    header('Content-Type:application/json');
    echo '{ "message": "page not found"}';
}