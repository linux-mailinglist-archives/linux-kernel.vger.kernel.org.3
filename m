Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7401046A32B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbhLFRoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:44:17 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43699 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243757AbhLFRoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:44:16 -0500
Received: by mail-ot1-f47.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so14564765otu.10;
        Mon, 06 Dec 2021 09:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2RIZxH5MEQAtOoJUz0p9vaNdr0uKsBybCKAajP5uoCA=;
        b=pDKavRGFTAxtMDe8hbGA1cKChx4vv2XLgqTL3p/IzZEVNeucsnm7qBt87Gg0vVfSb2
         jsH3pcRAh5WsOStHow539IWO+CmO5pMBjF2Tlt+bMIfyJAChMMhD0jV4FssUIrkIyxcP
         G8OTEJvuZYx7eb09/ItVyZtUa0XPQzlCjIbpUhvNHKqI8v5aAbTkQLzGhRq3Y/4MF/S0
         71xjhS1+jFaE6P/esq2ykSZUpsG+S6wvEsERV6vMRC5AzpLF36pL07hXesZoFJKpoyyd
         M5rVlQtfFpCrrE4fjx/dIEKbA98bDyemJnm9s1ieKAWvJMWt+BBFhG1ETsx/Z+d5bT1J
         9M0g==
X-Gm-Message-State: AOAM532tJf0SugyLw+jxGU3XoZiu2WmuFshSwHnIxbDaHUCzDI4fGaBe
        +EXiiVGDgjyzceahokMvN0FmQf0vAA==
X-Google-Smtp-Source: ABdhPJwOlFnz5IdJmXfmUhJApMKv/DbIfwhmzcv6a0QynL81EkhXjCuKB28HaRke7Po/t+hlNtIniA==
X-Received: by 2002:a05:6830:44c:: with SMTP id d12mr30025630otc.66.1638812446912;
        Mon, 06 Dec 2021 09:40:46 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id h3sm2202424oon.34.2021.12.06.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:40:46 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: atmel: Add missing 'interrupts' property
Date:   Mon,  6 Dec 2021 11:40:45 -0600
Message-Id: <20211206174045.2294873-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'unevaluatedProperties' support implemented, the atmel,sama5d4-wdt
example has the following warning:

/home/rob/proj/git/linux-dt/.build-arm64/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.example.dt.yaml: watchdog@fc068640: Unevaluated properties are not allowed ('interrupts' was unexpected)

Document the missing 'interrupts' property.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
index 9856cd76c28d..a9635c03761c 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
@@ -22,6 +22,9 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
   atmel,watchdog-type:
     $ref: /schemas/types.yaml#/definitions/string
     description: should be hardware or software.
-- 
2.32.0

