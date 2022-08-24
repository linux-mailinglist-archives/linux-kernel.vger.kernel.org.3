Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A755559F6AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbiHXJnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbiHXJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:43:43 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B2592F4E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=wKt3Dn8j9uSc7B
        5EhIB4EGLx7pjDxO5kqFp34hJTebQ=; b=J9fEm05uPijF2Yw1vJFwGXMX2QDtxk
        VPWgoOIw8uFo0ibZdHVCvMjmgtI64LD885Vzw9/bjw1tfUPZSTL19N35QZZQ/FEB
        nBZ1LwLAWxoCWEOK82vpvFTR0hDoZEW/kcIPIHrL6/AB5yXLqJLDuZLJaI2TNYe9
        eZHJa2LCH8bV8=
Received: (qmail 2162710 invoked from network); 24 Aug 2022 11:43:37 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Aug 2022 11:43:37 +0200
X-UD-Smtp-Session: l3s3148p1@4LLWg/nmcpsgAwDPXxw3AFlguiwjsjwa
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: renesas,sh-msiof: R-Car V3U is R-Car Gen4
Date:   Wed, 24 Aug 2022 11:43:26 +0200
Message-Id: <20220824094327.33685-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite the name, R-Car V3U is the first member of the R-Car Gen4
family. Hence move its compatible value to the R-Car Gen4 section.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index 3813e8aaaefd..64faa8d3580a 100644
--- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -47,11 +47,11 @@ properties:
               - renesas,msiof-r8a77980      # R-Car V3H
               - renesas,msiof-r8a77990      # R-Car E3
               - renesas,msiof-r8a77995      # R-Car D3
-              - renesas,msiof-r8a779a0      # R-Car V3U
           - const: renesas,rcar-gen3-msiof  # generic R-Car Gen3 and RZ/G2
                                             # compatible device
       - items:
           - enum:
+              - renesas,msiof-r8a779a0      # R-Car V3U
               - renesas,msiof-r8a779f0      # R-Car S4-8
           - const: renesas,rcar-gen4-msiof  # generic R-Car Gen4
                                             # compatible device
-- 
2.35.1

