Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B059519550
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiEDCFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344015AbiEDCCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:02:43 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9BC2610B;
        Tue,  3 May 2022 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651629532; x=1683165532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SfFRyNG4hERL+TTomH08jiy/yMmdir6j259/R+4NcYg=;
  b=KXHFtCFAw1/YNdZS5bSmXPkpPbq1Ttr6ag/99PSHTabw2v+00+Tz0VK8
   2UTFkcEv1sxw6sOM0UwC5C/OyxXAGdG3EJ2VS62cU6YMqWZi9Y3eEpEUi
   KsdISC+kGoGPMXd72f35yC0FJWzCa+zBAbvLBNyy/p0I/O77taN08jBK6
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 May 2022 18:58:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 18:58:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 18:58:51 -0700
Received: from [10.50.60.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 3 May 2022
 18:58:48 -0700
Message-ID: <c2ede158-3c50-9de5-653f-607377a01992@quicinc.com>
Date:   Wed, 4 May 2022 07:28:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] soc: qcom: llcc: Add sc8180x and sc8280xp
 configurations
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20220502215406.612967-1-bjorn.andersson@linaro.org>
 <20220502215406.612967-3-bjorn.andersson@linaro.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220502215406.612967-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/2022 3:24 AM, Bjorn Andersson wrote:
> Add LLCC configuration data for the SC8180X and SC8280XP platforms,
> based on the downstream tables.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changs since v1:
> - Updated tables according to documentation - thanks Sai!
>
>   drivers/soc/qcom/llcc-qcom.c       | 60 ++++++++++++++++++++++++++++++
>   include/linux/soc/qcom/llcc-qcom.h |  2 +
>   2 files changed, 62 insertions(+)
>
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 85ba8209b182..4b143cf7b4ce 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -130,6 +130,50 @@ static const struct llcc_slice_config sc7280_data[] =  {
>   	{ LLCC_MODPE,    29, 64,  1, 1, 0x3f, 0x0, 0, 0, 0, 1, 0, 0},
>   };
>   
> +static const struct llcc_slice_config sc8180x_data[] = {
> +	{ LLCC_CPUSS,    1, 6144,  1, 1, 0xfff, 0x0,   0, 0, 0, 1, 1 },
> +	{ LLCC_VIDSC0,   2, 512,   2, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_VIDSC1,   3, 512,   2, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_AUDIO,    6, 1024,  1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_MDMHPGRW, 7, 3072,  1, 1, 0x3ff, 0xc00, 0, 0, 0, 1, 0 },
> +	{ LLCC_MDM,      8, 3072,  1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_MODHW,    9, 1024,  1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_CMPT,     10, 6144, 1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_GPUHTW,   11, 1024, 1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_GPU,      12, 5120, 1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0,   0, 0, 0, 0, 1 },
> +	{ LLCC_CMPTDMA,  15, 6144, 1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_DISP,     16, 6144, 1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_VIDFW,    17, 1024, 1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_MDMHPFX,  20, 1024, 2, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_MDMPNG,   21, 1024, 0, 1, 0xc,   0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_AUDHW,    22, 1024, 1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_NPU,      23, 6144, 1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_WLHW,     24, 6144, 1, 1, 0xfff, 0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_MODPE,    29, 512,  1, 1, 0xc,   0x0,   0, 0, 0, 1, 0 },
> +	{ LLCC_APTCM,    30, 512,  3, 1, 0x0,   0x1,   1, 0, 0, 1, 0 },
> +	{ LLCC_WRCACHE,  31, 128,  1, 1, 0xfff, 0x0,   0, 0, 0, 0, 0 },
> +};
> +
> +static const struct llcc_slice_config sc8280xp_data[] = {
> +	{ LLCC_CPUSS,    1,  6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 1, 0 },
> +	{ LLCC_VIDSC0,   2,  512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_AUDIO,    6,  1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0, 0 },
> +	{ LLCC_CMPT,     10, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0, 0 },
> +	{ LLCC_GPUHTW,   11, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_GPU,      12, 4096, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 1 },
> +	{ LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> +	{ LLCC_DISP,     16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_AUDHW,    22, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_DRE,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
> +	{ LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> +	{ LLCC_CVPFW,    32, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_CPUSS1,   33, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_CPUHWT,   36, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> +};
> +
>   static const struct llcc_slice_config sdm845_data[] =  {
>   	{ LLCC_CPUSS,    1,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 1 },
>   	{ LLCC_VIDSC0,   2,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0 },
> @@ -276,6 +320,20 @@ static const struct qcom_llcc_config sc7280_cfg = {
>   	.reg_offset	= llcc_v1_2_reg_offset,
>   };
>   
> +static const struct qcom_llcc_config sc8180x_cfg = {
> +	.sct_data	= sc8180x_data,
> +	.size		= ARRAY_SIZE(sc8180x_data),
> +	.need_llcc_cfg	= true,
> +	.reg_offset	= llcc_v1_2_reg_offset,
> +};
> +
> +static const struct qcom_llcc_config sc8280xp_cfg = {
> +	.sct_data	= sc8280xp_data,
> +	.size		= ARRAY_SIZE(sc8280xp_data),
> +	.need_llcc_cfg	= true,
> +	.reg_offset	= llcc_v1_2_reg_offset,
> +};
> +
>   static const struct qcom_llcc_config sdm845_cfg = {
>   	.sct_data	= sdm845_data,
>   	.size		= ARRAY_SIZE(sdm845_data),
> @@ -741,6 +799,8 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   static const struct of_device_id qcom_llcc_of_match[] = {
>   	{ .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfg },
>   	{ .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfg },
> +	{ .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfg },
> +	{ .compatible = "qcom,sc8280xp-llcc", .data = &sc8280xp_cfg },
>   	{ .compatible = "qcom,sdm845-llcc", .data = &sdm845_cfg },
>   	{ .compatible = "qcom,sm6350-llcc", .data = &sm6350_cfg },
>   	{ .compatible = "qcom,sm8150-llcc", .data = &sm8150_cfg },
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index 0bc21ee58fac..9ed5384c5ca1 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -29,6 +29,8 @@
>   #define LLCC_AUDHW       22
>   #define LLCC_NPU         23
>   #define LLCC_WLHW        24
> +#define LLCC_PIMEM       25
> +#define LLCC_DRE         26
>   #define LLCC_CVP         28
>   #define LLCC_MODPE       29
>   #define LLCC_APTCM       30

Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>

(Note: LLCC_PIMEM isn't used now, but I guess doesn't hurt much to be included in header)

Thanks,
Sai
