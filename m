Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07F45A2850
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344072AbiHZNPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242915AbiHZNPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:15:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F120A477;
        Fri, 26 Aug 2022 06:15:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 11C5322CBE;
        Fri, 26 Aug 2022 13:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661519699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fNi9yBBIOMI4mmRT67z9hj/vhptWb9ZSQi1NXFzbvNU=;
        b=GflvrT/pcAWSVNueW8L6MJD+bpKNB5UHSrDEstqr0oEdxUgi3bZENi18eB4P/DG41mKUWf
        Z6jDV5YdZyy/JnjiDhFEP2V0N5x8UgoxfN+VFj/6RYXIc6v+bbMkZ2Y/ynJAt1nPj+Gt2Q
        2fyf5zNBiqgNen0hFww6fXOnYgdRkHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661519699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fNi9yBBIOMI4mmRT67z9hj/vhptWb9ZSQi1NXFzbvNU=;
        b=DaaqdhHEkWpjyyUim7j/jtgd9QYq1SsZBTauy6oogwRZdnK9B4x6kdaTq8MaIdF+Hk28pt
        SUUlo99nLdOfrfDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC1C013A7E;
        Fri, 26 Aug 2022 13:14:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2fkoMFLHCGMPJwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 26 Aug 2022 13:14:58 +0000
Date:   Fri, 26 Aug 2022 15:14:57 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] ACPI: docs: enumeration: Fix a few typos and wording
 mistakes
Message-ID: <20220826151457.7c13a407@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"sturct" -> "struct"
"similar than with" -> "similar to"
Missing comma, "it" and "to"

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
---
 Documentation/firmware-guide/acpi/enumeration.rst |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-5.19.orig/Documentation/firmware-guide/acpi/enumeration.rst	2022-08-26 12:46:35.307949217 +0200
+++ linux-5.19/Documentation/firmware-guide/acpi/enumeration.rst	2022-08-26 15:02:50.245981296 +0200
@@ -21,7 +21,7 @@ In order to support this and re-use the
   - Devices behind real busses where there is a connector resource
     are represented as struct spi_device or struct i2c_device. Note
     that standard UARTs are not busses so there is no struct uart_device,
-    although some of them may be represented by sturct serdev_device.
+    although some of them may be represented by struct serdev_device.
 
 As both ACPI and Device Tree represent a tree of devices (and their
 resources) this implementation follows the Device Tree way as much as
@@ -205,7 +205,7 @@ enumerated once spi_register_master() is
 		}
 		...
 
-The SPI device drivers only need to add ACPI IDs in a similar way than with
+The SPI device drivers only need to add ACPI IDs in a similar way to
 the platform device drivers. Below is an example where we add ACPI support
 to at25 SPI eeprom driver (this is meant for the above ACPI snippet)::
 
@@ -362,7 +362,7 @@ These GPIO numbers are controller relati
 specifies the path to the controller. In order to use these GPIOs in Linux
 we need to translate them to the corresponding Linux GPIO descriptors.
 
-There is a standard GPIO API for that and is documented in
+There is a standard GPIO API for that and it is documented in
 Documentation/admin-guide/gpio/.
 
 In the above example we can get the corresponding two GPIO descriptors with
@@ -538,8 +538,8 @@ information.
 PCI hierarchy representation
 ============================
 
-Sometimes could be useful to enumerate a PCI device, knowing its position on the
-PCI bus.
+Sometimes it could be useful to enumerate a PCI device, knowing its position on
+the PCI bus.
 
 For example, some systems use PCI devices soldered directly on the mother board,
 in a fixed position (ethernet, Wi-Fi, serial ports, etc.). In this conditions it
@@ -550,7 +550,7 @@ To identify a PCI device, a complete hie
 the chipset root port to the final device, through all the intermediate
 bridges/switches of the board.
 
-For example, let us assume to have a system with a PCIe serial port, an
+For example, let's assume we have a system with a PCIe serial port, an
 Exar XR17V3521, soldered on the main board. This UART chip also includes
 16 GPIOs and we want to add the property ``gpio-line-names`` [1] to these pins.
 In this case, the ``lspci`` output for this component is::
@@ -593,8 +593,8 @@ To describe this Exar device on the PCI
 
 	Bus: 0 - Device: 14 - Function: 1
 
-To find this information is necessary disassemble the BIOS ACPI tables, in
-particular the DSDT (see also [2])::
+To find this information, it is necessary to disassemble the BIOS ACPI tables,
+in particular the DSDT (see also [2])::
 
 	mkdir ~/tables/
 	cd ~/tables/


-- 
Jean Delvare
SUSE L3 Support
