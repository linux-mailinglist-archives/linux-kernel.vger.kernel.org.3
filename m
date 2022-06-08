Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5A9542C8A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiFHKFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiFHKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:03:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCDA16537E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:46:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c2so26279059edf.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j0PTdx0/UCIpK0ZOIeulGWW4GyE4LxYKkVGD3OmaXiU=;
        b=Fk+XgbdK5jt6EWM3XYV3oHRYmbpqB55Wv2esIF2vb1QeiZyuFNKtE0Fo0ZrxudjbGM
         0PocN0v51sQvP+fC4UV2UnbEwQTyqAOfMPizB1atI1tbT4GpIdEihfqXkFffFnVHvc8Q
         sN+5ZtpLXnyKbd/m20ae79ezGjRjBi7tmCbJuxjoPvegNDCCGzFK9tEwd2S8DPa012AS
         1ehQeu8KsrNiL7fprbh2o4ZzSNO1VbDLUE+oDtPtpXvgjzioUQM/15NRH3v8AgB8nbEq
         SWSNqghBxtngi0n9itnfLNDWRdtoe51Fee1wdWDf07X4XjhsLNyzQAuEuFzV7vLrST0C
         Ty1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j0PTdx0/UCIpK0ZOIeulGWW4GyE4LxYKkVGD3OmaXiU=;
        b=xf6VfVBywXBciOoSoxZKnqn9PRkb6YE6NLcpjWpyZE6fKizjSlcDiNA3CjbOM+Wbnm
         lBqczOx8cbDA1DFQJWtDhK3QtgkXmXxuw/LwzimGLVPGbgUNf5htDzl85kf2rZSWvfh6
         ck70uW4Kt+NnBdi7jcVud6CJINHojc0VfXkeR9wmM1wYcbedDdEw3YRIvYRWv2SLnKFw
         v5dFH3YTKEM/alu+Ca44xJstJ0WLJ6GoomHhWr75HdO66gmlboBCbQNt0pvxRUnebui8
         IJ34xqJwsG9nNPpU3UK/CJHbUWEH5z0lCMSjLuJCiYxrVS1/8+qLirDJGaN1ok999JsB
         JLMQ==
X-Gm-Message-State: AOAM530ugAIa0CgiONu8QOCZbWPYUR9zto4JFJTZToG8O5c+IxUBcG1H
        BpdFNK3gtTtndRpUQba6J3Xi8w==
X-Google-Smtp-Source: ABdhPJxvBQYdWTcwz3QvJ11WUeVjDfmXGE7aAyqClhYPiTBjrba7qY3e1zzsvhWdTEtYrBqeoC/9Nw==
X-Received: by 2002:a05:6402:400b:b0:42d:c902:6c75 with SMTP id d11-20020a056402400b00b0042dc9026c75mr38760810eda.32.1654681565480;
        Wed, 08 Jun 2022 02:46:05 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v3-20020a056402348300b0042dccb44e88sm971530edc.23.2022.06.08.02.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:46:04 -0700 (PDT)
Message-ID: <97d63ed3-ec95-5a2e-edab-01af687c1d34@linaro.org>
Date:   Wed, 8 Jun 2022 11:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v8 2/3] phy: qcom-snps: Add support for overriding phy
 tuning parameters
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com
References: <1654066564-20518-1-git-send-email-quic_kriskura@quicinc.com>
 <1654066564-20518-3-git-send-email-quic_kriskura@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654066564-20518-3-git-send-email-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 08:56, Krishna Kurapati wrote:
