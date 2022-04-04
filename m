Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666264F1C61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382336AbiDDV0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379011AbiDDQTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:19:17 -0400
X-Greylist: delayed 148 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Apr 2022 09:17:21 PDT
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de [80.67.18.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0991E31922;
        Mon,  4 Apr 2022 09:17:20 -0700 (PDT)
Received: from [92.206.166.137] (helo=note-book.lan)
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1nbPMf-0006pF-Q4; Mon, 04 Apr 2022 18:15:37 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: leds: sgm3140: Document ocp8110 compatible
Date:   Mon,  4 Apr 2022 18:14:28 +0200
Message-Id: <20220404161428.17175-1-git@apitzsch.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

