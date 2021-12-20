Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED41347B507
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhLTVTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhLTVTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:19:10 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873EC061574;
        Mon, 20 Dec 2021 13:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rUR4T59zgk9unsHq9DSS81YlucLDE0VHV2qTQPF4oEk=; b=bGtP/Rmeshol6YGfEqJJbwruCZ
        s+oB4r8bEaILorwm2Jhzhc1Z0P7VhdiK/jZPXAS7YY4kq2AhV25Tt7bugCbW6tyErJ4Q93EI+zQkz
        T3rITYeyRaxgQM0zoqLZ5Sckc8GS7E9RsuXEyriGP9Tg1O2JE0AoFDXcmONZljPFfhmE=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mzQ3i-0000zo-6e; Mon, 20 Dec 2021 22:19:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     john@phrozen.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/14] dt-bindings: Add vendor prefix for Airoha
Date:   Mon, 20 Dec 2021 22:18:41 +0100
Message-Id: <20211220211854.89452-2-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211220211854.89452-1-nbd@nbd.name>
References: <20211220211854.89452-1-nbd@nbd.name>
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
Signed-off-by: Felix Fietkau <nbd@nbd.name>
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