> Add support for overriding electrical signal tuning parameters for
> SNPS HS Phy.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 267 +++++++++++++++++++++++++-
>  1 file changed, 265 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> index 5d20378..14bbb06 100644
> --- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> @@ -52,6 +52,12 @@
>  #define USB2_SUSPEND_N				BIT(2)
>  #define USB2_SUSPEND_N_SEL			BIT(3)
>  
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0		(0x6c)
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1		(0x70)
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2		(0x74)
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3		(0x78)
> +#define PARAM_OVRD_MASK				0xFF
> +
>  #define USB2_PHY_USB_PHY_CFG0			(0x94)
>  #define UTMI_PHY_DATAPATH_CTRL_OVERRIDE_EN	BIT(0)
>  #define UTMI_PHY_CMN_CTRL_OVERRIDE_EN		BIT(1)
> @@ -60,12 +66,76 @@
>  #define REFCLK_SEL_MASK				GENMASK(1, 0)
>  #define REFCLK_SEL_DEFAULT			(0x2 << 0)
>  
> +#define HS_DISCONNECT_MASK			GENMASK(2, 0)
> +
> +#define SQUELCH_DETECTOR_MASK			GENMASK(7, 5)
> +

I wonder why do you have here blank lines after every define. Are these
bits from different registers?

> +#define HS_AMPLITUDE_MASK			GENMASK(3, 0)
> +
> +#define PREEMPHASIS_DURATION_MASK		BIT(5)
> +
> +#define PREEMPHASIS_AMPLITUDE_MASK		GENMASK(7, 6)

These two look like from same register...

> +
> +#define HS_RISE_FALL_MASK			GENMASK(1, 0)
> +
> +#define HS_CROSSOVER_VOLTAGE_MASK		GENMASK(3, 2)
> +
> +#define HS_OUTPUT_IMPEDANCE_MASK		GENMASK(5, 4)

The same

> +
> +#define LS_FS_OUTPUT_IMPEDANCE_MASK		GENMASK(3, 0)
> +
> +
>  static const char * const qcom_snps_hsphy_vreg_names[] = {
>  	"vdda-pll", "vdda33", "vdda18",
>  };
>  
>  #define SNPS_HS_NUM_VREGS		ARRAY_SIZE(qcom_snps_hsphy_vreg_names)
>  
> +struct override_param {
> +	s32	value;
> +	u8	reg;
> +};
> +
> +#define OVERRIDE_PARAM(bps, val)\
> +{				\
> +	.value = bps,		\
> +	.reg = val,		\
> +}
> +
> +struct override_param_map {
> +	struct override_param *param_table;
> +	u8 table_size;
> +	u8 reg_offset;
> +	u8 param_mask;
> +};
> +
> +#define OVERRIDE_PARAM_MAP(table, num_elements, offset, mask)		\
> +{									\
> +	.param_table = table,						\
> +	.table_size = num_elements,					\
> +	.reg_offset = offset,						\
> +	.param_mask = mask,						\
> +}
> +
> +struct phy_override_seq {
> +	bool	need_update;
> +	u8	offset;
> +	u8	value;
> +	u8	mask;
> +};
> +
> +static const char *phy_seq_props[] = {

static const char * const

> +	"qcom,hs-disconnect-bp",
> +	"qcom,squelch-detector-bp",
> +	"qcom,hs-amplitude-bp",
> +	"qcom,pre-emphasis-duration-bp",
> +	"qcom,pre-emphasis-amplitude-bp",
> +	"qcom,hs-rise-fall-time-bp",
> +	"qcom,hs-crossover-voltage-microvolt",
> +	"qcom,hs-output-impedance-micro-ohms",
> +	"qcom,ls-fs-output-impedance-bp",
> +};
> +
>  /**
>   * struct qcom_snps_hsphy - snps hs phy attributes
>   *
> @@ -91,6 +161,7 @@ struct qcom_snps_hsphy {
>  
>  	bool phy_initialized;
>  	enum phy_mode mode;
> +	struct phy_override_seq update_seq_cfg[ARRAY_SIZE(phy_seq_props)];
>  };
>  
>  static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
> @@ -173,10 +244,147 @@ static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode,
>  	return 0;
>  }
>  
> +static struct override_param hs_disconnect_sc7280[] = {

This should be const. I see you are using it in non-const way and this
makes me wonder why... You just need to store the value from the DT and
program it (after converting the units). Why modifying static driver
data? What if you have two phy drivers? Which data is being used?

IOW, all these tables should be const and you could store the final
value in 'struct qcom_snps_hsphy'. Then just program to registers this
final value.

Best regards,
Krzysztof
