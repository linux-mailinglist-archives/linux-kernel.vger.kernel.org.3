Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41C4FBA5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345541AbiDKLEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbiDKLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:03:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8193AD7E;
        Mon, 11 Apr 2022 04:01:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3B1C0215FD;
        Mon, 11 Apr 2022 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649674904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45TauevK7dP+XLm2GxxbZ+B2Sm4ZxkU0Rw11agbZb2g=;
        b=fDBfsbC3Nq09IP9NcbgsTHVJL+C4OluYs7l2f6vx2Gpxbvsa+nzpzzDemLlJKysN9f5cIm
        uEVexj+CTG7qvaZNBgR8vBcNt8JKsUKYkTZDHoGoNaXLV+QIPoJbSxh/Hh5RSIqPQFEsZw
        F8hhsrISGzyfoV6KgnficZV1clRwlTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649674904;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45TauevK7dP+XLm2GxxbZ+B2Sm4ZxkU0Rw11agbZb2g=;
        b=4ugekRtF9A+LIGU0JyBtWy+WPcCKARPXNAMKmYxvCGhf8BRxNFKnF4rm0KVj+5Wtnhieni
        pxDJuMhcxUIAdOAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D914EA3B89;
        Mon, 11 Apr 2022 11:01:43 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/6] Documentation: move tty to driver-api
Date:   Mon, 11 Apr 2022 13:01:38 +0200
Message-Id: <20220411110143.10019-2-jslaby@suse.cz>
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

Based on discussion starting as 87mthw2o93.fsf@meer.lwn.net, let's move
the tty documentation to driver-api. It's more appropriate there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/driver-api/index.rst                   | 1 +
 Documentation/driver-api/serial/driver.rst           | 2 +-
 Documentation/{ => driver-api}/tty/index.rst         | 9 ++++-----
 Documentation/{ => driver-api}/tty/n_tty.rst         | 0
 Documentation/{ => driver-api}/tty/tty_buffer.rst    | 0
 Documentation/{ => driver-api}/tty/tty_driver.rst    | 0
 Documentation/{ => driver-api}/tty/tty_internals.rst | 0
 Documentation/{ => driver-api}/tty/tty_ldisc.rst     | 0
 Documentation/{ => driver-api}/tty/tty_port.rst      | 0
 Documentation/{ => driver-api}/tty/tty_struct.rst    | 0
 Documentation/index.rst                              | 1 -
 11 files changed, 6 insertions(+), 7 deletions(-)
 rename Documentation/{ => driver-api}/tty/index.rst (86%)
 rename Documentation/{ => driver-api}/tty/n_tty.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_buffer.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_driver.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_internals.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_ldisc.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_port.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_struct.rst (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index a7b0223e2886..bbbbcf20b7ce 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -101,6 +101,7 @@ available subsections can be seen below.
    surface_aggregator/index
    switchtec
    sync_file
+   tty
    vfio-mediated-device
    vfio
    vfio-pci-device-specific-driver-acceptance
diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index 7dc3791addeb..3c2d12acfd54 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -339,7 +339,7 @@ hardware.
 	This call must not sleep
 
   set_ldisc(port,termios)
-	Notifier for discipline change. See Documentation/tty/tty_ldisc.rst.
+	Notifier for discipline change. See ../tty/tty_ldisc.rst.
 
 	Locking: caller holds tty_port->mutex
 
diff --git a/Documentation/tty/index.rst b/Documentation/driver-api/tty/index.rst
similarity index 86%
rename from Documentation/tty/index.rst
rename to Documentation/driver-api/tty/index.rst
index 21ea0cb21e55..2240e52203d6 100644
--- a/Documentation/tty/index.rst
+++ b/Documentation/driver-api/tty/index.rst
@@ -43,11 +43,10 @@ Writing TTY Driver
 ==================
 
 Before one starts writing a TTY driver, they must consider
-:doc:`Serial <../driver-api/serial/driver>` and :doc:`USB Serial
-<../usb/usb-serial>` layers
-first. Drivers for serial devices can often use one of these specific layers to
-implement a serial driver. Only special devices should be handled directly by
-the TTY Layer. If you are about to write such a driver, read on.
+:doc:`Serial <../serial/driver>` and :doc:`USB Serial <../../usb/usb-serial>`
+layers first. Drivers for serial devices can often use one of these specific
+layers to implement a serial driver. Only special devices should be handled
+directly by the TTY Layer. If you are about to write such a driver, read on.
 
 A *typical* sequence a TTY driver performs is as follows:
 
diff --git a/Documentation/tty/n_tty.rst b/Documentation/driver-api/tty/n_tty.rst
similarity index 100%
rename from Documentation/tty/n_tty.rst
rename to Documentation/driver-api/tty/n_tty.rst
diff --git a/Documentation/tty/tty_buffer.rst b/Documentation/driver-api/tty/tty_buffer.rst
similarity index 100%
rename from Documentation/tty/tty_buffer.rst
rename to Documentation/driver-api/tty/tty_buffer.rst
diff --git a/Documentation/tty/tty_driver.rst b/Documentation/driver-api/tty/tty_driver.rst
similarity index 100%
rename from Documentation/tty/tty_driver.rst
rename to Documentation/driver-api/tty/tty_driver.rst
diff --git a/Documentation/tty/tty_internals.rst b/Documentation/driver-api/tty/tty_internals.rst
similarity index 100%
rename from Documentation/tty/tty_internals.rst
rename to Documentation/driver-api/tty/tty_internals.rst
diff --git a/Documentation/tty/tty_ldisc.rst b/Documentation/driver-api/tty/tty_ldisc.rst
similarity index 100%
rename from Documentation/tty/tty_ldisc.rst
rename to Documentation/driver-api/tty/tty_ldisc.rst
diff --git a/Documentation/tty/tty_port.rst b/Documentation/driver-api/tty/tty_port.rst
similarity index 100%
rename from Documentation/tty/tty_port.rst
rename to Documentation/driver-api/tty/tty_port.rst
diff --git a/Documentation/tty/tty_struct.rst b/Documentation/driver-api/tty/tty_struct.rst
similarity index 100%
rename from Documentation/tty/tty_struct.rst
rename to Documentation/driver-api/tty/tty_struct.rst
diff --git a/Documentation/index.rst b/Documentation/index.rst
index ee639a500278..71cc2d1f35f2 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -138,7 +138,6 @@ needed).
    misc-devices/index
    scheduler/index
    mhi/index
-   tty/index
    peci/index
 
 Architecture-agnostic documentation
-- 
2.35.1

