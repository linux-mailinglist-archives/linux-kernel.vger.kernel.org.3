Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8384FBA68
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbiDKLE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345182AbiDKLEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:04:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D804F10FED;
        Mon, 11 Apr 2022 04:01:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 97FF721600;
        Mon, 11 Apr 2022 11:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649674905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcZJ5/5ZjR47/kkn8TU+auFkri3paVZXIw4igHA+bA8=;
        b=Xq2XbxNsyLrA1uxRpVkuyRA6Uf6eYXKjnyi06UthMVpzOy/JowuAGgDN+BU2Qwm8t08Njl
        nDMPwfBvzy75QDoXMhlP/pATQ42vVGaFVHcQiHYYsX3bvyyOTc7GjTWHDdjeOkp7ExeEWB
        Z84Wz2Xw+NNJtqyryGywJU5FqBShWg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649674905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcZJ5/5ZjR47/kkn8TU+auFkri3paVZXIw4igHA+bA8=;
        b=TZ1UanC7y32seFAhi0KNvvH4j2Q0Q5MyivHFJdqnWUgJjFQflAKEG8vyHQEpmH80wFA2bO
        M/YPWIEbuU2axuCQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6C6A6A3B87;
        Mon, 11 Apr 2022 11:01:45 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 6/6] Documentation: tty: n_gsm, use power of ReST
Date:   Mon, 11 Apr 2022 13:01:43 +0200
Message-Id: <20220411110143.10019-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411110143.10019-1-jslaby@suse.cz>
References: <20220411110143.10019-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reformat the whole document, so that automatic numbering and TOC is
properly generated.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/tty/n_gsm.rst | 144 +++++++++++++------------
 1 file changed, 74 insertions(+), 70 deletions(-)

diff --git a/Documentation/driver-api/tty/n_gsm.rst b/Documentation/driver-api/tty/n_gsm.rst
index 04308a7a194a..35d7381515b0 100644
--- a/Documentation/driver-api/tty/n_gsm.rst
+++ b/Documentation/driver-api/tty/n_gsm.rst
@@ -2,6 +2,8 @@
 GSM 0710 tty multiplexor HOWTO
 ==============================
 
+.. contents:: :local:
+
 This line discipline implements the GSM 07.10 multiplexing protocol
 detailed in the following 3GPP document:
 
@@ -11,79 +13,81 @@ This document give some hints on how to use this driver with GPRS and 3G
 modems connected to a physical serial port.
 
 How to use it
--------------
-1. config initiator
-^^^^^^^^^^^^^^^^^^^^^
+=============
 
-1.1 initialize the modem in 0710 mux mode (usually AT+CMUX= command) through
-    its serial port. Depending on the modem used, you can pass more or less
-    parameters to this command.
+Config Initiator
+----------------
 
-1.2 switch the serial line to using the n_gsm line discipline by using
-    TIOCSETD ioctl.
+#. Initialize the modem in 0710 mux mode (usually ``AT+CMUX=`` command) through
+   its serial port. Depending on the modem used, you can pass more or less
+   parameters to this command.
 
-1.3 configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl.
+#. Switch the serial line to using the n_gsm line discipline by using
+   ``TIOCSETD`` ioctl.
 
-1.4 obtain base gsmtty number for the used serial port.
+#. Configure the mux using ``GSMIOC_GETCONF``/``GSMIOC_SETCONF`` ioctl.
 
-Major parts of the initialization program :
-(a good starting point is util-linux-ng/sys-utils/ldattach.c)::
+#. Obtain base gsmtty number for the used serial port.
 
-  #include <stdio.h>
-  #include <stdint.h>
-  #include <linux/gsmmux.h>
-  #include <linux/tty.h>
-  #define DEFAULT_SPEED	B115200
-  #define SERIAL_PORT	/dev/ttyS0
+   Major parts of the initialization program
+   (a good starting point is util-linux-ng/sys-utils/ldattach.c)::
 
-	int ldisc = N_GSM0710;
-	struct gsm_config c;
-	struct termios configuration;
-	uint32_t first;
+      #include <stdio.h>
+      #include <stdint.h>
+      #include <linux/gsmmux.h>
+      #include <linux/tty.h>
 
-	/* open the serial port connected to the modem */
-	fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);
+      #define DEFAULT_SPEED	B115200
+      #define SERIAL_PORT	/dev/ttyS0
 
-	/* configure the serial port : speed, flow control ... */
+      int ldisc = N_GSM0710;
+      struct gsm_config c;
+      struct termios configuration;
+      uint32_t first;
 
-	/* send the AT commands to switch the modem to CMUX mode
-	   and check that it's successful (should return OK) */
-	write(fd, "AT+CMUX=0\r", 10);
+      /* open the serial port connected to the modem */
+      fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);
 
