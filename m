Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B969574E62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbiGNMvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbiGNMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:51:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6022427CC3;
        Thu, 14 Jul 2022 05:51:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 32FB56601A18;
        Thu, 14 Jul 2022 13:51:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657803100;
        bh=/qRsaiAgLbzGHG/6WO0k1pR3txmkbfbYsKKPfsVfxDY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K5ZCojJY9+IgZigrYxxRVXd1B0oPGlmzaTgndBKrwfb/7yGNbclqNPlC2qyNnokN0
         6Kye+CdGZwEtRn0gKtGBGnaJqQN9/XSTju9OOw/3/5vP9h95GMD+JMf7+pUXymnJB2
         rEFtYb9L5pGgNjU3sJXNmuY1dNF5qcDpOREHfM46isRcvTrIt9mJnyCXu8dEcDgI2+
         z079De/tXFGh4SQTMG7eYXXKRNdsbIneAeOF1euzD40hPG9pUcFI4hbQ9/z8SQxiDC
         zF+D8GhORS9o1mHYi6zvQsBKK5dkQUIEub3gOeQCgZy7vQYP0Vq7F078kh9DhPVAgD
         brRF0v3eHJvNw==
Message-ID: <ef935a6f-77a2-5c9a-2cbc-0b0192aee56b@collabora.com>
Date:   Thu, 14 Jul 2022 14:51:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: Add device tree for Sony Xperia
 1 IV
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220714123406.1919836-1-konrad.dybcio@somainline.org>
 <20220714123406.1919836-5-konrad.dybcio@somainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220714123406.1919836-5-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/07/22 14:34, Konrad Dybcio ha scritto:
> Add support for Sony Xperia 1 IV, a.k.a PDX223. This device is a part
> of the SoMC SM8450 Nagara platform and currently it is the only
> device based on that board, so no -common DTSI is created until (if?)
> other Nagara devices appear.
> 
> This commit brings support for:
> * SD Card
> * USB (*including SuperSpeed*)
> * ADSP/CDSP/SLPI (modem remains untested for now)
> * Most regulators (some GPIO-enabled ones require PMIC GPIOs but
> trying to access any SPMI device crashes the device..)
> * Part of I2C-connected peripherals (notably no touch due to a
> driver bug)
> * PCIe0 (PCIe1 is unused)
> 
> Do note display via simplefb is not supported, as the display is blanked
> upon exiting XBL.
> 
> To create a working boot image, you need to run:
> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/sm8450-sony-xperia-\
> nagara-pdx223.dtb > .Image.gz-dtb
> 
> mkbootimg \
> --kernel .Image.gz-dtb \
> --ramdisk some_initrd.img \
> --pagesize 4096 \
> --base 0x0 \
> --kernel_offset 0x8000 \
> --ramdisk_offset 0x1000000 \
> --tags_offset 0x100 \
> --cmdline "SOME_CMDLINE" \
> --dtb_offset 0x1f00000 \
> --header_version 1 \
> --os_version 12 \
> --os_patch_level 2022-06 \ # or newer
> -o boot.img-sony-xperia-pdx223
> 
> Then, you need to flash it on the device and get rid of all the
> vendor_boot/dtbo mess:
> 
> // You have to either pull vbmeta{"","_system"} from
> // /dev/block/bootdevice/by-name/ or build one as a part of AOSP build process
> fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
> fastboot --disable-verity --disable-verification flash vbmeta_system \
> vbmeta_system.img
> 
> fastboot flash boot boot.img-sony-xperia-pdx223
> fastboot erase vendor_boot
> fastboot erase recovery
> fastboot flash dtbo emptydtbo.img
> fastboot reboot
> 
> Where emptydtbo.img is a tiny file that consists of 2 bytes (all zeroes), doing
> a "fastboot erase" won't cut it, the bootloader will go crazy and things will
> fall apart when it tries to overlay random bytes from an empty partition onto a
> perfectly good appended DTB.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> - remove a stray blank line
> - use generic node names for CS35L41
> - fix up indentation for sdhci-caps-mask
> 
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../qcom/sm8450-sony-xperia-nagara-pdx223.dts | 634 ++++++++++++++++++
>   2 files changed, 635 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 01773f3ce57f..157ef6958e1f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -126,3 +126,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
> new file mode 100644
> index 000000000000..7fe582b92a61
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
> @@ -0,0 +1,634 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm8450.dtsi"
> +
> +/delete-node/ &adsp_mem;
> +/delete-node/ &rmtfs_mem;
> +/delete-node/ &video_mem;
> +
> +/ {
> +	model = "Sony Xperia 1 IV";
> +	compatible = "sony,pdx223", "qcom,sm8450";
> +	chassis-type = "handset";
> +

..snip..

> +
> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
> +&gpi_dma1 {
> +	status = "okay";
> +};
> +
> +&gpi_dma2 {
> +	status = "okay";
> +};
> +
> +/* I2C4 is used, it hosts a Samsung touchscreen, but GPI DMA is broken.. */

Why aren't you enabling i2c4 like you did with i2c 5/9/13?

If enabling that produces any side effect you should advertise that.

> +
> +&i2c5 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* Dialog SLG51000 CMIC @ 75 */
> +};
> +
> +&i2c9 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* NXP SN1X0 NFC @ 28 */
> +};
> +
> +&i2c13 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* Richwave RTC6226 FM Radio Receiver @ 64 */
> +};
> +
> +&i2c14 {
> +	clock-frequency = <1000000>;
> +	status = "okay";
> +
> +	cs35l41_l: speaker-amp@40 {

What about an even more generic audio-amplifier@40 ?

> +		compatible = "cirrus,cs35l41";
> +		reg = <0x40>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
> +		cirrus,boost-peak-milliamp = <4000>;
> +		cirrus,boost-ind-nanohenry = <1000>;
> +		cirrus,boost-cap-microfarad = <15>;
> +		cirrus,gpio2-src-select = <2>;
> +		cirrus,gpio2-output-enable;
> +		cirrus,asp-sdout-hiz = <3>;
> +		#sound-dai-cells = <1>;
> +	};
> +
> +	cs35l41_r: speaker-amp@41 {
> +		compatible = "cirrus,cs35l41";
> +		reg = <0x41>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
> +		cirrus,boost-peak-milliamp = <4000>;
> +		cirrus,boost-ind-nanohenry = <1000>;
> +		cirrus,boost-cap-microfarad = <15>;
> +		cirrus,gpio2-src-select = <2>;
> +		cirrus,gpio2-output-enable;
> +		cirrus,asp-sdout-hiz = <3>;
> +		#sound-dai-cells = <1>;
> +	};
> +};
> +

..snip..

> +
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
> +	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_n>;
> +	vmmc-supply = <&pm8350c_l9>;
> +	vqmmc-supply = <&pm8350c_l6>;

> +	/* Forbid SDR104/SDR50 - broken hw! */
> +	sdhci-caps-mask = <0x3 0x0>;

Is this a device-specific quirk? Is Sony hardware broken, or is it a SoC
(or SoC version-specific) issue?

If this is a SoC-specific issue, that should be rectified in sdhci-msm instead.

> +	no-sdio;
> +	no-mmc;
> +	status = "okay";
> +};
> +

Regards,
Angelo
