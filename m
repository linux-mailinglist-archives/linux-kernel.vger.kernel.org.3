Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1337E548035
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiFMHPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbiFMHOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:14:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A3B1A3B4;
        Mon, 13 Jun 2022 00:14:15 -0700 (PDT)
Date:   Mon, 13 Jun 2022 07:14:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655104453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uN7GJEzbcGh/PqzVZwaY9FVsZWswt4juX+htQ8dEkPY=;
        b=QlkW1Y9vkYyapSgYhNu7j3ilVu2aYmoZ9NDJw52g8sl+tvuOCL5prli6TebtcJPtxVwQz1
        7BF37F+vUwM8KpP5GKADo9ceaZrUG4z7LnTVOuZ29W6Ug7fSa9kS9xHPW+/LUjsS99DJEp
        tLD8BZfJhiucDyUS99Kh7h/m+QYSAm0LtB9kXywmXOyKl7nHOcKXx1MVxjQtyp8cvANtY4
        aF1CSzVa/6TBVCjqECob7+vMGleH4SYymnKo6rfYtdRthCZrZ0L2inA7cJ0uRiVQmF1q0d
        RamwOcsHTmZGQyxRKYO4aSr5Ln8Yx26qJzB60YUrl+qHU2WqmsZPtWmnudlvhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655104453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uN7GJEzbcGh/PqzVZwaY9FVsZWswt4juX+htQ8dEkPY=;
        b=hyk56MLiwtinb2LMZ4YViphnrL/vcku9dt83V7JGPvBQh21mFz0hMO13VsbcAORmBh6bnK
        KnanUdpeudmuZ5BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.19-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220610083628.1205136-1-maz@kernel.org>
References: <20220610083628.1205136-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165510445167.4207.4891830247271681153.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     6872fcac7158c3b3728a2ec1ea771ade0e61ddd5
Gitweb:        https://git.kernel.org/tip/6872fcac7158c3b3728a2ec1ea771ade0e61ddd5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 13 Jun 2022 09:10:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jun 2022 09:10:49 +02:00

Merge tag 'irqchip-fixes-5.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip/genirq fixes from Marc Zyngier:

 - Invoke runtime PM for chained interrupts, aligning the behaviour
   with that of 'normal' interrupts

 - A flurry of of_node refcounting fixes

 - A fix for the recently merged loongarch that broke UP MIPS

 - A configuration fix for the Xilinx interrupt controller

 - Yet another new compat string for the Uniphier interrupt controller

Link: https://lore.kernel.org/lkml/20220610083628.1205136-1-maz@kernel.org
---
