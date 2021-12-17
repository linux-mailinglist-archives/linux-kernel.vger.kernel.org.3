Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E72C4789C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhLQLYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhLQLYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:24:04 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5747BC06173E;
        Fri, 17 Dec 2021 03:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DcbP8XXWf5wA/EHUK5gDuBqB3xYKUZKXikbNc0uUTaY=; b=jz9RsG4tI+Itg3tyohwc490c/H
        zES3QxR72ipebjtPmqnpkkG9hCIiylCS3uqpdbcJkPurZ4WOn7MkrPbNKS7WjiOHIW9WccfRI5ecy
        SWJytalhgbOAKDOJNvQ3xqsu1IfJ9flCGmZSiDAjCghEYcvfdi6PjW8Tg2Dj6i7KUKJc=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1myBL9-000742-ND; Fri, 17 Dec 2021 12:23:55 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     john@phrozen.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/14] dt-bindings: Add vendor prefix for Airoha
Date:   Fri, 17 Dec 2021 12:23:31 +0100
Message-Id: <20211217112345.14029-2-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217112345.14029-1-nbd@nbd.name>
References: <20211217112345.14029-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

Add vendor prefix "airoha" for Airoha, a subsidiary of MediaTek

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 66d6432fd781..025df36aee5f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -59,6 +59,8 @@ patternProperties:
     description: Aeroflex Gaisler AB
   "^aesop,.*":
     description: AESOP Embedded Forum
+  "^airoha,.*":
+    description: Airoha
   "^al,.*":
     description: Annapurna Labs
   "^alcatel,.*":
-- 
2.34.1

