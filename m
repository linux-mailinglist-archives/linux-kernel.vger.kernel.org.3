Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27AB4FAAC3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiDIUbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiDIUbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:31:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60392C49A1;
        Sat,  9 Apr 2022 13:29:09 -0700 (PDT)
Date:   Sat, 09 Apr 2022 20:29:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649536148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7y+GAn8IiNbo6k7FckLBeAYS70B+Oe8m/iFrsO0IfcQ=;
        b=cb7TnuF+fnFifGuXApW5ZXiRIneHKUBCIeNM0X4Na/SGm6aDcnjPIt1BkFWhIh14NTfTK2
        K1BfAxZ78+hsDl6ylc9KTEZlNu3QR3OQiGNBjbbhfl7mv1vBUXmxXQOL0zQZLiyQo8jVHf
        c+p3TNte8ftgxGqhqJP+dexMLWke7WgirJ0Zb2FE60+2DQ06KBtU6bLTdwx/Wyv8fYGhwP
        IyoJa8JBSA0jjhr8W3JyCfgHbB5rHqwSsjGzVNKObxW+ZSLupqWsYE5LKQdWya1fVcEIIm
        RQHbjQ7pI6xFcHIj8WKKwswXCEy3RffQICnC1PuGTdUH4vv4AFK+UxHjJlGpmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649536148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7y+GAn8IiNbo6k7FckLBeAYS70B+Oe8m/iFrsO0IfcQ=;
        b=mzbGVkxJR+BUP37AJNlEFPji5gRTv1eh/YZKm1uUeuN88o8M6OfhMSUv1rqnvCAexLSMuE
        n8HoFco8zvznUBAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.18-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220409094229.267649-1-maz@kernel.org>
References: <20220409094229.267649-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164953614715.4207.13727291708188252137.tip-bot2@tip-bot2>
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

Commit-ID:     63ef1a8a07ef64f802af1adadae3b05ba824c534
Gitweb:        https://git.kernel.org/tip/63ef1a8a07ef64f802af1adadae3b05ba824c534
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 09 Apr 2022 22:21:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 09 Apr 2022 22:21:55 +02:00

Merge tag 'irqchip-fixes-5.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

 - Fix GICv3 polling for RWP in redistributors

 - Reject ACPI attempts to use SGIs on GIC/GICv3

 - Fix unpredictible behaviour when making a VPE non-resident
   with GICv4

 - A couple of fixes for the newly merged qcom-mpm driver

Link: https://lore.kernel.org/lkml/20220409094229.267649-1-maz@kernel.org
---
