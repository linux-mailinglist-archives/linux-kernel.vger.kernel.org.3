Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB69583877
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiG1GL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiG1GLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:11:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F853244C;
        Wed, 27 Jul 2022 23:11:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4C9935C142;
        Thu, 28 Jul 2022 06:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658988658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vE3lqgObhp+xA4CyyUBOqxikMk/zmslrA0px/M7XVgY=;
        b=KNc2WxSpTyu1g7K8XE/yQXYhfBVta8Eh9L99DzXD9sKP5uWOnaWYzTkSJttRi5xnqYyBvO
        KHjwkJgVyYITeeaGQe6tTsiiOmXkdBt5KhTIbddt7EimrtG2ugj9qyO6tQtkamoWujd2ty
        QC4r5qca6ugGz65m5Hgj7uk3sYdCltA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658988658;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vE3lqgObhp+xA4CyyUBOqxikMk/zmslrA0px/M7XVgY=;
        b=hp/b23j1V7WHnGijucEuuEH7LDw+6fZ/Q3QntjVBTpWgR7U1UhsQUNou6vfnKGUHlDaUaE
        eaIA1OwikoziGdDw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1F3172C142;
        Thu, 28 Jul 2022 06:10:58 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 6/6] tty: serial: document uart_get_console()
Date:   Thu, 28 Jul 2022 08:10:56 +0200
Message-Id: <20220728061056.20799-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728061056.20799-1-jslaby@suse.cz>
References: <20220728061056.20799-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was the only function mentioned in the text, but was neither linked
nor documented. So document and link it, so that hyperlinking works in
the text.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/driver.rst |  2 +-
 drivers/tty/serial/serial_core.c           | 13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index e1b440f2c02b..23c6b956cd90 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -76,7 +76,7 @@ Other functions
            uart_add_one_port uart_remove_one_port uart_console_write
            uart_parse_earlycon uart_parse_options uart_set_options
            uart_get_lsr_info uart_handle_dcd_change uart_handle_cts_change
-           uart_try_toggle_sysrq
+           uart_try_toggle_sysrq uart_get_console
 
 Other notes
 -----------
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 14d309850d2e..12c87cd201a7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2087,10 +2087,15 @@ void uart_console_write(struct uart_port *port, const char *s,
 }
 EXPORT_SYMBOL_GPL(uart_console_write);
 
-/*
- *	Check whether an invalid uart number has been specified, and
- *	if so, search for the first available port that does have
- *	console support.
+/**
+ * uart_get_console - get uart port for console
+ * @ports: ports to search in
+ * @nr: number of @ports
+ * @co: console to search for
+ * Returns: uart_port for the console @co
+ *
+ * Check whether an invalid uart number has been specified (as @co->index), and
+ * if so, search for the first available port that does have console support.
  */
 struct uart_port * __init
 uart_get_console(struct uart_port *ports, int nr, struct console *co)
-- 
2.37.1

