Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD8C4897FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbiAJLum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245086AbiAJLtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:49:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA656C061759;
        Mon, 10 Jan 2022 03:49:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r9so24475794wrg.0;
        Mon, 10 Jan 2022 03:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BZOz3rBRK9T1NJYwX4wR3Rx8LIgVrV05ZwydszvJ/w=;
        b=lr5Z+SCtLVTeLyQ0yAPGeriul3M/sb48r09iMN2fpfsN9I4KSJrxq8ZAVNGhny/guE
         NbGRpskBFwrAnY7k/Z6t+abNFO+UDUJls9DtSpJ+48fnAI/p8X4ZEZ+bD6i6ULFhFaH2
         z8SX21ZoICYKFa+nh8y3GmgnLh4DmnXUQjIBIh8rdRcO8DUGAU8rE/d8x1MWO9JQb0+9
         YsTgnVAH09ap7BgXNtGOSHPiBGvIUOH+UP0Ee8IjxJamjNFv3DnSf0+/bgyb1FsCwYDp
         gYCoPXqgORScffFlDqdTnyZuuDxebRagdAVBTxykxozU4sILYUOTcFV24IxC2OVHQISU
         iu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BZOz3rBRK9T1NJYwX4wR3Rx8LIgVrV05ZwydszvJ/w=;
        b=26bklaCURiB+M5d5FsGQIL0ovTDVdyCCyuZBvAbhfI5XEILuhwzEh7nbAbDWStoZSQ
         bV6y5NthBsFg/Lvh2LQI/AC/cLA4BNgJCUxnUgF2sixsMG30uG1YBvj3S4ckG8dFtWiR
         G5pCtd/DfEml++BZpwCbxyLtLrPvRPGud7rFwLz7/LNGvnHj8IgaPIIrbBxWL+9wQzS2
         inWujjdSAFdmQB/q6LH359LTYHR7nj9KQu90/Tmo7jozqp+Uyx3UU44ktIoyUpN2fA5c
         EU+KgxZ7MNxrCc0qToca2gmXlz33hZScpekWi47xx8pMVZpz7Z6e8fGCGnD9NR4e1hOk
         kVhg==
X-Gm-Message-State: AOAM532txeyFTyUKEeoKE+ImPsmXi6t0bcWKEoyC0LqG4U3XvHNM3iIh
        1VMI7386rVWKAcJFXx3SsZMBUbjk17tPpA==
X-Google-Smtp-Source: ABdhPJzYRkhfIUUAVvWoSVT58H+K9Hf2lyW+S7Dp7ffh/c+SDBL/4d6PNn9tY0/XBsBBAJnJJED7Vg==
X-Received: by 2002:adf:e8d2:: with SMTP id k18mr65592698wrn.187.1641815373164;
        Mon, 10 Jan 2022 03:49:33 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id 9sm8090252wrz.90.2022.01.10.03.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:49:32 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/4] dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
Date:   Mon, 10 Jan 2022 12:49:27 +0100
Message-Id: <20220110114930.1406665-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt binding header for resets lines in Mediatek MT7621 SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 include/dt-bindings/reset/mt7621-reset.h | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 include/dt-bindings/reset/mt7621-reset.h

diff --git a/include/dt-bindings/reset/mt7621-reset.h b/include/dt-bindings/reset/mt7621-reset.h
new file mode 100644
index 000000000000..7572c6b41453
--- /dev/null
+++ b/include/dt-bindings/reset/mt7621-reset.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 Sergio Paracuellos
+ * Author: Sergio Paracuellos <sergio.paracuellos@gmail.com>
+ */
+
+#ifndef DT_BINDING_MT7621_RESET_H
+#define DT_BINDING_MT7621_RESET_H
+
+#define MT7621_RST_SYS		0
+#define MT7621_RST_MCM		2
+#define MT7621_RST_HSDMA	5
+#define MT7621_RST_FE		6
+#define MT7621_RST_SPDIFTX	7
+#define MT7621_RST_TIMER	8
+#define MT7621_RST_INT		9
+#define MT7621_RST_MC		10
+#define MT7621_RST_PCM		11
+#define MT7621_RST_PIO		13
+#define MT7621_RST_GDMA		14
+#define MT7621_RST_NFI		15
+#define MT7621_RST_I2C		16
+#define MT7621_RST_I2S		17
+#define MT7621_RST_SPI		18
+#define MT7621_RST_UART1	19
+#define MT7621_RST_UART2	20
+#define MT7621_RST_UART3	21
+#define MT7621_RST_ETH		23
+#define MT7621_RST_PCIE0	24
+#define MT7621_RST_PCIE1	25
+#define MT7621_RST_PCIE2	26
+#define MT7621_RST_AUX_STCK	28
+#define MT7621_RST_CRYPTO	29
+#define MT7621_RST_SDXC		30
+#define MT7621_RST_PPE		31
+
+#endif /* DT_BINDING_MT7621_RESET_H */
-- 
2.25.1

