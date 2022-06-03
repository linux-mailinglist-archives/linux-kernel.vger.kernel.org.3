Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B36953CCCC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbiFCP7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343551AbiFCP7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:59:12 -0400
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086089FD3;
        Fri,  3 Jun 2022 08:59:09 -0700 (PDT)
Received: from [77.244.183.192] (port=64530 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.95)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nx9hZ-0009cb-LI;
        Fri, 03 Jun 2022 17:59:05 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 1/6] MAINTAINERS: update Luca Ceresoli's e-mail address
Date:   Fri,  3 Jun 2022 17:57:22 +0200
Message-Id: <20220603155727.1232061-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Bootlin address is preferred from now on.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2316278d9db9..7d4bead48ed1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9500,7 +9500,7 @@ F:	tools/testing/selftests/mount_setattr/
 F:	include/linux/mnt_idmapping.h
 
 IDT VersaClock 5 CLOCK DRIVER
-M:	Luca Ceresoli <luca@lucaceresoli.net>
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
 F:	drivers/clk/clk-versaclock5.c
@@ -12042,7 +12042,7 @@ F:	drivers/regulator/max77650-regulator.c
 F:	include/linux/mfd/max77650.h
 
 MAXIM MAX77714 PMIC MFD DRIVER
-M:	Luca Ceresoli <luca@lucaceresoli.net>
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
 F:	drivers/mfd/max77714.c
@@ -12057,7 +12057,7 @@ F:	drivers/regulator/max77802-regulator.c
 F:	include/dt-bindings/*/*max77802.h
 
 MAXIM MAX77976 BATTERY CHARGER
-M:	Luca Ceresoli <luca@lucaceresoli.net>
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
 F:	drivers/power/supply/max77976_charger.c
-- 
2.25.1

