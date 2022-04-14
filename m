Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406F7500B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbiDNKh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbiDNKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:37:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5208053B74;
        Thu, 14 Apr 2022 03:35:26 -0700 (PDT)
Date:   Thu, 14 Apr 2022 10:35:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649932517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEdXWOolFMpX310q7AURVkltiWxCj+2BxsZYXt8kQpA=;
        b=kDxrbrnyHTOG+ioShl/gIQUbaSQSuenZhauiZ2E1eIsz209F3hyPhxk15zOIkMLQIctLHZ
        Cs7IOXPGmNAtAyrtE6QQ9dqma5EoMVad2dA3j/IPAHly8Z3tQzLRWbu7mw/+YSs4VUji3z
        Rp3/4S4WjTL2di/CJZL0AFEUCIL3ar3XH7qbuWok8+ECV/a9grSnw3KetTSvnsVCqRxapz
        Jj4pI25DelSCsHVhuFRS9e1ViNxkMANo8SiyKYEZ484lKBkFlpGxGKcufF2WG/Sgbqf6a9
        s3tqv47EfHe3vPp2Zfb3SHGPzNY9eAqIV1+ros59qH0BOsR8a38LBq4nf79PHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649932517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEdXWOolFMpX310q7AURVkltiWxCj+2BxsZYXt8kQpA=;
        b=LAChuiDqlV5Qju9t+bTqshWgyMyxm/Pnlw8Ehbf2BRkOE9y7QnaYzySImholarTVkyTD8r
        6uG/QQrdj9aIECCA==
From:   "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/process: Fix kernel-doc warning due to a
 changed function name
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220414062110.60343-1-jiapeng.chong@linux.alibaba.com>
References: <20220414062110.60343-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <164993251625.4207.15885270496028960488.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     dbb5ab6d2c0a7397d77c9f60fe23844d4fe4e634
Gitweb:        https://git.kernel.org/tip/dbb5ab6d2c0a7397d77c9f60fe23844d4fe4e634
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Thu, 14 Apr 2022 14:21:10 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Apr 2022 12:23:06 +02:00

x86/process: Fix kernel-doc warning due to a changed function name

Fix the following scripts/kernel-doc warning:

  arch/x86/kernel/process.c:412: warning: expecting prototype for tss_update_io_bitmap().
  Prototype was for native_tss_update_io_bitmap() instead.

  [ bp: Massage. ]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220414062110.60343-1-jiapeng.chong@linux.alibaba.com
---
 arch/x86/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b370767..b3d2d41 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -405,7 +405,7 @@ static void tss_copy_io_bitmap(struct tss_struct *tss, struct io_bitmap *iobm)
 }
 
 /**
- * tss_update_io_bitmap - Update I/O bitmap before exiting to usermode
+ * native_tss_update_io_bitmap - Update I/O bitmap before exiting to user mode
  */
 void native_tss_update_io_bitmap(void)
 {
