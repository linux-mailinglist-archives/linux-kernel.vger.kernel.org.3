Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A970252CFF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiESJ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiESJ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:57:58 -0400
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC02980A2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:57:55 -0700 (PDT)
Date:   Thu, 19 May 2022 09:57:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1652954273; x=1653213473;
        bh=mI9YViAkERtCP5EFuhj+NGOwU/tifHVoXhnfRWVBLSI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=haUv0nm1H8O7A0JGUks64lqZE0GcVZF5jV+VjjtveGI31F8skfJMLlJjl8k8MjJiZ
         woFif3+I4PiLrxVtOa5sAET0VwNXEwXiMh+ZiBcHVxFIUjZ33BLALMtmkhcub7+ofM
         bBpOQ7o1IHsFPFa2yNaUrDPv6RHJKQFMMXRzI4ikVsIeP2juvhxymEE5mkmbShobS+
         wKCwUg1YrVBePAXBZK7PYUYhvLKpKSqNLefZ0mKb5p1e3alBBqm4yIhZ4qg9ALuaNm
         M1QfZiiFucpJxgSyMrKH+rRuVAKCUXrLlkyVk79fidCSnh18hgiHNes3gD/ELJmTFX
         T48aPE7nygubA==
To:     Andy Gross <agross@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Alec Su <ae40515@yahoo.com.tw>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8996-xiaomi-natrium: Add support for Xiaomi Mi 5s Plus
Message-ID: <NqQY5WA6i6jOhK8lZ-YD4kWA57qJCSIGJE6_xAQmOiFJ4a-msHcn7oakouduiLhODYlfWVvgr-E5S6m43Ab6EUFa0ZPYV0kPGeYbVV7zpUI=@protonmail.com>
In-Reply-To: <3644ad8a-d5d8-8ea2-b659-029619c64f1f@linaro.org>
References: <20220519074112.25600-1-ae40515@yahoo.com.tw> <20220519074112.25600-2-ae40515@yahoo.com.tw> <3644ad8a-d5d8-8ea2-b659-029619c64f1f@linaro.org>
Feedback-ID: 6882736:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 19th, 2022 at 1:42 PM, Krzysztof Kozlowski <krzysztof.kozl=
owski@linaro.org> wrote:
> On 19/05/2022 09:41, Alec Su wrote:
>
> > Add the device tree for Xiaomi Mi 5s Plus (natrium).
> >
> > Signed-off-by: Alec Su ae40515@yahoo.com.tw
> > Reviewed-by: Yassine Oudjana y.oudjana@protonmail.com
>
>
> This is the first patch, so the review tag is a bit unexepected. Was it
> really given?

I reviewed it before it was sent. Apparently I wasn't thorough enough
since you found some simple mistakes.

