Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B557FDDA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiGYKtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiGYKtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:49:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1089A17A94;
        Mon, 25 Jul 2022 03:49:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B61C6601ABA;
        Mon, 25 Jul 2022 11:49:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658746141;
        bh=DuyxjzOXiMO0pzm3yf4UEgvrKD0RvGxzutfiUdtRCc4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RpDre6hv6EIJ3NPL9XFlsUlGuKOgc+syc9BIsSYPbxptPjJcdWxmaYozJQaGJEqCD
         5NsDYVIguRL1dSF4YLxfuKukMQQ0k9DJsrSCgBVTsBxmIB0P74btppVDgVyDLxF++c
         S3n68UOgDLSkZkHtoTw7/CjR3F4GEhHmgaP07/FB1aVrOvgcIqWydsrgXDssvzoYQx
         GcTIK39tHZFh+gDid6oYjooy+boMA8fgqZsIiTILWEG4tbWuzSw7AMx2hUK8BqOeWA
         GoMk40oWVtPqgBY/405NfBDUcl3PE46utbWC+YhgACF6pCUyKj1Z9XPUSbeqDqByBL
         nhxQpdp3EGMEw==
Message-ID: <f3027153-860f-7ffc-b4a0-ff2a43100cf4@collabora.com>
Date:   Mon, 25 Jul 2022 12:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 6/8] arm64: dts: mediatek: cherry: Enable DSP, audio
 codec and sound card
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
 <20220721145017.918102-7-angelogioacchino.delregno@collabora.com>
 <CAGXv+5E+6aCz3dxsfCqZAOkcmqDp0YWngsv-OZ23NDYhuZSfHw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5E+6aCz3dxsfCqZAOkcmqDp0YWngsv-OZ23NDYhuZSfHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/07/22 12:44, Chen-Yu Tsai ha scritto:
> On Thu, Jul 21, 2022 at 10:53 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> All machines of the Cherry platform have a working DSP (integrated
>> into the MT8195 SoC), and audio support, some with a different audio
>> codec: specifically, some using Realtek's RT5682I and some RT5682S.
>>
>> Write a configuration for all the audio bits to enable functionality.
> 
> I think we're still missing some code for SOF that implements the
> machine_select() callback, plus the firmware has to be fetched from
> the ChromeOS rootfs.
> 
> It might make sense to have SOF disabled for now. Removing the adsp
> reference and the overriding dai-link entry from the sound node
> should do the trick.
> 

Uhm... I think that we should either have audio, with DSP, or not have it
at all... the userspace configurations will differ, so we'd end up with
two different confs of which one will get unused and cluttering the ucm2
conf git.

At this point, I think that the most sensible option is to either omit
this commit, or keep audio disabled until the machine_select() callback
gets in...

