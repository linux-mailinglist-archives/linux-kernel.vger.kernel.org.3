Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980CF4C7C00
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiB1VaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiB1V3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:29:54 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5FF12F42F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:29:13 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 8954 invoked from network); 28 Feb 2022 22:29:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1646083750; bh=du3D/0ryZsshRSGV4ThK5CGxk2r42FFE6m4FeX7u3TM=;
          h=From:To:Cc:Subject;
          b=qpH1KamWRo8AAuFau8XL53lR6wbbs5/wxaVX+VAmdBsmojPFDGp2WbBTJkrP7qgjt
           jXsCGfU6PTXHRFxbaBng6QskCT58ayPbzcd3uEHvAS00VUrNGI+e0ojdqKY4vCxXiA
           0TFENDUiTYm7oOdYRVUyXdoe51i9LYxNkoajJ5NU=
Received: from aafa139.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.130.139])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 28 Feb 2022 22:29:10 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Ira W . Snyder" <ira.snyder@gmail.com>
Subject: [PATCH 08/10] x86/Kconfig: improve CONFIG_PCI_CNB20LE_QUIRK doc
Date:   Mon, 28 Feb 2022 22:28:24 +0100
Message-Id: <20220228212826.27080-9-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228212826.27080-1-mat.jonczyk@o2.pl>
References: <20220228212826.27080-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: f7072062548be6cafb15c4836830e774
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [UaMk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was unable to find a specification of this chipset.

There is a bug report in Red Hat from 2010 [2]. From dmesg from there it
looks ServerWorks CNB20LE was a chipset (controlling the PCI root
bridge and peripherals) and it was working with Pentium III. There was
also a LKML thread from 2002 [1].

There was also some research paper from CERN listing some server
configured with it with a dual Pentium III setup. [3]

[1] Zwane Mwaikambo, Re: Problem with ServerWorks CNB20LE and lost interrupts
https://lkml.org/lkml/2002/1/11/71

[2] Bug 665109 - e100 problems on old Compaq Proliant DL320
https://bugzilla.redhat.com/show_bug.cgi?id=665109

[3] R. Hughes-Jones, S. Dallison, G. Fairey, Performance Measurements on
Gigabit Ethernet NICs and Server Quality Motherboards,
http://datatag.web.cern.ch/papers/pfldnet2003-rhj.doc

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ira W. Snyder <ira.snyder@gmail.com>
---
 arch/x86/Kconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 27d21ef518b0..212f2b9a9d91 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2672,13 +2672,21 @@ config MMCONF_FAM10H
 	depends on X86_64 && PCI_MMCONFIG && ACPI
 
 config PCI_CNB20LE_QUIRK
-	bool "Read CNB20LE Host Bridge Windows" if EXPERT
+	bool "Support PCI hotplug with the CNB20LE chipset" if EXPERT
 	depends on PCI
 	help
 	  Read the PCI windows out of the CNB20LE host bridge. This allows
 	  PCI hotplug to work on systems with the CNB20LE chipset which do
 	  not have ACPI.
 
+	  The ServerWorks (later Broadcom) CNB20LE was a chipset designed
+	  probably for Pentium III.
+
+	  To find out if you have such a chipset, search for a PCI device with
+	  1166:0009 PCI IDs, for example by executing
+		lspci -nn | grep '1166:0009'
+	  The code is inactive if there is none.
+
 	  There's no public spec for this chipset, and this functionality
 	  is known to be incomplete.
 
-- 
2.25.1

