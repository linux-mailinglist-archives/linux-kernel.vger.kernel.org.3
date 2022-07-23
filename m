Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681FD57EF9E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiGWO0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbiGWO0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:26:18 -0400
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C815F17594
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:26:17 -0700 (PDT)
Date:   Sat, 23 Jul 2022 14:26:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1658586375; x=1658845575;
        bh=bSIVb35VNgsRupgexWfXqDR6bz6XZ6vs9aSsZ2kOLkM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=VYffmJg3P6qWDgCF/JWOqcH1b0x1+YtvpH/RZeX/07FzxkQibmQpHkqpq0xbv7xL3
         Yrgh3FWgB1OdOQy9P5tUzeKN9tpzfFzfHADB7qmUtpdiCHpmJGSLtxbdSm+K0ja1QZ
         12YmqZNZHbUc9RaZKuLIqjMQ7IuSQJNfGcCiL4MgR5HhJ4jusMOoAnvaltVP+3wqqw
         0F8x8O5pAkTYoiYoteGHgWrwzC5VxrXdhr/V513XItOW97bmqb0TesByCLCs1SYTCO
         UugOSWFc7mv3lWqYH/ElGhZGcfIQveKfsiAzALsqJJqFNdk61nHNawK2+AmQ41G5ME
         SEzKtB9TTdfAQ==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH v5 3/4] ARM: dts: qcom-msm8916-samsung-e2015: Include dts from arm64
Message-ID: <20220723142459.136568-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220723141835.136196-1-linmengbo0689@protonmail.com>
References: <20220723141835.136196-1-linmengbo0689@protonmail.com>
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
---
 arch/arm/boot/dts/Makefile                          | 3 +++
 arch/arm/boot/dts/qcom-msm8916-samsung-e5.dts       | 3 +++
 arch/arm/boot/dts/qcom-msm8916-samsung-e7.dts       | 3 +++
 arch/arm/boot/dts/qcom-msm8916-samsung-grandmax.dts | 3 +++
 4 files changed, 12 insertions(+)
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
--
2.30.2


