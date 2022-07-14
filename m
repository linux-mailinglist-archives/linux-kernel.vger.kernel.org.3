Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C59574F93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiGNNs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiGNNsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:48:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EEE52FF5;
        Thu, 14 Jul 2022 06:48:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 36EB46601A3F;
        Thu, 14 Jul 2022 14:48:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657806501;
        bh=Le8TuEVYGRZlOYwQZb5dHp9qfKoYO16nkNDuU6D/NQU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xp8hC7Y4IHRryMiwvDsPgr+1yhB0FLEj9RxOWfWYUgumrBH7EOOMEJNPYwjINQXLJ
         lw3liiP4kldB88Vc3LdtoniQ0ImHsJq/ocMmBXQ5l519x2C5O5sorTXm//znhI+YIZ
         YXKU7tY/98ZZCT/f3fDCF+3tDaqFv0thioPjeUPq4x9p66N0lVoonp6F8ZIGWc/3ZX
         neY+zuvE9PiJge77j6JwmYFGinYpcBRAaM2jM+nmHBp6cxP74KFT/KDPw4mApgUr65
         8Yb4j7f8T+RFJ0Kt44e3g3qN20C1GWiOecKG4v4GBGxkY2bZGaVu7F/LdnjJXjvCxF
         T3wE4TTDN5zpQ==
Message-ID: <ce7e5e38-11bf-638e-c2de-f3a8c7d624d1@collabora.com>
Date:   Thu, 14 Jul 2022 15:48:18 +0200
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
 <ef935a6f-77a2-5c9a-2cbc-0b0192aee56b@collabora.com>
 <8d738cad-e6c8-90e0-ffa2-ecf3fbe8dd59@somainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8d738cad-e6c8-90e0-ffa2-ecf3fbe8dd59@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/07/22 15:38, Konrad Dybcio ha scritto:
