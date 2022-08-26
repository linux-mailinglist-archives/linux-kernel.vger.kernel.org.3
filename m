Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6D5A2230
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbiHZHpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245506AbiHZHpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:45:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA88E0D7;
        Fri, 26 Aug 2022 00:45:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q7Wdra023548;
        Fri, 26 Aug 2022 07:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ETkj+QXTCULceRPEha9GhQ71BYIoHHYCDlJY3zP5qIs=;
 b=MQAwx0HQ/6SekDZplIFA1FXuWJsCP14YleGxwuZRl50UADeby6bXZZw/8R2NdlQBCSLn
 eEvutKJ0esCirP+MViY7mj21QnjwBXosfc8ElX/qxg0cGWb4GzVyLgsqU5ktebXT+eSN
 SlT4LjdwABQva01jwzcSFaF+syRruwNFptr6BAoYlnj9deFan8UTRS48UhdSOnsEnCOt
 5jgm1Z1YNT2oGQNu4RUSLNdrK9xQeHlPsjqpPx6siq2k97xzEdlDeOkdNiWKtoBOGjwj
 UqMQxPMMt8HOCOEzE/dW1KIApa06sz1F6hYaxh6j7rWy4tVillow6r7GHzBUUJlkU4b/ ww== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j6sv7829c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 07:45:28 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27Q7eRx8005942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 07:40:27 GMT
Received: from [10.216.58.196] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 26 Aug
 2022 00:40:23 -0700
Message-ID: <089f50b7-a87e-8570-d85f-be7470153493@quicinc.com>
Date:   Fri, 26 Aug 2022 13:10:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH linux-next] rpmsg: char: Remove the unneeded result
 variable
Content-Language: en-US
To:     <cgel.zte@gmail.com>, <bjorn.andersson@linaro.org>
CC:     <mathieu.poirier@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220826071954.252485-1-ye.xingchen@zte.com.cn>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220826071954.252485-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W3Ltf_LZM7JtQnhzXs2JeSd5AdWV_8z7
X-Proofpoint-GUID: W3Ltf_LZM7JtQnhzXs2JeSd5AdWV_8z7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2022 12:49 PM, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value rpmsg_chrdev_eptdev_add() directly instead of storing it
> in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/rpmsg/rpmsg_char.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 4f2189111494..0850ae34fb88 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -424,15 +424,12 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
>   			       struct rpmsg_channel_info chinfo)
>   {
>   	struct rpmsg_eptdev *eptdev;
> -	int ret;
>   
>   	eptdev = rpmsg_chrdev_eptdev_alloc(rpdev, parent);
>   	if (IS_ERR(eptdev))
>   		return PTR_ERR(eptdev);
>   
> -	ret = rpmsg_chrdev_eptdev_add(eptdev, chinfo);
> -
> -	return ret;
> +	return rpmsg_chrdev_eptdev_add(eptdev, chinfo);
>   }

LGTM.

Reviewed-by:Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh



>   EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
>   
