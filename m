Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037AE4A31C8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 21:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353051AbiA2ULo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 15:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiA2ULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 15:11:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45117C061714;
        Sat, 29 Jan 2022 12:11:43 -0800 (PST)
Date:   Sat, 29 Jan 2022 20:11:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643487100;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYaQWgIvptgh10iYW/4FbMUdUbbw/s1ijxzyBKJ8MCU=;
        b=ZFxLeQDiSsI4kLtzhgxHeyVlSu9cmfrP8gR3RF9Uu/nCqyi7E4L2XL9L031jWx0Gu2R9aS
        teKhpVXxnDK7Qk03yrvk5PLq3gGDlk8Ke7gXTC7JBWtGOFcUzeNlem2dEQuk7i10+wxQFK
        iOeqLQh0+F0L1gCKlkZrYyOmRNUjjRkLCVFzfmCeCrzxxX0pOxJOoD5X77hxjHwunGY/Bl
        ZeqDZb92CoFGNaS7VMThe7rKqZpb31WUlsqV/n92AfxFYzgBiwufLA4rhFIRbaTQpOW+D5
        i/HxQ+KtxAu4Ss7YEFo9zdvg6oKfuAJbauYgpbdpbzR0TLfVAcJHB3z7h3bZkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643487100;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYaQWgIvptgh10iYW/4FbMUdUbbw/s1ijxzyBKJ8MCU=;
        b=eB/7M4EByB/3DWwnoZGugA2cqQOeJRUBURtB+HPB8CVHgj8udfO5xekZIgLpH3o+26H0ye
        z2NyZ8geTqRvF0CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.17-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220128174217.517041-1-maz@kernel.org>
References: <20220128174217.517041-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164348709902.16921.12003619101749886028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     243d30803744155a54bfb8a844cc964945cfd9a1
Gitweb:        https://git.kernel.org/tip/243d30803744155a54bfb8a844cc964945cfd9a1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 29 Jan 2022 21:03:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 29 Jan 2022 21:03:20 +01:00

Merge tag 'irqchip-fixes-5.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

  - Drop an unused private data field in the AIC driver

  - Various fixes to the realtek-rtl driver

  - Make the GICv3 ITS driver compile again in !SMP configurations

  - Force reset of the GICv3 ITSs at probe time to avoid issues during kexec

  - Yet another kfree/bitmap_free conversion

  - Various DT updates (Renesas, SiFive)

Link: https://lore.kernel.org/r/20220128174217.517041-1-maz@kernel.org
---
