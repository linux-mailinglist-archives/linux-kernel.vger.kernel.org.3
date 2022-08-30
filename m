Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448CB5A5F89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiH3Jf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiH3Jeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:34:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4040E58AF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:33:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id br21so8935028lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Sg21c2U2EDU591BTmReyYxGtxFU2rdWH4lXcz9Jl/oQ=;
        b=UwZYN0UUvos+DFIuMcMKB3/g70v3pn0hSXod2WnobjsosLlxM6kc3MnjSquBQ4YB01
         C8+4FlN6dJKloZ6tAHIniVANNjj2S3Uj7hAfJ121LePeGSAg8R2qs82XPu3yrtSqV5uB
         4lr3R3VIprm4JwhjyDgYyHRY8lN5UKqy2h/RzKb1+6pOdBz7CQ6EHJK1tdSWmRhBk86x
         2oDZpP8yBcbncwsxoHSVZiyT1xccZcfZzLIHwL5rQC748fggv06LdR34ktXRtdB8COQI
         T9wVYQ59zQ9ui9T/fcB0oxAaBSZWz5A+hGMm5QcuTJUwey65/YnoUEwSDp1fDyMZzA5b
         gMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Sg21c2U2EDU591BTmReyYxGtxFU2rdWH4lXcz9Jl/oQ=;
        b=GQU5EaKr4LNlS9t/dxDm9qEGOpSvc+zZEHuMUGeJKstH5tRREMGzwGL5cDC5MXsNPR
         ohS4Fzfcgp5bCgAojRCuWU4TO2ysUnFnSidcc8y85g+m0DGfNUHFz3aDsjcS5F9xcgPG
         vtxnjyI22MDzLm7FIWFtrpSbsKYL/aVktcsCeXe/wCPgAfXHUFe0zkmER0pqOujZF3rI
         37+1ida09m1SQgo84Elyp2T/KMDhomgaelzT0NQFmFMsko9UgLlE0kUi5Wu8aGX87NFG
         KAtkwA83wsIC+7XNNXY1ZOYWnTUWaWX8YEaO7Cs2GZzP66Z3zLCvOYVTn6CBq8TEzj/Z
         PrCw==
X-Gm-Message-State: ACgBeo1CzavL1bAiVw1FMX90HC5aK6Gwjb9zad03T/E1L3aPtcuTQjLK
        vXIVlH76HhAS1IEDL978hIjApA==
X-Google-Smtp-Source: AA6agR5yh8X5BmKU4wxxWdgpsp/W/CNveRawwlV8nLGSOyxDU0ID2dkfzy1lRZaQcQkOIti+Cy+hYQ==
X-Received: by 2002:ac2:5462:0:b0:48b:2a7b:3c15 with SMTP id e2-20020ac25462000000b0048b2a7b3c15mr7783055lfn.489.1661851981612;
        Tue, 30 Aug 2022 02:33:01 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id a13-20020ac2520d000000b0048a9603399csm1556472lfl.116.2022.08.30.02.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:33:01 -0700 (PDT)
Message-ID: <184d4ff5-e80c-6a24-8071-0b0a69710685@linaro.org>
Date:   Tue, 30 Aug 2022 12:32:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] arm64: dts: qcom: sc7280: Add device tree for
 herobrine evoker
Content-Language: en-US
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     mka@chromium.org, dianders@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220830053307.3997495-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220830133300.1.I7dd7a79c4cc5fe91c3feb004473feb3b34b7b2d8@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830133300.1.I7dd7a79c4cc5fe91c3feb004473feb3b34b7b2d8@changeid>
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

On 30/08/2022 08:33, Sheng-Liang Pan wrote:
> Add a basic device tree for the herobrine evoker board.
> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sc7280-herobrine-evoker-r0.dts   | 333 ++++++++++++++++++
>  2 files changed, 334 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 1d86a33de528c..59c22ba54a366 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -103,6 +103,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> new file mode 100644
> index 0000000000000..ccbe50b6249ab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Evoker board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7280-herobrine.dtsi"
> +
> +/ {
> +	model = "Google Evoker";
> +	compatible = "google,evoker", "qcom,sc7280";

Undocumented compatible.

Please run scripts/checkpatch.pl and fix reported warnings.

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +};
> +
> +/*
> + * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES

What does it mean and why it's SCREAMING?

> + *
> + * Sort order matches the order in the parent files (parents before children).

Why? Sorting should be rather alphabetical.


Best regards,
Krzysztof
