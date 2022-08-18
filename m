Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB265987BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbiHRPrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245479AbiHRPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:47:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E52BB687;
        Thu, 18 Aug 2022 08:47:07 -0700 (PDT)
Date:   Thu, 18 Aug 2022 15:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660837626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1ZBjoWOM8zbpX6y1BZr6IrR1LRXu2X5aBtikUp09wo=;
        b=hR+yepTUc7OfD70kE6YWiWx+t2Efmgd8/BaORtZxMQgQDmx2BOv74+wLZRFVyoc/FLuE9X
        I4DeKEeg2yIAdC9T5STqDtIIp2bg/iiuTdkN8CgZrRWD5Ba2c1K30cuNUHECjzqMzfNeJz
        phR8qCJ/K+fu79Kqg2uBjSuILkT0D5hq6TLPJH/MZ7JUtmEeFSP0OqItKt/nOSeaugU94O
        r3q1VwRALmq2c/fyW/U+gen+fhbSIJZ3xT0FESzUaNr+ZiKwtF/aLfunqyaU1EYWUTpNUr
        iiA86qAQfmMMNu7qMIuJwpeuQxfwzZ2wqeXldbu9xIYJn01GUsWpBKP3Xs3yCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660837626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1ZBjoWOM8zbpX6y1BZr6IrR1LRXu2X5aBtikUp09wo=;
        b=+gPBKD04IlMHTUW+1QBYic0RBOcfIy0xWOQmrjA3/kOnSmR4CU44SkWrDw9EmhVkOvpcJQ
        TtsL0G2cNVFWLHBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-6.0-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220812125910.2227338-1-maz@kernel.org>
References: <20220812125910.2227338-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <166083762434.401.9456477010273369465.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     57646d6769f13f9484ffc6869c493e25a6568073
Gitweb:        https://git.kernel.org/tip/57646d6769f13f9484ffc6869c493e25a6568073
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 18 Aug 2022 17:37:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Aug 2022 17:37:22 +02:00

Merge tag 'irqchip-fixes-6.0-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

  - A bunch of small fixes for the recently merged LoongArch drivers

  - A leftover from the non-SMP IRQ affinity rework affecting
    the Hyper-V IOMMU code

Link: https://lore.kernel.org/r/20220812125910.2227338-1-maz@kernel.org
---
