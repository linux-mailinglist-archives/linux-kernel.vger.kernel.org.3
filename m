Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD75811E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiGZLZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiGZLZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:25:23 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C521E3F8;
        Tue, 26 Jul 2022 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658834723; x=1690370723;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TgsY3kSUDq559VWKlBJhSI8YVwFY9gdL6CTg2MQlcG8=;
  b=wjO5vkwlHvM6lkCMeUJErEnq8BxEniMvXR6yTlx3g9W3N/Pgo3OP6hBo
   peysYxRuQ1MbtRZD4t2EHPTCYFTWTdjHTtCZffFa66WeJr7gexJb306N6
   uqgcIVbjEE6fGdRI7zTAaUqF3uiDcgOTxErgd6QCX8VX8AvLPStvIZaij
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 26 Jul 2022 04:25:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 04:25:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 04:25:21 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Jul
 2022 04:25:17 -0700
Subject: Re: [PATCH 03/10] soc: qcom: icc-bwmon: drop unused BWMON_ZONE_COUNT
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-4-krzysztof.kozlowski@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <689ae7a0-bb23-8264-a2ff-40b1b5bbf0af@quicinc.com>
Date:   Tue, 26 Jul 2022 16:55:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220720192807.130098-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

Thanks for working on the llcc bwmon patch series!


On 7/21/22 12:58 AM, Krzysztof Kozlowski wrote:
> BWMON_ZONE_COUNT define is not used.
> 
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/soc/qcom/icc-bwmon.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index 3415f42523cd..b76a59d9002c 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -105,7 +105,6 @@
>   
>   /* BWMONv4 count registers use count unit of 64 kB */
>   #define BWMON_COUNT_UNIT_KB			64
> -#define BWMON_ZONE_COUNT			0x2d8

Apart from ^^ a few more defines like BWMON_GLOBAL_IRQ_STATUS,
THRESHOLD_COUNT_ZONE2_SHIFT were unused as well.

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

>   #define BWMON_ZONE_MAX(zone)			(0x2e0 + 4 * (zone))
>   
>   struct icc_bwmon_data {
> 
