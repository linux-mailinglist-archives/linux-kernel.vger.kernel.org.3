Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7830047F02E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbhLXQd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:33:57 -0500
Received: from ixit.cz ([94.230.151.217]:49696 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhLXQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:33:48 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 1BCFA2243C;
        Fri, 24 Dec 2021 17:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640363626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FoA5iIkkF6H+aVXyAyIGl68mDWYX9Ghj7Pu9I1UcMTk=;
        b=Lam7IlCcYZ9rbjbVarQFfEqOx5eVAKDBlKssLc0uDa3KyzCQBe/KEOre/yEBaGZgRO0G2H
        DxrLm4xB4LhY/mD1dhRgUI0NSOXJHnh7kJlfSnnhU3gM+//A9V1qy1NcJNl+yloflkFzrP
        sn2F1K43IE4NGY7N3v6Md0TOpmVijWo=
From:   David Heidelberg <david@ixit.cz>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: spmi: spmi can have at least up to 5 registers
Date:   Fri, 24 Dec 2021 17:33:43 +0100
Message-Id: <20211224163344.54177-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Qualcomm SPMI Controller (PMIC Arbiter) can have 5,
bump reg up to maxItems 5.

Fixes warning as:
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: spmi@c440000: reg: [[0, 205783040, 0, 4352], [0, 207618048, 0, 33554432], [0, 241172480, 0, 1048576], [0, 242221056, 0, 655360], [0, 205561856, 0, 155648]] is too long
        From schema: Documentation/devicetree/bindings/spmi/spmi.yaml

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/spmi/spmi.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spmi/spmi.yaml b/Documentation/devicetree/bindings/spmi/spmi.yaml
index 1d243faef2f8..d7d9345d7c60 100644
--- a/Documentation/devicetree/bindings/spmi/spmi.yaml
+++ b/Documentation/devicetree/bindings/spmi/spmi.yaml
@@ -25,7 +25,8 @@ properties:
     pattern: "^spmi@.*"
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 5
 
   "#address-cells":
     const: 2
-- 
2.34.1

