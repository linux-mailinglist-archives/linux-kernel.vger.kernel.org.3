Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A8D4789C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhLQLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbhLQLYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:24:04 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C62C061574;
        Fri, 17 Dec 2021 03:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nUSlPxq9cI8SGtTbOTGvLmDhrd4m3sHfyKCnFvnVWTA=; b=HCuIpbtb811lbemxISI27B3yZY
        sQSX6EaTcE5DNmbwc1mhRv5BE+afiGaRuymzafN41nh/DQe/5GVtdhDsU0tl/Ep51tWxYGdtqtTVk
        lGbVv6uDFug4Rb+uBPmeD44ISLa7qunNT1jiE6wjCTPIW+hksvRXt9WKBbeKnxi4N0Og=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1myBLA-000742-Jk; Fri, 17 Dec 2021 12:23:56 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     Rob Herring <robh+dt@kernel.org>, John Crispin <john@phrozen.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/14] dt-bindings: arm: airoha: Add binding for EN7523 SoC and EVB
Date:   Fri, 17 Dec 2021 12:23:32 +0100
Message-Id: <20211217112345.14029-3-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217112345.14029-1-nbd@nbd.name>
References: <20211217112345.14029-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

Add devicetree binding for Airoha EN7523 SoC and evaluation board.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Bert Vermeulen <bert@biot.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../devicetree/bindings/arm/airoha.yaml       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/airoha.yaml

diff --git a/Documentation/devicetree/bindings/arm/airoha.yaml b/Documentation/devicetree/bindings/arm/airoha.yaml
new file mode 100644
index 000000000000..fc19b1a6f37b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/airoha.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/airoha.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha SoC based Platforms Device Tree Bindings
+
+maintainers:
+  - Felix Fietkau <nbd@nbd.name>
+  - John Crispin <john@phrozen.org>
+
+description:
+  Boards with an Airoha SoC shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - airoha,en7523-evb
+          - const: airoha,en7523
+
+additionalProperties: true
+
+...
-- 
2.34.1

