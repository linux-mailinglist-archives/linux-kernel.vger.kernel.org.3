Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A2852F11B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351864AbiETQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346045AbiETQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:52:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C25C994FE;
        Fri, 20 May 2022 09:52:55 -0700 (PDT)
Date:   Fri, 20 May 2022 16:52:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653065568;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3cq8tceraEn5aryHaEp6+fdeoIPJQzR5dSACACvQ8I=;
        b=XBnkrLsRDnLrdDwo/ZYTbEG8KHmWqxZNhcDsS6LXwZy0kf9Kg2e7GM0TmbgkHd7sHjR/2Z
        GX5JOClwo7+Bhb9Sw9aAxj23Ws09l00m8C9o6CV4JLYXtE5Wvs+3xU+wjDe2LgrjEKqdVb
        iepn2bao7z7REVaiWCLluxHvX+lgSnGhjgg+nwkbHAYWRiEvMAiQQIlg+cDtQXbZfkzpIk
        jGnxQLPADeuWFOn52QZMtZfrCF31UzA5aujwHxzZKZVOT1+WroyjBCBBXSHbb6Gy9yLrAC
        0+9iHbAMtZsnp5r9LezF6nEKPYiYK/G41Ijz7e8a/60C8nHg96qjMd/vzYw0XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653065568;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3cq8tceraEn5aryHaEp6+fdeoIPJQzR5dSACACvQ8I=;
        b=BjyBlSk/7BPNR49TmbEhfmNYan57JxLKfQDPvmo91kQttTmtCuySum9BT2oZhwHR/6p2N3
        R56cQZYRcIj4AZAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-5.19' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220519165308.998315-1-maz@kernel.org>
References: <20220519165308.998315-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165306556654.4207.16860910960888100211.tip-bot2@tip-bot2>
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

Commit-ID:     cdb4913293897dde0df522ed5789ba016f3b9157
Gitweb:        https://git.kernel.org/tip/cdb4913293897dde0df522ed5789ba016f3b9157
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 May 2022 18:48:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 20 May 2022 18:48:54 +02:00

Merge tag 'irqchip-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip updates from Marc Zyngier:

 - Add new infrastructure to stop gpiolib from rewriting irq_chip
   structures behind our back. Convert a few of them, but this will
   obviously be a long effort.

 - A bunch of GICv3 improvements, such as using MMIO-based invalidations
   when possible, and reducing the amount of polling we perform when
   reconfiguring interrupts.

 - Another set of GICv3 improvements for the Pseudo-NMI functionality,
   with a nice cleanup making it easy to reason about the various
   states we can be in when an NMI fires.

 - The usual bunch of misc fixes and minor improvements.

Link: https://lore.kernel.org/all/20220519165308.998315-1-maz@kernel.org
---
