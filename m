Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2165A927D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiIAI4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiIAI4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:56:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C936D12CB19;
        Thu,  1 Sep 2022 01:56:11 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2817OAJd006975;
        Thu, 1 Sep 2022 08:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fQA25NwyX3gMlI+Zmailgv/tBeOJU/nLjAI1PDjDWcs=;
 b=cIQrOBgEJbf4qlfmFq0rClIgiFJLRhted5Df/YOjp7rRRjWcH20KbPJp8/Rdv/H/GgQJ
 Z35Iaoy7AxnG4pkz2e1psGN7UO7jinBnxolnFZExHVDjeDJKCSOS4z2pZW/ecqtGwU48
 QWTm15Y71iPgmH+WkBnmq3wSbNipEfybcEyKM1TQLMXZzeRdsHvzid6ovCHoW8VlNove
 6vEiqjTT12lr0Woh3fUL8Ey+i8rNnXuUgYhdga2jWOGeZAPIiQ4/3R7Wju4mrz+gQ4rj
 9U+QUON5InzbRQRAFEEWLKxmHCXrIu16azyhyGupYLoIrqQoMPjupP6/ydR6kZz8qmAK rg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jaaasb1tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 08:56:07 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2818u7bj011761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 08:56:07 GMT
Received: from [10.216.21.166] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 01:56:04 -0700
Message-ID: <33688ee4-df73-a107-b775-02c4b4bc4229@quicinc.com>
Date:   Thu, 1 Sep 2022 14:25:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] remoteproc: report firmware name on load failures
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mojha@quicinc.com>
References: <20220831161736.749932-1-krzysztof.kozlowski@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220831161736.749932-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5pe_VhOTQSEdev5asV9R6AVGlspLfv2D
X-Proofpoint-ORIG-GUID: 5pe_VhOTQSEdev5asV9R6AVGlspLfv2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010039
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On 8/31/2022 9:47 PM, Krzysztof Kozlowski wrote:
> remoteproc error messages like:
>    remoteproc remoteproc0: request_firmware failed: -2
>    remoteproc remoteproc1: request_firmware failed: -2
> are difficult to debug as one actually have no clue which device
> reported it and which firmware is missing.  Be verbose and print the
> name of the failed firmware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/remoteproc/remoteproc_core.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e5279ed9a8d7..71cd7ed7a970 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1923,7 +1923,8 @@ int rproc_trigger_recovery(struct rproc *rproc)
>   	/* load firmware */
>   	ret = request_firmware(&firmware_p, rproc->firmware, dev);
>   	if (ret < 0) {
> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> +		dev_err(dev, "request_firmware %s failed: %d\n",
> +			rproc->firmware, ret);
>   		goto unlock_mutex;
>   	}
>   
> @@ -2023,7 +2024,8 @@ int rproc_boot(struct rproc *rproc)
>   		/* load firmware */
>   		ret = request_firmware(&firmware_p, rproc->firmware, dev);
>   		if (ret < 0) {
> -			dev_err(dev, "request_firmware failed: %d\n", ret);
> +			dev_err(dev, "request_firmware %s failed: %d\n",
> +				rproc->firmware, ret);

Good to have this.
Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

>   			goto downref_rproc;
>   		}
>   

-Mukesh
