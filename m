Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1BA58387A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiG1GLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbiG1GLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:11:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0EE32B8D;
        Wed, 27 Jul 2022 23:11:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 144795C141;
        Thu, 28 Jul 2022 06:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658988658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a2jBlWeeIqBQ6UE2YuyKwScE51qIsPNQhaXS9pslpfc=;
        b=0JQCW6l1wsPYafVQ0BbR8lBY9RyUbZDxwRXxMh6xLpQiyzVitmS7NFZEUoXquqnFgRYhdi
        UU1qoalQxD3sZb2Bct01iHi1X+wKMi7bMHuzmaeIQ+caq5pwuM2oQXW/0P6R4PuBOZZ39s
        vCCh4k8ep8yUzUUPv9umFAk+nQzA0fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658988658;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a2jBlWeeIqBQ6UE2YuyKwScE51qIsPNQhaXS9pslpfc=;
        b=V7M5gEtrKbosmOLmM7J14ZEKQ7Sl39qp+A3uLRw803vooQaFk5N9qF0wuHqTImCaWFXrtZ
        eEoQEPtr3iWRDLAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CF7342C141;
        Thu, 28 Jul 2022 06:10:57 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/6] tty: serial: serial_core, reformat kernel-doc for functions
Date:   Thu, 28 Jul 2022 08:10:55 +0200
Message-Id: <20220728061056.20799-5-jslaby@suse.cz>
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

There are many annotated functions in serial_core.c, but they do not
completely conform to the kernel-doc style. So reformat them and link
them from the Documentation.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/driver.rst |  11 ++-
 drivers/tty/serial/serial_core.c           | 107 ++++++++++-----------
 2 files changed, 60 insertions(+), 58 deletions(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index 13b580e887b4..e1b440f2c02b 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -25,10 +25,10 @@ Console Support
 ---------------
 
 The serial core provides a few helper functions.  This includes identifing
-the correct port structure (via uart_get_console) and decoding command line
-arguments (uart_parse_options).
+the correct port structure (via uart_get_console()) and decoding command line
+arguments (uart_parse_options()).
 
-There is also a helper function (uart_console_write) which performs a
+There is also a helper function (uart_console_write()) which performs a
 character by character write, translating newlines to CRLF sequences.
 Driver writers are recommended to use this function rather than implementing
 their own version.
@@ -73,7 +73,10 @@ Other functions
    :identifiers: uart_update_timeout uart_get_baud_rate uart_get_divisor
            uart_match_port uart_write_wakeup uart_register_driver
            uart_unregister_driver uart_suspend_port uart_resume_port
-           uart_add_one_port uart_remove_one_port
+           uart_add_one_port uart_remove_one_port uart_console_write
+           uart_parse_earlycon uart_parse_options uart_set_options
+           uart_get_lsr_info uart_handle_dcd_change uart_handle_cts_change
+           uart_try_toggle_sysrq
 
 Other notes
 -----------
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 810dba0b92e3..14d309850d2e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1034,10 +1034,10 @@ static int uart_set_info_user(struct tty_struct *tty, struct serial_struct *ss)
 }
 
 /**
- *	uart_get_lsr_info	-	get line status register info
- *	@tty: tty associated with the UART
- *	@state: UART being queried
- *	@value: returned modem value
+ * uart_get_lsr_info - get line status register info
+ * @tty: tty associated with the UART
+ * @state: UART being queried
+ * @value: returned modem value
  */
 static int uart_get_lsr_info(struct tty_struct *tty,
 			struct uart_state *state, unsigned int __user *value)
@@ -2067,11 +2067,11 @@ static void uart_port_spin_lock_init(struct uart_port *port)
 
 #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
 /**
- *	uart_console_write - write a console message to a serial port
- *	@port: the port to write the message
- *	@s: array of characters
- *	@count: number of characters in string to write
- *	@putchar: function to write character to port
+ * uart_console_write - write a console message to a serial port
+ * @port: the port to write the message
+ * @s: array of characters
+ * @count: number of characters in string to write
+ * @putchar: function to write character to port
  */
 void uart_console_write(struct uart_port *port, const char *s,
 			unsigned int count,
@@ -2110,24 +2110,23 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
 }
 
 /**
- *	uart_parse_earlycon - Parse earlycon options
- *	@p:	  ptr to 2nd field (ie., just beyond '<name>,')
- *	@iotype:  ptr for decoded iotype (out)
- *	@addr:    ptr for decoded mapbase/iobase (out)
- *	@options: ptr for <options> field; NULL if not present (out)
+ * uart_parse_earlycon - Parse earlycon options
+ * @p:	     ptr to 2nd field (ie., just beyond '<name>,')
+ * @iotype:  ptr for decoded iotype (out)
+ * @addr:    ptr for decoded mapbase/iobase (out)
+ * @options: ptr for <options> field; %NULL if not present (out)
  *
- *	Decodes earlycon kernel command line parameters of the form
- *	   earlycon=<name>,io|mmio|mmio16|mmio32|mmio32be|mmio32native,<addr>,<options>
- *	   console=<name>,io|mmio|mmio16|mmio32|mmio32be|mmio32native,<addr>,<options>
+ * Decodes earlycon kernel command line parameters of the form:
+ *  * earlycon=<name>,io|mmio|mmio16|mmio32|mmio32be|mmio32native,<addr>,<options>
+ *  * console=<name>,io|mmio|mmio16|mmio32|mmio32be|mmio32native,<addr>,<options>
  *
- *	The optional form
+ * The optional form:
+ *  * earlycon=<name>,0x<addr>,<options>
+ *  * console=<name>,0x<addr>,<options>
  *
- *	   earlycon=<name>,0x<addr>,<options>
- *	   console=<name>,0x<addr>,<options>
+ * is also accepted; the returned @iotype will be %UPIO_MEM.
  *
- *	is also accepted; the returned @iotype will be UPIO_MEM.
- *
- *	Returns 0 on success or -EINVAL on failure
+ * Returns: 0 on success or -%EINVAL on failure
  */
 int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
 			char **options)