-	/* experience showed that some modems need some time before
-	   being able to answer to the first MUX packet so a delay
-	   may be needed here in some case */
-	sleep(3);
+      /* configure the serial port : speed, flow control ... */
 
-	/* use n_gsm line discipline */
-	ioctl(fd, TIOCSETD, &ldisc);
+      /* send the AT commands to switch the modem to CMUX mode
+         and check that it's successful (should return OK) */
+      write(fd, "AT+CMUX=0\r", 10);
 
-	/* get n_gsm configuration */
-	ioctl(fd, GSMIOC_GETCONF, &c);
-	/* we are initiator and need encoding 0 (basic) */
-	c.initiator = 1;
-	c.encapsulation = 0;
-	/* our modem defaults to a maximum size of 127 bytes */
-	c.mru = 127;
-	c.mtu = 127;
-	/* set the new configuration */
-	ioctl(fd, GSMIOC_SETCONF, &c);
-	/* get first gsmtty device node */
-	ioctl(fd, GSMIOC_GETFIRST, &first);
-	printf("first muxed line: /dev/gsmtty%i\n", first);
+      /* experience showed that some modems need some time before
+         being able to answer to the first MUX packet so a delay
+         may be needed here in some case */
+      sleep(3);
 
-	/* and wait for ever to keep the line discipline enabled */
-	daemon(0,0);
-	pause();
+      /* use n_gsm line discipline */
+      ioctl(fd, TIOCSETD, &ldisc);
+
+      /* get n_gsm configuration */
+      ioctl(fd, GSMIOC_GETCONF, &c);
+      /* we are initiator and need encoding 0 (basic) */
+      c.initiator = 1;
+      c.encapsulation = 0;
+      /* our modem defaults to a maximum size of 127 bytes */
+      c.mru = 127;
+      c.mtu = 127;
+      /* set the new configuration */
+      ioctl(fd, GSMIOC_SETCONF, &c);
+      /* get first gsmtty device node */
+      ioctl(fd, GSMIOC_GETFIRST, &first);
+      printf("first muxed line: /dev/gsmtty%i\n", first);
+
+      /* and wait for ever to keep the line discipline enabled */
+      daemon(0,0);
+      pause();
 
-1.5 use these devices as plain serial ports.
+#. Use these devices as plain serial ports.
 
-   for example, it's possible:
+   For example, it's possible:
 
-   - and to use gnokii to send / receive SMS on ttygsm1
-   - to use ppp to establish a datalink on ttygsm2
+   - to use *gnokii* to send / receive SMS on ``ttygsm1``
+   - to use *ppp* to establish a datalink on ``ttygsm2``
 
-1.6 first close all virtual ports before closing the physical port.
+#. First close all virtual ports before closing the physical port.
 
    Note that after closing the physical port the modem is still in multiplexing
    mode. This may prevent a successful re-opening of the port later. To avoid
@@ -91,27 +95,27 @@ Major parts of the initialization program :
    a disconnect command frame manually before initializing the multiplexing mode
    for the second time. The byte sequence for the disconnect command frame is::
 
-      0xf9, 0x03, 0xef, 0x03, 0xc3, 0x16, 0xf9.
+      0xf9, 0x03, 0xef, 0x03, 0xc3, 0x16, 0xf9
 
-2. config requester
-^^^^^^^^^^^^^^^^^^^^^
+Config Requester
+----------------
 
-2.1 receive string "AT+CMUX= command" through its serial port,initialize
-    mux mode config
+#. Receive ``AT+CMUX=`` command through its serial port, initialize mux mode
+   config.
 
-2.2 switch the serial line to using the n_gsm line discipline by using
-    TIOCSETD ioctl.
+#. Switch the serial line to using the *n_gsm* line discipline by using
+   ``TIOCSETD`` ioctl.
 
-2.3 configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl.
+#. Configure the mux using ``GSMIOC_GETCONF``/``GSMIOC_SETCONF`` ioctl.
 
-2.4 obtain base gsmtty number for the used serial port::
+#. Obtain base gsmtty number for the used serial port::
 
-  #include <stdio.h>
-  #include <stdint.h>
-  #include <linux/gsmmux.h>
-  #include <linux/tty.h>
-  #define DEFAULT_SPEED	B115200
-  #define SERIAL_PORT	/dev/ttyS0
+        #include <stdio.h>
+        #include <stdint.h>
+        #include <linux/gsmmux.h>
+        #include <linux/tty.h>
+        #define DEFAULT_SPEED	B115200
+        #define SERIAL_PORT	/dev/ttyS0
 
 	int ldisc = N_GSM0710;
 	struct gsm_config c;
-- 
2.35.1