> 
> ChenYu
> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  10 ++
>>   .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  10 ++
>>   .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  10 ++
>>   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 117 ++++++++++++++++++
>>   4 files changed, 147 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>> index 3348ba69ff6c..2d5e8f371b6d 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>> @@ -10,6 +10,16 @@ / {
>>          compatible = "google,tomato-rev1", "google,tomato", "mediatek,mt8195";
>>   };
>>
>> +&audio_codec {
>> +       compatible = "realtek,rt5682i";
>> +       realtek,btndet-delay = <16>;
>> +};
>> +
>> +&sound {
>> +       compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
>> +       model = "mt8195_r1019_5682";
>> +};
>> +
>>   &ts_10 {
>>          status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
>> index 4669e9d917f8..2586c32ce6e6 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
>> @@ -10,6 +10,11 @@ / {
>>          compatible = "google,tomato-rev2", "google,tomato", "mediatek,mt8195";
>>   };
>>
>> +&audio_codec {
>> +       compatible = "realtek,rt5682i";
>> +       realtek,btndet-delay = <16>;
>> +};
>> +
>>   &pio_default {
>>          pins-low-power-hdmi-disable {
>>                  pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
>> @@ -30,6 +35,11 @@ pins-low-power-pcie0-disable {
>>          };
>>   };
>>
>> +&sound {
>> +       compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
>> +       model = "mt8195_r1019_5682";
>> +};
>> +
>>   &ts_10 {
>>          status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
>> index 5021edd02f7c..f54f9477b99d 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
>> @@ -11,6 +11,11 @@ / {
>>                       "google,tomato", "mediatek,mt8195";
>>   };
>>
>> +&audio_codec {
>> +       compatible = "realtek,rt5682s";
>> +       realtek,amic-delay-ms = <250>;
>> +};
>> +
>>   &pio_default {
>>          pins-low-power-hdmi-disable {
>>                  pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
>> @@ -31,6 +36,11 @@ pins-low-power-pcie0-disable {
>>          };
>>   };
>>
>> +&sound {
>> +       compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
>> +       model = "m8195_r1019_5682s";
>> +};
>> +
>>   &ts_10 {
>>          status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> index 58349d4c3c8b..ca9955a97f8f 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> @@ -25,6 +25,12 @@ chosen {
>>                  stdout-path = "serial0:115200n8";
>>          };
>>
>> +       dmic_codec: dmic-codec {
>> +               compatible = "dmic-codec";
>> +               num-channels = <2>;
>> +               wakeup-delay-ms = <50>;
>> +       };
>> +
>>          memory@40000000 {
>>                  device_type = "memory";
>>                  reg = <0 0x40000000 0 0x80000000>;
>> @@ -116,9 +122,49 @@ scp_mem: memory@50000000 {
>>                          reg = <0 0x50000000 0 0x2900000>;
>>                          no-map;
>>                  };
>> +
>> +               adsp_mem: memory@60000000 {
>> +                       compatible = "shared-dma-pool";
>> +                       reg = <0 0x60000000 0 0xd80000>;
>> +                       no-map;
>> +               };
>> +
>> +               afe_mem: memory@60d80000 {
>> +                       compatible = "shared-dma-pool";
>> +                       reg = <0 0x60d80000 0 0x100000>;
>> +                       no-map;
>> +               };
>> +
>> +               adsp_device_mem: memory@60e80000 {
>> +                       compatible = "shared-dma-pool";
>> +                       reg = <0 0x60e80000 0 0x280000>;
>> +                       no-map;
>> +               };
>> +       };
>> +
>> +       spk_amplifier: rt1019p {
>> +               compatible = "realtek,rt1019p";
>> +               label = "rt1019p";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&rt1019p_pins_default>;
>> +               sdb-gpios = <&pio 100 GPIO_ACTIVE_HIGH>;
>>          };
>>   };
>>
>> +&adsp {
>> +       status = "okay";
>> +
>> +       memory-region = <&adsp_device_mem>, <&adsp_mem>;
>> +};
>> +
>> +&afe {
>> +       status = "okay";
>> +
>> +       mediatek,etdm-in2-cowork-source = <2>;
>> +       mediatek,etdm-out2-cowork-source = <0>;
>> +       memory-region = <&afe_mem>;
>> +};
>> +
>>   &i2c0 {
>>          status = "okay";
>>
>> @@ -152,6 +198,17 @@ &i2c2 {
>>          clock-frequency = <400000>;
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&i2c2_pins>;
>> +
>> +       audio_codec: codec@1a {
>> +               /* Realtek RT5682i or RT5682s, sharing the same configuration */
>> +               reg = <0x1a>;
>> +               interrupts-extended = <&pio 89 IRQ_TYPE_EDGE_BOTH>;
>> +               realtek,jd-src = <1>;
>> +
>> +               AVDD-supply = <&mt6359_vio18_ldo_reg>;
>> +               MICVDD-supply = <&pp3300_z2>;
>> +               VBAT-supply = <&pp3300_z5>;
>> +       };
>>   };
>>
>>   &i2c3 {
>> @@ -256,6 +313,11 @@ &mmc1 {
>>          vqmmc-supply = <&mt_pmic_vmc_ldo_reg>;
>>   };
>>
>> +&mt6359codec {
>> +       mediatek,dmic-mode = <1>;  /* one-wire */
>> +       mediatek,mic-type-0 = <2>; /* DMIC */
>> +};
>> +
>>   /* for CPU-L */
>>   &mt6359_vcore_buck_reg {
>>          regulator-always-on;
>> @@ -463,6 +525,34 @@ &pio {
>>                  "AP_SPI_FLASH_MOSI",
>>                  "AP_SPI_FLASH_MISO";
>>
>> +       aud_pins_default: audio-default-pins {
>> +               pins-cmd-dat {
>> +                   pinmux = <PINMUX_GPIO69__FUNC_AUD_CLK_MOSI>,
>> +                            <PINMUX_GPIO70__FUNC_AUD_SYNC_MOSI>,
>> +                            <PINMUX_GPIO71__FUNC_AUD_DAT_MOSI0>,
>> +                            <PINMUX_GPIO72__FUNC_AUD_DAT_MOSI1>,
>> +                            <PINMUX_GPIO73__FUNC_AUD_DAT_MISO0>,
>> +                            <PINMUX_GPIO74__FUNC_AUD_DAT_MISO1>,
>> +                            <PINMUX_GPIO75__FUNC_AUD_DAT_MISO2>,
>> +                            <PINMUX_GPIO0__FUNC_TDMIN_MCK>,
>> +                            <PINMUX_GPIO1__FUNC_TDMIN_DI>,
>> +                            <PINMUX_GPIO2__FUNC_TDMIN_LRCK>,
>> +                            <PINMUX_GPIO3__FUNC_TDMIN_BCK>,
>> +                            <PINMUX_GPIO60__FUNC_I2SO2_D0>,
>> +                            <PINMUX_GPIO49__FUNC_I2SIN_D0>,
>> +                            <PINMUX_GPIO50__FUNC_I2SO1_MCK>,
>> +                            <PINMUX_GPIO51__FUNC_I2SO1_BCK>,
>> +                            <PINMUX_GPIO52__FUNC_I2SO1_WS>,
>> +                            <PINMUX_GPIO53__FUNC_I2SO1_D0>;
>> +               };
>> +
>> +               pins-hp-jack-int-odl {
>> +                       pinmux = <PINMUX_GPIO89__FUNC_GPIO89>;
>> +                       input-enable;
>> +                       bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>> +               };
>> +       };
>> +
>>          cr50_int: cr50-irq-default-pins {
>>                  pins-gsc-ap-int-odl {
>>                          pinmux = <PINMUX_GPIO88__FUNC_GPIO88>;
>> @@ -707,6 +797,21 @@ pins-low-power-pupd {
>>                  };
>>          };
>>
>> +       rt1011_pins_default: rt1011-default-pins {
>> +               pins-spk {
>> +                       pinmux = <PINMUX_GPIO94__FUNC_GPIO94>,
>> +                                <PINMUX_GPIO100__FUNC_GPIO100>;
>> +                       output-high;
>> +               };
>> +       };
>> +
>> +       rt1019p_pins_default: rt1019p-default-pins {
>> +               pins-amp-sdb {
>> +                       pinmux = <PINMUX_GPIO100__FUNC_GPIO100>;
>> +                       output-low;
>> +               };
>> +       };
>> +
>>          scp_pins: scp-default-pins {
>>                  pins-vreq {
>>                          pinmux = <PINMUX_GPIO76__FUNC_SCP_VREQ_VAO>;
>> @@ -779,6 +884,18 @@ cros-ec-rpmsg {
>>          };
>>   };
>>
>> +&sound {
>> +       status = "okay";
>> +
>> +       mediatek,adsp = <&adsp>;
>> +       mediatek,dai-link =
>> +               "DL10_FE", "DPTX_BE", "ETDM1_IN_BE", "ETDM2_IN_BE",
>> +               "ETDM1_OUT_BE", "ETDM2_OUT_BE","UL_SRC1_BE",
>> +               "AFE_SOF_DL2", "AFE_SOF_DL3", "AFE_SOF_UL4", "AFE_SOF_UL5";
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&aud_pins_default>;
>> +};
>> +
>>   &spi0 {
>>          status = "okay";
>>
>> --
>> 2.35.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718
