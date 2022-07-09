Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3756C972
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiGIMpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGIMpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 08:45:07 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD14E84E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 05:45:01 -0700 (PDT)
Date:   Sat, 09 Jul 2022 12:44:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1657370698; x=1657629898;
        bh=UDnvT/mAnQL0JxNE2mPgfbjTpGw4MweBJ4NSW0rF8fM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=oA3ll+U6g549T0Gf8OKhYfpiRUVNFgxLxwHwKNyA/+a2K4ExaMBTNotYP9zpIKXsL
         oQiQKTCnj5k5T7JzWHFfBgXm5E2wWPplyUilTuHR2b4AEtw9kU/B5SvPWPlBI8WKw4
         id4KxBkGgUep9nf2sEfWxWs5hiEbwR4mUwna51C4=
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        MollySophia <mollysophia379@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: Add support for Xiaomi Mi Mix2s
Message-ID: <1dbc8965-ad52-76f7-d4df-bcbb327fd4e2@connolly.tech>
In-Reply-To: <c85c5226-4414-c8de-b4a5-cf9d70c3c4d1@somainline.org>
References: <20220708020930.7183-1-mollysophia379@gmail.com> <c85c5226-4414-c8de-b4a5-cf9d70c3c4d1@somainline.org>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/2022 09:33, Konrad Dybcio wrote:
>
>
> On 8.07.2022 04:09, MollySophia wrote:
>> Add support for Xiaomi Mi Mix2s (polaris) handsets.
>>
>> Currently working features:
>> - UFS
>> - Touchscreen
>> - USB 2
>> - Bluetooth
>> - Wi-Fi
>> - GPU
>> - Venus
>> - Display (need jdi-fhd-nt35596s panel driver, which I have sent a
>>    patch but it haven't been into upstream yet)
>>
>> Signed-off-by: MollySophia <mollysophia379@gmail.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>   .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   | 963 ++++++++++++++++++
>>   2 files changed, 964 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qco=
m/Makefile
>> index 77ba2c9661d3..628b95e1012b 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -112,6 +112,7 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-sony-xperia-ta=
ma-apollo.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-shift-axolotl.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-xiaomi-beryllium-ebbg.dtb
>>   dtb-$(CONFIG_ARCH_QCOM) +=3D sdm845-xiaomi-beryllium-tianma.dtb
>> +dtb-$(CONFIG_ARCH_QCOM) +=3D sdm845-xiaomi-polaris.dtb
> Please fix the tab/space situation.
>
>>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm850-lenovo-yoga-c630.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm850-samsung-w737.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sm6125-sony-xperia-seine-pdx201.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/a=
rm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
>> new file mode 100644
>> index 000000000000..d3e535a542ef
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
>> @@ -0,0 +1,963 @@
>> +// SPDX-License-Identifier: GPL-2.0
> Could you relicense this to BSD3?
>
>> +/*
>> + * Copyright (c) 2020, Xilin Wu <strongtz@yeah.net>
>> + * Copyright (c) 2022, Molly Sophia <mollysophia379@gmail.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +#include <dt-bindings/sound/qcom,q6afe.h>
>> +#include <dt-bindings/sound/qcom,q6asm.h>
>> +#include <dt-bindings/sound/qcom,q6afe.h>
>> +#include <dt-bindings/sound/qcom,q6asm.h>
>> +#include <dt-bindings/sound/qcom,q6voice.h>
>> +#include "sdm845.dtsi"
>> +#include "pm8998.dtsi"
>> +#include "pmi8998.dtsi"
>> +#include "pm8005.dtsi"
>> +
>> +/*
>> + * Delete following upstream (sdm845.dtsi) reserved
>> + * memory mappings which are different in this device.
>> + */
>> +/delete-node/ &rmtfs_mem;
>> +/delete-node/ &adsp_mem;
>> +/delete-node/ &wlan_msa_mem;
>> +/delete-node/ &mpss_region;
>> +/delete-node/ &venus_mem;
>> +/delete-node/ &cdsp_mem;
>> +/delete-node/ &mba_region;
>> +/delete-node/ &slpi_mem;
>> +/delete-node/ &spss_mem;
>> +
>> +/ {
>> +=09model =3D "Xiaomi Mi MIX 2s";
> 2S? [1]
>
>> +=09compatible =3D "xiaomi,polaris", "qcom,sdm845";
>> +=09chassis-type =3D "handset";
>> +
>> +=09/* required for bootloader to select correct board */
>> +=09qcom,board-id =3D <0x2a 0x0>;
>> +=09qcom,msm-id =3D <0x141 0x20001>;
> Other boards put msm-id before board-id.
This seems arbitrary
>
>> +
>> +=09aliases {
>> +=09=09serial0 =3D &uart9;
>> +=09=09serial1 =3D &uart6;
>> +=09};
>> +
>> +=09volume-keys {
>> +=09=09compatible =3D "gpio-keys";
>> +=09=09autorepeat;
>> +
>> +=09=09pinctrl-names =3D "default";
>> +=09=09pinctrl-0 =3D <&vol_up_pin_a>;
>> +
>> +=09=09key-vol-up {
>> +=09=09=09label =3D "Volume Up";
>> +=09=09=09linux,code =3D <KEY_VOLUMEUP>;
>> +=09=09=09gpios =3D <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
>> +=09=09=09debounce-interval =3D <15>;
>> +=09=09};
>> +=09};
>> +
>> +=09reserved-memory {
>> +=09=09adsp_mem: memory@8c500000 {
>> +=09=09=09reg =3D <0 0x8c500000 0 0x1e00000>;
>> +=09=09=09no-map;
>> +=09=09};
>> +
>> +=09=09wlan_msa_mem: memory@8e300000 {
>> +=09=09=09reg =3D <0 0x8e300000 0 0x100000>;
>> +=09=09=09no-map;
>> +=09=09};
>> +
>> +=09=09mpss_region: memory@8e400000 {
>> +=09=09=09reg =3D <0 0x8e400000 0 0x7800000>;
>> +=09=09=09no-map;
>> +=09=09};
>> +
>> +=09=09venus_mem: memory@95c00000 {
>> +=09=09=09reg =3D <0 0x95c00000 0 0x500000>;
>> +=09=09=09no-map;
>> +=09=09};
>> +
>> +=09=09cdsp_mem: memory@96100000 {
>> +=09=09=09reg =3D <0 0x96100000 0 0x800000>;
>> +=09=09=09no-map;
>> +=09=09};
>> +
>> +=09=09mba_region: memory@96900000 {
>> +=09=09=09reg =3D <0 0x96900000 0 0x200000>;
>> +=09=09=09no-map;
>> +=09=09};
>> +
>> +=09=09slpi_mem: memory@96b00000 {
>> +=09=09=09reg =3D <0 0x96b00000 0 0x1400000>;
>> +=09=09=09no-map;
>> +=09=09};
>> +
>> +=09=09spss_mem: memory@97f00000 {
>> +=09=09=09reg =3D <0 0x97f00000 0 0x100000>;
>> +=09=09=09no-map;
>> +=09=09};
>> +
>> +=09=09rmtfs_mem: memory@f6301000 {
>> +=09=09=09compatible =3D "qcom,rmtfs-mem";
>> +=09=09=09reg =3D <0 0xf6301000 0 0x200000>;
>> +=09=09=09no-map;
>> +
>> +=09=09=09qcom,client-id =3D <1>;
>> +=09=09=09qcom,vmid =3D <15>;
>> +=09=09};
>> +=09};
>> +
>> +=09battery: battery {
>> +=09=09compatible =3D "simple-battery";
>> +
>> +=09=09charge-full-design-microamp-hours =3D <3400000>;
>> +=09=09voltage-min-design-microvolt =3D <3400000>;
> That's specific to your device, but 3v4 looks veeery low..
Most lipoly's can safely go down to 3.4v, no permanent damage until
3.2v. That said this value is currently unused on all devices except the
OnePlus 6 afaik.
>
>
>> +=09=09voltage-max-design-microvolt =3D <4400000>;
>> +=09};
>> +
>> +=09vreg_tp_vddio: tp-vddio-vreg {
>> +=09=09compatible =3D "regulator-fixed";
>> +=09=09regulator-name =3D "vreg_tp_vddio";
>> +
>> +=09=09regulator-min-microvolt =3D <1800000>;
>> +=09=09regulator-max-microvolt =3D <1800000>;
>> +
>> +=09=09gpio =3D <&tlmm 23 0>;
>> +=09=09regulator-always-on;
>> +=09=09regulator-boot-on;
>> +=09=09enable-active-high;
>> +=09};
>> +
>> +=09vreg_s4a_1p8: vreg-s4a-1p8 {
>> +=09=09compatible =3D "regulator-fixed";
>> +=09=09regulator-name =3D "vreg_s4a_1p8";
>> +
>> +=09=09regulator-min-microvolt =3D <1800000>;
>> +=09=09regulator-max-microvolt =3D <1800000>;
>> +=09=09regulator-always-on;
>> +=09};
>> +};
>> +
>> +&apps_rsc {
>> +=09pm8998-rpmh-regulators {
>> +=09=09compatible =3D "qcom,pm8998-rpmh-regulators";
>> +=09=09qcom,pmic-id =3D "a";
>> +
>> +=09=09vreg_s2a_1p1: smps2 {
>> +=09=09=09regulator-min-microvolt =3D <1100000>;
>> +=09=09=09regulator-max-microvolt =3D <1100000>;
>> +=09=09};
>> +
>> +=09=09vreg_s3a_1p35: smps3 {
>> +=09=09=09regulator-min-microvolt =3D <1352000>;
>> +=09=09=09regulator-max-microvolt =3D <1352000>;
>> +=09=09};
>> +
>> +=09=09vreg_s5a_2p04: smps5 {
>> +=09=09=09regulator-min-microvolt =3D <1904000>;
>> +=09=09=09regulator-max-microvolt =3D <2040000>;
>> +=09=09};
>> +
>> +=09=09vreg_s7a_1p025: smps7 {
>> +=09=09=09regulator-min-microvolt =3D <900000>;
>> +=09=09=09regulator-max-microvolt =3D <1028000>;
>> +=09=09};
>> +
>> +=09=09vdda_mipi_dsi0_pll:
>> +=09=09vdda_ufs1_core:
>> +=09=09vreg_l1a_0p875: ldo1 {
>> +=09=09=09regulator-min-microvolt =3D <880000>;
>> +=09=09=09regulator-max-microvolt =3D <880000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l2a_1p2: ldo2 {
>> +=09=09=09regulator-min-microvolt =3D <1200000>;
>> +=09=09=09regulator-max-microvolt =3D <1200000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09=09regulator-always-on;
>> +=09=09};
>> +
>> +=09=09vreg_l3a_1p0: ldo3 {
>> +=09=09=09regulator-min-microvolt =3D <1000000>;
>> +=09=09=09regulator-max-microvolt =3D <1000000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l5a_0p8: ldo5 {
>> +=09=09=09regulator-min-microvolt =3D <800000>;
>> +=09=09=09regulator-max-microvolt =3D <800000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l6a_1p8: ldo6 {
>> +=09=09=09regulator-min-microvolt =3D <1856000>;
>> +=09=09=09regulator-max-microvolt =3D <1856000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l7a_1p8: ldo7 {
>> +=09=09=09regulator-min-microvolt =3D <1800000>;
>> +=09=09=09regulator-max-microvolt =3D <1800000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l8a_1p2: ldo8 {
>> +=09=09=09regulator-min-microvolt =3D <1200000>;
>> +=09=09=09regulator-max-microvolt =3D <1248000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l9a_1p8: ldo9 {
>> +=09=09=09regulator-min-microvolt =3D <1704000>;
>> +=09=09=09regulator-max-microvolt =3D <2928000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l10a_2p95: ldo10 {
>> +=09=09=09regulator-min-microvolt =3D <1704000>;
>> +=09=09=09regulator-max-microvolt =3D <2928000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l11a_1p05: ldo11 {
>> +=09=09=09regulator-min-microvolt =3D <1000000>;
>> +=09=09=09regulator-max-microvolt =3D <1048000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l12a_1p8: ldo12 {
>> +=09=09=09regulator-min-microvolt =3D <1800000>;
>> +=09=09=09regulator-max-microvolt =3D <1800000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l13a_2p95: ldo13 {
>> +=09=09=09regulator-min-microvolt =3D <1800000>;
>> +=09=09=09regulator-max-microvolt =3D <2960000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l14a_1p8: ldo14 {
>> +=09=09=09regulator-min-microvolt =3D <1800000>;
>> +=09=09=09regulator-max-microvolt =3D <1880000>;
>> +=09=09=09regulator-always-on;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l15a_1p8: ldo15 {
>> +=09=09=09regulator-min-microvolt =3D <1800000>;
>> +=09=09=09regulator-max-microvolt =3D <1800000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l16a_2p7: ldo16 {
>> +=09=09=09regulator-min-microvolt =3D <2704000>;
>> +=09=09=09regulator-max-microvolt =3D <2704000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l17a_1p3: ldo17 {
>> +=09=09=09regulator-always-on;
>> +=09=09=09regulator-min-microvolt =3D <1304000>;
>> +=09=09=09regulator-max-microvolt =3D <1304000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l18a_2p9: ldo18 {
>> +=09=09=09regulator-min-microvolt =3D <2704000>;
>> +=09=09=09regulator-max-microvolt =3D <2960000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l19a_3p1: ldo19 {
>> +=09=09=09regulator-min-microvolt =3D <2856000>;
>> +=09=09=09regulator-max-microvolt =3D <3104000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l20a_2p95: ldo20 {
>> +=09=09=09regulator-min-microvolt =3D <2704000>;
>> +=09=09=09regulator-max-microvolt =3D <2960000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l21a_2p95: ldo21 {
>> +=09=09=09regulator-min-microvolt =3D <2704000>;
>> +=09=09=09regulator-max-microvolt =3D <2960000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l22a_3p3: ldo22 {
>> +=09=09=09regulator-min-microvolt =3D <2864000>;
>> +=09=09=09regulator-max-microvolt =3D <3312000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l23a_3p3: ldo23 {
>> +=09=09=09regulator-min-microvolt =3D <3000000>;
>> +=09=09=09regulator-max-microvolt =3D <3312000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l24a_3p075: ldo24 {
>> +=09=09=09regulator-min-microvolt =3D <3088000>;
>> +=09=09=09regulator-max-microvolt =3D <3088000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l25a_3p3: ldo25 {
>> +=09=09=09regulator-always-on;
>> +=09=09=09regulator-min-microvolt =3D <3000000>;
>> +=09=09=09regulator-max-microvolt =3D <3312000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vdda_mipi_dsi0_1p2:
>> +=09=09vdda_ufs1_1p2:
>> +=09=09vreg_l26a_1p2: ldo26 {
>> +=09=09=09regulator-min-microvolt =3D <1200000>;
>> +=09=09=09regulator-max-microvolt =3D <1200000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09};
>> +
>> +=09=09vreg_l28a_3p0: ldo28 {
>> +=09=09=09regulator-min-microvolt =3D <2856000>;
>> +=09=09=09regulator-max-microvolt =3D <3008000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> +=09=09=09regulator-always-on;
>> +=09=09};
>> +
>> +=09=09vreg_lvs1a_1p8: lvs1 {
>> +=09=09=09regulator-min-microvolt =3D <1800000>;
>> +=09=09=09regulator-max-microvolt =3D <1800000>;
>> +=09=09};
>> +
>> +=09=09vreg_lvs2a_1p8: lvs2 {
>> +=09=09=09regulator-min-microvolt =3D <1800000>;
>> +=09=09=09regulator-max-microvolt =3D <1800000>;
>> +=09=09};
>> +=09};
>> +
>> +=09pmi8998-rpmh-regulators {
>> +=09=09compatible =3D "qcom,pmi8998-rpmh-regulators";
>> +=09=09qcom,pmic-id =3D "b";
>> +
>> +=09=09vreg_bob: bob {
>> +=09=09=09regulator-min-microvolt =3D <3312000>;
>> +=09=09=09regulator-max-microvolt =3D <3600000>;
>> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_AUTO>;
>> +=09=09=09regulator-allow-bypass;
>> +=09=09};
>> +=09};
>> +
>> +=09pm8005-rpmh-regulators {
>> +=09=09compatible =3D "qcom,pm8005-rpmh-regulators";
>> +=09=09qcom,pmic-id =3D "c";
>> +
>> +=09=09vreg_smp3c_0p6: smps3 {
>> +=09=09=09regulator-always-on;
>> +=09=09=09regulator-min-microvolt =3D <600000>;
>> +=09=09=09regulator-max-microvolt =3D <600000>;
>> +=09=09};
>> +=09};
>> +};
>> +
>> +&gpi_dma0 {
>> +=09status =3D "okay";
>> +};
> /\ & \/ are incorrectly sorted.
>
>> +
>> +&gpi_dma1 {
>> +=09status =3D "okay";
>> +};
>> +
>> +&cdsp_pas {
>> +=09status =3D "okay";
> Can you please move the status =3D "okay" down in all nodes?
>
>
>> +=09firmware-name =3D "qcom/sdm845/polaris/cdsp.mbn";
>> +};
>> +
>> +&dsi0 {
>> +=09status =3D "okay";
>> +=09vdda-supply =3D <&vdda_mipi_dsi0_1p2>;
>> +
>> +=09display_panel: panel@0 {
>> +=09=09status =3D "okay";
> This is redundant.
>
>> +=09=09compatible =3D "jdi,fhd-nt35596s";
>> +=09=09#address-cells =3D <1>;
>> +=09=09#size-cells =3D <0>;
>> +=09=09reg =3D <0>;
>> +
>> +=09=09vddio-supply =3D <&vreg_l14a_1p8>;
>> +=09=09vddpos-supply =3D <&lab>;
>> +=09=09vddneg-supply =3D <&ibb>;
>> +
>> +=09=09reset-gpios =3D <&tlmm 6 GPIO_ACTIVE_LOW>;
>> +
>> +=09=09backlight =3D <&pmi8998_wled>;
>> +
>> +=09=09pinctrl-names =3D "default", "sleep";
>> +=09=09pinctrl-0 =3D <&sde_dsi_active>;
>> +=09=09pinctrl-1 =3D <&sde_dsi_suspend>;
>> +
>> +=09=09port {
>> +=09=09=09panel_in: endpoint {
>> +=09=09=09=09remote-endpoint =3D <&dsi0_out>;
>> +=09=09=09};
>> +=09=09};
>> +=09};
>> +};
>> +
>> +&dsi0_out {
>> +=09remote-endpoint =3D <&panel_in>;
>> +=09data-lanes =3D <0 1 2 3>;
>> +};
>> +
>> +&dsi0_phy {
>> +=09status =3D "okay";
>> +=09vdds-supply =3D <&vdda_mipi_dsi0_pll>;
>> +};
>> +
>> +&gcc {
>> +=09protected-clocks =3D <GCC_QSPI_CORE_CLK>,
>> +=09=09=09   <GCC_QSPI_CORE_CLK_SRC>,
>> +=09=09=09   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
>> +=09=09=09   <GCC_LPASS_Q6_AXI_CLK>,
>> +=09=09=09   <GCC_LPASS_SWAY_CLK>;
>> +};
>> +
>> +&gmu {
>> +=09status =3D "okay";
>> +};
>> +
>> +&gpu {
>> +=09status =3D "okay";
>> +
>> +=09zap-shader {
>> +=09=09memory-region =3D <&gpu_mem>;
>> +=09=09firmware-name =3D "qcom/sdm845/polaris/a630_zap.mbn";
>> +=09};
>> +};
>> +
>> +&ibb {
>> +=09regulator-min-microvolt =3D <4600000>;
>> +=09regulator-max-microvolt =3D <6000000>;
>> +=09regulator-over-current-protection;
>> +=09regulator-pull-down;
>> +=09regulator-soft-start;
>> +=09qcom,discharge-resistor-kohms =3D <300>;
> Reverse-Christmas-tree, please.
>
>> +};
>> +
>> +&lab {
>> +=09regulator-min-microvolt =3D <4600000>;
>> +=09regulator-max-microvolt =3D <6000000>;
>> +=09// regulator-over-current-protection;
> No dead code. Either remove it or leave it. There is however a bug (?)
> in the labibb driver that will make the OCP interrupt fire on every scree=
n
> power on (at least on the devices I tried, but I doubt it should be like =
this).
>
>> +=09regulator-pull-down;
>> +=09regulator-soft-start;
>> +};
>> +
>> +&i2c5 {
>> +=09#dma-cells =3D <3>;
> The dma property is SoC-wide, please create a separate patch and add it t=
o sdm845.dtsi.
Not all devices use DMA for i2c, currently there is a {bug?} in the
GPI_DMA driver where when you add the DMA properties it will not
properly default to FIFO if the firmware doesn't support DMA on that
particular controller.
>
>
>> +=09status =3D "okay";
>> +=09clock-frequency =3D <400000>;
>> +
>> +=09dmas =3D <&gpi_dma0 0 5 QCOM_GPI_I2C>,
>> +=09=09   <&gpi_dma0 1 5 QCOM_GPI_I2C>;
>> +=09dma-names =3D "tx", "rx";
(these would need to be added too)
>> +
>> +=09tas2559_codec: codec@4c{
>> +=09=09#sound-dai-cells =3D <1>;
>> +=09=09compatible =3D "ti,tas2559";
>> +=09=09reg =3D <0x4c>;
>> +=09=09ti,tas2559-reset-gpio =3D <&tlmm 14 0>;
>> +=09=09ti,tas2560-reset-gpio =3D <&tlmm 25 0>;
>> +=09=09ti,tas2559-addr =3D <0x4c>;
>> +=09=09ti,tas2560-addr =3D <0x4d>;
>> +=09};
>> +};
>> +
>> +&i2c14 {
>> +=09#dma-cells =3D <3>;
> ditto
>
>> +=09status =3D "okay";
>> +=09clock-frequency =3D <400000>;
>> +
>> +=09dmas =3D  <&gpi_dma1 0 6 QCOM_GPI_I2C>,
>> +=09=09=09<&gpi_dma1 1 6 QCOM_GPI_I2C>;
>> +=09dma-names =3D "tx", "rx";
>> +
>> +=09touchscreen@20 {
>> +=09=09compatible =3D "syna,rmi4-i2c";
>> +=09=09reg =3D <0x20>;
>> +=09=09#address-cells =3D <1>;
>> +=09=09#size-cells =3D <0>;
>> +=09=09interrupts-extended =3D <&tlmm 125 0x2008>;
>> +
>> +=09=09pinctrl-names =3D "default", "sleep";
>> +=09=09pinctrl-0 =3D <&ts_int_default &ts_reset_default>;
>> +=09=09pinctrl-1 =3D <&ts_int_sleep &ts_reset_sleep>;
>> +
>> +=09=09vdd-supply =3D <&vreg_l28a_3p0>;
>> +=09=09vio-supply =3D <&vreg_tp_vddio>;
>> +
>> +=09=09syna,reset-delay-ms =3D <200>;
>> +=09=09syna,startup-delay-ms =3D <200>;
>> +
>> +=09=09rmi4-f01@1 {
>> +=09=09=09reg =3D <0x1>;
>> +=09=09=09syna,nosleep-mode =3D <0x1>;
> Decimal?
>
>> +=09=09};
>> +
>> +=09=09rmi4-f12@12 {
>> +=09=09=09reg =3D <0x12>;
>> +=09=09=09syna,sensor-type =3D <1>;
>> +=09=09=09syna,clip-x-low =3D <0>;
>> +=09=09=09syna,clip-x-high =3D <1080>;
>> +=09=09=09syna,clip-y-low =3D <0>;
>> +=09=09=09syna,clip-y-high =3D <2160>;
>> +=09=09=09syna,rezero-wait-ms =3D <200>;
>> +=09=09};
>> +=09};
>> +};
>> +
>> +&qup_i2c14_default {
>> +=09mux {
>> +=09=09pins =3D "gpio33", "gpio34";
>> +=09=09function =3D "qup14";
>> +=09};
> This part is identical to the one in sdm845.dtsi.
>
>> +
>> +=09config {
>> +=09=09pins =3D "gpio33", "gpio34";
>> +=09=09drive-strength =3D <2>;
>> +=09=09bias-disable;
>> +=09};
>> +};
>> +
>> +&ipa {
>> +=09status =3D "okay";
>> +
>> +=09memory-region =3D <&ipa_fw_mem>;
>> +=09firmware-name =3D "qcom/sdm845/polaris/ipa_fws.mbn";
>> +};
>> +
>> +&slpi_pas {
>> +=09status =3D "okay";
>> +=09firmware-name =3D "qcom/sdm845/polaris/slpi.mbn";
>> +};
>> +
>> +&mdss {
>> +=09status =3D "okay";
>> +};
> Sorted incorrectly.
(ie, no alphabetically)
>
>> +
>> +/* Modem/wifi*/
> I think this comment is redundant.
>
>> +&mss_pil {
>> +=09status =3D "okay";
>> +=09firmware-name =3D "qcom/sdm845/polaris/mba.mbn", "qcom/sdm845/polari=
s/modem.mbn";
>> +};
>> +
>> +&pm8998_gpio {
>> +=09vol_up_pin_a: vol-up-active {
>> +=09=09pins =3D "gpio6";
>> +=09=09function =3D "normal";
>> +=09=09input-enable;
>> +=09=09bias-pull-up;
>> +=09=09qcom,drive-strength =3D <PMIC_GPIO_STRENGTH_NO>;
>> +=09};
>> +};
>> +
>> +&pm8998_pon {
>> +=09resin {
>> +=09=09compatible =3D "qcom,pm8941-resin";
>> +=09=09interrupts =3D <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
>> +=09=09debounce =3D <15625>;
>> +=09=09bias-pull-up;
>> +=09=09linux,code =3D <KEY_VOLUMEDOWN>;
>> +=09};
>> +};
>> +
>> +&pmi8998_haptics {
> This is not in mainline.
>
>> +=09status =3D "okay";
>> +
>> +=09qcom,wave-play-rate-us =3D <4255>;
>> +};
>> +
>> +&pmi8998_charger {
> Neither is this.
>
>> +=09status =3D "okay";
>> +=09monitored-battery =3D <&battery>;
>> +};
>> +
>> +&pmi8998_fg {
> Or this.
>
>> +=09status =3D "okay";
>> +
>> +=09power-supplies =3D <&pmi8998_charger>;
>> +=09monitored-battery =3D <&battery>;
>> +};
>> +
>> +&pmi8998_rradc {
>> +=09status =3D "okay";
>> +};
>> +
>> +&pmi8998_wled {
>> +=09status =3D "okay";
>> +=09qcom,current-boost-limit =3D <970>;
>> +=09qcom,ovp-millivolt =3D <29600>;
>> +=09qcom,current-limit-microamp =3D <20000>;
>> +=09qcom,num-strings =3D <2>;
>> +=09qcom,switching-freq =3D <600>;
>> +=09qcom,external-pfet;
>> +=09qcom,cabc;
>> +};
>> +
>> +&q6afedai {
>> +=09qi2s@22 {
>> +=09=09reg =3D <22>;
>> +=09=09qcom,sd-lines =3D <0>;
>> +=09};
>> +};
>> +
>> +&q6asmdai {
>> +=09dai@0 {
>> +=09=09reg =3D <0>;
>> +=09};
>> +
>> +=09dai@1 {
>> +=09=09reg =3D <1>;
>> +=09};
>> +
>> +=09dai@2 {
>> +=09=09reg =3D <2>;
>> +=09};
>> +};
>> +
>> +&q6cvp {
> I don't think that's in mainline either..
>> +=09status =3D "okay";
>> +};
>> +
>> +&q6cvs {
> Or this..
>> +=09status =3D "okay";
>> +};
>> +
>> +&q6mvm {
> And this..
>> +=09status =3D "okay";
>> +};
>> +
>> +&qupv3_id_0 {
>> +=09status =3D "okay";
>> +};
>> +
>> +&qupv3_id_1 {
>> +=09status =3D "okay";
>> +};
>> +
>> +&sound {
>> +=09compatible =3D "qcom,db845c-sndcard";
>> +=09pinctrl-0 =3D <&quat_mi2s_active
>> +=09=09=09&quat_mi2s_sd0_active>;
>> +=09pinctrl-names =3D "default";
>> +=09model =3D "Xiaomi Mi Mix2s";
>> +=09audio-routing =3D
>> +=09=09"RX_BIAS", "MCLK",
>> +=09=09"AMIC1", "MIC BIAS1",
>> +=09=09"AMIC2", "MIC BIAS2",
>> +=09=09"AMIC3", "MIC BIAS3";
>> +
>> +=09mm1-dai-link {
>> +=09=09link-name =3D "MultiMedia1";
>> +=09=09cpu {
>> +=09=09=09sound-dai =3D <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
>> +=09=09};
>> +=09};
>> +
>> +=09mm2-dai-link {
>> +=09=09link-name =3D "MultiMedia2";
>> +=09=09cpu {
>> +=09=09=09sound-dai =3D <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
>> +=09=09};
>> +=09};
>> +
>> +=09mm3-dai-link {
>> +=09=09link-name =3D "MultiMedia3";
>> +=09=09cpu {
>> +=09=09=09sound-dai =3D <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
>> +=09=09};
>> +=09};
>> +
>> +=09dai-link-voicemmode1 {
>> +=09=09link-name =3D "VoiceMMode1";
>> +=09=09cpu {
>> +=09=09=09sound-dai =3D <&q6voicedai VOICEMMODE1>;
> Consequently, some nodes will have to go since they're referencing
> a device that does not have a driver or even exist in mainline. I
> suppose you can remove the sound node entirely for the time being,
> unless you have any kind of sound output without them.
The voicemmode dai is only used for call audio, sound should otherwise
work without it. That said, it's news to be that nodes without drivers
can't go into mainline...
>
>> +=09=09};
>> +=09};
>> +
>> +=09tas2559-dai-link {
>> +=09=09link-name =3D "Primary Spkr Playback";
>> +=09=09cpu {
>> +=09=09=09sound-dai =3D <&q6afedai QUATERNARY_MI2S_RX>;
>> +=09=09};
>> +
>> +=09=09platform {
>> +=09=09=09sound-dai =3D <&q6routing>;
>> +=09=09};
>> +
>> +=09=09codec {
>> +=09=09=09sound-dai =3D  <&tas2559_codec 0>;
>> +=09=09};
>> +=09};
>> +
>> +=09slim-dai-link {
>> +=09=09link-name =3D "SLIM Playback";
>> +=09=09cpu {
>> +=09=09=09sound-dai =3D <&q6afedai SLIMBUS_0_RX>;
>> +=09=09};
>> +
>> +=09=09platform {
>> +=09=09=09sound-dai =3D <&q6routing>;
>> +=09=09};
>> +
>> +=09=09codec {
>> +=09=09=09sound-dai =3D  <&wcd9340 0>;
>> +=09=09};
>> +=09};
>> +
>> +=09slimcap-dai-link {
>> +=09=09link-name =3D "SLIM Capture";
>> +=09=09cpu {
>> +=09=09=09sound-dai =3D <&q6afedai SLIMBUS_0_TX>;
>> +=09=09};
>> +
>> +=09=09platform {
>> +=09=09=09sound-dai =3D <&q6routing>;
>> +=09=09};
>> +
>> +=09=09codec {
>> +=09=09=09sound-dai =3D <&wcd9340 1>;
>> +=09=09};
>> +=09};
>> +};
>> +
>> +&tlmm {
>> +=09gpio-reserved-ranges =3D <0 4>, <81 4>;
>> +
>> +=09ts_reset_default: ts-reset-default {
>> +=09=09mux {
> Please drop the extra mux{} / config{}. You can do it like this:
>
> ts_reset_default: ts-reset-default {
> =09pins =3D "gpio99";
> =09function =3D "gpio";
> =09drive-strength =3D <16>;
> =09output-high;
> };
>
>> +=09=09=09pins =3D "gpio99";
>> +=09=09=09function =3D "gpio";
>> +=09=09};
>> +
>> +=09=09config {
>> +=09=09=09pins =3D "gpio99";
>> +=09=09=09drive-strength =3D <16>;
>> +=09=09=09output-high;
>> +=09=09};
>> +=09};
>> +
>> +=09ts_int_default: ts-int-default {
>> +=09=09mux {
>> +=09=09=09pins =3D "gpio125";
>> +=09=09=09function =3D "gpio";
>> +=09=09};
>> +
>> +=09=09config {
>> +=09=09=09pins =3D "gpio125";
>> +=09=09=09bias-pull-down;
>> +=09=09=09drive-strength =3D <16>;
>> +=09=09=09input-enable;
>> +=09=09};
>> +=09};
>> +
>> +=09ts_reset_sleep: ts-reset-sleep {
>> +=09=09mux {
>> +=09=09=09pins =3D "gpio99";
>> +=09=09=09function =3D "gpio";
>> +=09=09};
>> +
>> +=09=09config {
>> +=09=09=09pins =3D "gpio99";
>> +=09=09=09bias-disable;
>> +=09=09=09drive-strength =3D <2>;
>> +=09=09};
>> +=09};
>> +
>> +=09ts_int_sleep: ts-int-sleep {
>> +=09=09mux {
>> +=09=09=09pins =3D "gpio125";
>> +=09=09=09function =3D "gpio";
>> +=09=09};
>> +
>> +=09=09config {
>> +=09=09=09pins =3D "gpio125";
>> +=09=09=09bias-pull-down;
>> +=09=09=09drive-strength =3D <2>;
>> +=09=09=09input-enable;
>> +=09=09};
>> +=09};
>> +
>> +=09sde_dsi_active: sde-dsi-active {
>> +=09=09mux {
>> +=09=09=09pins =3D "gpio6", "gpio10";
>> +=09=09=09function =3D "gpio";
>> +=09=09};
>> +
>> +=09=09config {
>> +=09=09=09pins =3D "gpio6", "gpio10";
>> +=09=09=09drive-strength =3D <8>;
>> +=09=09=09bias-disable =3D <0>;
>> +=09=09};
>> +=09};
>> +
>> +=09sde_dsi_suspend: sde-dsi-suspend {
>> +=09=09mux {
>> +=09=09=09pins =3D "gpio6", "gpio10";
>> +=09=09=09function =3D "gpio";
>> +=09=09};
>> +
>> +=09=09config {
>> +=09=09=09pins =3D "gpio6", "gpio10";
>> +=09=09=09drive-strength =3D <2>;
>> +=09=09=09bias-pull-down;
>> +=09=09};
>> +=09};
>> +
>> +=09wcd_intr_default: wcd-intr-default {
>> +=09=09pins =3D <54>;
>> +=09=09function =3D "gpio";
>> +
>> +=09=09input-enable;
>> +=09=09bias-pull-down;
>> +=09=09drive-strength =3D <2>;
>> +=09};
>> +};
>> +
>> +&uart6 {
>> +=09status =3D "okay";
>> +
>> +=09bluetooth {
>> +=09=09compatible =3D "qcom,wcn3990-bt";
>> +
>> +=09=09/*
>> +=09=09 * This path is relative to the qca/
>> +=09=09 * subdir under lib/firmware.
>> +=09=09 */
> This comment should fit in a single line.
>
>> +=09=09firmware-name =3D "polaris/crnv21.bin";
>> +
>> +=09=09vddio-supply =3D <&vreg_s4a_1p8>;
>> +=09=09vddxo-supply =3D <&vreg_l7a_1p8>;
>> +=09=09vddrf-supply =3D <&vreg_l17a_1p3>;
>> +=09=09vddch0-supply =3D <&vreg_l25a_3p3>;
>> +=09=09max-speed =3D <3200000>;
>> +=09};
>> +};
>> +
>> +&usb_1 {
>> +=09status =3D "okay";
>> +=09/* We'll use this as USB 2.0 only */
>> +=09qcom,select-utmi-as-pipe-clk;
>> +};
>> +
>> +&usb_1_dwc3 {
>> +=09dr_mode =3D "peripheral";
>> +
>> +=09/* fastest mode for USB 2 */
> Tiiiny nit, but since you have to send v(n+1) anyway, please make this
> comment start with an uppercase letter.
>
>
>> +=09maximum-speed =3D "high-speed";
>> +
>> +=09/* Remove USB3 phy */
>> +=09phys =3D <&usb_1_hsphy>;
>> +=09phy-names =3D "usb2-phy";
>> +};
>> +
>> +&usb_1_hsphy {
>> +=09status =3D "okay";
>> +
>> +=09vdd-supply =3D <&vreg_l1a_0p875>;
>> +=09vdda-pll-supply =3D <&vreg_l12a_1p8>;
>> +=09vdda-phy-dpdm-supply =3D <&vreg_l24a_3p075>;
>> +
>> +=09qcom,imp-res-offset-value =3D <8>;
>> +=09qcom,hstx-trim-value =3D <QUSB2_V2_HSTX_TRIM_21_6_MA>;
>> +=09qcom,preemphasis-level =3D <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
>> +=09qcom,preemphasis-width =3D <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
>> +};
>> +
>> +&usb_1_qmpphy {
>> +=09status =3D "okay";
>> +
>> +=09vdda-phy-supply =3D <&vreg_l26a_1p2>;
>> +=09vdda-pll-supply =3D <&vreg_l1a_0p875>;
>> +};
>> +
>> +&ufs_mem_hc {
>> +=09status =3D "okay";
>> +=09reset-gpios =3D <&tlmm 150 GPIO_ACTIVE_LOW>;
>> +=09vcc-supply =3D <&vreg_l20a_2p95>;
>> +=09vcc-max-microamp =3D <800000>;
>> +};
>> +
>> +&ufs_mem_phy {
>> +=09status =3D "okay";
>> +=09vdda-phy-supply =3D <&vdda_ufs1_core>;
>> +=09vdda-pll-supply =3D <&vdda_ufs1_1p2>;
>> +};
>> +
>> +&venus {
>> +=09status =3D "okay";
>> +=09firmware-name =3D "qcom/sdm845/polaris/venus.mbn";
>> +};
>> +
>> +&wcd9340{
> Missing space.
>
> Konrad
>> +=09pinctrl-0 =3D <&wcd_intr_default>;
>> +=09pinctrl-names =3D "default";
>> +=09clock-names =3D "extclk";
>> +=09clocks =3D <&rpmhcc RPMH_LN_BB_CLK2>;
>> +=09reset-gpios =3D <&tlmm 64 0>;
>> +=09vdd-buck-supply =3D <&vreg_s4a_1p8>;
>> +=09vdd-buck-sido-supply =3D <&vreg_s4a_1p8>;
>> +=09vdd-tx-supply =3D <&vreg_s4a_1p8>;
>> +=09vdd-rx-supply =3D <&vreg_s4a_1p8>;
>> +=09vdd-io-supply =3D <&vreg_s4a_1p8>;
>> +=09qcom,micbias1-microvolt =3D <2700000>;
>> +=09qcom,micbias2-microvolt =3D <1800000>;
>> +=09qcom,micbias3-microvolt =3D <2700000>;
>> +=09qcom,micbias4-microvolt =3D <2700000>;
>> +};
>> +
>> +&wifi {
>> +=09status =3D "okay";
>> +
>> +=09vdd-0.8-cx-mx-supply =3D <&vreg_l5a_0p8>;
>> +=09vdd-1.8-xo-supply =3D <&vreg_l7a_1p8>;
>> +=09vdd-1.3-rfa-supply =3D <&vreg_l17a_1p3>;
>> +=09vdd-3.3-ch0-supply =3D <&vreg_l25a_3p3>;
>> +=09vdd-3.3-ch1-supply =3D <&vreg_l23a_3p3>;
>> +
>> +=09qcom,snoc-host-cap-skip-quirk;
>> +};
>> +
>> +/* PINCTRL - additions to nodes defined in sdm845.dtsi */
This comment can be dropped
>> +
>> +&qup_uart6_default {
>> +=09pinmux {
>> +=09=09 pins =3D "gpio45", "gpio46", "gpio47", "gpio48";
>> +=09=09 function =3D "qup6";
>> +=09};
>> +
>> +=09cts {
>> +=09=09pins =3D "gpio45";
>> +=09=09bias-disable;
>> +=09};
>> +
>> +=09rts-tx {
>> +=09=09pins =3D "gpio46", "gpio47";
>> +=09=09drive-strength =3D <2>;
>> +=09=09bias-disable;
>> +=09};
>> +
>> +=09rx {
>> +=09=09pins =3D "gpio48";
>> +=09=09bias-pull-up;
>> +=09};
>> +};
>>
>

