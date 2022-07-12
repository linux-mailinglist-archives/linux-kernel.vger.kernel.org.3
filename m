Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA03A571191
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiGLEzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGLEzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:55:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33067D7B4;
        Mon, 11 Jul 2022 21:55:19 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d10so6515993pfd.9;
        Mon, 11 Jul 2022 21:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJ2Bim60TG2OxgO2j6ASbQ/DUCglgOK7bbA5rKQk8eQ=;
        b=bLatEUazrt//trW4HpTh0UEeBPI7te4dkwE7/4DjtxJbPrg3TQoLG9lepE9xTZGkQc
         oJh6uBlX0bpjmT1gETW2sIBfK0ujKjf8gvEqq7nvYQZOzA0vhsOZ13LBS+KYSj7MUQfZ
         mqGT4TsfQPLuFpPzYVpRrjUP9kijh53TMyhysj0FsF7lerMH/E1v/G1ciSUU9B/A6Btn
         VNMefZACUJj7c9W9ux5Us3b7qGYiFSBRod7JVoeZfy9BYkLKNsjFhqxC82+lhESBxeQM
         ZLvFZTpRFjIbsns3yaKce/GrH3zVIC2CaeUCXGPoYqLPaVFlcsOpYssPRwNWXfYTFAM8
         qOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJ2Bim60TG2OxgO2j6ASbQ/DUCglgOK7bbA5rKQk8eQ=;
        b=1ymVKR0LDUuIykihwbqDH14nmW7nL48PSMLnofak1GlHiDP1QM5q6kpEZsre/GginO
         FaSMUzu0I2lsjzXsS4SUCPsG/FY3NkNwVcGEHYkGgR4nhwBIrxmTQDCM1rZoQk6hKVGG
         WUFciKI7lKBQCprEnf2zCvFM6ytQ0jYBHivvTnaeVlk+vt65Z9CWisYa49hAwUOPiIFZ
         +1Y9lHoYmH026y8mSs05bc6WKnmWTfUnFT1IGCERQ3UKJBxteCuVJteVTj6QGMxOiFB2
         wyHC7JVsLwbK2+4VMgSvVxubMiqOxF4hJeg11VnYtnzXi6fr2WS+IgDA36IPmOd31BfX
         cusA==
X-Gm-Message-State: AJIora9l9u1zliP7g1nvpXFZMsQ5TC/3keMwUXjz0i2f2zb0Ai/rDh1h
        We2vBTL+I0s1NFYv870ePlEgF7n8+aQ=
X-Google-Smtp-Source: AGRyM1ve+57NtRM2fKzZ/JikDXTNLLIT/Uj+hr6NMMo7xWcuDR6JZkKVakuRbhfj7zyPVH5v3KFYLQ==
X-Received: by 2002:a05:6a00:16ca:b0:525:a5d5:d16f with SMTP id l10-20020a056a0016ca00b00525a5d5d16fmr22135061pfc.9.1657601719428;
        Mon, 11 Jul 2022 21:55:19 -0700 (PDT)
Received: from debian.moxa.com ([123.51.145.104])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b0016be0d5483asm5664677plh.252.2022.07.11.21.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 21:55:18 -0700 (PDT)
From:   Jimmy Chen <u7702045@gmail.com>
X-Google-Original-From: Jimmy Chen <jimmy.chen@moxa.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Remove an entry for MOXA platform board
Date:   Tue, 12 Jul 2022 12:55:02 +0800
Message-Id: <20220712045505.4500-1-jimmy.chen@moxa.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use Freescale instead of create new MOXA entry

Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
---
 .../devicetree/bindings/arm/moxa.yaml         | 21 -------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/moxa.yaml

diff --git a/Documentation/devicetree/bindings/arm/moxa.yaml b/Documentation/devicetree/bindings/arm/moxa.yaml
deleted file mode 100644
index 73f4bf883b06..000000000000
--- a/Documentation/devicetree/bindings/arm/moxa.yaml
+++ /dev/null
@@ -1,21 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/arm/moxa.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MOXA platform device tree bindings
-
-maintainers:
-  - Jimmy Chen <jimmy.chen@moxa.com>
-
-properties:
-  compatible:
-    description: UC-82XX-LX embedded computer
-    items:
-      - const: moxa,uc-8210
-      - const: moxa,uc-8220
-
-additionalProperties: true
-...
-
-- 
2.20.1

