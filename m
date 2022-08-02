Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD0C587B03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiHBKrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbiHBKrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:47:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B0E1A3AE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:46:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e11so15185333ljl.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kYGReEVOZuoydATB0Wl+C6DwDR9NNOWFvZPWcmy7Oo0=;
        b=aLh1WRmL/UxS915aB2r7CXtv5iNzjJ1veojZpwseqyEmlFsSqxGNEr1Fr2Swe6e6Wm
         A7UET8CZi5VYJ78MbdRphNDqF6bDRi5oXUEDS/5xL0ylLEBu9gq0xgGA2GUdrV3wJ/al
         sv73Cym6OTe1JXoUgJFSOoXcP9c9A0DNToNhYBVvDNnPt4XsJA/ON5E50EqNTKkeeLMo
         rENxHXYbbgsmwZ0VL2X+cy/wBI9P65pLE/skvWwMpfck/orBIz/kkg9PoF0CuXfUohBX
         EaVXS934S2OYq+vL/FOetSxEroEl10QLhP7qzLt+b6ZVEoghzlwf2itNt9TVUH6s4rH6
         oovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kYGReEVOZuoydATB0Wl+C6DwDR9NNOWFvZPWcmy7Oo0=;
        b=72bvnW3AurRNvKsL31kiSCGG8wQkObqvqvHqdJuVNdUHgJaArTm+U7pndhtg1R6Uyu
         OhffiCpm78di1w3+Wzrspi7F9YX+fSI/yNY3aic+y4vjqaTVqSK6QfVwlNlvSBjgEyXH
         YjWDjcTvh57Y7cU29UIJRFx4x4ycUwpLoQRdpNmH0nDyyh4jtcwF28QIuqQUVDIAV/X8
         cXFviRLT/WTd+3w7p6LF+fwGooKEoDHaHM8AlV9opoCWpRMlwdd3jJZvzpr1sY8eLRXH
         b6BHrPBNLY7H5rn9xufqJyELkEkPXrYS41xhRga9RLDfSu9aaw89TReqzSXaK0jw/6qG
         4RUg==
X-Gm-Message-State: AJIora8sXaXgyTkWpGSaC/14xzg/+dprVvKrCL2R0coEUJYj2b6j8jCt
        aOVgrsbthI+TCVeneYUo+gaPeg==
X-Google-Smtp-Source: AGRyM1uNpWiTZ6zMkYqSjTDyh2KL/069FM1E2eGC8VvEyzH2C2ow5itpXFiXzWVKA0EycotOff0MIg==
X-Received: by 2002:a05:651c:1503:b0:24c:81df:e1f2 with SMTP id e3-20020a05651c150300b0024c81dfe1f2mr5995044ljf.182.1659437210824;
        Tue, 02 Aug 2022 03:46:50 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id w5-20020ac254a5000000b0048aeafde9b8sm1277227lfk.108.2022.08.02.03.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 03:46:50 -0700 (PDT)
Message-ID: <3f56541a-29c1-af76-0de3-b20eb81a5fa8@linaro.org>
Date:   Tue, 2 Aug 2022 12:46:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 05/13] regulator: qcom_spmi: Add support for new
 regulator types
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
 <20220731223736.1036286-6-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220731223736.1036286-6-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 00:37, Iskren Chernev wrote:
