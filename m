Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189554FBD47
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346577AbiDKNjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346163AbiDKNjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:39:20 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020CC2180D;
        Mon, 11 Apr 2022 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649684225; x=1681220225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U5xmi+ZKs6LVmqmHM/hjJ79x5Wcf0VgOcaX88wCM5wg=;
  b=zToeqIQRVcW9YSL5LKnaxA4mfkLWnhB/vVKVUPjMwdCBciDgHglfMInY
   VUwJSBc8+Q2WkTr4qIg24srRmQXFtEjsrC3LR6iXFYOjDGGXsVmtMuAoJ
   MMRJGkrtgWk7vU5ii/nt52HySHpLT6AgK6UUHxrhIol/uCPBI4c+9ghSU
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Apr 2022 06:37:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:37:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 06:37:04 -0700
Received: from [10.50.47.200] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 06:37:00 -0700
Message-ID: <8a627cc0-8f9b-0bda-c9b5-6d51a788948a@quicinc.com>
Date:   Mon, 11 Apr 2022 19:06:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/3] soc: qcom: llcc: Add sc8180x and sc8280xp
 configurations
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20220408213336.581661-1-bjorn.andersson@linaro.org>
 <20220408213336.581661-2-bjorn.andersson@linaro.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220408213336.581661-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Looks like downstream LLCC configuration data is not up to date, I have cross checked with SCT table in IP doc
and have suggested the changes inline as per the latest doc.

On 4/9/2022 3:03 AM, Bjorn Andersson wrote:
> Add LLCC configuration data for the SC8180X and SC8280XP platforms,
> based on the downstream tables.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/soc/qcom/llcc-qcom.c       | 60 ++++++++++++++++++++++++++++++
>   include/linux/soc/qcom/llcc-qcom.h |  2 +
>   2 files changed, 62 insertions(+)
>
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index eecafeded56f..a76d58195637 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -130,6 +130,50 @@ static const struct llcc_slice_config sc7280_data[] =  {
>   	{ LLCC_MODPE,    29, 64,  1, 1, 0x3f, 0x0, 0, 0, 0, 1, 0, 0},
>   };
>   
> +static const struct llcc_slice_config sc8180x_data[] = {
> +	{ LLCC_CPUSS,    1, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 1 },
> +	{ LLCC_VIDSC0,    2, 512, 2, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_VIDSC1,    3, 512, 2, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_ROTATOR,    4, 1024, 2, 1, 0xfff, 0x0, 2, 0, 0, 1, 0 },
> +	{ LLCC_VOICE,    5, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },

These two are not present in latest SCT table, you can remove these.

> +	{ LLCC_AUDIO,    6, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },

Max size is 1024KB -> { LLCC_AUDIO,    6, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },

> +	{ LLCC_MDMHPGRW,    7, 1024, 2, 0, 0xfff, 0x0, 0, 0, 0, 1, 0 },

Max size is 3072KB , priority is 1, fixed size is 1, bonus ways is 0x3ff, reserved ways is 0xc00, change like below.

{ LLCC_MDMHPGRW,    7, 3072, 1, 1, 0x3ff, 0xc00, 0, 0, 0, 1, 0 },

> +	{ LLCC_MDM,    8, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },

Max size is 3072KB -> { LLCC_MDM,    8, 3072, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
There is one more entry for LLCC_MODHW like below after LLCC_MDM,

{ LLCC_MODHW,    9, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },

> +	{ LLCC_CMPT,   10, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_GPUHTW,   11, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_GPU,   12, 5120, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_MMUHWT,   13, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1 },

Max size is 1024KB -> { LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1 },

> +	{ LLCC_CMPTDMA,   15, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_DISP,   16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_VIDFW,   17, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },

Max size is 1024KB -> { LLCC_VIDFW,   17, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },

> +	{ LLCC_MDMHPFX,   20, 1024, 2, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_MDMPNG,   21, 1024, 0, 1, 0xf, 0x0, 0, 0, 0, 1, 0 },

Bonus ways is 0xc -> { LLCC_MDMPNG,   21, 1024, 0, 1, 0xc, 0x0, 0, 0, 0, 1, 0 },

> +	{ LLCC_AUDHW,   22, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_NPU,   23, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_WLHW,   24, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_PIMEM,   25, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },

There is no PIMEM entry, you can remove that and add 3 other entries as below,

{ LLCC_MODPE,    29, 512,  1, 1, 0xc,   0x0, 0, 0, 0, 1, 0 },
{ LLCC_APTCM,    30, 512,  3, 1, 0x0,   0x1, 1, 0, 0, 1, 0 },
{ LLCC_WRCACHE,  31, 128,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0 },


> +};
> +
> +static const struct llcc_slice_config sc8280xp_data[] = {
> +	{ LLCC_CPUSS,    1,  6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 1 },
> +	{ LLCC_VIDSC0,   2,  512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_AUDIO,    6,  1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0 },
> +	{ LLCC_CMPT,     10, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0 },
> +	{ LLCC_GPUHTW,   11, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_GPU,      12, 4608, 1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0 },

Max capacity in 4096KB, fixed size is 1 -> { LLCC_GPU,      12, 4096, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },

> +	{ LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1 },
> +	{ LLCC_DISP,     16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_AUDHW,    22, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_DRE,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0 },
> +	{ LLCC_WRCACHE,  31, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1 },

Max capacity is 1024KB -> { LLCC_WRCACHE,  31, 1024,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1 },

> +	{ LLCC_CVPFW,    17, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_CPUSS1,   3,  2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_CAMEXP0,  14, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0 },

This is not present in latest LLCC SCT table, you can remove it.

> +	{ LLCC_CPUHWT,   5,  512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1 },
> +};
> +

Also need one more column field (write_scid_en) at the end with all false(0) values except for GPU SCID (12)
which is true (1) for sc8280xp.

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


Thanks,
Sai
