Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4675316A8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbiEWRHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 13:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbiEWRFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:05:54 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2A76A059;
        Mon, 23 May 2022 10:05:53 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-d39f741ba0so19182100fac.13;
        Mon, 23 May 2022 10:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o14pKCAai8oO1v+9hK17Nc7y/3uZkxj9s6PMf7yQgR4=;
        b=ct+BgoO5RJa1EPdeUQOQAgmVU+nQDwwTw3+c9IQz+y8F/N2nkE0wdER8AqnsiZn9Z8
         /d9KkzVMNUbhRY/uOLyM7CJWQEKtFqQKvoDYV6zqsnUfqy4g0YP1t3s+4M+l2zEy5bms
         MwVQr1Ir3S9bUBV66ldEUMAMYAsxC2jTGPCMjep6RY5ufaFMf34JBv5FejByVMBwqi9m
         Z9JRU7hKKfQMm741+c/kLtBv6yLuKn6GryTI1N1jZclJ4q9xf8mw5pMxzFxEI8Rc9kvH
         GU2c7i0iSYO3OW5irNVO0x3cU1rBLJ1ibVngNkfnnhaUXyaLl2KgETAtR0RP+f7x2dpZ
         5exw==
X-Gm-Message-State: AOAM533PdxeIAbs+dI/SaHkM0hq54ntTlZjY7XG+RJuTitOvXzI7vK39
        vyphFAp2vH+S/yn0LtyEsg==
X-Google-Smtp-Source: ABdhPJwc1Mn6hBzvABcwzRIkOO/6cuYfrk4xmpQBMDzFgzwQDP45aIoB6NwfWsmKFg8h/M6hKQ5McQ==
X-Received: by 2002:a05:6870:538d:b0:de:aa91:898e with SMTP id h13-20020a056870538d00b000deaa91898emr22248oan.54.1653325552083;
        Mon, 23 May 2022 10:05:52 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id y1-20020a4a9c01000000b0035eb4e5a6d3sm4521078ooj.41.2022.05.23.10.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:05:51 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Olof Johansson <olof@lixom.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH] dt-bindings: input: matrix-keymap: Add common 'linux,no-autorepeat' property
Date:   Mon, 23 May 2022 12:04:49 -0500
Message-Id: <20220523170449.1763039-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'linux,no-autorepeat' is a common property used in multiple bindings,
but doesn't have a common type definition nor description. Add a common
definition and drop the now redundant description from
holtek,ht16k33.yaml.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/auxdisplay/holtek,ht16k33.yaml        | 3 +--
 Documentation/devicetree/bindings/input/matrix-keymap.yaml    | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
index fc4873deb76f..f4579e9f44a1 100644
--- a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
+++ b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
@@ -39,8 +39,7 @@ properties:
 
   linux,keymap: true
 
-  linux,no-autorepeat:
-    description: Disable keyrepeat
+  linux,no-autorepeat: true
 
   default-brightness-level:
     minimum: 1
diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.yaml b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
index 6699d5e32dca..9f703bb51e12 100644
--- a/Documentation/devicetree/bindings/input/matrix-keymap.yaml
+++ b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
@@ -27,6 +27,10 @@ properties:
       column and linux key-code. The 32-bit big endian cell is packed as:
           row << 24 | column << 16 | key-code
 
+  linux,no-autorepeat:
+    type: boolean
+    description: Disable keyrepeat
+
   keypad,num-rows:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Number of row lines connected to the keypad controller.
-- 
2.34.1

