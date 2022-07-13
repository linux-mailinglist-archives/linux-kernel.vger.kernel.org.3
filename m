Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24CE5733C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbiGMKG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiGMKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:06:19 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4FEB03E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=vU7FzLsGhteYWA
        lX5AmR5qM0k2NYlzMgLWR9q91NNoc=; b=E4mOuWpWQEXuuC9Py/UScsGHFm/psW
        scKrMIVS6Fu0Sh7MQGpg8XyagpOGx3YctlCTBIFcVB1W8oWSptMn9mUF4KzMN7Dn
        9h2Hh4aQUxgxLarhV4cC5T1yLlXpfQh9qy+brZz1fdWRR6aZZIvdf2l81NTBrS0i
        SEA6DCYdZKDd0=
Received: (qmail 123381 invoked from network); 13 Jul 2022 12:06:14 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 12:06:14 +0200
X-UD-Smtp-Session: l3s3148p1@iiJn76zjntYgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: timer: renesas,cmt: Add r8a779f0 and generic Gen4 CMT support
Date:   Wed, 13 Jul 2022 12:06:01 +0200
Message-Id: <20220713100603.3391-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713100603.3391-1-wsa+renesas@sang-engineering.com>
References: <20220713100603.3391-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../devicetree/bindings/timer/renesas,cmt.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
index 53dd6d9f518f..7cc1ec4b4e38 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -83,6 +83,11 @@ properties:
               - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
           - const: renesas,rcar-gen3-cmt0 # 32-bit CMT0 on R-Car Gen3 and RZ/G2
 
+      - items:
+          - enum:
+              - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
+          - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
+
       - items:
           - enum:
               - renesas,r8a774a1-cmt1     # 48-bit CMT on RZ/G2M
@@ -100,6 +105,11 @@ properties:
               - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
           - const: renesas,rcar-gen3-cmt1 # 48-bit CMT on R-Car Gen3 and RZ/G2
 
+      - items:
+          - enum:
+              - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
+          - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
+
   reg:
     maxItems: 1
 
-- 
2.35.1

