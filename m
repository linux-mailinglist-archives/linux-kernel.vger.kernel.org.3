Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4020C4AB32D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347882AbiBGBqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiBGBqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:46:22 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1A9C061348;
        Sun,  6 Feb 2022 17:46:20 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id e28so10388095pfj.5;
        Sun, 06 Feb 2022 17:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=9Q5/F8EmWvdY2BVBPwxUCP4JTGecrqYUq+/uZOYIhBk=;
        b=awv32MCVB6xoA8hpTDqMvERErV8/3s6P/y8YvJbYK4x+foi07jjUmTSf3PCarpaTPZ
         BTM2eGhHnAxAzpGZOicz+GfXFDgDgKfCJ6onRXJ9ROP+BKa+hMOnILXrzkZ1syBgRkL6
         /C/JbTSluSQH3dJeNJcI6O2HRgJvnb2ZEiNWmY3lPmOVbV2d5bUhn2FkpCrUaibfbeCR
         MckwQjxpTcH5ZCwJ42xi/K+HHtmbJRTFD53kdLTTG3CUypVNT03OI4C1H9IZZdwjNHJN
         jNMAb7zLctwukNUTaEjJL18QLZflGl55TXwcDZC1RsIUk+FQzIvsk8eJ+9WfBWIGJPnc
         Xtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9Q5/F8EmWvdY2BVBPwxUCP4JTGecrqYUq+/uZOYIhBk=;
        b=1YkGqz+rptUYcKwqtMtRcgve7dsC5eCD21IfJHFLOQ7tW5UkNA+ftN5qyPNLPkjxc3
         u5i3+SYAJvVTqkDnfs1DJcPMt7Tg8ru0Ned1u1HTJJ11PttDHhGObVWQJWXziYY8jXIc
         sMoF+9tXzCJFEFGq+Y8MTFgn6nIjgZS+Jds1azXF5ahQ8Q/Ot9NBpgZ3WFUhgQvcAVMP
         pR56Xnei8nQS0PN+qchyKKSPi7YaWht/mzQTFyowwnORGx51a9AODscvfO3KrY5084aR
         srCUplQR8YfpeFhxmfMvylhperVhYQgsrhz43U0YGjBhGhLttSCwvlMzwD4Y8LWcvTyX
         c2jQ==
X-Gm-Message-State: AOAM531nkc57ha3qDIEKAh32gVPd3EQDG+aeoHXqxREyLj2jqG5Dg+Gh
        wm+yxxbIfC0pg56iYSu3I6I=
X-Google-Smtp-Source: ABdhPJzcXjq4UIXHIcwYc3lcDZJhfbJ3ZQf6vzr+6w38knHEzAa4wIZGvrfnDItDhT5sg6FBpanz4A==
X-Received: by 2002:a63:5144:: with SMTP id r4mr7643965pgl.382.1644198380016;
        Sun, 06 Feb 2022 17:46:20 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id g1sm9690899pfu.32.2022.02.06.17.46.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Feb 2022 17:46:19 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH next] dt-bindings:spi: Fix test error for sp7021.
Date:   Mon,  7 Feb 2022 09:46:34 +0800
Message-Id: <b8a94fbfcab68b1279b09b6297099310c209927b.1644198244.git.lhjeff911@gmail.com>
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

Remove the include path and modify parameters for fix error for bt binding test

Fixes: a708078eeb99  ("spi: Add Sunplus SP7021 schema")
Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
index 38589fd..298eac2 100644
--- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
@@ -59,8 +59,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/sp-sp7021.h>
-    #include <dt-bindings/reset/sp-sp7021.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spi@9C002D80 {
         compatible = "sunplus,sp7021-spi";
@@ -73,8 +71,8 @@ examples:
         interrupts = <144 IRQ_TYPE_LEVEL_HIGH>,
                      <146 IRQ_TYPE_LEVEL_HIGH>,
                      <145 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&clkc SPI_COMBO_0>;
-        resets = <&rstc RST_SPI_COMBO_0>;
+        clocks = <&clkc 0x32>;
+        resets = <&rstc 0x22>;
         pinctrl-names = "default";
         pinctrl-0 = <&pins_spi0>;
     };
-- 
2.7.4