> 
> 
> On 14.07.2022 14:51, AngeloGioacchino Del Regno wrote:
>> Il 14/07/22 14:34, Konrad Dybcio ha scritto:
>>> Add support for Sony Xperia 1 IV, a.k.a PDX223. This device is a part
>>> of the SoMC SM8450 Nagara platform and currently it is the only
>>> device based on that board, so no -common DTSI is created until (if?)
>>> other Nagara devices appear.
>>>
>>> This commit brings support for:
>>> * SD Card
>>> * USB (*including SuperSpeed*)
>>> * ADSP/CDSP/SLPI (modem remains untested for now)
>>> * Most regulators (some GPIO-enabled ones require PMIC GPIOs but
>>> trying to access any SPMI device crashes the device..)
>>> * Part of I2C-connected peripherals (notably no touch due to a
>>> driver bug)
>>> * PCIe0 (PCIe1 is unused)
>>>
>>> Do note display via simplefb is not supported, as the display is blanked
>>> upon exiting XBL.
>>>
>>> To create a working boot image, you need to run:
>>> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/sm8450-sony-xperia-\
>>> nagara-pdx223.dtb > .Image.gz-dtb
>>>
>>> mkbootimg \
>>> --kernel .Image.gz-dtb \
>>> --ramdisk some_initrd.img \
>>> --pagesize 4096 \
>>> --base 0x0 \
>>> --kernel_offset 0x8000 \
>>> --ramdisk_offset 0x1000000 \
>>> --tags_offset 0x100 \
>>> --cmdline "SOME_CMDLINE" \
>>> --dtb_offset 0x1f00000 \
>>> --header_version 1 \
>>> --os_version 12 \
>>> --os_patch_level 2022-06 \ # or newer
>>> -o boot.img-sony-xperia-pdx223
>>>
>>> Then, you need to flash it on the device and get rid of all the
>>> vendor_boot/dtbo mess:
>>>
>>> // You have to either pull vbmeta{"","_system"} from
>>> // /dev/block/bootdevice/by-name/ or build one as a part of AOSP build process
>>> fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
>>> fastboot --disable-verity --disable-verification flash vbmeta_system \
>>> vbmeta_system.img
>>>
>>> fastboot flash boot boot.img-sony-xperia-pdx223
>>> fastboot erase vendor_boot
>>> fastboot erase recovery
>>> fastboot flash dtbo emptydtbo.img
>>> fastboot reboot
>>>
>>> Where emptydtbo.img is a tiny file that consists of 2 bytes (all zeroes), doing
>>> a "fastboot erase" won't cut it, the bootloader will go crazy and things will
>>> fall apart when it tries to overlay random bytes from an empty partition onto a
>>> perfectly good appended DTB.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>> Changes since v1:
>>> - remove a stray blank line
>>> - use generic node names for CS35L41
>>> - fix up indentation for sdhci-caps-mask
>>>
>>>    arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>>    .../qcom/sm8450-sony-xperia-nagara-pdx223.dts | 634 ++++++++++++++++++
>>>    2 files changed, 635 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index 01773f3ce57f..157ef6958e1f 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -126,3 +126,4 @@ dtb-$(CONFIG_ARCH_QCOM)    += sm8350-sony-xperia-sagami-pdx214.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)    += sm8350-sony-xperia-sagami-pdx215.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)    += sm8450-hdk.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)    += sm8450-qrd.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)    += sm8450-sony-xperia-nagara-pdx223.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
>>> new file mode 100644
>>> index 000000000000..7fe582b92a61
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
>>> @@ -0,0 +1,634 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>> +#include "sm8450.dtsi"
>>> +
>>> +/delete-node/ &adsp_mem;
>>> +/delete-node/ &rmtfs_mem;
>>> +/delete-node/ &video_mem;
>>> +
>>> +/ {
>>> +    model = "Sony Xperia 1 IV";
>>> +    compatible = "sony,pdx223", "qcom,sm8450";
>>> +    chassis-type = "handset";
>>> +
>>
>> ..snip..
>>
>>> +
>>> +&gpi_dma0 {
>>> +    status = "okay";
>>> +};
>>> +
>>> +&gpi_dma1 {
>>> +    status = "okay";
>>> +};
>>> +
>>> +&gpi_dma2 {
>>> +    status = "okay";
>>> +};
>>> +
>>> +/* I2C4 is used, it hosts a Samsung touchscreen, but GPI DMA is broken.. */
>>
>> Why aren't you enabling i2c4 like you did with i2c 5/9/13?
>>
>> If enabling that produces any side effect you should advertise that.
> The comment explains it, no point in enabling it if not even the dma engine
> behind it is functioning properly and you can't interact with the bus, waste
> of power and cpu cycles.
> 

The comment is not explaining whether enabling the bus, without adding any
device node, would produce side effects.
If you can scan the bus (example: i2c-detect) without side effects, in my
opinion, it's worth enabling it anyway... you probably won't miss a couple
of CPU cycles at boot and actually enabling the functionality later will
result in a one liner commit. Would be neat.

> 
>>
>>> +
>>> +&i2c5 {
>>> +    clock-frequency = <400000>;
>>> +    status = "okay";
>>> +
>>> +    /* Dialog SLG51000 CMIC @ 75 */
>>> +};
>>> +
>>> +&i2c9 {
>>> +    clock-frequency = <400000>;
>>> +    status = "okay";
>>> +
>>> +    /* NXP SN1X0 NFC @ 28 */
>>> +};
>>> +
>>> +&i2c13 {
>>> +    clock-frequency = <400000>;
>>> +    status = "okay";
>>> +
>>> +    /* Richwave RTC6226 FM Radio Receiver @ 64 */
>>> +};
>>> +
>>> +&i2c14 {
>>> +    clock-frequency = <1000000>;
>>> +    status = "okay";
>>> +
>>> +    cs35l41_l: speaker-amp@40 {
>>
>> What about an even more generic audio-amplifier@40 ?
> That's really an arbitrary barrier to decide when it's "generic enough", I'll
> leave that up to the maintainers to decide.
> 

Fair enough. I don't have any *strong* feelings about using 'audio-amplifier'
anyway :-)

> 
>>
>>> +        compatible = "cirrus,cs35l41";
>>> +        reg = <0x40>;
>>> +        interrupt-parent = <&tlmm>;
>>> +        interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
>>> +        reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
>>> +        cirrus,boost-peak-milliamp = <4000>;
>>> +        cirrus,boost-ind-nanohenry = <1000>;
>>> +        cirrus,boost-cap-microfarad = <15>;
>>> +        cirrus,gpio2-src-select = <2>;
>>> +        cirrus,gpio2-output-enable;
>>> +        cirrus,asp-sdout-hiz = <3>;
>>> +        #sound-dai-cells = <1>;
>>> +    };
>>> +
>>> +    cs35l41_r: speaker-amp@41 {
>>> +        compatible = "cirrus,cs35l41";
>>> +        reg = <0x41>;
>>> +        interrupt-parent = <&tlmm>;
>>> +        interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
>>> +        reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
>>> +        cirrus,boost-peak-milliamp = <4000>;
>>> +        cirrus,boost-ind-nanohenry = <1000>;
>>> +        cirrus,boost-cap-microfarad = <15>;
>>> +        cirrus,gpio2-src-select = <2>;
>>> +        cirrus,gpio2-output-enable;
>>> +        cirrus,asp-sdout-hiz = <3>;
>>> +        #sound-dai-cells = <1>;
>>> +    };
>>> +};
>>> +
>>
>> ..snip..
>>
>>> +
>>> +&sdhc_2 {
>>> +    cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
>>> +    pinctrl-names = "default", "sleep";
>>> +    pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
>>> +    pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_n>;
>>> +    vmmc-supply = <&pm8350c_l9>;
>>> +    vqmmc-supply = <&pm8350c_l6>;
>>
>>> +    /* Forbid SDR104/SDR50 - broken hw! */
>>> +    sdhci-caps-mask = <0x3 0x0>;
>>
>> Is this a device-specific quirk? Is Sony hardware broken, or is it a SoC
>> (or SoC version-specific) issue?
>>
>> If this is a SoC-specific issue, that should be rectified in sdhci-msm instead.
> If it was a SoC-specific issue, it would land in the SoC-specific DTSI. This is the
> PDX223-specific DTSI, so I think it's pretty clear..
> 
> 

If you took that from downstream, I would still ask for clarification to somebody
at Qualcomm, or anybody else who might know.

Besides, if you're sure that this is a machine-specific issue, please rectify
the comment for the sake of readability with something like:

/* Forbid SDR104/SDR50 due to board-specific issues */

Regards,
Angelo

