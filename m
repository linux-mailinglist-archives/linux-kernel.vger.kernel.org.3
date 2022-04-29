Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2253A514A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359748AbiD2NXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359723AbiD2NXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:23:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C6FD34;
        Fri, 29 Apr 2022 06:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C536FCE2A31;
        Fri, 29 Apr 2022 13:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E519DC385A7;
        Fri, 29 Apr 2022 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651238419;
        bh=W0F62x4ZZOH2j54MPXWZcj4w3N1F+atcMVbtEoqkWr8=;
        h=From:To:Cc:Subject:Date:From;
        b=l328/irFh6BO2aAxvUJPBmxX/X8CRjQyhrbT4dMb5WH1sLSW33JdnfTnOQ0sUbkiq
         5EAzCPDIGqPPIWdVbPFUa35q1WSrnkmwkjy+geWl0QD6w07nXbURqlKxnKAbwnHoyN
         4P5rF+bmRHnmGxShuYwwzhsIpaiKRlTRnSVdxYCLf4QKkH8KMCDtS7k4nZZm7AM+5+
         gj2qqD/sI/rO+Rhl+DC/1kuAAzekts4jsmFQzFj8LZbGqwXzFPGE0bg6JfyaeLzr9n
         aF1iUH8pvcWB22C34vCZNd3T43NEA7i54L7oUptiQKoPhBj8qcuQc6Ay6/vqj5ehi9
         SGxFDwlmoZODA==
Received: by pali.im (Postfix)
        id 49A35CAF; Fri, 29 Apr 2022 15:20:16 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: watchdog: max63xx: Add GPIO binding
Date:   Fri, 29 Apr 2022 15:13:48 +0200
Message-Id: <20220429131349.21229-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO is optional and used for WDI logic.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
index ab9641e845db..a97aa0135ef9 100644
--- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
+++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
@@ -27,6 +27,10 @@ properties:
     description: This is a 1-byte memory-mapped address
     maxItems: 1
 
+  gpios:
+    description: Optional GPIO used for controlling WDI when WDI bit is not mapped to memory
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.20.1

