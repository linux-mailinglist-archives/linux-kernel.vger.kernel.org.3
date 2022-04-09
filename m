Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45E4FA27D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbiDIEWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbiDIEWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:22:12 -0400
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F2DCA82;
        Fri,  8 Apr 2022 21:20:04 -0700 (PDT)
Date:   Sat, 09 Apr 2022 04:20:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1649478002;
        bh=1G4kcKsu+V9ba6ODhUKp40IVqdmE3MfHKuvyo+ThTOQ=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=gibdyB98QFHb+tGpILKkq7Y2E7JcteE36UHPBNVhmXd1bDF/Krib55pibiGJ6D9h5
         Mw4UYyJO0n+xra2IxiJJC8xR9WmZ5tIvrTlOkn6xpKksSGOpG7NXx5LlmiuH8+keWK
         xYMP21Ef5sEX/9+daEYvLvFKJPFSqOqE/b1VBpSoITkUj3DuR3qqkcq8F61RxE7lp2
         Rf8IVgWIwPRb21mxsaTAH4uqlr9MvC20DTZMjUQUNWdGbjG9+4Vtyjh8pTrTRbQCQN
         5GqE4Ea0VDdxFtDoeSVEks+juZdoSQU+ez8mjcvRzCeJt4njHnWIBnXZ10l5HO8fsg
         wMlzODslre6oA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 9/9] arm64: dts: qcom: msm8996-xiaomi-scorpio: Use MSM8996 Pro
Message-ID: <I8rKN2XYPwD-pMiRLt6Hqy7v6Dw3fwg5U8sApTSX6n-4olK8_yz7c-lu_YuRsBW94N8PlXojurNpPjHWM6_710s705ptHtdyu-U7Y65SzPc=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xiaomi Mi Note 2 has the MSM8996 Pro SoC. Rename the dts
to match, include msm8996pro.dtsi, and add the qcom,msm8996pro
compatible. To do that, the msm8996.dtsi include in msm8996-xiaomi-common
has to be moved to msm8996-xiaomi-gemini, the only device that needs it
included after this change. The msm-id is also removed as it is now defined
in msm8996pro.dtsi.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile                             | 2 +-
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi           | 3 ---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts            | 1 +
 ...m8996-xiaomi-scorpio.dts =3D> msm8996pro-xiaomi-scorpio.dts} | 4 ++--
 4 files changed, 4 insertions(+), 6 deletions(-)
 rename arch/arm64/boot/dts/qcom/{msm8996-xiaomi-scorpio.dts =3D> msm8996pr=
o-xiaomi-scorpio.dts} (99%)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index f9e6343acd03..72b8fcdd9074 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -37,7 +37,7 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996-sony-xperia-tone-d=
ora.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996-sony-xperia-tone-kagura.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996-sony-xperia-tone-keyaki.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996-xiaomi-gemini.dtb
-dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996-xiaomi-scorpio.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996pro-xiaomi-scorpio.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8998-asus-novago-tp370ql.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8998-fxtec-pro1.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8998-hp-envy-x2.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm=
64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 7a9fcbe9bb31..1bdd3f09f536 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -3,9 +3,6 @@
  * Copyright (c) 2020, Yassine Oudjana <y.oudjana@protonmail.com>
  */

-/dts-v1/;
-
-#include "msm8996.dtsi"
 #include "pm8994.dtsi"
 #include "pmi8994.dtsi"
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm6=
4/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index 34f82e06ef53..e360187109a2 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -5,6 +5,7 @@

 /dts-v1/;

+#include "msm8996.dtsi"
 #include "msm8996-xiaomi-common.dtsi"
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm=
64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
similarity index 99%
rename from arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
rename to arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
index 27a45ddbb5bd..2028325e1c0f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
@@ -5,6 +5,7 @@

 /dts-v1/;

+#include "msm8996pro.dtsi"
 #include "msm8996-xiaomi-common.dtsi"
 #include "pmi8996.dtsi"
 #include <dt-bindings/sound/qcom,q6afe.h>
@@ -12,9 +13,8 @@

 / {
 =09model =3D "Xiaomi Mi Note 2";
-=09compatible =3D "xiaomi,scorpio", "qcom,msm8996";
+=09compatible =3D "xiaomi,scorpio", "qcom,msm8996pro", "qcom,msm8996";
 =09chassis-type =3D "handset";
-=09qcom,msm-id =3D <305 0x10000>;
 =09qcom,board-id =3D <34 0>;

 =09chosen {
--
2.35.1

