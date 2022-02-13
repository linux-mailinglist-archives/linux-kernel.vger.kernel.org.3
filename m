Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F77F4B3B90
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 14:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiBMNZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 08:25:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiBMNZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 08:25:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657EA5EDDD;
        Sun, 13 Feb 2022 05:25:13 -0800 (PST)
Date:   Sun, 13 Feb 2022 13:25:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644758709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7/pIjh0RL7n91EArZbPWWMW4/WSrDHP+MZcRXDIJgU=;
        b=bPRxmL3S3Hl9FPOTw82dro4xvD1Z1v/mh6IVojdt/MENOV1g8V4Vul0Z5N3Q0uyTFt9+pz
        Zri3ZHjKrb+V26OHQWxxT27u/ytZU6OD64uCieBqV8TaO9DYKFSkrQpYFXu2j/WM21PSPT
        gkN101x/6U3UIa44rZiibCjPoxqub0kMlcN3f3v330j3kZtHGa0Qd17hEDmlAye9GSLj+B
        lp3lrEcvD/FsHYLS/N3EeK20fKKGkvCYtghUYuEMK3anikbZW4DYqCYW1oPAiCQMeHl0HD
        K0YuSdzzsODiosO6jGRwBefBGdhIZBUd3DEhQoKRQH7bsUmKYny1HHIpBoyF4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644758709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7/pIjh0RL7n91EArZbPWWMW4/WSrDHP+MZcRXDIJgU=;
        b=2hKJTg8p6FWbo10OVCAMFl0iwfuwi776HGO66QBPMlq+phDEeI6N0nzssi9wVdRNrq53YT
        +AbGWqDaoHGiCNBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.17-2' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220211110038.1179155-1-maz@kernel.org>
References: <20220211110038.1179155-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164475870802.16921.7505879140824625645.tip-bot2@tip-bot2>
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

Commit-ID:     1e34064b60552616b2767d22f2e6f440ced09acb
Gitweb:        https://git.kernel.org/tip/1e34064b60552616b2767d22f2e6f440ced09acb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 13 Feb 2022 14:16:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 13 Feb 2022 14:16:23 +01:00

Merge tag 'irqchip-fixes-5.17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

 - Don't register a hotplug notifier on GICv3 systems that advertise
   LPI support, but have no ITS to make use of it

 - Add missing DT matching for the thead,c900-plic variant of the
   SiFive PLIC

Link: https://lore.kernel.org/r/20220211110038.1179155-1-maz@kernel.org
---
