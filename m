Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6144BAF57
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiBRB4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:56:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiBRB4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:56:44 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857CB5C341;
        Thu, 17 Feb 2022 17:56:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id om7so7280893pjb.5;
        Thu, 17 Feb 2022 17:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=WHpd6Sk/XqYh0Nmb203v+Ms5w8m3DPKkCa4xdTTw7C8=;
        b=GRQCNflMzwSiCrZxgdp/birK1ikdDMUfUZqq53GBOycuXlfK+u55Xio3IRY2pmgDrG
         6vpkrL+tfZrr6H3e9kVqTGU3vXDxWGKl2PEoBFuZu/YNSnSJ5/eTpmHX1fRuyCAsy38P
         A/90aP3Zl4ZPaaFgXt7/u+tWODDpypYdXqzkQD9mLuUI0a9KBlcPtSi93FxI9IO2SwPc
         O/Ez/W3kDBl1a68ZlU9b6PrSpnZgj5LtKJawXOibKX7o2K8517M3tdIbBJ1sZuTfUI3+
         Gkz41RcwdK3bOOE3CYPi+DvONT9us4OGolEDWsmedZ/gizCsujhhs9hxhaNeRV8uq2j0
         zKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WHpd6Sk/XqYh0Nmb203v+Ms5w8m3DPKkCa4xdTTw7C8=;
        b=zeY6iZcJ1hmpL8DOwzdHo3jpst6iXXJFBLmICbCZO8whu3PMr/CUFcLCIajTX/IACp
         6U6Q0ae5RmMN3hyPnUvgM+6m8iTVbFGz7g1J60X8NKUnQpRV8Cpgw837U4kd1J2G/NFo
         zUYVKgMP1nDdOdEvysREIAF0q+7RJXcX2vvmpka7silfM6pdlWTQXw+dUfJY3GewqJIa
         EBMKa/YR1t/p1hXcJDV6MDztQrfqwArHhno75/saVHN9fYc/c+NbsQCCCUkck5pIeT+V
         GZYqQmK3Tg9dBXzzIGku2M7lYANWdoaxvnmXQvp4cbeAOBQRR898P1+wud2Dk56afWLX
         3igg==
X-Gm-Message-State: AOAM531zu/Lq7f+eSza5Ikp54USftZ/XSkBXxNNNKUZXZ+bxG1HUTOCe
        JDxlPdpUR3QIAhIUqMEu4lKgjhaXfxFc9Q==
X-Google-Smtp-Source: ABdhPJyGF9SFBwyyZSZ95lmmAgCDOnmg5xfmy+Ly6ZrFBOdqdYSznKxxD5LTEC/EHLfKh+4q3rSGEA==
X-Received: by 2002:a17:902:d353:b0:14a:18ab:298c with SMTP id l19-20020a170902d35300b0014a18ab298cmr5303458plk.87.1645149387808;
        Thu, 17 Feb 2022 17:56:27 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id g18sm87493pfc.108.2022.02.17.17.56.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Feb 2022 17:56:27 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH] dt-bindings: spi: delete unused required and adjust the item.
Date:   Fri, 18 Feb 2022 09:56:44 +0800
Message-Id: <6a86f8c481be417972ef1b1e3b902ccf95706547.1645149279.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

delete unused required(clock-name)
adjust position (interrupts)

Fixes: 3b8ab4da34 ("spi: Fix test error for sp7021")

Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
index 298eac2..9df08d7 100644
--- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
@@ -47,10 +47,9 @@ required:
   - compatible
   - reg
   - reg-names
-  - interrupts
   - interrupt-names
+  - interrupts
   - clocks
-  - clocks-names
   - resets
   - pinctrl-names
   - pinctrl-0
-- 
2.7.4

