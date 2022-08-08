Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A5458C357
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiHHGcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiHHGcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:32:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE75810FDC
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:32:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o2so3929399lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 23:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TcTcVYINkT1LgQg4jB7USFvBaNV5S683l5CtEZpWSgI=;
        b=TGZkbfF2KN2XSw0JdREuQhXjlwQCdDbgydsKd9WjxRJNii6SYwx5+oOtiKjXAJCorf
         4ca1RBnrVNF0L8Slj1dQGmbdYey16Fwwp9MWliaUDp2cJC6waEA97E24RirVkn3lo0Wd
         4ObKzy0CgBCnrOeszWPZ7MOHM7a3/vIJ5pC1grNGra+dfE0GOY9K8i3jgrjUpiUo2iLO
         +RvGYv7JzjhxJ8ryIHnQmdPbGkOfNPvzrvNZbu2YRmYCG7L9Py5nE8JqmcGakLDpn+aD
         HoS0yKBoTcZT+f4Eix+tnkH8rJwqFXSNJPNkz/O6XTPzYryRYYsK6T3/acsf8Y3YUxKl
         FNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TcTcVYINkT1LgQg4jB7USFvBaNV5S683l5CtEZpWSgI=;
        b=TxWnDjaSiBCe8iEqRLFFoib6tocCtc2SGm54JRvPwNSQOe1fP7O7O9FZKAAuUR8m5r
         WjDzUX0Sgkahwrz4hEZw0loW2Oci90zNcLBT3X86ZkmdrF6zhSFlL5GwucC91xPeNNAc
         5hjvKUCjgzUVjkrzYU3mDjuZT28YJFQsK31S9ZfSch8oL+ENVVXVXXxjYyPLDtJ4W4nr
         epb0VdvcRb93Et1Tctr1NxNtj4eOrFJutNzCgTIAcLz7IdPJGgRQMWsGWgTwsPj6BK82
         Ycr3MIGtRY+xcFz/CENdC1uCKa2oh+PdXw3i+EBWABQiFC47dtuvKgdFZoYBKfMdWmr0
         7ZAg==
X-Gm-Message-State: ACgBeo2bB08ybKksp9nMn3nJwbMwcW3PcAtyfaUh4KdhdFJqfCteDJEi
        bUoAWqiE75wcsmJ6bTVq9RT1Xw==
X-Google-Smtp-Source: AA6agR5L7HlkTLMcyJ04cu9bbbvPKW99qL/El8g6wA5S21j2RAKlk0lSK55nP0DM01EO4L3wHGlWsQ==
X-Received: by 2002:a05:6512:31c5:b0:48b:38cf:51f8 with SMTP id j5-20020a05651231c500b0048b38cf51f8mr5964416lfe.315.1659940335132;
        Sun, 07 Aug 2022 23:32:15 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id z22-20020a2e9656000000b0025e4de48d36sm1271201ljh.94.2022.08.07.23.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:32:14 -0700 (PDT)
Message-ID: <1359679e-fdc8-1d71-0ff5-a7972e118c37@linaro.org>
Date:   Mon, 8 Aug 2022 09:32:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: split beryllium dts into common
 dtsi and tianma dts
Content-Language: en-US
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20220806210220.31565-1-joelselvaraj.oss@gmail.com>
 <20220806210220.31565-2-joelselvaraj.oss@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220806210220.31565-2-joelselvaraj.oss@gmail.com>
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

On 06/08/2022 23:02, Joel Selvaraj wrote:
> There are two panel variants of Xiaomi Poco F1. Tianma and EBBG panel.
> The previous beryllium dts supported the Tianma variant. In order to
> add support for EBBG variant, the common nodes from beryllium dts are
> moved to a new common dtsi and to make the variants distinguishable,
> sdm845-xiaomi-beryllium.dts is now named as
> sdm845-xiaomi-beryllium-tianma.dts
> 
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                      |  2 +-
>  ...ryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} |  9 +++++----
>  .../boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts   | 10 ++++++++++
>  3 files changed, 16 insertions(+), 5 deletions(-)
>  rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} (98%)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2f8aec2cc6db..02db413b228c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -106,7 +106,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> similarity index 98%
> rename from arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> rename to arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index d88dc07205f7..83edcb1171f5 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -221,8 +221,7 @@ &dsi0 {
>  	status = "okay";
>  	vdda-supply = <&vreg_l26a_1p2>;
>  
> -	panel@0 {
> -		compatible = "tianma,fhd-video";
> +	display_panel: panel@0 {
>  		reg = <0>;
>  		vddio-supply = <&vreg_l14a_1p8>;
>  		vddpos-supply = <&lab>;
> @@ -234,8 +233,10 @@ panel@0 {
>  		backlight = <&pmi8998_wled>;
>  		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
>  
> +		status = "disabled";
> +
>  		port {
> -			tianma_nt36672a_in_0: endpoint {
> +			panel_in_0: endpoint {
>  				remote-endpoint = <&dsi0_out>;
>  			};
>  		};
> @@ -243,7 +244,7 @@ tianma_nt36672a_in_0: endpoint {
>  };
>  
>  &dsi0_out {
> -	remote-endpoint = <&tianma_nt36672a_in_0>;
> +	remote-endpoint = <&panel_in_0>;
>  	data-lanes = <0 1 2 3>;
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> new file mode 100644
> index 000000000000..fcbef5ad2909
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "sdm845-xiaomi-beryllium-common.dtsi"

Nice diff.

However what happened to compatibles? Why do you have now two boards
with same compatible and model name?

Best regards,
Krzysztof
