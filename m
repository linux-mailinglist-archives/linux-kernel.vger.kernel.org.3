Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA604A6F28
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245085AbiBBKrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:47:22 -0500
Received: from ip-94-112-206-30.net.upcbroadband.cz ([94.112.206.30]:58936
        "EHLO ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240987AbiBBKrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:47:19 -0500
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 31EC320056;
        Wed,  2 Feb 2022 11:47:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1643798837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CwgkS16hm6g+f5m8exUl+Us46dxj6gX2mGlYXB1Jatk=;
        b=zhbq5TZRpRAkGxsVtxWjPvz/TJVH6AhqLPo3jTeVxqGGaHpzKafiJCouEvIive2GiBuhOi
        haO4JcoVZR/ug3CqVXFbsOg+F2R11tMIHsDymWOyJ/O9ZW4OKmPb2B4q5lu4xNfH5Up/uh
        lMfxEIcLswdX4tJ4DHCTMAuN7YQyd3Q=
From:   David Heidelberg <david@ixit.cz>
To:     Li-hao Kuo <lhjeff911@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: add mising description type to reg property
Date:   Wed,  2 Feb 2022 11:47:15 +0100
Message-Id: <20220202104715.27839-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing description type.

Fixes warning:
Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml: properties:reg:items: 'anyOf' conditional failed

Fixes: a708078eeb99 ("spi: Add Sunplus SP7021 schema")

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
index 24382cdda645..38589fdbc80d 100644
--- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
@@ -20,8 +20,8 @@ properties:
 
   reg:
     items:
-      - the SPI master registers
-      - the SPI slave registers
+      - description: the SPI master registers
+      - description: the SPI slave registers
 
   reg-names:
     items:
-- 
2.34.1