> > ---
> > arch/arm64/boot/dts/qcom/Makefile | 1 +
> > .../boot/dts/qcom/msm8996-xiaomi-natrium.dts | 419 ++++++++++++++++++
> > 2 files changed, 420 insertions(+)
> > create mode 100644 arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
> >
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qc=
om/Makefile
> > index 2f8aec2cc6db..3ae7ecd369fb 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -37,6 +37,7 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D msm8996-sony-xperia-tone=
-dora.dtb
> > dtb-$(CONFIG_ARCH_QCOM) +=3D msm8996-sony-xperia-tone-kagura.dtb
> > dtb-$(CONFIG_ARCH_QCOM) +=3D msm8996-sony-xperia-tone-keyaki.dtb
> > dtb-$(CONFIG_ARCH_QCOM) +=3D msm8996-xiaomi-gemini.dtb
> > +dtb-$(CONFIG_ARCH_QCOM) +=3D msm8996-xiaomi-natrium.dtb
> > dtb-$(CONFIG_ARCH_QCOM) +=3D msm8996-xiaomi-scorpio.dtb
> > dtb-$(CONFIG_ARCH_QCOM) +=3D msm8998-asus-novago-tp370ql.dtb
> > dtb-$(CONFIG_ARCH_QCOM) +=3D msm8998-fxtec-pro1.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts b/arch=
/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
> > new file mode 100644
> > index 000000000000..212ff0fbf262
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
> > @@ -0,0 +1,419 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*> + * Copyright (c) 2022, Alec Su ae40515@yahoo.com.tw
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "msm8996-xiaomi-common.dtsi"
> > +#include "pmi8996.dtsi"
> > +#include <dt-bindings/sound/qcom,q6afe.h>
> > +#include <dt-bindings/sound/qcom,q6asm.h>
> > +
> > +/ {
> > + model =3D "Xiaomi Mi 5s Plus";
> > + compatible =3D "xiaomi,natrium", "qcom,msm8996";
> > + chassis-type =3D "handset";
> > + qcom,msm-id =3D <305 0x10000>;
>
>
> There is no such property documented. Either add bindings, or drop.
>
> > + qcom,board-id =3D <47 0>;
>
>
> The same.

These properties are already used in many device trees; they are
needed to let the bootloader pick a DTB, but yes they aren't
documented currently. devicetree/bindings/arm/qcom.yaml would
probably be a good place to put them.

> > +};
> > +
> > +&adsp_pil {
> > + firmware-name =3D "qcom/msm8996/natrium/adsp.mbn";
> > +};
> > +
> > +&blsp2_i2c6 {
> > + synaptics@20 {
> > + compatible =3D "syna,rmi4-i2c";
> > + reg =3D <0x20>;
> > + #address-cells =3D <1>;
> > + #size-cells =3D <0>;
>
>
> Why do you have address/size cells here?
>
> > + interrupt-parent =3D <&tlmm>;
> > + interrupts =3D <125 IRQ_TYPE_LEVEL_LOW>;
> > + vdda-supply =3D <&vreg_l6a_1p8>;
> > + vdd-supply =3D <&vdd_3v2_tp>;
> > + reset-gpios =3D <&tlmm 89 GPIO_ACTIVE_LOW>;
> > +
> > + pinctrl-names =3D "default", "sleep";
> > + pinctrl-0 =3D <&touchscreen_default>;
> > + pinctrl-1 =3D <&touchscreen_sleep>;
> > + };
> > +
>
>
> No need for blank line.
>
> > +};
> > +
> > +&dsi0 {
> > + status =3D "okay";
> > +
> > + vdd-supply =3D <&vreg_l2a_1p25>;
> > + vdda-supply =3D <&vreg_l19a_3p3>;
> > + vddio-supply =3D <&vreg_l14a_1p8>;
> > +
> > + pinctrl-names =3D "default", "sleep";
> > + pinctrl-0 =3D <&mdss_dsi_default &mdss_te_default>;
> > + pinctrl-1 =3D <&mdss_dsi_sleep &mdss_te_sleep>;
> > +
> > + panel: panel@0 {
> > + compatible =3D "jdi,fhd-r63452";
> > + reg =3D <0>;
> > + reset-gpios =3D <&tlmm 8 GPIO_ACTIVE_LOW>;
> > + backlight =3D <&pmi8994_wled>;
> > +
> > + port {
> > + panel_in: endpoint {
> > + remote-endpoint =3D <&dsi0_out>;
> > + };
> > + };
> > + };
> > +};
> > +
> > +&dsi0_out {
> > + remote-endpoint =3D <&panel_in>;
> > +};
> > +
> > +&gpu {
> > + zap-shader {
> > + firmware-name =3D "qcom/msm8996/natrium/a530_zap.mbn";
> > + };
> > +};
> > +
> > +&mss_pil {
> > + firmware-name =3D "qcom/msm8996/natrium/mba.mbn",
> > + "qcom/msm8996/natrium/modem.mbn";
> > +};
> > +
> > +&pmi8994_wled {
> > + status =3D "okay";
> > +
> > + qcom,num-strings =3D <2>;
> > + qcom,enabled-strings =3D <0 1>;
> > + qcom,switching-freq =3D <600>;
> > +};
> > +
> > +&q6asmdai {
> > + dai@0 {
> > + reg =3D <0>;
> > + };
> > +
> > + dai@1 {
> > + reg =3D <1>;
> > + };
> > +
> > + dai@2 {
> > + reg =3D <2>;
> > + };
> > +};
> > +
> > +&slpi_pil {
> > + firmware-name =3D "qcom/msm8996/natrium/slpi.mbn";
> > +};
> > +
> > +&sound {
> > + compatible =3D "qcom,apq8096-sndcard";
> > + model =3D "natrium";
> > + audio-routing =3D "RX_BIAS", "MCLK";
> > +
> > + mm1-dai-link {
> > + link-name =3D "MultiMedia1";
> > + cpu {
> > + sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> > + };
> > + };
> > +
> > + mm2-dai-link {
> > + link-name =3D "MultiMedia2";
> > + cpu {
> > + sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
> > + };
> > + };
> > +
> > + mm3-dai-link {
> > + link-name =3D "MultiMedia3";
> > + cpu {
> > + sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
> > + };
> > + };
> > +
> > + slim-dai-link {
> > + link-name =3D "SLIM Playback";
> > + cpu {
> > + sound-dai =3D <&q6afedai SLIMBUS_6_RX>;
> > + };
> > +
> > + platform {
> > + sound-dai =3D <&q6routing>;
> > + };
> > +
> > + codec {
> > + sound-dai =3D <&wcd9335 6>;
> > + };
> > + };
> > +
> > + slimcap-dai-link {
> > + link-name =3D "SLIM Capture";
> > + cpu {
> > + sound-dai =3D <&q6afedai SLIMBUS_0_TX>;
> > + };
> > +
> > + platform {
> > + sound-dai =3D <&q6routing>;
> > + };
> > +
> > + codec {
> > + sound-dai =3D <&wcd9335 1>;
> > + };
> > + };
> > +};
> > +
> > +&venus {
> > + firmware-name =3D "qcom/msm8996/natrium/venus.mbn";
> > +};
> > +
> > +&rpm_requests {
> > + pm8994-regulators {
> > + vreg_l3a_0p875: l3 {
> > + regulator-name =3D "vreg_l3a_0p875";
> > + regulator-min-microvolt =3D <850000>;
> > + regulator-max-microvolt =3D <1300000>;
> > + };
> > + vreg_l11a_1p1: l11 {
> > + regulator-name =3D "vreg_l11a_1p1";
> > + regulator-min-microvolt =3D <1100000>;
> > + regulator-max-microvolt =3D <1100000>;
> > + };
> > + vreg_l17a_2p8: l17 {
> > + regulator-name =3D "vreg_l17a_2p8";
> > + regulator-min-microvolt =3D <2800000>;
> > + regulator-max-microvolt =3D <2800000>;
> > + };
> > + vreg_l18a_2p8: l18 {
> > + regulator-name =3D "vreg_l18a_2p8";
> > + regulator-min-microvolt =3D <2800000>;
> > + regulator-max-microvolt =3D <2800000>;
> > + };
> > + vreg_l29a_2p8: l29 {
> > + regulator-name =3D "vreg_l29a_2p8";
> > + regulator-min-microvolt =3D <2800000>;
> > + regulator-max-microvolt =3D <2800000>;
> > + };
> > + };
> > +};
> > +
> > +&pm8994_gpios {
> > + gpio-line-names =3D
> > + "NC", /* GPIO_1 /
> > + "VOL_UP_N", / GPIO_2 /
> > + "SPKR_ID", / GPIO_3 /
> > + "PWM_HAPTICS", / GPIO_4 /
> > + "INFARED_DRV", / GPIO_5 /
> > + "NC", / GPIO_6 /
> > + "KEYPAD_LED_EN_A", / GPIO_7 /
> > + "WL_EN", / GPIO_8 /
> > + "3P3_ENABLE", / GPIO_9 /
> > + "NC", / GPIO_10 /
> > + "NC", / GPIO_11 /
> > + "NC", / GPIO_12 /
> > + "NC", / GPIO_13 /
> > + "NC", / GPIO_14 /
> > + "DIVCLK1_CDC", / GPIO_15 /
> > + "DIVCLK2_HAPTICS", / GPIO_16 /
> > + "NC", / GPIO_17 /
> > + "32KHz_CLK_IN", / GPIO_18 /
> > + "BT_EN", / GPIO_19 /
> > + "PMIC_SLB", / GPIO_20 /
> > + "UIM_BATT_ALARM", / GPIO_21 /
> > + "NC"; / GPIO_22 /
> > +};
> > +
> > +&pm8994_mpps {
> > + gpio-line-names =3D
> > + "NC", / MPP_1 /
> > + "CCI_TIMER1", / MPP_2 /
> > + "PMIC_SLB", / MPP_3 /
> > + "EXT_FET_WLED_PWR_EN_N",/ MPP_4 /
> > + "NC", / MPP_5 /
> > + "NC", / MPP_6 /
> > + "NC", / MPP_7 /
> > + "NC"; / MPP_8 /
> > +};
> > +
> > +&pmi8994_gpios {
> > + gpio-line-names =3D
> > + "NC", / GPIO_1 /
> > + "SPKR_PA_EN", / GPIO_2 /
> > + "NC", / GPIO_3 /
> > + "NC", / GPIO_4 /
> > + "NC", / GPIO_5 /
> > + "NC", / GPIO_6 /
> > + "NC", / GPIO_7 /
> > + "NC", / GPIO_8 /
> > + "NC", / GPIO_9 /
> > + "NC"; / GPIO_10 /
> > +};
> > +
> > +&tlmm {
> > + gpio-line-names =3D
> > + "ESE_SPI_MOSI", / GPIO_0 /
> > + "ESE_SPI_MISO", / GPIO_1 /
> > + "NC", / GPIO_2 /
> > + "ESE_SPI_CLK", / GPIO_3 /
> > + "MSM_UART_TX", / GPIO_4 /
> > + "MSM_UART_RX", / GPIO_5 /
> > + "NFC_I2C_SDA", / GPIO_6 /
> > + "NFC_I2C_SCL", / GPIO_7 /
> > + "LCD0_RESET_N", / GPIO_8 /
> > + "NFC_IRQ", / GPIO_9 /
> > + "LCD_TE", / GPIO_10 /
> > + "LCD_ID_DET1", / GPIO_11 /
> > + "NFC_DISABLE", / GPIO_12 /
> > + "CAM_MCLK0", / GPIO_13 /
> > + "CAM_MCLK1", / GPIO_14 /
> > + "CAM_MCLK2", / GPIO_15 /
> > + "ESE_PWR_REQ", / GPIO_16 /
> > + "CCI_I2C_SDA0", / GPIO_17 /
> > + "CCI_I2C_SCL0", / GPIO_18 /
> > + "CCI_I2C_SDA1", / GPIO_19 /
> > + "CCI_I2C_SCL1", / GPIO_20 /
> > + "NFC_DWL_REQ", / GPIO_21 /
> > + "CCI_TIMER1", / GPIO_22 /
> > + "WEBCAM1_RESET_N", / GPIO_23 /
> > + "ESE_IRQ", / GPIO_24 /
> > + "NC", / GPIO_25 /
> > + "WEBCAM1_STANDBY", / GPIO_26 /
> > + "NC", / GPIO_27 /
> > + "NC", / GPIO_28 /
> > + "NC", / GPIO_29 /
> > + "CAM_VDD_1P2_EN_2", / GPIO_30 /
> > + "CAM_RESET_0", / GPIO_31 /
> > + "CAM_RESET_1", / GPIO_32 /
> > + "NC", / GPIO_33 /
> > + "NC", / GPIO_34 /
> > + "PCI_E0_RST_N", / GPIO_35 /
> > + "PCI_E0_CLKREQ_N", / GPIO_36 /
> > + "PCI_E0_WAKE", / GPIO_37 /
> > + "CHARGER_INT", / GPIO_38 /
> > + "CHARGER_RESET", / GPIO_39 /
> > + "NC", / GPIO_40 /
> > + "QCA_UART_TXD", / GPIO_41 /
> > + "QCA_UART_RXD", / GPIO_42 /
> > + "QCA_UART_CTS", / GPIO_43 /
> > + "QCA_UART_RTS", / GPIO_44 /
> > + "MAWC_UART_TX", / GPIO_45 /
> > + "MAWC_UART_RX", / GPIO_46 /
> > + "NC", / GPIO_47 /
> > + "NC", / GPIO_48 /
> > + "NC", / GPIO_49 /
> > + "FP_SPI_RST", / GPIO_50 /
> > + "TYPEC_I2C_SDA", / GPIO_51 /
> > + "TYPEC_I2C_SCL", / GPIO_52 /
> > + "CODEC_INT2_N", / GPIO_53 /
> > + "CODEC_INT1_N", / GPIO_54 /
> > + "APPS_I2C7_SDA", / GPIO_55 /
> > + "APPS_I2C7_SCL", / GPIO_56 /
> > + "FORCE_USB_BOOT", / GPIO_57 /
> > + "NC", / GPIO_58 /
> > + "NC", / GPIO_59 /
> > + "NC", / GPIO_60 /
> > + "NC", / GPIO_61 /
> > + "ESE_RSTN", / GPIO_62 /
> > + "TYPEC_INT", / GPIO_63 /
> > + "CODEC_RESET_N", / GPIO_64 /
> > + "PCM_CLK", / GPIO_65 /
> > + "PCM_SYNC", / GPIO_66 /
> > + "PCM_DIN", / GPIO_67 /
> > + "PCM_DOUT", / GPIO_68 /
> > + "CDC_44K1_CLK", / GPIO_69 /
> > + "SLIMBUS_CLK", / GPIO_70 /
> > + "SLIMBUS_DATA0", / GPIO_71 /
> > + "SLIMBUS_DATA1", / GPIO_72 /
> > + "LDO_5V_IN_EN", / GPIO_73 /
> > + "TYPEC_EN_N", / GPIO_74 /
> > + "NC", / GPIO_75 /
> > + "NC", / GPIO_76 /
> > + "NC", / GPIO_77 /
> > + "NC", / GPIO_78 /
> > + "NC", / GPIO_79 /
> > + "SENSOR_RESET_N", / GPIO_80 /
> > + "FP_SPI_MOSI", / GPIO_81 /
> > + "FP_SPI_MISO", / GPIO_82 /
> > + "FP_SPI_CS_N", / GPIO_83 /
> > + "FP_SPI_CLK", / GPIO_84 /
> > + "NC", / GPIO_85 /
> > + "CAM_VDD_1P2_EN", / GPIO_86 /
> > + "MSM_TS_I2C_SDA", / GPIO_87 /
> > + "MSM_TS_I2C_SCL", / GPIO_88 /
> > + "TS_RESOUT_N", / GPIO_89 /
> > + "ESE_SPI_CS_N", / GPIO_90 /
> > + "NC", / GPIO_91 /
> > + "CAM2_AVDD_EN", / GPIO_92 /
> > + "CAM2_VCM_EN", / GPIO_93 /
> > + "NC", / GPIO_94 /
> > + "NC", / GPIO_95 /
> > + "NC", / GPIO_96 /
> > + "GRFC_0", / GPIO_97 /
> > + "GRFC_1", / GPIO_98 /
> > + "NC", / GPIO_99 /
> > + "GRFC_3", / GPIO_100 /
> > + "GRFC_4", / GPIO_101 /
> > + "GRFC_5", / GPIO_102 /
> > + "NC", / GPIO_103 /
> > + "GRFC_7", / GPIO_104 /
> > + "UIM2_DATA", / GPIO_105 /
> > + "UIM2_CLK", / GPIO_106 /
> > + "UIM2_RESET", / GPIO_107 /
> > + "UIM2_PRESENT", / GPIO_108 /
> > + "UIM1_DATA", / GPIO_109 /
> > + "UIM1_CLK", / GPIO_110 /
> > + "UIM1_RESET", / GPIO_111 /
> > + "UIM1_PRESENT", / GPIO_112 /
> > + "UIM_BATT_ALARM", / GPIO_113 /
> > + "GRFC_8", / GPIO_114 /
> > + "GRFC_9", / GPIO_115 /
> > + "TX_GTR_THRES", / GPIO_116 /
> > + "ACCEL_INT", / GPIO_117 /
> > + "GYRO_INT", / GPIO_118 /
> > + "COMPASS_INT", / GPIO_119 /
> > + "PROXIMITY_INT_N", / GPIO_120 /
> > + "FP_IRQ", / GPIO_121 /
> > + "P_SENSE", / GPIO_122 /
> > + "HALL_INTR2", / GPIO_123 /
> > + "HALL_INTR1", / GPIO_124 /
> > + "TS_INT_N", / GPIO_125 /
> > + "NC", / GPIO_126 /
> > + "GRFC_11", / GPIO_127 /
> > + "NC", / GPIO_128 /
> > + "EXT_GPS_LNA_EN", / GPIO_129 /
> > + "NC", / GPIO_130 /
> > + "LCD_ID_DET2", / GPIO_131 /
> > + "LCD_TE2", / GPIO_132 /
> > + "GRFC_14", / GPIO_133 /
> > + "GSM_TX2_PHASE_D", / GPIO_134 /
> > + "NC", / GPIO_135 /
> > + "GRFC_15", / GPIO_136 /
> > + "RFFE3_DATA", / GPIO_137 /
> > + "RFFE3_CLK", / GPIO_138 /
> > + "NC", / GPIO_139 /
> > + "NC", / GPIO_140 /
> > + "RFFE5_DATA", / GPIO_141 /
> > + "RFFE5_CLK", / GPIO_142 /
> > + "NC", / GPIO_143 /
> > + "COEX_UART_TX", / GPIO_144 /
> > + "COEX_UART_RX", / GPIO_145 /
> > + "RFFE2_DATA", / GPIO_146 /
> > + "RFFE2_CLK", / GPIO_147 /
> > + "RFFE1_DATA", / GPIO_148 /
> > + "RFFE1_CLK"; / GPIO_149 */
> > +
> > + touchscreen_default: touchscreen_default {
>
>
> No underscores in node names.
>
> > + pins =3D "gpio89", "gpio125";
> > + function =3D "gpio";
> > + drive-strength =3D <10>;
> > + bias-pull-up;
> > + };
> > +
> > + touchscreen_sleep: touchscreen_sleep {
>
>
> The same.
>
> > + pins =3D "gpio89", "gpio125";
> > + function =3D "gpio";
> > + drive-strength =3D <2>;
> > + bias-disable;
> > + };
> > +};
>
>
>
> Best regards,
> Krzysztof
