Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15204D7E71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbiCNJ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbiCNJ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1051726CF;
        Mon, 14 Mar 2022 02:27:48 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:27:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sR3nV2kv/09GVXOFZiO306BSvLFY+B0mvuMMSQsd4DE=;
        b=pTEItVwPNHvmd7GP+AivQyk1MJv0tzfvZb84FT7wIKufMTiIgarQVlkAoU8Cf/TDHlw+1N
        YVFPUQopgf+hOi1qRX4sEySelYDnKg6J1xGUgkudBx4vzQf5OG1q4Zp4Xo+HaW3uZ1ZgD5
        2uekd3cLXCjDIdJe2jWtAocCOQ2V5gQu7ypX8Kxl8B746hFLNqbFaHk8CfHzbzWIzatamh
        rc67MnFSbdnnUcYCcyrSWZs9IID5Q9smOzFjDq1k2ALE6sD0+LoDYPWfcruVjTw1vLuM+5
        /Vcf3ro3vg+g45pvlB7iqxTkPX/iO/W/utgNwwmD4N+cYGfrxEdJYIXju6I00w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sR3nV2kv/09GVXOFZiO306BSvLFY+B0mvuMMSQsd4DE=;
        b=kYHH7+IELo3fDNRE7XJ634s7eGqRnMGSM8j0OyqiJvowVFMxhW6nyMhH/d52em2iv/M7iA
        LqOXjB40R1u/0NBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-5.18' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220313105142.704579-1-maz@kernel.org>
References: <20220313105142.704579-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164725006601.16921.2637757188708535130.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f0fae8a0edd445d042ee94153f127e8939fcf3d3
Gitweb:        https://git.kernel.org/tip/f0fae8a0edd445d042ee94153f127e8939fcf3d3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Mar 2022 10:23:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 14 Mar 2022 10:23:22 +01:00

Merge tag 'irqchip-5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip updates from Marc Zyngier:

  - Add support for the STM32MP13 variant

  - Move parent device away from struct irq_chip

  - Remove all instances of non-const strings assigned to
    struct irq_chip::name, enabling a nice cleanup for VIC and GIC)

  - Simplify the Qualcomm PDC driver

  - A bunch of SiFive PLIC cleanups

  - Add support for a new variant of the Meson GPIO block

  - Add support for the irqchip side of the Apple M1 PMU

  - Add support for the Apple M1 Pro/Max AICv2 irqchip

  - Add support for the Qualcomm MPM wakeup gadget

  - Move the Xilinx driver over to the generic irqdomain handling

  - Tiny speedup for IPIs on GICv3 systems

  - The usual odd cleanups

Link: https://lore.kernel.org/all/20220313105142.704579-1-maz@kernel.org
---
