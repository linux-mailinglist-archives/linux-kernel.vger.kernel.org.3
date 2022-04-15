Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E7A502927
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353041AbiDOMAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352854AbiDOL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:41 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F6AB0A71
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:57:06 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id D75053F642;
        Fri, 15 Apr 2022 13:57:03 +0200 (CEST)
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
Subject: [PATCH 15/23] ARM: dts: qcom-msm8974pro-*: Use the 8974pro name in DT filenames
Date:   Fri, 15 Apr 2022 13:56:25 +0200
Message-Id: <20220415115633.575010-16-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 'pro' part to the filenames of DTs of devices that are based on
this SoC to make in easier to differentiate between Snapdragon 800- and
801-based platforms.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm/boot/dts/Makefile                                    | 4 ++--
 ...8974-samsung-klte.dts => qcom-msm8974pro-samsung-klte.dts} | 0
 ...tor.dts => qcom-msm8974pro-sony-xperia-shinano-castor.dts} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{qcom-msm8974-samsung-klte.dts => qcom-msm8974pro-samsung-klte.dts} (100%)
 rename arch/arm/boot/dts/{qcom-msm8974-sony-xperia-shinano-castor.dts => qcom-msm8974pro-sony-xperia-shinano-castor.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 91f630f4dbfd..51d72dcd1f45 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1009,10 +1009,10 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8960-cdp.dtb \
 	qcom-msm8974-fairphone-fp2.dtb \
 	qcom-msm8974-lge-nexus5-hammerhead.dtb \
-	qcom-msm8974-samsung-klte.dtb \
 	qcom-msm8974-sony-xperia-rhine-amami.dtb \
 	qcom-msm8974-sony-xperia-rhine-honami.dtb \
-	qcom-msm8974-sony-xperia-shinano-castor.dtb \
+	qcom-msm8974pro-samsung-klte.dtb \
+	qcom-msm8974pro-sony-xperia-shinano-castor.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb \
 	qcom-sdx55-mtp.dtb \
 	qcom-sdx55-t55.dtb \
diff --git a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
rename to arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
similarity index 100%
rename from arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts
rename to arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
-- 
2.35.2

