Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52766516FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiEBMkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiEBMkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:40:42 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837FD13D12
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:37:12 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:194e:5782:c420:7f87])
        by xavier.telenet-ops.be with bizsmtp
        id RodA2700A28fWK501odAC4; Mon, 02 May 2022 14:37:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nlVIb-002mgV-Tp; Mon, 02 May 2022 14:37:09 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nlVIb-002hmZ-Bz; Mon, 02 May 2022 14:37:09 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] serial: 8250: pxa: Remove unneeded <linux/pm_runtime.h>
Date:   Mon,  2 May 2022 14:37:06 +0200
Message-Id: <9fd96fba9bbbbdeb16af0dc07ae9dee21c8e297c.1651494971.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2545eaa7fc552013a5d04c4df027255204e64834.1651494971.git.geert+renesas@glider.be>
References: <2545eaa7fc552013a5d04c4df027255204e64834.1651494971.git.geert+renesas@glider.be>
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

The 8250 PXA driver never used Runtime PM, so there was never a need to
include <linux/pm_runtime.h>.

Fixes: ab28f51c77cd4618 ("serial: rewrite pxa2xx-uart to use 8250_core")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/8250/8250_pxa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 33ca98bfa5b37c1b..795e55142d4c7c06 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -22,7 +22,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
-#include <linux/pm_runtime.h>
 
 #include "8250.h"
 
-- 
2.25.1

