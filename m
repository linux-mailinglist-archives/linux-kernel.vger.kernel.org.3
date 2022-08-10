Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDCA58E89C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiHJITd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiHJITR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:19:17 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C23784ECA;
        Wed, 10 Aug 2022 01:19:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D57FC021C;
        Wed, 10 Aug 2022 10:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660119551; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=24xyn2EcGe3/F2/wyHYU1Hh1pGAy3aJpsHHcjneCMio=;
        b=NqwTyR2kfa0wGCkAne1TYHGK/yRNVixnb5DTYIyZhueX7/TGnX3CutYDAcT83viZqzVdBS
        7VW9mRz4dglK/gzRXoMZ5n5+Z2IPsG5GcUKpGRqpPEjwZOuoYBXkwuoi799LElcxJLxbcu
        7F53yYKpLyn0ETvX7GYH4qlHsGJOA+sWnpHQm6uNvdbB8toq4sovXp1KRdi/2uQQxUSxTY
        dZGifT7Waei7lqb4JzVblgdffFPm+pjafjriooiKhLoV2ZwsVo6tayx90SaW0kxb8Hp3Bt
        vl3ua0lOoR9FrLVdk4d/FspDxOZNKV6Xy9bhhrDqp8YW73uePakvuqTc8UE4gw==
From:   Frieder Schrempf <frieder@fris.de>
To:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, soc@kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v2 3/3] ARM: dts: imx6ul-kontron: Add imx6ull-kontron-bl to Makefile
Date:   Wed, 10 Aug 2022 10:18:23 +0200
Message-Id: <20220810081825.19051-4-frieder@fris.de>
In-Reply-To: <20220810081825.19051-1-frieder@fris.de>
References: <20220810081825.19051-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The imx6ull-kontron-bl.dtb wasn't build as part of the
CONFIG_SOC_IMX6UL option. Add it to the list.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6627aed26fd6..1d0c79f61072 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -726,6 +726,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-colibri-wifi-iris.dtb \
 	imx6ull-colibri-wifi-iris-v2.dtb \
 	imx6ull-jozacp.dtb \
+	imx6ull-kontron-bl.dtb \
 	imx6ull-myir-mys-6ulx-eval.dtb \
 	imx6ull-opos6uldev.dtb \
 	imx6ull-phytec-segin-ff-rdk-nand.dtb \
-- 
2.37.1

