Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2486652FBD2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355515AbiEULVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242628AbiEULMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:06 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954E2B1B3;
        Sat, 21 May 2022 04:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kQa5cfuPEsbdnRvQ8ftErp/mynhbBnfSGp1TG+fR1bE=;
  b=OECAspocGk4KwZCivgUPEzFkLguLIRQPoDoEpXglC2sSYPNhPHPamMmI
   JuyFmyXTJ+PX7DO9bt9rZQ1rP5jcYEuqFkijNX+brIopDjempkX26hzqz
   a9IN/YSAFyDvSvGkoPi6ksuBOHUa9Yw5/EhjNM0ikg8dfohbWyGjU/bSQ
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727918"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:56 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Laxman Dewangan <ldewangan@nvidia.com>
Cc:     kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: tegra: fix typos in comments
Date:   Sat, 21 May 2022 13:10:33 +0200
Message-Id: <20220521111145.81697-23-Julia.Lawall@inria.fr>
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

Spelling mistakes (triple letters) in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/tty/serial/serial-tegra.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d942ab152f5a..101fb585e6f9 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -441,7 +441,7 @@ static char tegra_uart_decode_rx_error(struct tegra_uart_port *tup,
 
 	if (unlikely(lsr & TEGRA_UART_LSR_ANY)) {
 		if (lsr & UART_LSR_OE) {
-			/* Overrrun error */
+			/* Overrun error */
 			flag = TTY_OVERRUN;
 			tup->uport.icount.overrun++;
 			dev_dbg(tup->uport.dev, "Got overrun errors\n");
@@ -1080,7 +1080,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	tup->rx_in_progress = 1;
 
 	/*
-	 * Enable IE_RXS for the receive status interrupts like line errros.
+	 * Enable IE_RXS for the receive status interrupts like line errors.
 	 * Enable IE_RX_TIMEOUT to get the bytes which cannot be DMA'd.
 	 *
 	 * EORD is different interrupt than RX_TIMEOUT - RX_TIMEOUT occurs when

