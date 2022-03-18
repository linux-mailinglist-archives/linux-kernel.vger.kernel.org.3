Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B04DD81E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiCRKjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiCRKi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:38:58 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2230F2D8125;
        Fri, 18 Mar 2022 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CWcBMmMi6fNaNE57LOh1pQYBwkefYJf4b2w4bAjHl0A=;
  b=J5B0sRvZX3OkZCoa3QNL+Fy0yQ4CaUaZAvDTsclK6lS3Blw0coE8fg+I
   cXFSvtVjP6l5//yF6XnVsdCDPOJqTnVQgDgGX9jxz+A1pziKfQxP5M2t1
   juRMqEexEk6Wss6NhgBwNoSJZkg9GcN37UbCOyIxJwLhIuN8RGtmE2Ume
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935633"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:35 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     kernel-janitors@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mmp: fix typos in comments
Date:   Fri, 18 Mar 2022 11:36:59 +0100
Message-Id: <20220318103729.157574-4-Julia.Lawall@inria.fr>
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
 arch/arm/mach-mmp/gplugd.c |    2 +-
 arch/arm/mach-mmp/pxa168.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 5888b71944b8..ead674015b55 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -154,7 +154,7 @@ static int gplugd_eth_init(void)
 struct pxa168_eth_platform_data gplugd_eth_platform_data = {
 	.port_number = 0,
 	.phy_addr    = 0,
-	.speed       = 0, /* Autonagotiation */
+	.speed       = 0, /* Autonegotiation */
 	.intf        = PHY_INTERFACE_MODE_RMII,
 	.init        = gplugd_eth_init,
 };
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 1e9389245d0e..97e6c3b2bd31 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -129,7 +129,7 @@ struct platform_device pxa168_device_gpio = {
 };
 
 struct resource pxa168_usb_host_resources[] = {
-	/* USB Host conroller register base */
+	/* USB Host controller register base */
 	[0] = {
 		.start	= PXA168_U2H_REGBASE + U2x_CAPREGS_OFFSET,
 		.end	= PXA168_U2H_REGBASE + USB_REG_RANGE,

