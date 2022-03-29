Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63C94EAAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiC2Jj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbiC2Jjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:39:51 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70E5124C20
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:38:08 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d553:ff0a:6830:6bde])
        by albert.telenet-ops.be with bizsmtp
        id C9e52700k49QC44069e6Kh; Tue, 29 Mar 2022 11:38:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZ8If-007Eie-H9; Tue, 29 Mar 2022 11:38:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZ8Ie-00CC2F-Mp; Tue, 29 Mar 2022 11:38:04 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car H3/M3/E3 support
Date:   Tue, 29 Mar 2022 11:38:03 +0200
Message-Id: <3784b6cb76a008fb56d6cb4ba228d78c77e710fa.1648546583.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for the SPI Multi I/O Bus Controller (RPC-IF) in the
R-Car H3, M3-W, M3-W+, M3-N, and E3 SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/memory-controllers/renesas,rpc-if.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
index 9a6dbf54b5406eb6..ae31dc97524cd6c9 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -31,8 +31,13 @@ properties:
               - renesas,r8a774b1-rpc-if       # RZ/G2N
               - renesas,r8a774c0-rpc-if       # RZ/G2E
               - renesas,r8a774e1-rpc-if       # RZ/G2H
+              - renesas,r8a7795-rpc-if        # R-Car H3
+              - renesas,r8a7796-rpc-if        # R-Car M3-W
+              - renesas,r8a77961-rpc-if       # R-Car M3-W+
+              - renesas,r8a77965-rpc-if       # R-Car M3-N
               - renesas,r8a77970-rpc-if       # R-Car V3M
               - renesas,r8a77980-rpc-if       # R-Car V3H
+              - renesas,r8a77990-rpc-if       # R-Car E3
               - renesas,r8a77995-rpc-if       # R-Car D3
               - renesas,r8a779a0-rpc-if       # R-Car V3U
           - const: renesas,rcar-gen3-rpc-if   # a generic R-Car gen3 or RZ/G2{E,H,M,N} device
-- 
2.25.1

