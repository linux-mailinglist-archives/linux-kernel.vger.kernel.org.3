Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABE2542AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiFHJK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiFHJJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:09:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890EC2194F3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:26:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x62so26030309ede.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pMsHwy7E/xLjDEEsUZts4AUene1hjdqOhTRjyDswkzk=;
        b=E8NB/2f0URNU7PNZSgEeDI0looKPg4GXnardUu6uxPQbCLD/BDqvF41YH6KXApwxiF
         gKgorM8EvdS80nuP67fOY6zeQPUuJxyghGCXx6+of6Zstz53Bm8BfDnDHPtLwle/07Fx
         neXE/8kBuRFM+vkSYKtPnOwV9ugYei5PauEaSDpOxOZdyFUFkNu4e/nYNdkwEiI8QckI
         qhrB6ce0Ecv/ZafjbLSx3g/VHDKecpICx9BSVDi8dtp3Xu1FOrNvwNb5PoKsVZbXfE2t
         SICv1/5CeF7SNl7NA4jTB/Toy4h6h9ptwo+8eOjoUOI8EYY/PZenaASSqqIgnaM2VLGK
         jj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pMsHwy7E/xLjDEEsUZts4AUene1hjdqOhTRjyDswkzk=;
        b=o75L6uEYzq79QHnv8RSi7SEXC0zpcdRolXH5JoclPKaOX54Z5EkrG+DCHTi1N+uTYo
         AP9gH6WcMRz5rq3xoWDgEabhGSnydDkjP22I7XCVNe/lCiUB8CaoGG8rWojXXBiHx9SD
         sZFcJS4gIIG+WMgxdLyJZKvLtG79hXcW2qOv2SWWwTFFkLwIDdMou/8NZb/rK7jPUHGm
         j959SUAsLtxIqYZi0YBXTAFQ+luZbvW3vaCGmoeAQJ0lf7cg69acNELyqwrXjv4/FxsV
         DdL74rXoQA1sXz0Ku9bLrFIFtvnprNtzKN2Ho01td8BWgkgT5uUh7BaOU5TbERkUiOUH
         H7Qw==
X-Gm-Message-State: AOAM533o89XEiU2spdtLGjMhiqAzdFp4BOyeEWypXAQy5LDW7UDpSCmy
        N+0PsskqA6VNPPEmKrNW/ZlgQQ==
X-Google-Smtp-Source: ABdhPJxT2XneRrGJcLdjXRKLMXv9KAQjDXOXQ3UZsDHcyZt3gLmxCrWYCweARDOvznAPwpQGiBR0zA==
X-Received: by 2002:a05:6402:3588:b0:42e:6a8:a5d5 with SMTP id y8-20020a056402358800b0042e06a8a5d5mr37733781edc.117.1654676806148;
        Wed, 08 Jun 2022 01:26:46 -0700 (PDT)
Received: from [192.168.0.189] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ss9-20020a170907c00900b00711d8696de9sm2938274ejc.70.2022.06.08.01.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:26:45 -0700 (PDT)
Message-ID: <ff5afd82-8183-b94a-afa5-ce9e684e97fb@linaro.org>
Date:   Wed, 8 Jun 2022 10:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: add SA8540P and ADP
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-5-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607214113.4057684-5-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 23:41, Bjorn Andersson wrote:
> Introduce the Qualcomm SA8540P automotive platform and the SA8295P ADP
> development board.
> 
> The SA8540P and SC8280XP are fairly similar, so the SA8540P is built
> ontop of the SC8280XP dtsi to reduce duplication. As more advanced
> features are integrated this might be re-evaluated.
> 
> This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
> regulators, debug UART, PMICs, remoteprocs (NSPs crashes shortly after
> booting) and USB.
> 
> The SA8295P ADP contains four PM8450 PMICs, which according to their
> revid are compatible with PM8150. They are defined within the ADP for
> now, to avoid creating additional .dtsi files for PM8150 with just
> addresses changed - and to allow using the labels from the schematics.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 434 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8540p.dtsi    | 133 +++++++
>  3 files changed, 568 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8540p.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index ceeae094a59f..2f416b84b71c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -52,6 +52,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> new file mode 100644
> index 000000000000..f78203d7bfd2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -0,0 +1,434 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +#include "sa8540p.dtsi"
> +
> +/ {
> +	model = "Qualcomm SA8295P ADP";
> +	compatible = "qcom,sa8295p-adp", "qcom,sa8540p";

Similarly to previous patch - this needs to be documented.

Rest looks ok.

Best regards,
Krzysztof
