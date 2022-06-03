Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3871E53CCCF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbiFCP7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbiFCP7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:59:31 -0400
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5652C107;
        Fri,  3 Jun 2022 08:59:30 -0700 (PDT)
Received: from [77.244.183.192] (port=64530 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.95)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nx9hv-0009cb-DZ;
        Fri, 03 Jun 2022 17:59:27 +0200
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
Subject: [PATCH 2/6] dt-bindings: update Luca Ceresoli's e-mail address
Date:   Fri,  3 Jun 2022 17:57:23 +0200
Message-Id: <20220603155727.1232061-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603155727.1232061-1-luca@lucaceresoli.net>
References: <20220603155727.1232061-1-luca@lucaceresoli.net>
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
 Documentation/devicetree/bindings/clock/idt,versaclock5.yaml    | 2 +-
 Documentation/devicetree/bindings/mfd/maxim,max77714.yaml       | 2 +-
 .../devicetree/bindings/power/supply/maxim,max77976.yaml        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
index be66f1e8b547..7c331bfbe370 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
@@ -45,7 +45,7 @@ description: |
   The case where SH and SP are both 1 is likely not very interesting.
 
 maintainers:
-  - Luca Ceresoli <luca@lucaceresoli.net>
+  - Luca Ceresoli <luca.ceresoli@bootlin.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77714.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
index 74a6867d3c82..edac14af101e 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: MAX77714 PMIC with GPIO, RTC and watchdog from Maxim Integrated.
 
 maintainers:
-  - Luca Ceresoli <luca@lucaceresoli.net>
+  - Luca Ceresoli <luca.ceresoli@bootlin.com>
 
 description: |
   MAX77714 is a Power Management IC with 4 buck regulators, 9
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
index 675b9b26d233..f23dcc50793e 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Maxim Integrated MAX77976 Battery charger
 
 maintainers:
-  - Luca Ceresoli <luca@lucaceresoli.net>
+  - Luca Ceresoli <luca.ceresoli@bootlin.com>
 
 description: |
   The Maxim MAX77976 is a 19Vin / 5.5A, 1-Cell Li+ battery charger
-- 
2.25.1

