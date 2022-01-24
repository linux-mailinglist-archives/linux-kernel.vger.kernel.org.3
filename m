Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80CA49842A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbiAXQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240982AbiAXQDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:03:19 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DB2C061401;
        Mon, 24 Jan 2022 08:03:18 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bu18so50856932lfb.5;
        Mon, 24 Jan 2022 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mw/nT0vt0+cT+LkenUQbG2Z7gp/pXoAuAnG9olFE3MA=;
        b=pWO43tId6KoMhWrCNLMxVIO+NxW8YPGOOilVMNmJdZSwNeTQjtIGPEndNk5tWkxb8p
         KCQDhY2iq1MOFswrDvPLP09iYj7iWgkK9VRM4SIhF95oNunvro6QK5oxSOiYRI4cccCL
         JIUyTPVETcO7NftPRRD99KiTlQQqXMgb+WFM27vTpSQ435ZGVZSefRG5V0bURTmYmkUi
         /x9dk0YnzkLUQI0upBQNcQi1d6EEfVWvRNX36fdYcBM8L3qg8rM5TDodIuJ8iGx8uFM8
         4zurLgccK8g1JWSgJI0CA8zJ7JhWO/nltB0Q8SiR/1HOmctQGXDh/NvifAh7CasIyR5Q
         eI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mw/nT0vt0+cT+LkenUQbG2Z7gp/pXoAuAnG9olFE3MA=;
        b=BrxYkit3V6hdTuc0GqfoiVmDedIsUFmQGfgGzKe5ETWE4EmIkxvlntT0qW4kGgxScV
         Y6v3w6jVSt+Nf+JuoDfeIS1pASvRCqtNnmmCbkY3cvO5y56vHbiYKExbOEJwl3ch1qWv
         8XMCCpjRISlJxv3IrJwVwpljcG5JLNIqEdmUyjBvGg0PDAtHoqWRiIKn2WQ/yX7g37Nn
         2W0lTK58QKDUEXCLro8pVb7QBKyEUPMOS8oBdoE7XYNjfhKX3hqsPxJAvvF4XSsHxXL2
         /gSn1FALSYbqtBTsuJVEwgHztbQqkIE987CV8B8yxPDjKUU5/9nblgei+xOMBfH8kKk+
         9wcQ==
X-Gm-Message-State: AOAM530X3rA2iTfpQQWXIEdyNHZpCxAlVZHOrEQAiK8FMQUqWQ2lR0yr
        bBcxOmDZQI5c2uTbdufVDKs=
X-Google-Smtp-Source: ABdhPJyjNJOSI6CBKKV6aC3EliDIlRqDSbiSoeVnzGZNFWML3IWOJXXdbxWG40DUby945j/ZAQ6vrA==
X-Received: by 2002:a2e:a171:: with SMTP id u17mr5466485ljl.343.1643040197402;
        Mon, 24 Jan 2022 08:03:17 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n21sm674187lji.18.2022.01.24.08.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:03:17 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/3] dt-bindings: nvmem: brcm,nvram: add NVMEM cell to example
Date:   Mon, 24 Jan 2022 17:02:59 +0100
Message-Id: <20220124160300.25131-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124160300.25131-1-zajec5@gmail.com>
References: <20220124160300.25131-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

NVRAM doesn't have cells at hardcoded addresses. They are stored in
internal struct (custom & dynamic format) . It's still important to
define relevant cells in DT so NVMEM consumers can reference them.

One of cells set in almost every device is "et0macaddr" containing MAC
address. Add it to example to show how it can be referenced.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
index 8c3f0cd22821..ab14e3ae45c8 100644
--- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -32,6 +32,9 @@ unevaluatedProperties: false
 examples:
   - |
     nvram@1eff0000 {
-            compatible = "brcm,nvram";
-            reg = <0x1eff0000 0x10000>;
+        compatible = "brcm,nvram";
+        reg = <0x1eff0000 0x10000>;
+
+        mac: et0macaddr {
+        };
     };
-- 
2.31.1

