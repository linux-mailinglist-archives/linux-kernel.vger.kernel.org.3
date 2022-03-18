Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FD04DD821
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbiCRKkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiCRKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:11 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C522DC014;
        Fri, 18 Mar 2022 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y4SWvaFF8SLF18WGHPMXLhVShwqcGA37JZXbsBYpEjo=;
  b=fbWymSZZAY0ujoskteXjkICADm86iX6MRN0XTYcYCSXL6JV1QkHx0fB2
   w5gO6LrOq1RgUSOVokIfsYPFw7Sr2wjdnDj0ogv9WpNPyvM1EUdxbubmi
   2Z/DSD/fzkh/twvPersTHKHJnDzrZwl7se605ahqRwiB4/3wDNH8pkCy7
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935665"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:39 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     kernel-janitors@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] omap1: htc_herald: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:22 +0100
Message-Id: <20220318103729.157574-27-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/arm/mach-omap1/board-htcherald.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 258304edf23e..d528b8497061 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -170,7 +170,7 @@ static const unsigned int htc_herald_keymap[] = {
 	KEY(3, 0, KEY_VOLUMEUP), /* Volume up */
 	KEY(4, 0, KEY_F2),  /* Right bar (landscape) */
 	KEY(5, 0, KEY_MAIL), /* Win key (portrait) */
-	KEY(6, 0, KEY_DIRECTORY), /* Right bar (protrait) */
+	KEY(6, 0, KEY_DIRECTORY), /* Right bar (portrait) */
 	KEY(0, 1, KEY_LEFTCTRL), /* Windows key */
 	KEY(1, 1, KEY_COMMA),
 	KEY(2, 1, KEY_M),

