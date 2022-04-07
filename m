Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D24F851F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiDGQp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241664AbiDGQp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:45:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C63F1C1E46
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:43:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so2325566pja.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ua13KjJ44TnzMW/JsRGbxh5MdZZs5pUlw2C+XLDEQAU=;
        b=kmDrfwgHcJfDO6CqJKi8wbwaQKrr9LHOWNheZWqSFdFeL5ZuSgD/YmQiUhFyOVy0uC
         DBgRoipvJ6c+7bzP67Ywn7+E+dMJO/70nCuF9MA7VAN0nq4x1nOsZ2iW3RwcUxwv3K3A
         uJ1qPh4r7v36KtvUEx9Ql+TtTyVbVd94RSdwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ua13KjJ44TnzMW/JsRGbxh5MdZZs5pUlw2C+XLDEQAU=;
        b=pvR+YycyG7P4MwZ9bW04s2bv4ehKQbIC9TmqfPU4L7jNXm30YxgndqjDXLMZgNqEOj
         Ib9ag+TyE+J382Ok2lSLXYPxr2NUZT2uzly0tO87fr4aLCQaTFKRuKmJ4gL/OlZUCH3l
         gm+4nFknxMZauqYziZN0gG/enk0shjV0TJ7vzJqPAN54BlVzGRZf7PSTx3sF0EbM1PfJ
         pHzDJxC4jCDSkVW7mM+DwUez8v3+jI22UIxbnJw7BB5DsBpnzXIe3fHpsIG38+APsHeE
         X6CvLNjGfZXPY8qjPwIusqP0kQqDBiIwbGoZTfxpuvtQOC3dRR6LV1pRL1tVaRY2rzOx
         SmKA==
X-Gm-Message-State: AOAM530mPYLYfdPu1rYUXyZAeSWtcSSG0LXpt6TgG50INfKaP9+aDwaX
        EdLvv9WcdAGECMhsRQovOj0vKg==
X-Google-Smtp-Source: ABdhPJwD9ZPPEfmsluDZxDBfd5nSYo8Z7c3H37FzPDzr6bIxpBhX5zCHgKTIjg7w21SQZT7dKdhNLw==
X-Received: by 2002:a17:90b:915:b0:1ca:b584:8241 with SMTP id bo21-20020a17090b091500b001cab5848241mr16878815pjb.46.1649349828860;
        Thu, 07 Apr 2022 09:43:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:693e:9ca0:42a0:6bf7])
        by smtp.gmail.com with UTF8SMTPSA id q7-20020a056a00084700b004fb205947c7sm24520071pfk.131.2022.04.07.09.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 09:43:48 -0700 (PDT)
Date:   Thu, 7 Apr 2022 09:43:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2]arm64: dts: qcom: Add sc7180-gelarshie
Message-ID: <Yk8Uws1/Uia1B4Ok@google.com>
References: <20220407075427.41141-1-chenxiangrui@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220407075427.41141-1-chenxiangrui@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 03:54:26PM +0800, Mars Chen wrote:

> Subject: [PATCH] [v2]arm64: dts: qcom: Add sc7180-gelarshie

Krzysztof already pointed out that the subject is incorrect. Besides that
the version number also looks wrong. This is at least v3:

v3: this patch
v2 dupe (?): https://patchwork.kernel.org/project/linux-arm-msm/patch/20220406094156.3191-1-chenxiangrui@huaqin.corp-partner.google.com/
v2 dupe (?): https://patchwork.kernel.org/project/linux-arm-msm/patch/20220406074707.2393-1-chenxiangrui@huaqin.corp-partner.google.com/
v2: https://patchwork.kernel.org/project/linux-arm-msm/patch/20220406073756.2041-1-chenxiangrui@huaqin.corp-partner.google.com/
v1: https://patchwork.kernel.org/project/linux-arm-msm/patch/20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com/

