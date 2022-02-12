Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2234B3799
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 20:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiBLTQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 14:16:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiBLTQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 14:16:51 -0500
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de [80.67.18.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A493B03E;
        Sat, 12 Feb 2022 11:16:46 -0800 (PST)
Received: from [92.206.166.137] (helo=note-book.lan)
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1nIwqg-0000Mn-3w; Sat, 12 Feb 2022 19:10:18 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add ocs prefix
Date:   Sat, 12 Feb 2022 19:09:40 +0100
Message-Id: <20220212180942.8241-1-git@apitzsch.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20211117091405.7412-1-git@apitzsch.eu>
References: <20211117091405.7412-1-git@apitzsch.eu>
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

Add the prefix for Orient Chip Technology.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..9ffffa9773ca 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -854,6 +854,8 @@ patternProperties:
     description: NXP Semiconductors
   "^oceanic,.*":
     description: Oceanic Systems (UK) Ltd.
+  "^ocs,.*":
+    description: Orient Chip Technology Co., Ltd.
   "^oct,.*":
     description: Octavo Systems LLC
   "^okaya,.*":
-- 
2.35.1

