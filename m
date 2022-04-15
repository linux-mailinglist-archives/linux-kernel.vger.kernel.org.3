Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6929502916
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352795AbiDOL72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiDOL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:15 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DF8A8EDB;
        Fri, 15 Apr 2022 04:56:45 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 4493D3F612;
        Fri, 15 Apr 2022 13:56:41 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 01/23] ARM: dts: qcom-*-sony*: Mention SONY board names in DT filenames
Date:   Fri, 15 Apr 2022 13:56:11 +0200
Message-Id: <20220415115633.575010-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SONY phones/tables are based on a common board ('platform'). Devices
based on the same are often close to identical. Mention their association
in filenames, like it's done in arm64 DTs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm/boot/dts/Makefile                                | 8 ++++----
 ...a-yuga.dts => qcom-apq8064-sony-xperia-lagan-yuga.dts} | 0
 ...amami.dts => qcom-msm8974-sony-xperia-rhine-amami.dts} | 0
 ...nami.dts => qcom-msm8974-sony-xperia-rhine-honami.dts} | 0
 ...or.dts => qcom-msm8974-sony-xperia-shinano-castor.dts} | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/boot/dts/{qcom-apq8064-sony-xperia-yuga.dts => qcom-apq8064-sony-xperia-lagan-yuga.dts} (100%)
 rename arch/arm/boot/dts/{qcom-msm8974-sony-xperia-amami.dts => qcom-msm8974-sony-xperia-rhine-amami.dts} (100%)
 rename arch/arm/boot/dts/{qcom-msm8974-sony-xperia-honami.dts => qcom-msm8974-sony-xperia-rhine-honami.dts} (100%)
 rename arch/arm/boot/dts/{qcom-msm8974-sony-xperia-castor.dts => qcom-msm8974-sony-xperia-shinano-castor.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 252353fb4e3b..91f630f4dbfd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -988,7 +988,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8060-dragonboard.dtb \
 	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8064-ifc6410.dtb \
-	qcom-apq8064-sony-xperia-yuga.dtb \
+	qcom-apq8064-sony-xperia-lagan-yuga.dtb \
 	qcom-apq8064-asus-nexus7-flo.dtb \
 	qcom-apq8074-dragonboard.dtb \
 	qcom-apq8084-ifc6540.dtb \
@@ -1010,9 +1010,9 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8974-fairphone-fp2.dtb \
 	qcom-msm8974-lge-nexus5-hammerhead.dtb \
 	qcom-msm8974-samsung-klte.dtb \
-	qcom-msm8974-sony-xperia-amami.dtb \
-	qcom-msm8974-sony-xperia-castor.dtb \
-	qcom-msm8974-sony-xperia-honami.dtb \
+	qcom-msm8974-sony-xperia-rhine-amami.dtb \
+	qcom-msm8974-sony-xperia-rhine-honami.dtb \
+	qcom-msm8974-sony-xperia-shinano-castor.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb \
 	qcom-sdx55-mtp.dtb \
 	qcom-sdx55-t55.dtb \
diff --git a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
rename to arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts
rename to arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
rename to arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
rename to arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts
-- 
2.35.2

