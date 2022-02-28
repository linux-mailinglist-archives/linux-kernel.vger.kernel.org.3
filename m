Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372654C7BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiB1V3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiB1V33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:29:29 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155E12F156
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:28:47 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 36602 invoked from network); 28 Feb 2022 22:28:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1646083724; bh=hQyEzhAswdpO758hYkD84OwxXozNH85Ca7RwTLG0cOk=;
          h=From:To:Cc:Subject;
          b=geG4m0vFiGdf1hec3UP9qwP/ieypbim8uFWSVvlNLbr0YuTgySvegANUdXFCdwmPl
           9u40CWZOqo6kV06afvCPWgImVVl1XVakgGq6OSTXv6Fove7CaSd4VWCt5k/Ol9/F1E
           k/bDqUU6kV0K2FE5iGeurbB4IjWIIOBCjc4lacL8=
Received: from aafa139.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.130.139])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 28 Feb 2022 22:28:43 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Subject: [PATCH 00/10] x86: Kconfig cleanups and help text improvements
Date:   Mon, 28 Feb 2022 22:28:16 +0100
Message-Id: <20220228212826.27080-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: o2.pl)                                      
X-WP-MailID: ffc21dc811ce6037ffdc3365c30649ec
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [EXM0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There are some problems with the Kconfig files in the kernel. The help
text is frequently confusing and does not really describe what the
feature is about in a language that users could understand. Sometimes,
the help text was not updated after kernel or ecosystem changes.
References to something "future" or "old" are also usually given without
specifying any dates.

I have started improving the Kconfig files for x86. I'm sending the
first round of patches - what I have right now.

Greetings,
Mateusz

Mateusz Jończyk (10):
  x86/Kconfig: enable X86_X2APIC by default and improve help text
  x86/apic: fix panic message when x2APIC is not supported
  x86/Kconfig: always enable ARCH_SPARSEMEM_ENABLE
  x86/Kconfig: drop X86_32_NON_STANDARD
  x86/Kconfig: move all X86_EXTENDED_PLATFORM options together
  x86/Kconfig: update lists in X86_EXTENDED_PLATFORM
  x86/Kconfig: add help text to CONFIG_PCI_MMCONFIG
  x86/Kconfig: improve CONFIG_PCI_CNB20LE_QUIRK doc
  x86/Kconfig: document year of release of glibc 2.3.3
  x86/Kconfig: remove CONFIG_ISA_BUS

 arch/x86/Kconfig            | 129 +++++++++++++++++++-----------------
 arch/x86/kernel/apic/apic.c |   2 +-
 drivers/iio/dac/Kconfig     |   2 +-
 3 files changed, 71 insertions(+), 62 deletions(-)


base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
-- 
2.25.1

