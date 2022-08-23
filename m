Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B56C59EE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiHWVoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHWVoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:44:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6350B56B99;
        Tue, 23 Aug 2022 14:44:10 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NLBAmC032572;
        Tue, 23 Aug 2022 21:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mGedryMM3NKijC1SW+NCkzUI76azmDy6pdzu03EbKnw=;
 b=QbBHFfKIlu59KinBdsfCHRiRyAHu6Y5h2otqOktfgYY5Eh6hHn6/pNVon+avm3GRvYXe
 szF+oTHv43ikd5k6dCh3SM+QEzExHfdVgHQ/E614CY55S+9MHXaee+EEBBPF4fSrFr8v
 QVwZMHmYnyeSQA7pRA8AOlOKpCkmr1wMyOdicqLGgks5m9vkp0BKNUzvICDnvZ8ibTaC
 l7d5zCOV6hTkZthscvFGDWHrHvvRF+TPITyLgWCIBhtIvuruZYFPNS/vWRg0nGi1pI0n
 Bkl3WpEGz8hFrvb6FzEhh8Ubekmz3vpnNt2ms/MR1n6VFwYs4tY9pVseM0fZd/o3u2aQ 1A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pqguc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 21:43:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27NLhuhL007079
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 21:43:57 GMT
Received: from [10.111.161.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 14:43:54 -0700
Message-ID: <7e2ab82b-f7d7-e1e9-d97b-037a9220916f@quicinc.com>
Date:   Tue, 23 Aug 2022 14:43:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] drm/msm/dp: Silence inconsistent indent warning
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>
CC:     <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        kernel test robot <lkp@intel.com>
References: <20220823212302.1744145-1-swboyd@chromium.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220823212302.1744145-1-swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 155BSIDkVOm3JwjJvNu5BfhKOujNmVdO
X-Proofpoint-GUID: 155BSIDkVOm3JwjJvNu5BfhKOujNmVdO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_08,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230081
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/2022 2:23 PM, Stephen Boyd wrote:
> Build robots complain
> 
>   smatch warnings:
>   drivers/gpu/drm/msm/dp/dp_link.c:969 dp_link_process_link_status_update() warn: inconsistent indenting
> 
> Fix it along with a trailing space from the same commit.
> 
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Fixes: ea530388e64b ("drm/msm/dp: skip checking LINK_STATUS_UPDATED bit")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> 
> Changes from v1 (https://lore.kernel.org/r/20220823024356.783318-1-swboyd@chromium.org)
>   * Roll in extra whitespace fix
> 
>   drivers/gpu/drm/msm/dp/dp_link.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
> index 36f0af02749f..36bb6191d2f0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.c
> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> @@ -786,7 +786,7 @@ static int dp_link_process_link_training_request(struct dp_link_private *link)
>   			link->request.test_lane_count);
>   
>   	link->dp_link.link_params.num_lanes = link->request.test_lane_count;
> -	link->dp_link.link_params.rate =
> +	link->dp_link.link_params.rate =
>   		drm_dp_bw_code_to_link_rate(link->request.test_link_rate);
>   
>   	return 0;
> @@ -965,8 +965,7 @@ static int dp_link_process_link_status_update(struct dp_link_private *link)
>   	if (channel_eq_done && clock_recovery_done)
>   		return -EINVAL;
>   
> -
> -       return 0;
> +	return 0;
>   }
>   
>   /**
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
