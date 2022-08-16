Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE59595D85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiHPNjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiHPNjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:39:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76F641D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:39:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so14939554lfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=x/vaRiOOU21IuGmCpE4aZJDprVivgqzk7X8uAzJCMUU=;
        b=BJKBj6DQsaDvXnmM0pZpihAjMt8H2x4QLtpefnTPys1lYrtR/Orv3IO0Pbd/KvubpS
         RKa78/a/wFDk++buB22JwvNjkSgp0lqrz1vZjMmfodKSjDbiJyJvOEHE/2GYhhLykuZ6
         +925tQf7yNTE19yzk7yiFgT5ZY4bsKeJEYCqWFlCspoXZYy4iAEcdKJ8gnlajszlBCqS
         hv0js/oMtNLTTy9M9hLa3nOF77MtB4pnvVkAI5AKcOUOgnPXD9Lfd+Bd/bbkybhJhUEQ
         l7p8prVf33U4KZUojLYFo+EO1JCI1pf/zDLJ/BcSr3eGOZL3Ech2igYcsegwreelkpQO
         hAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=x/vaRiOOU21IuGmCpE4aZJDprVivgqzk7X8uAzJCMUU=;
        b=ra7W5EPe8dvaa8m1cVY5iPmoHZHi1Am+HAtgwy2Vi5PHoBoTnOPtjU7qXuSWX7MkWv
         XUSi8hhfZe7B1AvexM4jZwHtE0m/Ybgh481lQgeB/As8EjFT/sNf3CZWF/45nld1qyUE
         YSIE3LTEkIqZhYfWVThv/OkxnchXNPPVI6LAhdrsw6d6qaOYuvwasXcYS18LOUi5xadu
         oe544iT2oFn5noJ50hJfbna7oyMf5VOemiVvHJ4y9vV1ZfWYobFIACVRaXn8qAw8jkiS
         swIHeu9ncv5k2yZV2ZwlouJ32QIONLhhRUGTmSFzJF/V/Yyq3J0vYYbnftk0azH+TdoK
         wPOg==
X-Gm-Message-State: ACgBeo3ArqJTuc/Q34l5vCupt+puWFkHQt1Zgim7lGjMy1BmdxdQrTFa
        G6TjqxMNY09gMRG7RV2BR9OwXQ==
X-Google-Smtp-Source: AA6agR5ChdkHEDah1oK10Jh7b4i7HL9FxjhrHX2yx5J31ITpC0HkfuPcYTHax+h64VHOJ4yH418Bfw==
X-Received: by 2002:a05:6512:230a:b0:48c:2e06:6c74 with SMTP id o10-20020a056512230a00b0048c2e066c74mr7461447lfu.358.1660657154846;
        Tue, 16 Aug 2022 06:39:14 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id v18-20020ac258f2000000b0048b26d4bb64sm1401791lfo.40.2022.08.16.06.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 06:39:14 -0700 (PDT)
Message-ID: <94d8f4e0-3fc0-0143-4039-4b50c655530e@linaro.org>
Date:   Tue, 16 Aug 2022 16:39:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 2/2] arm64: dts: imx8mp-msc-sm2s: Add device trees for
 MSC SM2S-IMX8PLUS SoM and carrier board
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220816123849.747157-1-martyn.welch@collabora.com>
 <20220816123849.747157-2-martyn.welch@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816123849.747157-2-martyn.welch@collabora.com>
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

On 16/08/2022 15:38, Martyn Welch wrote:
> Add device trees for one of a number of MSC's (parent company, Avnet)
> variants of the SM2S-IMX8PLUS system on module along with the compatible
> SM2S-SK-AL-EP1 carrier board. As the name suggests, this family of SoMs use
> the NXP i.MX8MP SoC and provide the SMARC module interface.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Thank you for your patch. There is something to discuss/improve.

> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> new file mode 100644
> index 000000000000..3ea822d9e58d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Avnet Embedded GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp-msc-sm2s-14N0600E.dtsi"
> +#include <dt-bindings/clock/imx8mp-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "MSC SM2-MB-EP1 Carrier Board with SM2S-IMX8PLUS-QC6-14N0600E SoM";
> +	compatible = "avnet,sm2s-imx8mp-14N0600E-ep1",
> +		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
> +		     "fsl,imx8mp";
> +};
> +
> +&flexcan1 {
> +	status = "okay";
> +};
> +
> +&flexcan2 {
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	no-1-8-v;
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_smarc_gpio>;
> +
> +	pinctrl_smarc_gpio: smarcgpiosgrp {
> +		fsl,pins =
> +			<MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	0x19>, /* GPIO0 */
> +			<MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01	0x19>, /* GPIO1 */
> +			<MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02	0x19>, /* GPIO2 */
> +			<MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03	0x19>, /* GPIO3 */
> +			<MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x19>, /* GPIO4 */
> +			<MX8MP_IOMUXC_SAI3_MCLK__GPIO5_IO02	0x19>, /* GPIO5 */
> +			<MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x19>, /* GPIO6 */
> +			<MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10	0x19>, /* GPIO7 */
> +			<MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20	0x19>, /* GPIO8 */
> +			<MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21	0x19>, /* GPIO9 */
> +			<MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22	0x19>, /* GPIO10 */
> +			<MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x19>, /* GPIO11 */
> +			<MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19	0x19>, /* GPIO12 */
> +			<MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00	0x19>; /* GPIO13 */
> +	};
> +};
> +

No need for trailing blank line.

With this fixed:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
