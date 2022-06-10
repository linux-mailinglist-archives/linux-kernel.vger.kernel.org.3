Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555C5546BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349853AbiFJRyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244289AbiFJRyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:54:18 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF62F17FC1E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:54:17 -0700 (PDT)
Date:   Fri, 10 Jun 2022 17:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1654883653; x=1655142853;
        bh=nxoTndTUQ2vonEkTmNIcxLEtrwo1HFnunt341zyx2GM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=lQWp4mBy1fGSJ5VPzSTpIoso/bPCVN6uxsPe4rNR2LJ+Xzu3hcbvtxVYRW0ITiPp8
         ypH0aXO9FAfL5nCp+sxQEDVPNLdozXGK/Sg6sFNiX3m3PIPB6pEewUwfl/MMpLgWGZ
         92Ya4mSlHIKn6q1IQbf3t5rZwwvtUWECd8/iUepWegOMLblDiIn5KFqPwK6haH5N+X
         RjPIzv0qkKH7o1H8a9JJF6zZv931kIAETj6ZLh6yi4U3Rt0uIbFYIV0rjjAsNxUA1F
         tfUDQQEBA+KphbSQ2zkL0LvvSe+yDcnNBb1yUFN2di2fSr6yeGk2WjNgrfTcjANKLT
         WTMkf2oyTcp3g==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [RESEND PATCH] arm64: dts: qcom: msm8916-samsung-a2015: Add touchscreen pinctrl
Message-ID: <20220610175332.104154-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A3, A5 and most of the Samsung phones with MSM8916 SoC use GPIO pin 13 for
touchscreen interrupts. Add touchscreen pinctrl to a2015 common dtsi.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts      | 8 --------
 arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts      | 8 --------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 9b4b7de7cec2..9c19f257cc81 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -460,6 +460,14 @@ tsp_en_default: tsp-en-default {
 =09=09drive-strength =3D <2>;
 =09=09bias-disable;
 =09};
+
+=09ts_int_default: ts-int-default {
+=09=09pins =3D "gpio13";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
 };

 &pm8916_gpios {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/ar=
m64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index 4ba11b020f9b..bc198a2eea25 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -128,12 +128,4 @@ tkey_led_en_default: tkey-led-en-default {
 =09=09drive-strength =3D <2>;
 =09=09bias-disable;
 =09};
-
-=09ts_int_default: ts-int-default {
-=09=09pins =3D "gpio13";
-=09=09function =3D "gpio";
-
-=09=09drive-strength =3D <2>;
-=09=09bias-disable;
-=09};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts b/arch/ar=
m64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
index d978c9ac179d..7f2ab1891d91 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
@@ -69,12 +69,4 @@ tkey_en_default: tkey-en-default {
 =09=09drive-strength =3D <2>;
 =09=09bias-disable;
 =09};
-
-=09ts_int_default: ts-int-default {
-=09=09pins =3D "gpio13";
-=09=09function =3D "gpio";
-
-=09=09drive-strength =3D <2>;
-=09=09bias-disable;
-=09};
 };
--
2.30.2


