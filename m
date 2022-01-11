Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB1E48B423
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbiAKRif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbiAKRie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:38:34 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313F6C06173F;
        Tue, 11 Jan 2022 09:38:34 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m1so25788793lfq.4;
        Tue, 11 Jan 2022 09:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYYzoRrQ7r+3JpOotxz5TLZg5+kezFddh/tOm+gkJ/E=;
        b=VO+7AUmH236AUGDb7AjgqyhmDVLKPqSpwlxOVzs7tsXwPK0P7VM9FLd1qgG/mw6h6+
         J7n7iuaqOfOfcwJIvevHfCE+ByK0MLuvYslhG9hKA4IBnutDvHGxvwITCMHL9wnOxNR1
         zMVviY+gBjfQpwbRiQ0BUCCcSabRs2aM+roE0RCBguqwYaKdu7PU3y3kj4cJrLqA3rYA
         VTLr7GIJJJ4nOgOfrNdJDMGk0O3OSlkv3p39Z30mKPfkEMZsP9EYqD8nqinjD9eT39uG
         TaOFlZjaryuJ7o8Hhfcauy7IhKk4FU3G0pRhxicgme/zZqHKSwzXS1zplqJUshQ+hQNb
         JY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYYzoRrQ7r+3JpOotxz5TLZg5+kezFddh/tOm+gkJ/E=;
        b=B45XFhfjShovAqj9ILTqfruK4hZteYJs311YAS8wKZ4nKfaK6xkQ+SEnfPeyK1gbHp
         m+LKdxJoKQE4vpOlXXxRju2Qwrnrq6ZSWxRZgKeMvV3yV3OGbVw9PbWaipVhKcWBnldM
         DCOyEu1d2eKh96J3FU2KM/qSSRQyqGqsOt+u9rlFlRqVCVJiVOYRaH+grvzFWS8BALEc
         23VnrioKFkD0lsK3eAcMZLFpyR3Suzn6zVw8Ro8Fs1IVmcZ7WcsMib+SMCt9SkjMb2tt
         nQMhxFEmUk+aAV/YZDHdnC8wsnRsKZQDXX3ZoLTCiar5sXGJ2vflPHFTsGi85aNsgzrB
         YHvg==
X-Gm-Message-State: AOAM530Lo21vIGpHZh93EfhTctxCOv0Z3I0GippgflQINk0Sq1DGVI8K
        tqCoqNadiROdZ8OzQNDOV9w=
X-Google-Smtp-Source: ABdhPJz17YczZ1GSZFlOG63TSsg8uPrzH5rSR9XRjtlmomJwtUPUnyThDi8aUVXoV962SqM1aNic4Q==
X-Received: by 2002:a19:2d0c:: with SMTP id k12mr4080549lfj.224.1641922712308;
        Tue, 11 Jan 2022 09:38:32 -0800 (PST)
Received: from localhost.localdomain (host-95-152-62-123.dsl.sura.ru. [95.152.62.123])
        by smtp.gmail.com with ESMTPSA id m15sm1392428lfg.291.2022.01.11.09.38.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Jan 2022 09:38:31 -0800 (PST)
From:   Maxim <bigunclemax@gmail.com>
To:     vladimir.oltean@nxp.com
Cc:     andrew@lunn.ch, benh@kernel.crashing.org, bigunclemax@gmail.com,
        davem@davemloft.net, devicetree@vger.kernel.org, fido_max@inbox.ru,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, paulus@samba.org, robh+dt@kernel.org
Subject: [PATCH v2] powerpc: dts: t1040rdb: fix ports names for Seville Ethernet switch
Date:   Tue, 11 Jan 2022 20:37:23 +0300
Message-Id: <20220111173723.26212-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220111152947.6zvt7j7366wsg6o2@skbuf>
References: <20220111152947.6zvt7j7366wsg6o2@skbuf>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Kiselev <bigunclemax@gmail.com>

On board rev A, the network interface labels for the switch ports
written on the front panel are different than on rev B and later.

This patch fixes network interface names for the switch ports according
to labels that are written on the front panel of the board rev B.
They start from ETH3 and end at ETH10.

This patch also introduces a separate device tree for rev A.
The main device tree is supposed to cover rev B and later.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts | 30 ++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1040rdb.dts       |  8 +++---
 2 files changed, 34 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts

diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts b/arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts
new file mode 100644
index 00000000000..2203286b64b
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * T1040RDB-REV-A Device Tree Source
+ *
+ * Copyright 2014 - 2015 Freescale Semiconductor Inc.
+ *
+ */
+
+/include/ "t1040rdb.dts"
+
+/ {
+	model = "fsl,T1040RDB-REV-A";
+	compatible = "fsl,T1040RDB-REV-A";
+};
+
+&seville_port0 {
+	label = "ETH5";
+};
+
+&seville_port2 {
+	label = "ETH7";
+};
+
+&seville_port4 {
+	label = "ETH9";
+};
+
+&seville_port6 {
+	label = "ETH11";
+};
diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb.dts b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
index af0c8a6f561..b6733e7e658 100644
--- a/arch/powerpc/boot/dts/fsl/t1040rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
@@ -119,7 +119,7 @@ &seville_port0 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_0>;
 	phy-mode = "qsgmii";
-	label = "ETH5";
+	label = "ETH3";
 	status = "okay";
 };
 
@@ -135,7 +135,7 @@ &seville_port2 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_2>;
 	phy-mode = "qsgmii";
-	label = "ETH7";
+	label = "ETH5";
 	status = "okay";
 };
 
@@ -151,7 +151,7 @@ &seville_port4 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_4>;
 	phy-mode = "qsgmii";
-	label = "ETH9";
+	label = "ETH7";
 	status = "okay";
 };
 
@@ -167,7 +167,7 @@ &seville_port6 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_6>;
 	phy-mode = "qsgmii";
-	label = "ETH11";
+	label = "ETH9";
 	status = "okay";
 };
 
-- 
2.32.0 (Apple Git-132)

