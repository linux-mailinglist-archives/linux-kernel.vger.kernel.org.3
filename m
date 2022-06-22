Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5C3554EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359091AbiFVPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359177AbiFVPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:08:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E733A2DA9D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:08:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sb34so5848019ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=GbOJQbCPXXFQWcBB2NA2p6q5ubRmVUJFNDbSoq8WWes=;
        b=QpzQ8IqF4+E6u9y6gcaykwSNvt+WZSEw6Qm8CfS5bdebU8w50WYSD+LhSNsFo7IqYI
         wc6naJWlvFAenLoP/BlvW5dhD6KEHEwxGVTL4aovxDOwzHZUJQPPGVXy61e4C/XKkKdU
         Kj0LOS5tZAHOLgOhXpIi1ia4LgBZasqViFzA7H8j/KGZTq5ySkG+Z2SQflqKiPvI1vvB
         DDro1YRWeEmG4AqXPWBvXtuAMDjaYfsjKbLpJ0Hbw1ha9rnwOkbmkawRS8jnTw4cuSu/
         bbDs3dgNQx3IF+4QSKhdWaTGBcB2dmNpAyALq5zGTwlQ6iWqCnqw1CTkUz2ogTEKq9/o
         InKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GbOJQbCPXXFQWcBB2NA2p6q5ubRmVUJFNDbSoq8WWes=;
        b=PtQdI/m7q+auJVQoKkU43VcVpOPYXf/K9XPovL1EdTie2FoK376fDtAyi59DaUuAjs
         4NmhpIkfvCzJBwzwzGnJgEIbiWukXNe7WkfWnHm7rsw/jBKiqsz77RgBgosnfK7WVzxt
         B+n0T/f6pcNwVgC7B87sZkmdFWom81vy9sPM/7bBXcTGQvEOzHJyXztItliszy2cgv+k
         YQc0E4n71TKaWVMYGpovAjevPOAztU7n/pCDm2jkR90N4sRM99oOfoMKABkowsSsczcW
         WDRKI7N3g9Wlev/h4Z39km4oHAr3dy+HF0gjcQGj5Y7ojb7Y6yuCtAG+01zWQ19WagAl
         LWZA==
X-Gm-Message-State: AJIora/FMF6Qk1d/cqxXcA5Y8CMKDEHyQeAyXm7624EqkGVQfR+jytbl
        4WTU7G0SPKKL3L/BmqNiXhvILg==
X-Google-Smtp-Source: AGRyM1uQtjqkSd7z3x0Z+zwX6gwY0VPrtqmnMZ43RgvyIsvA51gBRnK4Lr4IJG+qwTZA2wb7ORRFQQ==
X-Received: by 2002:a17:906:5d0b:b0:722:ebcc:b10c with SMTP id g11-20020a1709065d0b00b00722ebccb10cmr3488593ejt.175.1655910515407;
        Wed, 22 Jun 2022 08:08:35 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t24-20020a056402021800b004356a647d08sm11299011edv.94.2022.06.22.08.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 08:08:35 -0700 (PDT)
Message-ID: <c9ec14db-1ddd-7316-4ef6-9d57509f3fad@linaro.org>
Date:   Wed, 22 Jun 2022 17:08:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V2 3/8] clk: qcom: Add Global Clock controller (GCC)
 driver for IPQ5018
Content-Language: en-US
To:     Sricharan R <quic_srichara@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, p.zabel@pengutronix.de,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
 <20220621161126.15883-4-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220621161126.15883-4-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2022 18:11, Sricharan R wrote:
> From: Varadarajan Narayanan <quic_varada@quicinc.com>
> 
> Add support for the global clock controller found on IPQ5018
> based devices.
> 
> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Thank you for your patch. There is something to discuss/improve.

> ---
>  drivers/clk/qcom/Kconfig       |    7 +
>  drivers/clk/qcom/Makefile      |    1 +
>  drivers/clk/qcom/gcc-ipq5018.c | 3995 ++++++++++++++++++++++++++++++++
>  3 files changed, 4003 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-ipq5018.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index d01436be6d7a..294fb975db85 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -172,6 +172,13 @@ config IPQ_GCC_8074
>  	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>  	  of ipq8074.
>  
> +config IPQ_GCC_5018
> +	tristate "IPQ5018 Global Clock Controller"
> +	help
> +	 Support for global clock controller on ipq5018 devices.
> +	 Say Y if you want to use peripheral devices such as UART, SPI,
> +	 i2c, USB, SD/eMMC, etc.
> +
>  config MSM_GCC_8660
>  	tristate "MSM8660 Global Clock Controller"
>  	help
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 671cf5821af1..33ab4ce9b863 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
>  obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>  obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>  obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
> +obj-$(CONFIG_IPQ_GCC_5018) += gcc-ipq5018.o
>  obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>  obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
>  obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o

(...)

> +
> +static int gcc_ipq5018_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct regmap *regmap;
> +	struct qcom_cc_desc ipq5018_desc = gcc_ipq5018_desc;
> +
> +	regmap = qcom_cc_map(pdev, &ipq5018_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
> +
> +	ret = qcom_cc_really_probe(pdev, &ipq5018_desc, regmap);

return qcom_cc_really_probe(....)

> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register ipq5018 GCC clocks\n");
> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev, "Registered ipq5018 GCC clocks provider");

No probe success messages. This pollutes the log and there is other
infrastructure to check for successful probe.

> +
> +	return ret;
> +}
> +
> +static struct platform_driver gcc_ipq5018_driver = {
> +	.probe = gcc_ipq5018_probe,
> +	.driver = {
> +		.name   = "qcom,gcc-ipq5018",
> +		.owner  = THIS_MODULE,

No need for owner.

> +		.of_match_table = gcc_ipq5018_match_table,
> +	},
> +};
> +
> +static int __init gcc_ipq5018_init(void)
> +{
> +	return platform_driver_register(&gcc_ipq5018_driver);
> +}
> +core_initcall(gcc_ipq5018_init);
> +
> +static void __exit gcc_ipq5018_exit(void)
> +{
> +	platform_driver_unregister(&gcc_ipq5018_driver);
> +}
> +module_exit(gcc_ipq5018_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. GCC IPQ5018 Driver");
> +MODULE_LICENSE("GPL v2");


Best regards,
Krzysztof
