Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B25472648
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhLMJt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhLMJpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:45:34 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35871C0698C7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:40:56 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id n26so14451013pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9o8HQVfoP3+l27I9am8Hc3DOZB6yzyhxwyrzK9BV+hI=;
        b=hLmJX+Xuln4uIw6oqcC9O2KHKM1XAUOokD7HV+AGTM6aOhAH9caynLY0XCt0xavjJ0
         dSYl3SbnE59EoMSnyFHjc+hW80uJxP1xOr3rSKbnniThU4gVCqgqX2h34YVFpvnsZv6a
         jENd29U/aPeboNsTDOhGiYWzp0OOACn3WvsjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9o8HQVfoP3+l27I9am8Hc3DOZB6yzyhxwyrzK9BV+hI=;
        b=5hMZB0g9W2IeSgOTMa3Y7dEDUh/2VcB/WmMOLIsHXgsoE6eWlGWV1yenfNx/y+Crec
         F9+AzFomqMcOQ0JXAhEHsDjkGZWlQ4I8W6y6BqjPgEvf+ZnSOC3O+MK9NXwCN+rxlap9
         vuW2ULhrAciLCtCCG2xo8pbTxIOQZijIOK0pr0Imes16tzJcEOcZVtyH6uD6nrKmWQP/
         RmyNrN4B9Hx7qY4Y1HB0uOInXa6KXTg8OWhYo8NQAk49v/6Fl4GImOCmrNUBefGXBNzN
         5TCm294E7CAKJwqCSHvDYxie8Lb0r8nheD9Vmeidkpk2TrRaQNepyxoimKYIRPbPG+MK
         DAmw==
X-Gm-Message-State: AOAM530S+xWePL1mg1g08eIfdwRFRnC3E3FFr1k+DYuWizu9AO8IrZ6B
        uKJHK3K37X/HSrMqh1rOTRkK1A==
X-Google-Smtp-Source: ABdhPJyJZhXGzj9JC3iUFG82e6bBL4FoRDCpn3aiN+wyDwhyEadohyBQT8JSeFy9ZJt3oEHcwXjXnQ==
X-Received: by 2002:a63:b06:: with SMTP id 6mr538027pgl.502.1639388454288;
        Mon, 13 Dec 2021 01:40:54 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id d195sm10237609pga.41.2021.12.13.01.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:40:54 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/5] dt-bindings: gpio: msc313: Add offsets for ssd20xd
Date:   Mon, 13 Dec 2021 18:40:33 +0900
Message-Id: <20211213094036.1787950-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213094036.1787950-1-daniel@0x0f.com>
References: <20211213094036.1787950-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gpio offsets for the SSD201 and SSD202D chips.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/dt-bindings/gpio/msc313-gpio.h | 71 ++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/include/dt-bindings/gpio/msc313-gpio.h b/include/dt-bindings/gpio/msc313-gpio.h
index 2dd56683d3c1..5458c6580a02 100644
--- a/include/dt-bindings/gpio/msc313-gpio.h
+++ b/include/dt-bindings/gpio/msc313-gpio.h
@@ -50,4 +50,75 @@
 #define MSC313_GPIO_SPI0_DI	(MSC313_GPIO_SPI0 + 2)
 #define MSC313_GPIO_SPI0_DO	(MSC313_GPIO_SPI0 + 3)
 
