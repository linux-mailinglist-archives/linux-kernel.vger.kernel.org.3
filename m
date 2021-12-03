Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FE646767C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbhLCLhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhLCLhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:37:04 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB07C06173E;
        Fri,  3 Dec 2021 03:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uiLb1gICfT2LSIzGyLrHbKByJX69DDfTkndQNPjdmhw=; b=jTeeiVq+DiQ5gLROkyBmDlUFcs
        9Kuq0sHIU8TUMzY/YgbByowO1N5xfgOZOtbyNVZUDMU7JiOGSY8JNx/7iP6xqHyknML6A5XggB5Bd
        rAdOikxWJHztcfjQ5GCH9wHPoT+SjHdAllnocIvsrvL5vYARdqE+yQ3zwlo5YV40iTgE=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mt6oo-0004Ez-UD; Fri, 03 Dec 2021 12:33:35 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     john@phrozen.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/14] dt-bindings: Add vendor prefix for Airoha
Date:   Fri,  3 Dec 2021 12:33:18 +0100
Message-Id: <20211203113331.20510-2-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211203113331.20510-1-nbd@nbd.name>
References: <20211203113331.20510-1-nbd@nbd.name>
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
2.30.1

