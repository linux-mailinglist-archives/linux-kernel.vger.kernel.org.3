Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAF56D7AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiGKITK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGKITF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:19:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290A1BE99
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:19:03 -0700 (PDT)
Date:   Mon, 11 Jul 2022 08:19:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657527541;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4KYEQLB6G3yFWU4n0HyAHsxVSDrklKLH+vqDqAQ6M4=;
        b=2P7iCXA05IZYGr3eWdW3Ak/bSz/J2o327tb3lYFrI7nXNK9fPVi31A/nOsHKo+Tw0feLPb
        wKKdo/48+X3QVR3nxCRMKGZp+0rSKbuI33Hmk1Fm0riQZ7zDY0CKk/yMmLltjRhe9xJXxg
        4y7Ph3C0u+uFy1KT5ztGyHOdRacYsVvn3I1+auVLssPleRm2qFr66YcrONhw8637iowfoZ
        FINyNDOT/r+C9njG30T2LozlRwxyHk0W66Y/7HTttMSSgU8Q7ovPd5S/uEuOTw8xpntCwc
        admu61apD0Hd7vCrdS2j2INRkuijSTVQRMNJvHR78xrFMXQDSte7IwaeSmU4ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657527541;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4KYEQLB6G3yFWU4n0HyAHsxVSDrklKLH+vqDqAQ6M4=;
        b=Fn+VHrsqhVJ9yLIqePNeS2WwzTk0y55FTYqWR4pmGma9X/PumC4tELkCaUpxrN+5iFKFtv
        muwtRXC0nYSgAjBg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: thunderx: Don't directly include
 asm-generic/msi.h
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de
In-Reply-To: <20220711154252.4b88a601@canb.auug.org.au>
References: <20220711154252.4b88a601@canb.auug.org.au>
MIME-Version: 1.0
Message-ID: <165752754001.15455.5272535554101815616.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     7dc487d27f7fef32a79eacb4159636b0ea425a5b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/7dc487d27f7fef32a79eacb4159636b0ea425a5b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 11 Jul 2022 08:55:21 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 11 Jul 2022 09:15:58 +01:00

gpio: thunderx: Don't directly include asm-generic/msi.h

On architectures that require it, asm-generic/msi.h is already
dragged in by the higher level include files, and is commonly
refered to as 'asm/msi.h'.

It is also architecture specific, and breaks compilation in
a pretty bad way now that linux/gpio/driver.h includes asm/msi.h
(which drags a conflicting but nonetheless correct version
of msi_alloc_info_t on x86).

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220711154252.4b88a601@canb.auug.org.au
Link: https://lore.kernel.org/r/20220711081257.132901-1-maz@kernel.org
Fixes: 91a29af413de ("gpio: Remove dynamic allocation from populate_parent_alloc_arg()")
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-thunderx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index e1dedbc..cc62c6e 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -15,8 +15,6 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
-#include <asm-generic/msi.h>
-
 
 #define GPIO_RX_DAT	0x0
 #define GPIO_TX_SET	0x8