> Add support for some regulator types that are missing in this driver, all
> belonging to the FTSMPS426 register layout.  This is done in preparation
> for adding support for the PM6125 PMIC.
> 
> Although these regulators conform to ftsmps426 (common 2) layout, their
> modes are slightly offset (BYPASS, RETENTION and LPM values are one lower).
> 
> Also, slew rate for the FTS regulator is computed in a simpler way.
> 
> The inspiration for the magic constants was taken from [1]
> 
> [1]: https://source.codeaurora.org/quic/la/kernel/msm-5.4/commit/?h=kernel.lnx.5.4.r1-rel&id=d1220daeffaa440ffff0a8c47322eb0033bf54f5
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  drivers/regulator/qcom_spmi-regulator.c | 138 ++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
> 
> diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
> index a2d0292a92fd..50c8ee01e0ad 100644
> --- a/drivers/regulator/qcom_spmi-regulator.c
> +++ b/drivers/regulator/qcom_spmi-regulator.c
> @@ -99,6 +99,8 @@ enum spmi_regulator_logical_type {
>  	SPMI_REGULATOR_LOGICAL_TYPE_ULT_LDO,
>  	SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS426,
>  	SPMI_REGULATOR_LOGICAL_TYPE_HFS430,
> +	SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS3,
> +	SPMI_REGULATOR_LOGICAL_TYPE_LDO_510,
>  };
>  
>  enum spmi_regulator_type {
> @@ -166,6 +168,16 @@ enum spmi_regulator_subtype {
>  	SPMI_REGULATOR_SUBTYPE_HFS430		= 0x0a,
>  	SPMI_REGULATOR_SUBTYPE_HT_P150		= 0x35,
>  	SPMI_REGULATOR_SUBTYPE_HT_P600		= 0x3d,
> +	SPMI_REGULATOR_SUBTYPE_FTSMPS_510	= 0x0b,
> +	SPMI_REGULATOR_SUBTYPE_LV_P150_510	= 0x71,
> +	SPMI_REGULATOR_SUBTYPE_LV_P300_510	= 0x72,
> +	SPMI_REGULATOR_SUBTYPE_LV_P600_510	= 0x73,
> +	SPMI_REGULATOR_SUBTYPE_N300_510		= 0x6a,
> +	SPMI_REGULATOR_SUBTYPE_N600_510		= 0x6b,
> +	SPMI_REGULATOR_SUBTYPE_N1200_510	= 0x6c,
> +	SPMI_REGULATOR_SUBTYPE_MV_P50_510	= 0x7a,
> +	SPMI_REGULATOR_SUBTYPE_MV_P150_510	= 0x7b,
> +	SPMI_REGULATOR_SUBTYPE_MV_P600_510	= 0x7d,
>  };
>  
>  enum spmi_common_regulator_registers {
> @@ -193,6 +205,14 @@ enum spmi_ftsmps426_regulator_registers {
>  	SPMI_FTSMPS426_REG_VOLTAGE_ULS_MSB	= 0x69,
>  };
>  
> +/*
> + * Third common register layout
> + */
> +enum spmi_ftsmps3_regulator_registers {
> +	SPMI_FTSMPS3_REG_STEP_CTRL		= 0x3c,
> +};
> +
> +

Just one blank line.

>  enum spmi_vs_registers {
>  	SPMI_VS_REG_OCP				= 0x4a,
>  	SPMI_VS_REG_SOFT_START			= 0x4c,
> @@ -260,6 +280,15 @@ enum spmi_common_control_register_index {
>  
>  #define SPMI_FTSMPS426_MODE_MASK		0x07
>  
> +/* Third common regulator mode register values */
> +#define SPMI_FTSMPS3_MODE_BYPASS_MASK		2
> +#define SPMI_FTSMPS3_MODE_RETENTION_MASK	3
> +#define SPMI_FTSMPS3_MODE_LPM_MASK		4
> +#define SPMI_FTSMPS3_MODE_AUTO_MASK		6
> +#define SPMI_FTSMPS3_MODE_HPM_MASK		7
> +
> +#define SPMI_FTSMPS3_MODE_MASK			0x07
> +
>  /* Common regulator pull down control register layout */
>  #define SPMI_COMMON_PULL_DOWN_ENABLE_MASK	0x80
>  
> @@ -305,6 +334,9 @@ enum spmi_common_control_register_index {
>  #define SPMI_FTSMPS_STEP_MARGIN_NUM	4
>  #define SPMI_FTSMPS_STEP_MARGIN_DEN	5
>  
> +/* slew_rate has units of uV/us. */
> +#define SPMI_FTSMPS3_SLEW_RATE_38p4 38400
> +
>  #define SPMI_FTSMPS426_STEP_CTRL_DELAY_MASK	0x03
>  #define SPMI_FTSMPS426_STEP_CTRL_DELAY_SHIFT	0
>  
> @@ -554,6 +586,14 @@ static struct spmi_voltage_range ht_p600_ranges[] = {
>  	SPMI_VOLTAGE_RANGE(0, 1704000, 1704000, 1896000, 1896000, 8000),
>  };
>  
> +static struct spmi_voltage_range nldo_510_ranges[] = {
> +	SPMI_VOLTAGE_RANGE(0, 320000, 320000, 1304000, 1304000, 8000),
> +};
> +
> +static struct spmi_voltage_range ftsmps510_ranges[] = {
> +	SPMI_VOLTAGE_RANGE(0, 300000, 300000, 1372000, 1372000, 4000),
> +};
> +
>  static DEFINE_SPMI_SET_POINTS(pldo);
>  static DEFINE_SPMI_SET_POINTS(nldo1);
>  static DEFINE_SPMI_SET_POINTS(nldo2);
> @@ -576,6 +616,8 @@ static DEFINE_SPMI_SET_POINTS(ht_nldo);
>  static DEFINE_SPMI_SET_POINTS(hfs430);
>  static DEFINE_SPMI_SET_POINTS(ht_p150);
>  static DEFINE_SPMI_SET_POINTS(ht_p600);
> +static DEFINE_SPMI_SET_POINTS(nldo_510);
> +static DEFINE_SPMI_SET_POINTS(ftsmps510);
>  
>  static inline int spmi_vreg_read(struct spmi_regulator *vreg, u16 addr, u8 *buf,
>  				 int len)
> @@ -1062,6 +1104,24 @@ static unsigned int spmi_regulator_ftsmps426_get_mode(struct regulator_dev *rdev
>  	}
>  }
>  
> +static int
> +spmi_regulator_ftsmps3_get_mode(struct regulator_dev *rdev, unsigned int mode)
> +{
> +	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
> +	u8 reg;
> +
> +	spmi_vreg_read(vreg, SPMI_COMMON_REG_MODE, &reg, 1);
> +
> +	switch (reg) {
> +	case SPMI_FTSMPS3_MODE_HPM_MASK:
> +		return REGULATOR_MODE_NORMAL;
> +	case SPMI_FTSMPS3_MODE_AUTO_MASK:
> +		return REGULATOR_MODE_FAST;
> +	default:
> +		return REGULATOR_MODE_IDLE;
> +	}
> +}
> +
>  static int
>  spmi_regulator_common_set_mode(struct regulator_dev *rdev, unsigned int mode)
>  {
> @@ -1108,6 +1168,33 @@ spmi_regulator_ftsmps426_set_mode(struct regulator_dev *rdev, unsigned int mode)
>  	return spmi_vreg_update_bits(vreg, SPMI_COMMON_REG_MODE, val, mask);
>  }
>  
> +static int
> +spmi_regulator_ftsmps3_set_mode(struct regulator_dev *rdev, unsigned int mode)
> +{
> +	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
> +	u8 mask = SPMI_FTSMPS3_MODE_MASK;
> +	u8 val;
> +
> +	switch (mode) {
> +	case REGULATOR_MODE_NORMAL:
> +		val = SPMI_FTSMPS3_MODE_HPM_MASK;
> +		break;
> +	case REGULATOR_MODE_FAST:
> +		val = SPMI_FTSMPS3_MODE_AUTO_MASK;
> +		break;
> +	case REGULATOR_MODE_IDLE:
> +		val = vreg->logical_type ==
> +				SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS3 ?
> +			SPMI_FTSMPS3_MODE_RETENTION_MASK :
> +			SPMI_FTSMPS3_MODE_LPM_MASK;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return spmi_vreg_update_bits(vreg, SPMI_COMMON_REG_MODE, val, mask);
> +}
> +
>  static int
>  spmi_regulator_common_set_load(struct regulator_dev *rdev, int load_uA)
>  {
> @@ -1465,6 +1552,21 @@ static const struct regulator_ops spmi_hfs430_ops = {
>  	.get_mode		= spmi_regulator_ftsmps426_get_mode,
>  };
>  
> +static const struct regulator_ops spmi_ftsmps3_ops = {
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.is_enabled		= regulator_is_enabled_regmap,
> +	.set_voltage_sel	= spmi_regulator_ftsmps426_set_voltage,
> +	.set_voltage_time_sel	= spmi_regulator_set_voltage_time_sel,
> +	.get_voltage_sel	= spmi_regulator_ftsmps426_get_voltage,
> +	.map_voltage		= spmi_regulator_single_map_voltage,
> +	.list_voltage		= spmi_regulator_common_list_voltage,
> +	.set_mode		= spmi_regulator_ftsmps3_set_mode,
> +	.get_mode		= spmi_regulator_ftsmps3_get_mode,
> +	.set_load		= spmi_regulator_common_set_load,
> +	.set_pull_down		= spmi_regulator_common_set_pull_down,
> +};
> +
>  /* Maximum possible digital major revision value */
>  #define INF 0xFF
>  
> @@ -1549,6 +1651,16 @@ static const struct spmi_regulator_mapping supported_regulators[] = {
>  	SPMI_VREG(ULT_LDO, P300,     0, INF, ULT_LDO, ult_ldo, ult_pldo, 10000),
>  	SPMI_VREG(ULT_LDO, P150,     0, INF, ULT_LDO, ult_ldo, ult_pldo, 10000),
>  	SPMI_VREG(ULT_LDO, P50,     0, INF, ULT_LDO, ult_ldo, ult_pldo, 5000),
> +	SPMI_VREG(LDO, LV_P150_510, 0, INF, LDO_510, ftsmps3, ht_lvpldo, 10000),
> +	SPMI_VREG(LDO, LV_P300_510, 0, INF, LDO_510, ftsmps3, ht_lvpldo, 10000),
> +	SPMI_VREG(LDO, LV_P600_510, 0, INF, LDO_510, ftsmps3, ht_lvpldo, 10000),
> +	SPMI_VREG(LDO, MV_P50_510,  0, INF, LDO_510, ftsmps3, pldo660, 10000),
> +	SPMI_VREG(LDO, MV_P150_510, 0, INF, LDO_510, ftsmps3, pldo660, 10000),
> +	SPMI_VREG(LDO, MV_P600_510, 0, INF, LDO_510, ftsmps3, pldo660, 10000),
> +	SPMI_VREG(LDO, N300_510,    0, INF, LDO_510, ftsmps3, nldo_510, 10000),
> +	SPMI_VREG(LDO, N600_510,    0, INF, LDO_510, ftsmps3, nldo_510, 10000),
> +	SPMI_VREG(LDO, N1200_510,   0, INF, LDO_510, ftsmps3, nldo_510, 10000),
> +	SPMI_VREG(FTS, FTSMPS_510,  0, INF, FTSMPS3, ftsmps3, ftsmps510, 100000),
>  };
>  
>  static void spmi_calculate_num_voltages(struct spmi_voltage_set_points *points)
> @@ -1696,6 +1808,27 @@ static int spmi_regulator_init_slew_rate_ftsmps426(struct spmi_regulator *vreg,
>  	return ret;
>  }
>  
> +static int spmi_regulator_init_slew_rate_ftsmps3(struct spmi_regulator *vreg)
> +{
> +	int ret;
> +	u8 reg = 0;
> +	int delay;
> +
> +	ret = spmi_vreg_read(vreg, SPMI_FTSMPS3_REG_STEP_CTRL, &reg, 1);
> +	if (ret) {
> +		dev_err(vreg->dev, "spmi read failed, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	delay = reg & SPMI_FTSMPS426_STEP_CTRL_DELAY_MASK;
> +	delay >>= SPMI_FTSMPS426_STEP_CTRL_DELAY_SHIFT;
> +
> +

Drop two blank lines.


Best regards,
Krzysztof
