Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252AB5A2C07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiHZQKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiHZQKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:10:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF9B59251;
        Fri, 26 Aug 2022 09:10:43 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QFPFBY013992;
        Fri, 26 Aug 2022 16:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ThSsc8c8cp/PRPMjomjXR9rLNbkOBONEHayfg7bXR9I=;
 b=LgZaLJ5cSz5HqgMNsF5gelnsVNE7K8WfGGuo1X97OrxezJoDI9QbR4GalQuPz4tBRMs4
 KqSQdJR7IWD97nbJjZ1+Tg/IJYkuwxAvmx3kvay/sx0UpNigStq478gWsJhD9LEaVsTl
 Pdg6dWr31X6r0hjBgDTcPJFcdzrZ/qXzO9aLMsoWG1zOCfKRPrEiJoudgSo/44MpvbAA
 SzQnIMTjg8EjxlNIn8mm3tOJLUOX3PyU2uCXLwcZuXWd3/xMrfLuD5ClL9MGWa+GZuPT
 csglGjhj+45sB0B4J7apodZsBWij7m8FC4x5YjYZlG8L8491dsBn5tESTtVmzqw8UuOH MQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j6399p2yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 16:10:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27QGAXvc032519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 16:10:33 GMT
Received: from [10.38.245.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 26 Aug
 2022 09:10:31 -0700
Message-ID: <b190ff71-fdf4-9fe3-56ee-456665b48237@quicinc.com>
Date:   Fri, 26 Aug 2022 09:10:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH RESEND] drm/msm/dsi: fix the inconsistent indenting
Content-Language: en-US
To:     sunliming <sunliming@kylinos.cn>, <christian.koenig@amd.com>,
        <robdclark@gmail.com>, <dmitry.baryshkov@linaro.org>
CC:     <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <inux-arm-msm@vger.kernel.org>, <kelulanainsley@gmail.com>,
        kernel test robot <lkp@intel.com>
References: <20220826084917.95409-1-sunliming@kylinos.cn>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220826084917.95409-1-sunliming@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZvU2u7O3-6eWywJC_qBhQVaU5gwsnNFc
X-Proofpoint-ORIG-GUID: ZvU2u7O3-6eWywJC_qBhQVaU5gwsnNFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=886 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2022 1:49 AM, sunliming wrote:
> Fix the inconsistent indenting in function msm_dsi_dphy_timing_calc_v3().
> 
> Fix the following smatch warnings:
> 
> drivers/gpu/drm/msm/dsi/phy/dsi_phy.c:350 msm_dsi_dphy_timing_calc_v3() warn: inconsistent indenting
> 
> Fixes: f1fa7ff44056 ("drm/msm/dsi: implement auto PHY timing calculator for 10nm PHY")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
There is no need to resend this. This was already applied to msm-fixes

https://gitlab.freedesktop.org/drm/msm/-/commit/2f25a1fb4ec516c5ad67afd754334b491b9f09a5

> ---
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> index a39de3bdc7fa..56dfa2d24be1 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> @@ -347,7 +347,7 @@ int msm_dsi_dphy_timing_calc_v3(struct msm_dsi_dphy_timing *timing,
>   	} else {
>   		timing->shared_timings.clk_pre =
>   			linear_inter(tmax, tmin, pcnt2, 0, false);
> -			timing->shared_timings.clk_pre_inc_by_2 = 0;
> +		timing->shared_timings.clk_pre_inc_by_2 = 0;
>   	}
>   
>   	timing->ta_go = 3;
