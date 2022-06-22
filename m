Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EC8554EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359227AbiFVPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359240AbiFVPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:18:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6B5377F3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:18:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g26so13573856ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=KGHN8V/MAIJRoZiVsIc82ytAURP+6QoR2xSizEhnqIE=;
        b=AwntirR+Sp6DAcIOzmk1WFjzqReFE9ry4/mzdDiW/OfsDDT8ENg01M/2hHXYwwHIKN
         UooNHpmJMqQqfs7Vkqjin/cA8QdWusjILhtlqMcPWI7VKybsJI4dWRJZJXInr5goSpPq
         n8v9K8A7lygcL+vLnN//TVwxYquc+uAuoiChh2bgha6kzVQtWN71h6HZoRSaip3TNtJE
         vE/ayPdvnq4af59PIp/Uqt+Am9pXmPhdysxOlzlhodvasafulr70t9t0F+PrAtUKbQxr
         to8pHyECA4pe/rw9u4NXpjCmYwKYlN2pMNBsIcTcfcpfg+0nUsm4QYFmll7mIyUQiLMo
         IVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KGHN8V/MAIJRoZiVsIc82ytAURP+6QoR2xSizEhnqIE=;
        b=UT0iXp20cUFARbtlsQp2cZn0wzfTeychnFujnl7Xi5H9TFkBQgOond36xOWYb7KtDX
         8pFo17GHgTSBGbMzAdKtJF/gxf3AKOnE98eAg5Mw98uFrbkwzwp2h1tEcczxmLTEWRNa
         pXD3hevN8BnLu6F65eILdLU85hF0S/VRQ90EgwFa8do2ua3eHDdiNhJr7R4UZI8ack5T
         shrrOo7DGqJxHIuNbUDeoIrCZZOjRH2kARZhB2EEfAfthwe+lDmSXIqZL4jKxfKpyi2t
         jMi2onrHsgqoEK5bnCtawpmqCmn6byz8COOTLsAf7gTBDDLTbPcewxQeqWBrNu6d47h2
         8JHg==
X-Gm-Message-State: AJIora9Pt5KYySotw+Ky+EwvAKCd8qJHZ2LO9FkJeV5FnkFR9XPGNx0G
        Pun4doQOYHRT1xDpwF4G8dZ6WQ==
X-Google-Smtp-Source: AGRyM1uK824g/kFW/aTUbMXWwczn4JMyDfIciJmyAMAlZ5C5rNgycx6YKUE3YERXNZd/x/RKDRi6zw==
X-Received: by 2002:a17:907:868f:b0:702:f865:55de with SMTP id qa15-20020a170907868f00b00702f86555demr3704720ejc.24.1655911134088;
        Wed, 22 Jun 2022 08:18:54 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kx7-20020a170907774700b00722ea7a7febsm1568756ejc.194.2022.06.22.08.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 08:18:53 -0700 (PDT)
Message-ID: <876c9580-48ca-0491-24bc-4f20871277f0@linaro.org>
Date:   Wed, 22 Jun 2022 17:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V2 7/8] arm64: dts: Add ipq5018 SoC and MP03 board support
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
 <20220621161126.15883-8-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220621161126.15883-8-quic_srichara@quicinc.com>
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
> Add initial device tree support for the Qualcomm IPQ5018 SoC and
> MP03.1-C2 board.
> 
> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Chain needs fixes.

> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts |  29 +++
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 221 ++++++++++++++++++
>  3 files changed, 251 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5018.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index f9e6343acd03..c44e701f093c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-mp03.1-c2.dtb

This does not look like in proper order.

>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8150.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8910.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
> new file mode 100644
> index 000000000000..d1cd080ec3db
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +/*
> + * IPQ5018 CP01 board device tree source
> + *
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq5018.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ5018/AP-MP03-C2";
> +	compatible = "qcom,ipq5018-mp03", "qcom,ipq5018";
> +
> +	aliases {
> +		serial0 = &blsp1_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&blsp1_uart1 {
> +	pinctrl-0 = <&serial_1_pins>;
> +	pinctrl-names = "default";
> +	status = "ok";

"okay" is preferred.

> +};
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> new file mode 100644
> index 000000000000..084fb7b30dfd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +/*
> + * Copyright (c) 2017-2021, The Linux Foundation. All rights reserved.
> + */
> +/*
> + * IPQ5018 SoC device tree source
> + *
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.

Combine these two comments.

> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-ipq5018.h>
> +#include <dt-bindings/reset/qcom,gcc-ipq5018.h>
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	interrupt-parent = <&intc>;
> +
> +	sleep_clk: sleep-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	xo: xo {

Node name: xo-clk

> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;

The clock is provided by board, so at least frequency should be defined
there.

> +		#clock-cells = <0>;
> +	};
> +
> +	gen2clk0: gen2clk0 {

Keep consistent prefixes, so gen2-clk or gen2-0-clk

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "pcie20_phy0_pipe_clk";
> +	};
> +
> +	gen2clk1: gen2clk1 {

gen2-1-clk

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "pcie20_phy1_pipe_clk";
> +	};
> +


Best regards,
Krzysztof
