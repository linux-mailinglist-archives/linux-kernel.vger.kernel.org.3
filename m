Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7734678C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381233AbhLCNxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbhLCNxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:53:20 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7A4C06173E;
        Fri,  3 Dec 2021 05:49:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 37B2C1F46E6C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638539395; bh=5SXMGCa+TfmP8fr/3psu4C9pvK27zE6v9AXpJcy4HAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7tDyt+QZN8S7COxB5kxfE1gUulzvmNZFa2WwVLlyw02KzjTvZ7+EXgiuiunFVk6o
         heR6wOtkzrNXbrsjts0S5swFRKFzVF5R5EIg2Uz+7cLkMvLSDtNQlx2nMjC2dGF+Il
         usxTnCFi4YkEGYrdjs7JBKLw+7R1vfp8bbN0n6/7eitzmEnl68adC1iynenLkk+21R
         KJ5qTELBneiYl0/e93rCLabcQa/eRvYpyA7L/eMoBgpUUEZzMleMxxOC+UIg9Je5ld
         XmkFqQ/hesQeecPA2FFgYRMeLJ7E25kfddEi5NmkjK+VQvudXgy6pAsSVOC+v4Gpj9
         LDywwtjoFr1kQ==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, ariel.dalessandro@collabora.com,
        bcousson@baylibre.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, robh+dt@kernel.org, shengjiu.wang@gmail.com,
        tiwai@suse.com, tony@atomide.com
Subject: [PATCH 1/4] dt-bindings: sound: Rename tlv320aic31xx-micbias as tlv320aic31xx
Date:   Fri,  3 Dec 2021 10:49:27 -0300
Message-Id: <20211203134930.128703-2-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
References: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use a more generic name, so other definitions for tlv320aic31xx
can be included.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 .../devicetree/bindings/sound/tlv320aic31xx.txt          | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts                     | 2 +-
 include/dt-bindings/sound/tlv320aic31xx-micbias.h        | 9 ---------
 include/dt-bindings/sound/tlv320aic31xx.h                | 9 +++++++++
 sound/soc/codecs/tlv320aic31xx.c                         | 2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
 create mode 100644 include/dt-bindings/sound/tlv320aic31xx.h

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
index e372303697dc..bbad98d5b986 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
@@ -58,7 +58,7 @@ The pins can be used in referring sound node's audio-routing property.
 
 Example:
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/sound/tlv320aic31xx-micbias.h>
+#include <dt-bindings/sound/tlv320aic31xx.h>
 
 tlv320aic31xx: tlv320aic31xx@18 {
 	compatible = "ti,tlv320aic311x";
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 2f4d2e4e9b3e..4f9a7251a107 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -11,7 +11,7 @@
 #include <dt-bindings/pinctrl/am43xx.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pwm/pwm.h>
-#include <dt-bindings/sound/tlv320aic31xx-micbias.h>
+#include <dt-bindings/sound/tlv320aic31xx.h>
 
 / {
 	model = "TI AM43x EPOS EVM";
diff --git a/include/dt-bindings/sound/tlv320aic31xx-micbias.h b/include/dt-bindings/sound/tlv320aic31xx-micbias.h
deleted file mode 100644
index c6895a18a455..000000000000
--- a/include/dt-bindings/sound/tlv320aic31xx-micbias.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DT_TLV320AIC31XX_MICBIAS_H
-#define __DT_TLV320AIC31XX_MICBIAS_H
-
-#define MICBIAS_2_0V		1
-#define MICBIAS_2_5V		2
-#define MICBIAS_AVDDV		3
-
-#endif /* __DT_TLV320AIC31XX_MICBIAS_H */
diff --git a/include/dt-bindings/sound/tlv320aic31xx.h b/include/dt-bindings/sound/tlv320aic31xx.h
new file mode 100644
index 000000000000..3a845fbba992
--- /dev/null
+++ b/include/dt-bindings/sound/tlv320aic31xx.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_TLV320AIC31XX_H
+#define __DT_TLV320AIC31XX_H
+
+#define MICBIAS_2_0V		1
+#define MICBIAS_2_5V		2
+#define MICBIAS_AVDDV		3
+
+#endif /* __DT_TLV320AIC31XX_H */
diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 4224b4b3cae6..f2222c37913e 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -32,7 +32,7 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
-#include <dt-bindings/sound/tlv320aic31xx-micbias.h>
+#include <dt-bindings/sound/tlv320aic31xx.h>
 
 #include "tlv320aic31xx.h"
 
-- 
2.30.2

