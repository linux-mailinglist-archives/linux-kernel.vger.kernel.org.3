Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63524A6F32
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245607AbiBBKxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:53:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiBBKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:53:13 -0500
Date:   Wed, 02 Feb 2022 10:53:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643799192;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JltA6AnJ+s3tMFBXvcHISP0tXOyve+uqNVjA76OKQlg=;
        b=jZnxoIwTkE2CeJrIQcx/Ya9ZjgV0aUxl3uWwFa21W1gv4Z5IfBJoxQvRZAAW2HXqpUw8TC
        v3wKwx0TefyAVmV38BaiWxjAWK1VK4TKKP7sDyx/ZeLl8Z+MPc1jTAzuYZIWf3EUJHuciG
        jZQkOLW9W5JsvzrkQot0n2WzmfDy6DWk2aRx7ODqDyS1e9m/CKSnWJYqPvqIhL1dAuG59w
        qXCVAlpaHUEfVJobwzPuX6SJXiyonJ/zXB8skX1vy03Zk/hVX99a8UxYbijFXQQzN+wwUZ
        oqckMF+zhsw8MsMnbrqmTGgkkqCdbjctF8u44OhmsIeZtIJtd624PfX8g109Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643799192;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JltA6AnJ+s3tMFBXvcHISP0tXOyve+uqNVjA76OKQlg=;
        b=TJJtkDi5qtjzQXRtKrj8+FVEKuX/C+b07QkYhF3+4Ldg+0cxDASuZ8easULi441QJ/lEa7
        PkP0SoIKqcJmLTBw==
From:   "irqchip-bot for Guo Ren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/sifive-plic: Add missing
 thead,c900-plic match string
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20220130135634.1213301-3-guoren@kernel.org>
References: <20220130135634.1213301-3-guoren@kernel.org>
MIME-Version: 1.0
Message-ID: <164379919119.16921.10020352967794973731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     1d4df649cbb4b26d19bea38ecff4b65b10a1bbca
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1d4df649cbb4b26d19bea38ecff4b65b10a1bbca
Author:        Guo Ren <guoren@linux.alibaba.com>
AuthorDate:    Sun, 30 Jan 2022 21:56:34 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Feb 2022 10:49:29 

irqchip/sifive-plic: Add missing thead,c900-plic match string

The thead,c900-plic has been used in opensbi to distinguish
PLIC [1]. Although PLICs have the same behaviors in Linux,
they are different hardware with some custom initializing in
firmware(opensbi).

Qute opensbi patch commit-msg by Samuel:

  The T-HEAD PLIC implementation requires setting a delegation bit
  to allow access from S-mode. Now that the T-HEAD PLIC has its own
  compatible string, set this bit automatically from the PLIC driver,
  instead of reaching into the PLIC's MMIO space from another driver.

[1]: https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb31623a42ced45f38ea6

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220130135634.1213301-3-guoren@kernel.org
---
 drivers/irqchip/irq-sifive-plic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 259065d..09cc982 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -398,3 +398,4 @@ out_free_priv:
 
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmware driver */