@@ -2172,16 +2171,16 @@ int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
 EXPORT_SYMBOL_GPL(uart_parse_earlycon);
 
 /**
- *	uart_parse_options - Parse serial port baud/parity/bits/flow control.
- *	@options: pointer to option string
- *	@baud: pointer to an 'int' variable for the baud rate.
- *	@parity: pointer to an 'int' variable for the parity.
- *	@bits: pointer to an 'int' variable for the number of data bits.
- *	@flow: pointer to an 'int' variable for the flow control character.
+ * uart_parse_options - Parse serial port baud/parity/bits/flow control.
+ * @options: pointer to option string
+ * @baud: pointer to an 'int' variable for the baud rate.
+ * @parity: pointer to an 'int' variable for the parity.
+ * @bits: pointer to an 'int' variable for the number of data bits.
+ * @flow: pointer to an 'int' variable for the flow control character.
  *
- *	uart_parse_options decodes a string containing the serial console
- *	options.  The format of the string is <baud><parity><bits><flow>,
- *	eg: 115200n8r
+ * uart_parse_options() decodes a string containing the serial console
+ * options. The format of the string is <baud><parity><bits><flow>,
+ * eg: 115200n8r
  */
 void
 uart_parse_options(const char *options, int *baud, int *parity,
@@ -2202,13 +2201,13 @@ uart_parse_options(const char *options, int *baud, int *parity,
 EXPORT_SYMBOL_GPL(uart_parse_options);
 
 /**
- *	uart_set_options - setup the serial console parameters
- *	@port: pointer to the serial ports uart_port structure
- *	@co: console pointer
- *	@baud: baud rate
- *	@parity: parity character - 'n' (none), 'o' (odd), 'e' (even)
- *	@bits: number of data bits
- *	@flow: flow control character - 'r' (rts)
+ * uart_set_options - setup the serial console parameters
+ * @port: pointer to the serial ports uart_port structure
+ * @co: console pointer
+ * @baud: baud rate
+ * @parity: parity character - 'n' (none), 'o' (odd), 'e' (even)
+ * @bits: number of data bits
+ * @flow: flow control character - 'r' (rts)
  */
 int
 uart_set_options(struct uart_port *port, struct console *co,
@@ -3243,11 +3242,11 @@ bool uart_match_port(const struct uart_port *port1,
 EXPORT_SYMBOL(uart_match_port);
 
 /**
- *	uart_handle_dcd_change - handle a change of carrier detect state
- *	@uport: uart_port structure for the open port
- *	@status: new carrier detect status, nonzero if active
+ * uart_handle_dcd_change - handle a change of carrier detect state
+ * @uport: uart_port structure for the open port
+ * @status: new carrier detect status, nonzero if active
  *
- *	Caller must hold uport->lock
+ * Caller must hold uport->lock.
  */
 void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 {
@@ -3278,11 +3277,11 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
 
 /**
- *	uart_handle_cts_change - handle a change of clear-to-send state
- *	@uport: uart_port structure for the open port
- *	@status: new clear to send status, nonzero if active
+ * uart_handle_cts_change - handle a change of clear-to-send state
+ * @uport: uart_port structure for the open port
+ * @status: new clear to send status, nonzero if active
  *
- *	Caller must hold uport->lock
+ * Caller must hold uport->lock.
  */
 void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
 {
@@ -3353,15 +3352,15 @@ static void uart_sysrq_on(struct work_struct *w)
 static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
 
 /**
- *	uart_try_toggle_sysrq - Enables SysRq from serial line
- *	@port: uart_port structure where char(s) after BREAK met
- *	@ch: new character in the sequence after received BREAK
+ * uart_try_toggle_sysrq - Enables SysRq from serial line
+ * @port: uart_port structure where char(s) after BREAK met
+ * @ch: new character in the sequence after received BREAK
  *
- *	Enables magic SysRq when the required sequence is met on port
- *	(see CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE).
+ * Enables magic SysRq when the required sequence is met on port
+ * (see CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE).
  *
- *	Returns false if @ch is out of enabling sequence and should be
- *	handled some other way, true if @ch was consumed.
+ * Returns: %false if @ch is out of enabling sequence and should be
+ * handled some other way, %true if @ch was consumed.
  */
 bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
 {
-- 
2.37.1

