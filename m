Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3541C57F493
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 11:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbiGXJ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 05:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiGXJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 05:56:02 -0400
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44BAD126
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 02:55:56 -0700 (PDT)
Date:   Sun, 24 Jul 2022 09:55:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1658656554; x=1658915754;
        bh=JRcaGadoJSWUp388kLH0FateOfociPuBOP6jmYHh0XE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=NgmzzJBkVnRPAuu1I31pjFUcbpga81SpDAc3zwR7u9TXMxkNNlaZ7AHjCIeZg5K/h
         LxaIJJf++DcjBULQHf89sfYht/j6X2Tg5KoS4zq8NkktsfrBOOfyji31Wfd+In/pJv
         /eVLf7Urr1XSXlhiYpuNLP5cMzvS+33PTNAaWf3+p83j14VDl5GV9aFmECEpIuz14A
         3elkPKOL6zPHkjOGvOgmkoA+Sce/Nf1ZKKWExQZyUCiEw65ZjCwhs0hWhqAQm4DQtB
         iE1i8rupzYOWMR6MjyVsa6Ks2MHv3X4VyltQNRrrSByc5dy4zvRLkg0yLzvH7//Lya
         mklCK4z4j4FPg==
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
Subject: [PATCH v7 5/5] arm64: dts: qcom: msm8916-samsung-a2015: Rename touchscreen analog regulator
Message-ID: <20220724095438.14252-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220724095039.13568-1-linmengbo0689@protonmail.com>
References: <20220724095039.13568-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reg_vdd_tsp: regulator-vdd-tsp is actually used as an analog regulator for
touchscreen on all of a2015 and e2015 devices.
Rename it into reg_vdd_tsp_a: regulator-vdd-tsp-a to reduce confusion.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts       | 4 ++--
 arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 9b4b7de7cec2..2ac7ee3dd7c2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -61,9 +61,9 @@ hall-sensor {
 =09=09};
 =09};

-=09reg_vdd_tsp: regulator-vdd-tsp {
+=09reg_vdd_tsp_a: regulator-vdd-tsp-a {
 =09=09compatible =3D "regulator-fixed";
-=09=09regulator-name =3D "vdd_tsp";
+=09=09regulator-name =3D "vdd_tsp_a";
 =09=09regulator-min-microvolt =3D <3300000>;
 =09=09regulator-max-microvolt =3D <3300000>;

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/ar=
m64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index 4ba11b020f9b..d86d20f28d23 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -73,8 +73,8 @@ touchscreen@20 {
 =09=09touchscreen-size-x =3D <540>;
 =09=09touchscreen-size-y =3D <960>;

-=09=09vdd-supply =3D <&reg_vdd_tsp>;
-=09=09vddo-supply =3D <&pm8916_l6>;
+=09=09vcca-supply =3D <&reg_vdd_tsp_a>;
+=09=09vdd-supply =3D <&pm8916_l6>;

 =09=09pinctrl-names =3D "default";
 =09=09pinctrl-0 =3D <&ts_int_default>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts b/arch/ar=
m64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
index d978c9ac179d..76b6e8550121 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
@@ -42,7 +42,7 @@ touchscreen@48 {
 =09=09touchscreen-size-x =3D <720>;
 =09=09touchscreen-size-y =3D <1280>;

-=09=09avdd-supply =3D <&reg_vdd_tsp>;
+=09=09avdd-supply =3D <&reg_vdd_tsp_a>;
 =09=09vdd-supply =3D <&pm8916_l6>;

 =09=09pinctrl-names =3D "default";
--
2.30.2


