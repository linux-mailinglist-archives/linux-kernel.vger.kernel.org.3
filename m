Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A434A36F3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355215AbiA3Ovh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347259AbiA3Ovf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:51:35 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C901EC06173B;
        Sun, 30 Jan 2022 06:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/rahaqoBl10mLxjiHHBjaDkLrGMaoWWzxNZlctbd1uQ=; b=PX3110lEoSQ9dsykbvPfcmHvnh
        x/+XKcyBbGeu/2xbB4PJ3AZd6Jhpm/GfNLjHXUhuMqcDv4JXv1tVNrI0bTTqxPFSRSGBK8lS7BNEN
        ZcitLNcfpKngdVB+ebfFA4Lg5+m8U0GB76ICNSLfkJJe4sgNSC+E/FqcdnF26gpoeOcE=;
Received: from p200300daa716f900d40f7dfd86c385e0.dip0.t-ipconnect.de ([2003:da:a716:f900:d40f:7dfd:86c3:85e0] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nEBY6-0002if-1F; Sun, 30 Jan 2022 15:51:26 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     Rob Herring <robh+dt@kernel.org>, John Crispin <john@phrozen.org>
Cc:     soc@kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 02/13] dt-bindings: arm: airoha: Add binding for EN7523 SoC and EVB
Date:   Sun, 30 Jan 2022 15:51:05 +0100
Message-Id: <20220130145116.88406-3-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220130145116.88406-1-nbd@nbd.name>
References: <20220130145116.88406-1-nbd@nbd.name>
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
2.32.0 (Apple Git-132)

