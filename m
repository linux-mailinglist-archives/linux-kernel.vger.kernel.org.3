Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2857F10B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 21:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbiGWTAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 15:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiGWTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 15:00:34 -0400
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E401815805;
        Sat, 23 Jul 2022 12:00:31 -0700 (PDT)
Date:   Sat, 23 Jul 2022 19:00:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1658602829; x=1658862029;
        bh=Sj0ZR0HohsjOPmgButsXa1atxWK2a6J45yAwavd2ntA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=kmWp7YUYsZ/y627bGA37yXGSqDgPyhfDkggDRN4h36WXAGKxjJVVV87Tq5OBd5DHk
         R3opUTLtk6uWZOGR+vtX8P+xjkXv6ly1W7UFbNzcAeY2JTZXeiI+R3p1It9JR6xUnS
         RbxepFNGFDA8bLO/xnD8QdO1GbA3Fz7sSkgG4Sn0AiBrYG3Zfh8dXq+mXeX3ax83uV
         Kz6jzbjpPdErVXdGa+vlcfUBo/AkRzdhZiImO4yumFqHt9AKpdYue6bJVIpgjRvYyn
         btI1s5P3aV7b36QPvaPLBAIofuCVnS+qTFSdhJO8uhPrLDkMzkkzycBVtB0Sz2B9rr
         +5JWlc9tBLOIA==
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
Subject: [PATCH v6 3/5] ARM: dts: qcom-msm8916-samsung-e2015: Include dts from arm64
Message-ID: <20220723185913.203747-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220723185424.203340-1-linmengbo0689@protonmail.com>
References: <20220723185424.203340-1-linmengbo0689@protonmail.com>
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

After adding all necessary support for MSM8916 SMP/cpuidle without PSCI
on ARM32, build the Samsung Galaxy E5/E7/Grand Max device trees from the
arm64 tree together with the ARM32 include to allow booting this device on
ARM32.

The approach to include device tree files from other architectures is
inspired from e.g. the Raspberry Pi (bcm2711-rpi-4-b.dts) where this is
used to build the device tree for both ARM32 and ARM64.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>

arm64: dts: qcom: msm8916-samsung-e2015: Add regulator haptic
---
 arch/arm/boot/dts/Makefile                     |  3 +++
 arch/arm/boot/dts/qcom-msm8916-samsung-e5.dts  |  3 +++
 arch/arm/boot/dts/qcom-msm8916-samsung-e7.dts  |  3 +++
 .../boot/dts/qcom-msm8916-samsung-grandmax.dts |  3 +++
 .../dts/qcom/msm8916-samsung-e2015-common.dtsi | 18 +++---------------
 .../boot/dts/qcom/msm8916-samsung-grandmax.dts |  4 ++--
 6 files changed, 17 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8916-samsung-e5.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8916-samsung-e7.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8916-samsung-grandmax.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5112f493f494..b7a6983ee6fa 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1030,6 +1030,9 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
 =09qcom-ipq8064-rb3011.dtb \
 =09qcom-msm8226-samsung-s3ve3g.dtb \
 =09qcom-msm8660-surf.dtb \
+=09qcom-msm8916-samsung-e5.dtb \
+=09qcom-msm8916-samsung-e7.dtb \
+=09qcom-msm8916-samsung-grandmax.dtb \
 =09qcom-msm8916-samsung-serranove.dtb \
 =09qcom-msm8960-cdp.dtb \
 =09qcom-msm8974-lge-nexus5-hammerhead.dtb \
diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-e5.dts b/arch/arm/boot/=
dts/qcom-msm8916-samsung-e5.dts
new file mode 100644
index 000000000000..c8d34de8a71e
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8916-samsung-e5.dts
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "arm64/qcom/msm8916-samsung-e5.dts"
+#include "qcom-msm8916-smp.dtsi"
diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-e7.dts b/arch/arm/boot/=
dts/qcom-msm8916-samsung-e7.dts
new file mode 100644
index 000000000000..85be286c8608
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8916-samsung-e7.dts
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "arm64/qcom/msm8916-samsung-e7.dts"
+#include "qcom-msm8916-smp.dtsi"
diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-grandmax.dts b/arch/arm=
/boot/dts/qcom-msm8916-samsung-grandmax.dts
new file mode 100644
index 000000000000..d3abe0536238
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8916-samsung-grandmax.dts
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "arm64/qcom/msm8916-samsung-grandmax.dts"
+#include "qcom-msm8916-smp.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index 9caa8a161d31..3677fd81b6c1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -3,13 +3,6 @@
 #include "msm8916-samsung-a2015-common.dtsi"

 / {
-=09haptic {
-=09=09compatible =3D "regulator-haptic";
-=09=09haptic-supply =3D <&reg_motor_vdd>;
-=09=09min-microvolt =3D <3300000>;
-=09=09max-microvolt =3D <3300000>;
-=09};
-
 =09i2c-muic {
 =09=09/* SM5504 MUIC instead of SM5502 */
 =09=09/delete-node/ extcon@25;
@@ -26,14 +19,9 @@ muic: extcon@14 {
 =09=09};
 =09};

-=09reg_motor_vdd: regulator-motor-vdd {
-=09=09compatible =3D "regulator-fixed";
-=09=09regulator-name =3D "motor_vdd";
-=09=09regulator-min-microvolt =3D <3300000>;
-=09=09regulator-max-microvolt =3D <3300000>;
-
-=09=09gpio =3D <&msmgpio 76 GPIO_ACTIVE_HIGH>;
-=09=09enable-active-high;
+=09vibrator: vibrator {
+=09=09compatible =3D "gpio-vibrator";
+=09=09enable-gpios =3D <&msmgpio 76 GPIO_ACTIVE_HIGH>;

 =09=09pinctrl-names =3D "default";
 =09=09pinctrl-0 =3D <&motor_en_default>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts b/arch/a=
rm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
index 4c1becdb9428..74c07a970317 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
@@ -37,8 +37,8 @@ keyled {
 =09};
 };

-&reg_motor_vdd {
-=09gpio =3D <&msmgpio 72 GPIO_ACTIVE_HIGH>;
+&vibrator {
+=09enable-gpios =3D <&msmgpio 72 GPIO_ACTIVE_HIGH>;
 };

 &msmgpio {
--
2.30.2