> Add device tree for Gelarshie, a trogdor variant
> 
> Signed-off-by: Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sc7180-trogdor-gelarshie-r0.dts  |  15 +
>  .../dts/qcom/sc7180-trogdor-gelarshie.dtsi    | 280 ++++++++++++++++++
>  3 files changed, 296 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index f9e6343acd03..cf8f88b065c3 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3-lte.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-gelarshie-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
> new file mode 100644
> index 000000000000..027d6d563a5f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Gelarshie board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7180-trogdor-gelarshie.dtsi"
> +
> +/ {
> +	model = "Google Gelarshie (rev0+)";
> +	compatible = "google,gelarshie", "qcom,sc7180";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
> new file mode 100644
> index 000000000000..8758cafb2d89
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
>
> ...
>
> +&sound {
> +	compatible = "google,sc7180-gelarshie";

There is currently no device tree binding for this compatible string. Is
the gelarshie audio config different from that of coachz? If not the
compatible string "google,sc7180-coachz" should be used.

> +	model = "sc7180-adau7002-max98357a";
> +	audio-routing = "PDM_DAT", "DMIC";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dmic_clk_en>;
> +};
> +
> +&sound_multimedia0_codec {
> +	sound-dai = <&adau7002>;
> +};
> +
> +/* PINCTRL - modifications to sc7180-trogdor.dtsi */
> +
> +&en_pp3300_dx_edp {
> +	pinmux  {
> +		pins = "gpio67";
> +	};
> +
> +	pinconf {
> +		pins = "gpio67";
> +	};
> +};
> +
> +&ts_reset_l {
> +	pinconf {
> +		/*
> +		 * We want reset state by default and it will be up to the
> +		 * driver to disable this when it's ready.
> +		 */
> +		output-low;
> +	};
> +};
> +
> +/* PINCTRL - board-specific pinctrl */
> +
> +&tlmm {
> +	gpio-line-names = "HUB_RST_L",

nit: to make this list more digestible you could add comments with
pin numbers for every 10th pin and an empty line to separate the
'pin groups'  even more visually. See sc7280-herobrine-herobrine-r1.dts
for an example.

> +			  "AP_RAM_ID0",
> +			  "AP_SKU_ID2",
> +			  "AP_RAM_ID1",
> +			  "WF_CAM_EN2",
> +			  "AP_RAM_ID2",
> +			  "UF_CAM_EN",
> +			  "WF_CAM_EN",
> +			  "TS_RESET_L",
> +			  "TS_INT_L",
> +			  "",
> +			  "EDP_BRIJ_IRQ",
> +			  "AP_EDP_BKLTEN",
> +			  "UF_CAM_MCLK",
> +			  "WF_CAM_MCLK",
> +			  "EDP_BRIJ_I2C_SDA",
> +			  "EDP_BRIJ_I2C_SCL",
> +			  "UF_CAM_SDA",
> +			  "UF_CAM_SCL",
> +			  "WF_CAM_SDA",
> +			  "WF_CAM_SCL",
> +			  "",
> +			  "",
> +			  "AMP_EN",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "WF_CAM_RST_L",
> +			  "UF_CAM_RST_L",
> +			  "AP_BRD_ID2",
> +			  "BRIJ_SUSPEND",
> +			  "AP_BRD_ID0",
> +			  "AP_H1_SPI_MISO",
> +			  "AP_H1_SPI_MOSI",
> +			  "AP_H1_SPI_CLK",
> +			  "AP_H1_SPI_CS_L",
> +			  "BT_UART_CTS",
> +			  "BT_UART_RTS",
> +			  "BT_UART_TXD",
> +			  "BT_UART_RXD",
> +			  "H1_AP_INT_ODL",
> +			  "",
> +			  "UART_AP_TX_DBG_RX",
> +			  "UART_DBG_TX_AP_RX",
> +			  "",
> +			  "",
> +			  "FORCED_USB_BOOT",
> +			  "AMP_BCLK",
> +			  "AMP_LRCLK",
> +			  "AMP_DIN",
> +			  "",
> +			  "HP_BCLK",
> +			  "HP_LRCLK",
> +			  "HP_DOUT",
> +			  "",
> +			  "",
> +			  "AP_SKU_ID0",
> +			  "AP_EC_SPI_MISO",
> +			  "AP_EC_SPI_MOSI",
> +			  "AP_EC_SPI_CLK",
> +			  "AP_EC_SPI_CS_L",
> +			  "AP_SPI_CLK",
> +			  "AP_SPI_MOSI",
> +			  "AP_SPI_MISO",
> +			  /*
> +			   * AP_FLASH_WP_L is crossystem ABI. Schematics
> +			   * call it BIOS_FLASH_WP_L.
> +			   */
> +			  "AP_FLASH_WP_L",
> +			  "EN_PP3300_DX_EDP",
> +			  "AP_SPI_CS0_L",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "WLAN_SW_CTRL",
> +			  "BOOT_CONFIG_0",
> +			  "REPORT_SWITCH",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "DMIC_CLK_EN",
> +			  "HUB_EN",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "AP_SKU_ID1",
> +			  "AP_RST_REQ",
> +			  "",
> +			  "AP_BRD_ID1",
> +			  "AP_EC_INT_L",
> +			  "BOOT_CONFIG_1",
> +			  "",
> +			  "",
> +			  "BOOT_CONFIG_4",
> +			  "BOOT_CONFIG_2",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "EDP_BRIJ_EN",
> +			  "",
> +			  "",
> +			  "BOOT_CONFIG_3",
> +			  "WCI2_LTE_COEX_TXD",
> +			  "WCI2_LTE_COEX_RXD",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "FORCED_USB_BOOT_POL",
> +			  "AP_TS_PEN_I2C_SDA",
> +			  "AP_TS_PEN_I2C_SCL",
> +			  "DP_HOT_PLUG_DET",
> +			  "EC_IN_RW_ODL";
> +
> +	dmic_clk_en: dmic_clk_en {

node names should use dashes as separators, i.e.:
	dmic_clk_en: dmic-clk-en {

> +		pinmux {
> +			pins = "gpio83";
> +			function = "gpio";
> +		};
> +
> +		pinconf {
> +			pins = "gpio83";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +	};
> +};
