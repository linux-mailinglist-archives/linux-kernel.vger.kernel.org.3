Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE556220D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiF3Saj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbiF3Sah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:30:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3A42A18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:30:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id fd6so8326edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8HMvgDx0M45hOe9EzGAGdmmBFNF04LJ7caeVS5Jltm8=;
        b=I0Vj0nW8bONLNtF/M3fSTsRtcr+3vp0s5xn6kieZd2YagFyEH59dTgYRoNVVl3e8SJ
         CfDNk4pq4B/V3S0UOnERenMxrbwzJqPZtNagRNAi054J37qoGYTs1y2jVtlI7SJ4NJhd
         U7N4gRAvP+QARTwqkf1YOxspcUKugRIXBNlgt/TFDB9VOrgoHZ0p1LtjjPtwwTyNiUKx
         Ay5TLzocbIUS9/ZyIr7F9899+VFeN+SKq/ajtjUpSbA3AofF90AqCVgr1Bzd9To016VJ
         pRYvajT3FpbLD0yqzBX6vvfVdVYpS/nIDwnFGNDbLfRB9YmrO9sqnHuwYVgYkwdE7fcJ
         sJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8HMvgDx0M45hOe9EzGAGdmmBFNF04LJ7caeVS5Jltm8=;
        b=7nAfqPbZTC1KXgwR1uvdjPoq+ggrFMF0v3ZkbkssVV+K/iZmfMyi2t2pDBFwPVMqUR
         qTqn4ugLIdJ+waV17U64b5lWFPR8JFSIPNQ5IJ24GAlfPYVqfpKmdnX1g71LIwujoFvY
         FSTNz8tW/NWx/HlxZqfx6kUskSFd9l/Dk7i2KAIIntzREUBFmvKNQsYliVe+A4t9+VAw
         3yDPCAkG4BYolzyuS4zMb0dOY8xdPj6tDjO4WT5BgociBG8vIoJsZNt7XEOtIhBKj8nD
         wv6srG1vH99IxBccfKsT7ZzKbNWO5JQ+0yXALK31/HxNCYS/C0taQbMa9Eid40gRsWwH
         NZVQ==
X-Gm-Message-State: AJIora/P2Z6MFboll1Tci/cQZjn49MVEsxGAS41+/aHNlTmuUHd4TFJI
        8GYcA2Q5r2ED24TLyxGmNNnYDg==
X-Google-Smtp-Source: AGRyM1s4MONlgYXs7qxpA3tmdCGfx/WaTLR64DFqg92GMhzYfpDH56CO77DwihQhw6Y6IHLTTjcdxQ==
X-Received: by 2002:a05:6402:d5e:b0:435:dc14:d457 with SMTP id ec30-20020a0564020d5e00b00435dc14d457mr13333068edb.58.1656613833032;
        Thu, 30 Jun 2022 11:30:33 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7c98b000000b00435a912358dsm13601687edt.30.2022.06.30.11.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:30:32 -0700 (PDT)
Message-ID: <306aa2da-9393-2a01-63a4-e1c81fa85e39@linaro.org>
Date:   Thu, 30 Jun 2022 20:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] FROMLIST: arm64: dts: qcom: Add LTE SKUs for
 sc7280-villager family
Content-Language: en-US
To:     Jimmy Chen <jinghung.chen3@hotmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Jimmy Chen <jinghung.chen43@yahoo.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <SG2PR03MB5006F091C2016ADE8A9A208ECCBA9@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SG2PR03MB5006F091C2016ADE8A9A208ECCBA9@SG2PR03MB5006.apcprd03.prod.outlook.com>
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

On 30/06/2022 08:26, Jimmy Chen wrote:
> From: Jimmy Chen <jinghung.chen43@yahoo.com>
> 
> This adds LTE skus for villager device tree files.
> 
> Signed-off-by: Jimmy Chen <jinghung.chen43@yahoo.com>
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>

Use one identity and fix the subject - it's corrupted.

> ---
> 
>  arch/arm64/boot/dts/qcom/Makefile                 |  3 +++
>  .../arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |  7 -------
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts |  1 +
>  .../qcom/sc7280-herobrine-herobrine-r1-lte.dts    | 14 ++++++++++++++
>  .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi   | 15 +++++++++++++++
>  .../dts/qcom/sc7280-herobrine-villager-r0-lte.dts | 14 ++++++++++++++
>  .../dts/qcom/sc7280-herobrine-villager-r1-lte.dts | 14 ++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi          |  1 +
>  8 files changed, 62 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2f8aec2cc6db6..ab1066883c468 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -85,7 +85,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += sc7280-herobrine-herobrine-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += sc7280-herobrine-villager-r0-lte.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += sc7280-herobrine-villager-r1-lte.dtb

This looks not aligned with other entries.

>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> index 9f4a9c263c351..b1f83ddb4e23a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> @@ -83,13 +83,6 @@ spi_flash: flash@0 {
>  	};
>  };
>  
> -/* Modem setup is different on Chrome setups than typical Qualcomm setup */
> -&remoteproc_mpss {
> -	status = "okay";
> -	compatible = "qcom,sc7280-mss-pil";
> -	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
> -	memory-region = <&mba_mem>, <&mpss_mem>;
> -};
>  
>  /* Increase the size from 2.5MB to 8MB */
>  &rmtfs_mem {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> index a4ac33c4fd59a..7aaba5e51af01 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>  
>  #include "sc7280-herobrine.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts
> new file mode 100644
> index 0000000000000..e37773fd63b3b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Herobrine board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7280-herobrine-villager-r0.dts"
> +#include "sc7280-herobrine-lte-sku.dtsi"
> +
> +/{
> +	model = "Google Herobrine (rev1+) with LTE";
> +	compatible = "google,herobrine-sku0", "qcom,sc7280";

DT bindings update is needed. Unless it is already part of some other
set, but then this should be explained in some cover letter.

> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> new file mode 100644
> index 0000000000000..c628910b310d3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +  /*
> +   * Google Herobrine dts fragment for LTE SKUs
> +   *
> +   * Copyright 2022 Google LLC.
> +   */
> +/* Modem setup is different on Chrome setups than typical Qualcomm setup */
> +&remoteproc_mpss {
> +	status = "okay";
> +	compatible = "qcom,sc7280-mss-pil";
> +	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
> +	memory-region = <&mba_mem>, <&mpss_mem>;
> +	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
> +			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
> new file mode 100644
> index 0000000000000..672cb78e3088f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Villager board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7280-herobrine-villager-r0.dts"
> +#include "sc7280-herobrine-lte-sku.dtsi"
> +
> +/ {
> +	model = "Google Villager (rev0) with LTE";
> +	compatible = "google,villager-rev0-sku0", "qcom,sc7280";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> new file mode 100644
> index 0000000000000..2f05a19cc388e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Villager board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7280-herobrine-villager-r1.dts"
> +#include "sc7280-herobrine-lte-sku.dtsi"
> +
> +/ {
> +	model = "Google Villager (rev1+) with LTE";
> +	compatible = "google,villager-sku0", "qcom,sc7280";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 5eb668991e249..6928a0908fcd6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -13,6 +13,7 @@
>  #include "pmk8350.dtsi"
>  
>  #include "sc7280-chrome-common.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"

This looks like independent commit.

>  
>  / {
>  	aliases {


Best regards,
Krzysztof
