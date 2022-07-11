Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B447A568859
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiGFMbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiGFMbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:31:03 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB7526AC8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:31:02 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D06DC3F642;
        Wed,  6 Jul 2022 14:30:59 +0200 (CEST)
Message-ID: <3bf68892-9a55-1d6e-fb43-346d9378a866@somainline.org>
Date:   Wed, 6 Jul 2022 14:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] [PATCH v2 2/2] arm64: dts: qcom: Add LTE SKUs for
 sc7280-villager family
Content-Language: en-US
To:     Jimmy Chen <jinghung.chen3@hotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <SG2PR03MB500697A11DA5D0B45DE41B0ECC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <SG2PR03MB500697A11DA5D0B45DE41B0ECC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.07.2022 04:22, Jimmy Chen wrote:
> This adds LTE skus for villager device tree files.
> 
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> ---
> 
>  arch/arm64/boot/dts/qcom/Makefile                 |  2 ++
>  .../arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 11 -----------
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts |  1 +
>  .../dts/qcom/sc7280-herobrine-herobrine-r1.dts    |  1 +
>  .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi   | 15 +++++++++++++++
>  .../dts/qcom/sc7280-herobrine-villager-r0-lte.dts | 14 ++++++++++++++
>  .../dts/qcom/sc7280-herobrine-villager-r1-lte.dts | 14 ++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts           |  1 +
>  8 files changed, 48 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index bb9f4eb3e65a0..6d81ff12f5af2 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -103,6 +103,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0-lte.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> index cfe2741456a1a..25f31c81b2b74 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> @@ -83,17 +83,6 @@ spi_flash: flash@0 {
>  	};
>  };
>  
> -/* Modem setup is different on Chrome setups than typical Qualcomm setup */
> -&remoteproc_mpss {
> -	status = "okay";
> -	compatible = "qcom,sc7280-mss-pil";
> -	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
> -	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
> -	memory-region = <&mba_mem>, <&mpss_mem>;
> -	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
> -			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
> -};
> -
>  &remoteproc_wpss {
>  	status = "okay";
>  	firmware-name = "ath11k/WCN6750/hw1.0/wpss.mdt";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> index e9ca6c5d24a16..921eccfec39ae 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> @@ -9,6 +9,7 @@
>  
>  #include "sc7280-herobrine.dtsi"
>  #include "sc7280-herobrine-audio-wcd9385.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> index c1647a85a371a..c1a6719687252 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>  
>  #include "sc7280-herobrine.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"
>  
>  / {
>  	model = "Google Herobrine (rev1+)";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> new file mode 100644
> index 0000000000000..a4809dd2f4e8a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Herobrine dts fragment for LTE SKUs
> + *
> + * Copyright 2022 Google LLC.
> + */
> +/* Modem setup is different on Chrome setups than typical Qualcomm setup */
> +&remoteproc_mpss {
Hi, just a minor nit.

It was recently agreed upon that the status property should go last to
make things consistent with other DTs (qcom is - as usual - a special
snowflake :D). Could you please fix that up? The rest looks good.

Konrad
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
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index 6d3ff80582ae9..fba7e938ce35a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
>  #include "sc7280-idp.dtsi"
>  #include "pmr735a.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
