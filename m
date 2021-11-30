Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5F9462E64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhK3IUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:20:34 -0500
Received: from mail.emtrion.de ([87.139.198.129]:28992 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234761AbhK3IUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:20:33 -0500
Received: from emtrion-yocto-comrzn1d.emtrion.local
 (2003:f9:5824:1:20c:29ff:fe08:43c4) by EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 09:17:12 +0100
From:   <reinhold.mueller@emtrion.com>
To:     <robh+dt@kernel.org>, <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <reinhold.mueller@emtrion.com>
Subject: [PATCH 1/2] dt-bindings: arm/stm32: Add emtrion hardware emSBC-Argon
Date:   Tue, 30 Nov 2021 09:16:53 +0100
Message-ID: <20211130081654.119028-2-reinhold.mueller@emtrion.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211130081654.119028-1-reinhold.mueller@emtrion.com>
References: <20211130081654.119028-1-reinhold.mueller@emtrion.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [2003:f9:5824:1:20c:29ff:fe08:43c4]
X-ClientProxiedBy: EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1) To EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1)
X-C2ProcessedOrg: 5b249fcb-306f-4927-9982-5d11b1d300ce
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinhold Mueller <reinhold.mueller@emtrion.com>

This patch presents the yaml patch for the emtrion GmbH
Argon board series.

Signed-off-by: Reinhold Mueller <reinhold.mueller@emtrion.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index bcaf7be3ab37..710230847dcd 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -28,6 +28,14 @@ properties:
           - enum:
               - st,stm32mp153
               - st,stm32mp157
+
+      - description: emtrion STM32MP1 Argon based Boards
+        items:
+          - enum:
+              - emtrion,stm32mp157c-emsbc-argon
+          - enum:
+              - emtrion,stm32mp157c-emstamp-argon
+          - const: st,stm32mp157
       - items:
           - enum:
               - st,stm32f429i-disco
-- 
2.20.1

