Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBBE54CAE3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347525AbiFOOI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356894AbiFOOIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:08:42 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29F81836C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:08:41 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:5439:2bcc:4a70:48e8])
        by xavier.telenet-ops.be with bizsmtp
        id jS8g270044lJ8fu01S8gdf; Wed, 15 Jun 2022 16:08:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o1ThH-0044ss-L1; Wed, 15 Jun 2022 16:08:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o1ThH-006y6o-6b; Wed, 15 Jun 2022 16:08:39 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] MAINTAINERS: Add pin control bindings defs to Pin Control Subsystem
Date:   Wed, 15 Jun 2022 16:08:37 +0200
Message-Id: <5d0f18b7210c9fd4d9f01d0f8464f7a9701dc366.1655302107.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the section for the Pin Control Subsystem covers Device Tree
binding documents, it currently lacks DT binding definitions.
Add the latter.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37936d5af08e2f4e..2d31121ade3d81a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15711,6 +15711,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 F:	Documentation/devicetree/bindings/pinctrl/
 F:	Documentation/driver-api/pin-control.rst
 F:	drivers/pinctrl/
+F:	include/dt-bindings/pinctrl/
 F:	include/linux/pinctrl/
 
 PIN CONTROLLER - AMD
-- 
2.25.1

