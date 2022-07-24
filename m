Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A139657F495
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 11:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiGXJ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 05:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiGXJ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 05:56:05 -0400
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E01DEE4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 02:55:56 -0700 (PDT)
Date:   Sun, 24 Jul 2022 09:55:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1658656554; x=1658915754;
        bh=FEF5AAiMS4gD8qsqPLEZ7xhLZ3WtoMjzRd22rrrxYf4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=bbTAC0eGK0IsA02e6NpZaAKsH8aw6uHMRcwaz1R9tvUkTIY0MHBz35dyT+c8Ej5Au
         KWYsJAT3IB2nLHVMTCiWuvBQU3BWr+/KxdYJlfzc5dNCS71dOeg5tvzfNkTMpilGWH
         P2gRiQNby5uB2GmPREutQAQn84twp8gd70V0vGp/rPjxjHFt96EDfjL+t5bGhG1FTR
         fENX7i13Vlq/wISFTasvVs9ncgg6ZQkit+cUbi/uWZlypx6FTPjmLTgZO5/FUBLWZo
         UScWBhECWTdxi7e6aAbNaiNeVkUEMAv09NXVnTj1fKjlBc/VIjatNCLeLt9CMNv9n8
         A/ZVDKItArixQ==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, soc@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH v7 4/5] arm64: dts: qcom: msm8916-samsung-e2015: Add touchkey
Message-ID: <20220724095426.14189-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220724095039.13568-1-linmengbo0689@protonmail.com>
References: <20220724095039.13568-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Samsung Galaxy E5 and E7 the touch key is supplied by a single
fixed regulator (enabled via GPIO 97) that supplies both MCU and LED.
Add it to the device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../qcom/msm8916-samsung-e2015-common.dtsi    | 26 +++++++++++++++++++
 .../dts/qcom/msm8916-samsung-grandmax.dts     |  4 +++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index 9caa8a161d31..542010fdfb8a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -38,6 +38,19 @@ reg_motor_vdd: regulator-motor-vdd {
 =09=09pinctrl-names =3D "default";
 =09=09pinctrl-0 =3D <&motor_en_default>;
 =09};
+
+=09reg_touch_key: regulator-touch-key {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "touch_key";
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+
+=09=09gpio =3D <&msmgpio 97 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&tkey_en_default>;
+=09};
 };

 &blsp_i2c2 {
@@ -48,6 +61,11 @@ &blsp_i2c2 {
 =09/delete-node/ magnetometer@12;
 };

+&touchkey {
+=09vcc-supply =3D <&reg_touch_key>;
+=09vdd-supply =3D <&reg_touch_key>;
+};
+
 &msmgpio {
 =09motor_en_default: motor-en-default {
 =09=09pins =3D "gpio76";
@@ -56,4 +74,12 @@ motor_en_default: motor-en-default {
 =09=09drive-strength =3D <2>;
 =09=09bias-disable;
 =09};
+
+=09tkey_en_default: tkey-en-default {
+=09=09pins =3D "gpio97";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts b/arch/a=
rm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
index 4c1becdb9428..bc7134698978 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
@@ -41,6 +41,10 @@ &reg_motor_vdd {
 =09gpio =3D <&msmgpio 72 GPIO_ACTIVE_HIGH>;
 };

+&reg_touch_key {
+=09status =3D "disabled";
+};
+
 &msmgpio {
 =09gpio_leds_default: gpio-led-default {
 =09=09pins =3D "gpio60";
--
2.30.2


