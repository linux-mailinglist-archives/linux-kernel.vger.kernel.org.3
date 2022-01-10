Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B934893D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbiAJIlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241749AbiAJIjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:39:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3AFC03400E;
        Mon, 10 Jan 2022 00:39:14 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o3so25213123wrh.10;
        Mon, 10 Jan 2022 00:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BZOz3rBRK9T1NJYwX4wR3Rx8LIgVrV05ZwydszvJ/w=;
        b=SUj2/8gzHk7Re+1i01IPUqGCS3lyvGwRjRmxmuTKEf3DL3wDTs+OjGpE3Aqr+4f9gZ
         Z+sRbTUBpRktgTHwE5Bx7IVWzkMYp+t9yweFs0AKn+wPs3lwtexMI+Fd0WYD+Z9AqfGF
         e0lHVGbLqJ0NXLjGHTlbrFBVfuaEeSUIDkL6X4oi/R2h7IdE55GWDU+azfMZaKeyBkI9
         7y58en4styGl1btMiA6pzFTpxjwDLdsdRjbEsF/zLesXKYO/4ePatTR0MHcnIWy6jmMq
         XfzpT/ZDpC209Hy961OM8q+tWoOAvkU4G0H1rU1rqaQEIdnEQx8TvyxR9Shn2MImWViw
         oZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BZOz3rBRK9T1NJYwX4wR3Rx8LIgVrV05ZwydszvJ/w=;
        b=K2UKyfYCYqjw+iE728m1QisTLHYhja8ae2RdidDa+JFXJdHAlPUfzibVWrRxInQ5WM
         6RjwjW0Cb5dRM6Th8ohFV4mAyoC6xNyGKIqRa3tTV1jsg7/PaOCaR85448JMXR/mA9/S
         9tCmcaSKf7MP4HIONG+P9HPzQ+YT4GDd2W3nyNhX3EqkX80wogEdumeUdAI1ZLJodlna
         E9l/dATnB1DboShliiGBESTrOvoqRzcFSyqIFmJQl98YcoIF5XyAOvniMNmBuU3PBoEY
         ahM2agd5+KtuFQ4Z+IIZdG2QRwLoTcJvCf7G9XqClmYAN+IFOpqueoVPzV+vQ6R8hG0+
         wG6Q==
X-Gm-Message-State: AOAM530p+d1l2BF3TU1d9scQ+6fGIBFsFXUm/5MtCA0qkgAEdQWzunYS
        gW34iJxMpc0PylvFhC4teZZTIgQmxRDE/Q==
X-Google-Smtp-Source: ABdhPJwcJYgNMCVqDHqSF6f6uVq0pRv+GQUOmxr1/UfeXK6WNusqbp8tb4Bq6/kEIIOhN6x/k7c+Bw==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr8947962wru.493.1641803953094;
        Mon, 10 Jan 2022 00:39:13 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id m7sm508926wmi.13.2022.01.10.00.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 00:39:12 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
Date:   Mon, 10 Jan 2022 09:39:07 +0100
Message-Id: <20220110083910.1351020-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110083910.1351020-1-sergio.paracuellos@gmail.com>
References: <20220110083910.1351020-1-sergio.paracuellos@gmail.com>
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