+/* SSD20x */
+#define SSD20XD_GPIO_FUART	0
+#define SSD20XD_GPIO_FUART_RX	(SSD20XD_GPIO_FUART + 0)
+#define SSD20XD_GPIO_FUART_TX	(SSD20XD_GPIO_FUART + 1)
+#define SSD20XD_GPIO_FUART_CTS	(SSD20XD_GPIO_FUART + 2)
+#define SSD20XD_GPIO_FUART_RTS	(SSD20XD_GPIO_FUART + 3)
+
+#define SSD20XD_GPIO_SD		(SSD20XD_GPIO_FUART_RTS + 1)
+#define SSD20XD_GPIO_SD_CLK	(SSD20XD_GPIO_SD + 0)
+#define SSD20XD_GPIO_SD_CMD	(SSD20XD_GPIO_SD + 1)
+#define SSD20XD_GPIO_SD_D0	(SSD20XD_GPIO_SD + 2)
+#define SSD20XD_GPIO_SD_D1	(SSD20XD_GPIO_SD + 3)
+#define SSD20XD_GPIO_SD_D2	(SSD20XD_GPIO_SD + 4)
+#define SSD20XD_GPIO_SD_D3	(SSD20XD_GPIO_SD + 5)
+
+#define SSD20XD_GPIO_UART0	(SSD20XD_GPIO_SD_D3 + 1)
+#define SSD20XD_GPIO_UART0_RX	(SSD20XD_GPIO_UART0 + 0)
+#define SSD20XD_GPIO_UART0_TX	(SSD20XD_GPIO_UART0 + 1)
+
+#define SSD20XD_GPIO_UART1	(SSD20XD_GPIO_UART0_TX + 1)
+#define SSD20XD_GPIO_UART1_RX	(SSD20XD_GPIO_UART1 + 0)
+#define SSD20XD_GPIO_UART1_TX	(SSD20XD_GPIO_UART1 + 1)
+
+#define SSD20XD_GPIO_TTL	(SSD20XD_GPIO_UART1_TX + 1)
+#define SSD20XD_GPIO_TTL0	(SSD20XD_GPIO_TTL + 0)
+#define SSD20XD_GPIO_TTL1	(SSD20XD_GPIO_TTL + 1)
+#define SSD20XD_GPIO_TTL2	(SSD20XD_GPIO_TTL + 2)
+#define SSD20XD_GPIO_TTL3	(SSD20XD_GPIO_TTL + 3)
+#define SSD20XD_GPIO_TTL4	(SSD20XD_GPIO_TTL + 4)
+#define SSD20XD_GPIO_TTL5	(SSD20XD_GPIO_TTL + 5)
+#define SSD20XD_GPIO_TTL6	(SSD20XD_GPIO_TTL + 6)
+#define SSD20XD_GPIO_TTL7	(SSD20XD_GPIO_TTL + 7)
+#define SSD20XD_GPIO_TTL8	(SSD20XD_GPIO_TTL + 8)
+#define SSD20XD_GPIO_TTL9	(SSD20XD_GPIO_TTL + 9)
+#define SSD20XD_GPIO_TTL10	(SSD20XD_GPIO_TTL + 10)
+#define SSD20XD_GPIO_TTL11	(SSD20XD_GPIO_TTL + 11)
+#define SSD20XD_GPIO_TTL12	(SSD20XD_GPIO_TTL + 12)
+#define SSD20XD_GPIO_TTL13	(SSD20XD_GPIO_TTL + 13)
+#define SSD20XD_GPIO_TTL14	(SSD20XD_GPIO_TTL + 14)
+#define SSD20XD_GPIO_TTL15	(SSD20XD_GPIO_TTL + 15)
+#define SSD20XD_GPIO_TTL16	(SSD20XD_GPIO_TTL + 16)
+#define SSD20XD_GPIO_TTL17	(SSD20XD_GPIO_TTL + 17)
+#define SSD20XD_GPIO_TTL18	(SSD20XD_GPIO_TTL + 18)
+#define SSD20XD_GPIO_TTL19	(SSD20XD_GPIO_TTL + 19)
+#define SSD20XD_GPIO_TTL20	(SSD20XD_GPIO_TTL + 20)
+#define SSD20XD_GPIO_TTL21	(SSD20XD_GPIO_TTL + 21)
+#define SSD20XD_GPIO_TTL22	(SSD20XD_GPIO_TTL + 22)
+#define SSD20XD_GPIO_TTL23	(SSD20XD_GPIO_TTL + 23)
+#define SSD20XD_GPIO_TTL24	(SSD20XD_GPIO_TTL + 24)
+#define SSD20XD_GPIO_TTL25	(SSD20XD_GPIO_TTL + 25)
+#define SSD20XD_GPIO_TTL26	(SSD20XD_GPIO_TTL + 26)
+#define SSD20XD_GPIO_TTL27	(SSD20XD_GPIO_TTL + 27)
+
+#define SSD20XD_GPIO_GPIO	(SSD20XD_GPIO_TTL27 + 1)
+#define SSD20XD_GPIO_GPIO0	(SSD20XD_GPIO_GPIO + 0)
+#define SSD20XD_GPIO_GPIO1	(SSD20XD_GPIO_GPIO + 1)
+#define SSD20XD_GPIO_GPIO2	(SSD20XD_GPIO_GPIO + 2)
+#define SSD20XD_GPIO_GPIO3	(SSD20XD_GPIO_GPIO + 3)
+#define SSD20XD_GPIO_GPIO4	(SSD20XD_GPIO_GPIO + 4)
+#define SSD20XD_GPIO_GPIO5	(SSD20XD_GPIO_GPIO + 5)
+#define SSD20XD_GPIO_GPIO6	(SSD20XD_GPIO_GPIO + 6)
+#define SSD20XD_GPIO_GPIO7	(SSD20XD_GPIO_GPIO + 7)
+#define SSD20XD_GPIO_GPIO10	(SSD20XD_GPIO_GPIO + 8)
+#define SSD20XD_GPIO_GPIO11	(SSD20XD_GPIO_GPIO + 9)
+#define SSD20XD_GPIO_GPIO12	(SSD20XD_GPIO_GPIO + 10)
+#define SSD20XD_GPIO_GPIO13	(SSD20XD_GPIO_GPIO + 11)
+#define SSD20XD_GPIO_GPIO14	(SSD20XD_GPIO_GPIO + 12)
+#define SSD20XD_GPIO_GPIO85	(SSD20XD_GPIO_GPIO + 13)
+#define SSD20XD_GPIO_GPIO86	(SSD20XD_GPIO_GPIO + 14)
+#define SSD20XD_GPIO_GPIO90	(SSD20XD_GPIO_GPIO + 15)
+
 #endif /* _DT_BINDINGS_MSC313_GPIO_H */
-- 
2.34.1

