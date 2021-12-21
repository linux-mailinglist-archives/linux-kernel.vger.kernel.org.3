Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66D747BB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhLUISS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:18:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40078 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhLUISR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:18:17 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BL8IDJk091861;
        Tue, 21 Dec 2021 02:18:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640074693;
        bh=+5DKJ/0oNxXpWI67tKvUBJD1I9hTOkGU2Y7w3PRjvgM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mvzZ9nIYPQ/nACp522IznK8WZwj/KHP+UeOpNtViN3QxoSNAtk5EpktezOAbafACF
         uWod2b6AwcWHGdWygA1TUTM/xmYtnRp0W7Va7xP942szF8KLBZ6ip3OpwvxWFtm04/
         bVlk65AFzg8xFJrpuPQAirBBfXJEL0PDri0GXCkQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BL8IDEn081226
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Dec 2021 02:18:13 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Dec 2021 02:18:12 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Dec 2021 02:18:12 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BL8I7o9010607;
        Tue, 21 Dec 2021 02:18:10 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 1/5] dt-bindings: arm: ti: Add bindings for J721s2 SoC
Date:   Tue, 21 Dec 2021 13:48:02 +0530
Message-ID: <20211221081806.7836-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221081806.7836-1-a-govindraju@ti.com>
References: <20211221081806.7836-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for J721S2 SoC

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index cf327230fc0e..b03c10fa2e7a 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -53,6 +53,12 @@ properties:
               - ti,am642-sk
           - const: ti,am642
 
+      - description: K3 J721s2 SoC
+        items:
+          - enum:
+              - ti,j721s2-evm
+          - const: ti,j721s2
+
 additionalProperties: true
 
 ...
-- 
2.17.1

