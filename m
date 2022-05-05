Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C8D51C87E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383152AbiEES6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383090AbiEES6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:58:04 -0400
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de [80.67.18.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB213EB83;
        Thu,  5 May 2022 11:54:21 -0700 (PDT)
Received: from [92.206.160.44] (helo=note-book.lan)
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1nmgcJ-0004eJ-3e; Thu, 05 May 2022 20:54:23 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
To:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND] dt-bindings: leds: sgm3140: Document ocp8110 compatible
Date:   Thu,  5 May 2022 20:53:44 +0200
Message-Id: <20220505185344.10067-1-git@apitzsch.eu>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Orient Chip OCP8110 charge pump used for
camera flash LEDs.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
---
This patch was originally submitted as part of a series [1]. But only 1/3
and 3/3 made it into torvalds/linux.git
So this is a resubmisson to add the missing documentation.

[1]: https://lore.kernel.org/all/20220212180942.8241-2-git@apitzsch.eu/

 Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
index f68259619488..1c345cf16d08 100644
--- a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
@@ -18,7 +18,9 @@ description: |
 
 properties:
   compatible:
-    const: sgmicro,sgm3140
+    enum:
+      - ocs,ocp8110
+      - sgmicro,sgm3140
 
   enable-gpios:
     maxItems: 1
-- 
2.35.1

