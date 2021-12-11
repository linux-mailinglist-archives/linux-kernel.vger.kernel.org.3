Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E664716E6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhLKVyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:54:23 -0500
Received: from ixit.cz ([94.230.151.217]:42022 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhLKVyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:54:21 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 0E71721F5E;
        Sat, 11 Dec 2021 22:54:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639259657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zSpqLPn7P+S+3UQTwr7zSIFu2ADotQIHst4N/Z4gL4k=;
        b=nmOyzjJY8oReV6w6eiprkNmXME0kKkv0YoRZy3sL7d/G22zD+UJRAf0OrV9koPO5dpD+9j
        kbrj6Ubo9kYzMnZNoFXNLbnU7Eu8kvejuqFgZ16GQxQt7wX3SNH55tJQ/0lHooGXQJz9oF
        Ke31daEMl/EFBy9hSK4iLPUWRqBPtSo=
From:   David Heidelberg <david@ixit.cz>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Mark Brown <broonie@linaro.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: add missing pins
Date:   Sat, 11 Dec 2021 22:51:19 +0100
Message-Id: <20211211215120.70966-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pins missing in documentation, but present in the hardware.

Fixes: 0e826e867264 ("ASoC: add RT5677 CODEC driver")

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/sound/rt5677.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5677.txt b/Documentation/devicetree/bindings/sound/rt5677.txt
index da2430099181..74b6359b802d 100644
--- a/Documentation/devicetree/bindings/sound/rt5677.txt
+++ b/Documentation/devicetree/bindings/sound/rt5677.txt
@@ -54,9 +54,21 @@ Pins on the device (for linking into audio routes):
   * DMIC2
   * DMIC3
   * DMIC4
+  * DMIC L1
+  * DMIC L2
+  * DMIC L3
+  * DMIC L4
+  * DMIC R1
+  * DMIC R2
+  * DMIC R3
+  * DMIC R4
   * LOUT1
   * LOUT2
   * LOUT3
+  * PDM1L
+  * PDM1R
+  * PDM2L
+  * PDM2R
 
 Example:
 
-- 
2.33.0

