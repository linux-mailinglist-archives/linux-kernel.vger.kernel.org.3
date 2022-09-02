Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17A35AAC13
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbiIBKIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiIBKI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:08:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81E09F1B4;
        Fri,  2 Sep 2022 03:08:20 -0700 (PDT)
Received: from localhost (unknown [188.27.54.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 76DEF6601F05;
        Fri,  2 Sep 2022 11:08:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662113299;
        bh=bhtmsc4SAXx6vdsUdGvUZEFyQ91C4jgP6uCREcCIkrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AbSY8obnO7ZuJ9omzcHHKEm3LoqQQR4j/uFHbltr9l78I9s9n+vQ81Hg1VIeyhgVC
         +KALrGfdopp4X9uQQEzH5WqEaPnpLj+jiRL1tzQ8jw1w5rYzHquajaa6KNH4K0DFwx
         SDpCcwCJNTT3mgPLWAmpDzCEbNf80fVVq10IEy7Jg4rp/GE8t7d5jpp7Ge1IXWts9z
         vWGbxSYp1XdLf94ubqJsDHvblCYs4hYPfmLApN5BgQyQsLg5gcJ161T6pscTqpVUhp
         WgvrfxS3TdZcDoVLIdlwFZuNPJHBAiq2O5nsYoqdgla/XzwW3MBuE42LUJHAJU90Sc
         wKEE0wwoGGhug==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2 3/3] riscv: dts: starfive: Add StarFive VisionFive V1 device tree
Date:   Fri,  2 Sep 2022 13:08:06 +0300
Message-Id: <20220902100806.2378543-4-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902100806.2378543-1-cristian.ciocaltea@collabora.com>
References: <20220902100806.2378543-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree for the StarFive VisionFive V1 SBC [1], which
is similar with the already supported BeagleV Starlight Beta board,
both being based on the StarFive JH7100 SoC.

[1] https://github.com/starfive-tech/VisionFive

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/starfive/Makefile         |  2 +-
 .../jh7100-starfive-visionfive-v1.dts         | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 0ea1bc15ab30..039c143cba33 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
+dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb jh7100-starfive-visionfive-v1.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
new file mode 100644
index 000000000000..e82af72f1aaf
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2021 StarFive Technology Co., Ltd.
+ * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+/dts-v1/;
+#include "jh7100-common.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "StarFive VisionFive V1";
+	compatible = "starfive,visionfive-v1", "starfive,jh7100";
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&gpio 63 GPIO_ACTIVE_HIGH>;
+		priority = <224>;
+	};
+};
-- 
2.37.2

