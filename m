Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B85A68E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiH3Q6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiH3Q6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:58:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385AEB24A1;
        Tue, 30 Aug 2022 09:58:17 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UFxJTm028885;
        Tue, 30 Aug 2022 16:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5Wf6+OkpJlbMMlkzUeaHJttZ4+wKwZmkQLfCuv3YGbI=;
 b=ePU0x17jHUirtMZYvZBIuWKeWoMyRTPh9iJ3Jnsy0g4g3bcovHNjCl0DDoQWUA9Enyuw
 8xSLHYzca8m7vTG0OlTHf6Ux3G2Mz8vmFcAmB2/51w1n3WIMLQ84DxWRjMIr+5pzOUlE
 xrwv+njI1uIUD9Wa6hQAMyTewgJesh2+0zVQUwhzl73D/guOVBH6SnVdlWYSw6/nu8jg
 MaDwu/nGAe4NQpXCi4D9A6+xhRlveviGUPyk9lVZMsUa8vgwLwPGlWU4m2nJg7UtMmvt
 lpmO3M+X9H1Kiwh44kGh3kBLac4gKdYZgLXW+IKkENzcYpcv3kEFP7pYzT480tz00g7h LQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j9jm4gqj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 16:58:07 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27UGv4dg026790;
        Tue, 30 Aug 2022 16:58:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3j7cbkmq64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 16:58:06 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27UGw5ji027514;
        Tue, 30 Aug 2022 16:58:05 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 27UGw4RF027510
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 16:58:05 +0000
Received: from [10.111.165.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 30 Aug
 2022 09:58:02 -0700
Message-ID: <38a03147-058c-53e5-ea3f-68e40ad39ec4@quicinc.com>
Date:   Tue, 30 Aug 2022 09:58:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dsi: Remove use of device_node in
 dsi_host_parse_dt()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Sean Paul <sean@poorly.run>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <patches@lists.linux.dev>
References: <20220829165450.217628-1-nathan@kernel.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220829165450.217628-1-nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RdoyeJjpYfi6TAnYZH_N9WCrNw_tGLHS
X-Proofpoint-GUID: RdoyeJjpYfi6TAnYZH_N9WCrNw_tGLHS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1011 suspectscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300078
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2022 9:54 AM, Nathan Chancellor wrote:
> Clang warns:
> 
>    drivers/gpu/drm/msm/dsi/dsi_host.c:1903:14: error: variable 'device_node' is uninitialized when used here [-Werror,-Wuninitialized]
>            of_node_put(device_node);
>                        ^~~~~~~~~~~
>    drivers/gpu/drm/msm/dsi/dsi_host.c:1870:44: note: initialize the variable 'device_node' to silence this warning
>            struct device_node *endpoint, *device_node;
>                                                      ^
>                                                      = NULL
>    1 error generated.
> 
> device_node's assignment was removed but not all of its uses. Remove the
> call to of_node_put() and the variable declaration to clean up the
> warning.
> 
> Fixes: 5f8cdece42ff ("drm/msm/dsi: switch to DRM_PANEL_BRIDGE")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1700
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 57a4c0fa614b..7fbf391c024f 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1867,7 +1867,7 @@ static int dsi_host_parse_dt(struct msm_dsi_host *msm_host)
>   {
>   	struct device *dev = &msm_host->pdev->dev;
>   	struct device_node *np = dev->of_node;
> -	struct device_node *endpoint, *device_node;
> +	struct device_node *endpoint;
>   	int ret = 0;
>   
>   	/*
> @@ -1900,8 +1900,6 @@ static int dsi_host_parse_dt(struct msm_dsi_host *msm_host)
>   		}
>   	}
>   
> -	of_node_put(device_node);
> -
>   err:
>   	of_node_put(endpoint);
>   
> 
> base-commit: 5f8cdece42ff0c615e213b6619d29487f9f409d7
