Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD348583C35
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiG1Kna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiG1Kn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:43:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E69E13E8D;
        Thu, 28 Jul 2022 03:43:26 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:43:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGvppzKvnn5emKn8FK6lLsUDjVMRn3uVDNjhTYdUSyw=;
        b=VhpbSU6p3d5SUSYJ6x9R3Pnt/BgokR28x8xadnm3XLH3PH6wPyURqiwOUIOlgVBVLmJlnZ
        5rAx2YgQ7Cn4tGhiUl1ZWzdtlUaqQHgSsNXzkJyVIp5npzv9QwnZ2ObBbIIfJsDOJtPmMR
        e2oyHnACe1SBKDAcBRrRnDjq4Nj/4zgB3XZDEc7W3QsqLdhwRX3PZ5YgyzcsPHkvAwk+AP
        7Xra92dZnd8au6w3XQL+QhlzeXnbc2OAVsRw4uKhUtJ/XV8k3OaPaFyl1TjLReZ+fHnkFV
        o64lFpoEeml4huCwPnsqTQTwybZLQRD2ZiHxk7VTwMrSkKbrmkcsp3FGjchsHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGvppzKvnn5emKn8FK6lLsUDjVMRn3uVDNjhTYdUSyw=;
        b=PphPLRXSYqPCFzSk4O3SBTROFMAyG5LODJF/SbUvdlc921eUb7UpRMk6MV9DnsVKqb8HzC
        eTBgIDCtqhBNtVCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-5.20' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220727192356.1860546-1-maz@kernel.org>
References: <20220727192356.1860546-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165900500373.15455.16400919758936217377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     779fda86bdeb86bad6daa4f0ecf37788dfc26f6c
Gitweb:        https://git.kernel.org/tip/779fda86bdeb86bad6daa4f0ecf37788dfc26f6c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 28 Jul 2022 12:36:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 Jul 2022 12:36:35 +02:00

Merge tag 'irqchip-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip/genirq updates from Marc Zyngier:

 * Core code update:

  - Non-SMP IRQ affinity fixes, allowing UP kernel to behave similarly
    to SMP ones for the purpose of interrupt affinity

  - Let irq_set_chip_handler_name_locked() take a const struct irq_chip *

  - Tidy-up the NOMAP irqdomain API variant

  - Teach action_show() to use for_each_action_of_desc()

  - Make irq_chip_request_resources_parent() allow the parent callback
    to be optional

  - Remove dynamic allocations from populate_parent_alloc_arg()

 * New drivers:

  - Merge the long awaited IRQ support for the LoongArch architecture,
    with the provisional ACPICA update (to be reverted once the official
    support lands)

  - New Renesas RZ/G2L IRQC driver, equipped with its companion GPIO
    driver

 * Driver updates

  - Optimise the hot path operations for the SiFive PLIC, trading the
    locking for per-CPU priority masking masking operations which are
    apparently faster

  - Work around broken PLIC implementations that deal pretty badly with
    edge-triggered interrupts. Flag two implementations as affected.

  - Simplify the irq-stm32-exti driver, particularly the table that
    remaps the interrupts from exti to the GIC, reducing the memory usage

  - Convert the ocelot irq_chip to being immutable

  - Check ioremap() return value in the MIPS GIC driver

  - Move MMP driver init function declarations into the common .h

  - The obligatory typo fixes

Link: https://lore.kernel.org/all/20220727192356.1860546-1-maz@kernel.org
---
