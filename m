Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C0F52E9F5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348151AbiETKdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346638AbiETKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:33:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2B48CB20;
        Fri, 20 May 2022 03:33:46 -0700 (PDT)
Date:   Fri, 20 May 2022 10:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653042825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3EiRAfrIIlf5nSh1BVIrTg9D0v4FjgcwC3dU0MUagIE=;
        b=TgsC4A8r0Trv4KIp1jE6z0WvGz1lLd3mBesEK3ZL2Qe/rwSO424ZH1OP9Q0tTTj9FDZIZu
        BXZXHE9uRC21G+pVv3e87GFqzZTX694Jxd/Yj713ZGMvvwxI9t1s6uR5BNfZTuahK+ZjhN
        hczHj6wdk3eySdOfej2Fa6iWvdxdrenRpafMsAfZvVXQf1rAv56ibozaLT1WxqfxgfHGn3
        DA4tMgqZ1eY18UDfGjJQgxq/J+5ozjv1kd3P+IQ5aRLVtbuBkJH6k2bOBibhpn8P4bA3ei
        DTFNXGFsmsfG2Y/h7Z9vHlKnjEDbkKkSjTXmWT9BRnKGuEqMPx8DSwqfjIQwIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653042825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3EiRAfrIIlf5nSh1BVIrTg9D0v4FjgcwC3dU0MUagIE=;
        b=8SFiJBHiKF9WY8ObskHxAlTNVBfHSsUFqvSJ4i5A4NmiFqCr0jCnWoxSRm11NPch+RxsfV
        sHVimvolCS4V7FDw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Remove empty files
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220520101723.12006-1-bp@alien8.de>
References: <20220520101723.12006-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <165304282381.4207.12933200150021377765.tip-bot2@tip-bot2>
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

Commit-ID:     d936411dc9caeb3edb992e39c33d4d1d81ca8c08
Gitweb:        https://git.kernel.org/tip/d936411dc9caeb3edb992e39c33d4d1d81ca8c08
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 20 May 2022 12:12:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 20 May 2022 12:29:26 +02:00

x86: Remove empty files

Remove empty files which were supposed to get removed with the
respective commits removing the functionality in them:

$ find arch/x86/ -empty
arch/x86/lib/mmx_32.c
arch/x86/include/asm/fpu/internal.h
arch/x86/include/asm/mmx.h

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220520101723.12006-1-bp@alien8.de
---
 arch/x86/include/asm/fpu/internal.h | 0
 arch/x86/include/asm/mmx.h          | 0
 arch/x86/lib/mmx_32.c               | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 arch/x86/include/asm/fpu/internal.h
 delete mode 100644 arch/x86/include/asm/mmx.h
 delete mode 100644 arch/x86/lib/mmx_32.c

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
deleted file mode 100644
index e69de29..0000000
--- a/arch/x86/include/asm/fpu/internal.h
+++ /dev/null
diff --git a/arch/x86/include/asm/mmx.h b/arch/x86/include/asm/mmx.h
deleted file mode 100644
index e69de29..0000000
--- a/arch/x86/include/asm/mmx.h
+++ /dev/null
diff --git a/arch/x86/lib/mmx_32.c b/arch/x86/lib/mmx_32.c
deleted file mode 100644
index e69de29..0000000
--- a/arch/x86/lib/mmx_32.c
+++ /dev/null
