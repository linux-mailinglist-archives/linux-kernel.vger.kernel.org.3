Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B440C5A205A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243989AbiHZFg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHZFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:36:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69382CEB2A;
        Thu, 25 Aug 2022 22:36:25 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q4ddl2015439;
        Fri, 26 Aug 2022 05:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=C0lUWObrNcTw+zDPrJ0MNwDuJlgwPMa04nHCcS3OJEk=;
 b=If6pn9NDaQOzs1uYp/YrVtc0eVi6tBnRL43nFyLZBLGLK/7jTq6YdcLwPbkT5q0YNuT5
 4Boy0qAU+Ykcx9V8cdRw5uhVO9vzhi9PcXo0O45sIpP0XRgeX//RC+de4vq1E0CgNVQj
 4yWni0TmG7/GvybJxqGwUIuLB4tgcYOwSxmvCsd3E3jIj++fPsGeEQvIB38ZqELXlKJe
 qa+BoXX3dvWFiDtFEvaD7QD8HepgWTR7fKk3VA1oP6DyYYRrsMHtFPC5aWNnwFbzO/nI
 i6tvu+tUZSvvuqjpf1AmumVC7vAk+sSjtgJd6JUSdQx8LkWi4mtrne9ENiPY0DFM5SFE FA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j6ns50fh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 05:36:17 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27Q5aGPN013154
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 05:36:16 GMT
Received: from [10.216.58.196] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 22:36:13 -0700
Message-ID: <6f00975d-8900-f03a-45d9-546d222ac450@quicinc.com>
Date:   Fri, 26 Aug 2022 11:06:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next 2/3] remoteproc: qcom: wcss: Use
 devm_platform_ioremap_resource_byname()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>
References: <20220826014511.2270433-1-yangyingliang@huawei.com>
 <20220826014511.2270433-2-yangyingliang@huawei.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220826014511.2270433-2-yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ry-gTX09yz7bzKEivea296vyKwCeCbX1
X-Proofpoint-GUID: ry-gTX09yz7bzKEivea296vyKwCeCbX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2022 7:15 AM, Yang Yingliang wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/remoteproc/qcom_q6v5_wcss.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
> index 017ee225dc32..209fc1bd1424 100644
> --- a/drivers/remoteproc/qcom_q6v5_wcss.c
> +++ b/drivers/remoteproc/qcom_q6v5_wcss.c
> @@ -835,8 +835,7 @@ static int q6v5_wcss_init_mmio(struct q6v5_wcss *wcss,
>   		return -ENOMEM;
>   
>   	if (wcss->version == WCSS_IPQ8074) {
> -		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rmb");
> -		wcss->rmb_base = devm_ioremap_resource(&pdev->dev, res);
> +		wcss->rmb_base = devm_platform_ioremap_resource_byname(pdev, "rmb");

LGTM.

Reviewed-by:Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh


>   		if (IS_ERR(wcss->rmb_base))
>   			return PTR_ERR(wcss->rmb_base);
>   	}
