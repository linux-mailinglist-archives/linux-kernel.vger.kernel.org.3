Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E1748970E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbiAJLLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244464AbiAJLKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:10:42 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1397FC061751;
        Mon, 10 Jan 2022 03:10:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t28so19268744wrb.4;
        Mon, 10 Jan 2022 03:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BZOz3rBRK9T1NJYwX4wR3Rx8LIgVrV05ZwydszvJ/w=;
        b=IZoGetFevexdCPMr9wmIWzK3kSyE3XlPYLgqnt2+w7Vk6nP/d+SxzqhD5+Gj3WUGSi
         R6HS5Mc5HUbM5sh5+HLXuZo+Wqcg8C1EdMprgIaChKXWZ2RAiLJsY9u92AKzoO+QW7hL
         H+aN89QiLW3sjzx5v9KtkvjVK2bk3Seqgys+fXl94DcbPW5qOa38MzA8jRfy7NyzrbJc
         WAWmOLerHwVzkeU6sZeVN4WiJXoXljGpab0Dgt3WQy8Vci46lFGhC4bxGn49jFgH7Kwy
         YcMv1MQ8wEFNxPR/zq1+KJowE2ChhBAgnOGgdq3DT72LrH8xON7y0F/8Vvvns6FoWsAG
         ipbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BZOz3rBRK9T1NJYwX4wR3Rx8LIgVrV05ZwydszvJ/w=;
        b=DQOX5HksC91hqg7jJnAVHsXqbagcTKxaeHRoNK2tBu8Y6F7Qy3NaAECELwNjr5D6e4
         +jhn1+0LoIW7zQw+VqYodTY0vkyFi9wQIEDAGPDMgbumTOBb0mzmi0KWxxc2IBGxlFky
         vKZ5wVIZ9pT0xKaYF4LjX9uAvWxpPnvL+uLM3lX2CmHgM8ZwU1QhUEEIcui8n1H6trbj
         datx4m6l9xOseMbvV2ZUr0TQbtewzFH76KF1se3LQO1bY3K/0NBfd83iNU6/SQGLYVuC
         6OhhkJ6TkjwiOR7YKH0WKa323k10KnSX7YRGo3VwHgf7tCijwzPyljsxtIYEWntFJxw5
         oEqA==
X-Gm-Message-State: AOAM531FQnvrUpIpxk0hiLgCj4EAiAzsD4Kx4nSEp34mselOscYxBEZ4
        zcpLJEm3b5kmNn92UFAbmFyi7SXeVkOfRg==
X-Google-Smtp-Source: ABdhPJzYiVaMPTldnZT9Y7Zg8N5WZr4CYFjcg8SxU5eVhiv8fK8T2FTxBAoQbwBjE0Qt1IBbgo8fFA==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr3060751wrs.388.1641813040424;
        Mon, 10 Jan 2022 03:10:40 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id x8sm6256733wmj.44.2022.01.10.03.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:10:39 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/4] dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
Date:   Mon, 10 Jan 2022 12:10:33 +0100
Message-Id: <20220110111036.1380288-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
References: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
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

