Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E01D485A18
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbiAEUha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244100AbiAEUhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:37:06 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88CBC061212
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 12:37:05 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id b77so372544vka.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 12:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58UUNS0DgBb5XBf4k5/ZZBZVEZ/F2R7SYVQLoWIj1HA=;
        b=fX+lEplRyG8vV/rbGDaMDBkro3Dd7ZReV90UVRE16HASlm8S2TnG4eyO36HxLagfxC
         DKWGqgcWRiZ+6vA1oIKqF70eJJDmgTsyqY3R+5YVbLBpN/Ixl4BQm+9k/kT+Ucu3ya3a
         1oEfbOmfvc/F4Q+KE7et3tbzzSUXPsaE4QC3y2rsRnpActB5nRvxDH3OIQfc5C77RIfZ
         RVbJbe6PLBKWvXevVtrm4hCR6NA+368cVHGv7ddjtn4CpTXvrGwPnHIR0n01yS46SpWe
         X0RwQ6zc+NVXrmVCiX1Ef89lgdkwvoCWkqeDwx1keXJvJp/yYEZr0zFOfYganynJfhtk
         FOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58UUNS0DgBb5XBf4k5/ZZBZVEZ/F2R7SYVQLoWIj1HA=;
        b=KqQa7n3ZJCGf+CfOU8FJPvcBPMIoUFv/MOSya2/2VjAr7mKg6ELV+96OdAAnP5aXit
         L826nr4Pc9lyIE9wldv2U5G18eQZnbPtfGMzumwsgxSosIkirHKEL45wgj+r5zB/yfrT
         pb0rI+RDHKcT2Z69pyzjfeYGGTZVw7DXqCQiHixrPZ5oNvUm3jJL+aRpMRJpjmmR4HBG
         VDL79uAOC75e4yR8kMs4IFTx0Kpabc+oO7orElMZn3TKoMGwEPjUID74LgJW5AAckL6R
         VKvvhdZyNTppRcBJ7fi8a+5xaChTv+jdebDVnQLgXefbNrpLapX0Zh7HY/TxdHwhI9dc
         41uQ==
X-Gm-Message-State: AOAM530ulnIUeFZoN6ESmCGFYpCIJDufowYVIkTeU1PI5vhVu3hG+aC2
        X3Us6r8X3kLflsS4GNYm8L8=
X-Google-Smtp-Source: ABdhPJy7ViyvCGvd5plXY6x2N828NyNFgLUBwtfksiRWcyFa4kHPgvShSwmH3dvex5TRUXalSxLdrw==
X-Received: by 2002:a1f:218e:: with SMTP id h136mr19995820vkh.41.1641415024917;
        Wed, 05 Jan 2022 12:37:04 -0800 (PST)
Received: from localhost.localdomain ([181.22.170.52])
        by smtp.gmail.com with ESMTPSA id t130sm7860vkc.32.2022.01.05.12.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:37:04 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, len.baker@gmx.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 6/6] staging: vc04_services: rename BM2835 to BCM2835 in headers comments
Date:   Wed,  5 Jan 2022 17:35:48 -0300
Message-Id: <19acea9e9da0d3ebb1a7e6bce511a3c09e8c80c3.1641414449.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641414449.git.gascoar@gmail.com>
References: <cover.1641414449.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kernel, when referring to the chip BCM2835, it is more suitable
to use BCM2835 to BM2835. To avoid confusion, and to make things more
consistent, rename the headers titles accordingly.

Suggested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 2 +-
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h | 2 +-
 drivers/staging/vc04_services/bcm2835-camera/controls.c       | 2 +-
 drivers/staging/vc04_services/vchiq-mmal/mmal-common.h        | 2 +-
 drivers/staging/vc04_services/vchiq-mmal/mmal-encodings.h     | 2 +-
 drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h    | 2 +-
 drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h    | 2 +-
 drivers/staging/vc04_services/vchiq-mmal/mmal-msg-port.h      | 2 +-
 drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h           | 2 +-
 drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h    | 2 +-
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c         | 2 +-
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h         | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index c729b1b7de71..597c51e8ddf4 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
index 84ba789af120..0f0c6f7a3764 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index 178fb310b89a..eb722f16fb91 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
index 5bd7410a034a..b33129403a30 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-encodings.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-encodings.h
index 2be9941a1f30..e15ae7b24f73 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-encodings.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-encodings.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h
index 342c9b670f7e..d77e15f25dda 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h
index a118efd21d98..1e996d8cd283 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-port.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-port.h
index 3fa3f2a578f0..6ee4c1ed7f19 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-port.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-port.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
index b636e889c8a1..471413248a14 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
index a1e39b1b1701..2277e05b1e31 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 76d3f0399964..cb6cdbfaf6ec 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
index 1dc81ecf9268..6006e29232b3 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Broadcom BM2835 V4L2 driver
+ * Broadcom BCM2835 V4L2 driver
  *
  * Copyright © 2013 Raspberry Pi (Trading) Ltd.
  *
-- 
2.34.1

