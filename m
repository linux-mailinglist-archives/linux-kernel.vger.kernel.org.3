Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A649D4FAD86
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiDJK4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiDJK4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:56:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681061B787;
        Sun, 10 Apr 2022 03:54:28 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649588067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xctoUVYOaFhI2BODTogS4vA+LSWTcmrCe3hEFPVM0DE=;
        b=EB8ZsaacQMsCl364EyLW2YoJsW3I+C9vWYw+q7RhnAWa9BZ+tUf3sv4xeODIU+Sn1fkSLP
        Tc9FjaOT4dNEPbJ82ZeK9+PypvJPJCr6NONUx9idcvZwoE3nO8azBtqC8oFb626iu63Ma6
        51+PIcOVn/uQBuvIeK29HoDQqGGvvqLRFfYH/eoTY/I9k8L2dcncs1VwXIMegqYmFI2nSs
        84e28Bhrwh86QATcgUZh+AwuHvCToeQT0xc+ahkOtAAx6xISltqiRSNuSK0PlqjmQ4mO3f
        tVyaFam/0xPFacAAJF249lSePs+6clthFRmOsZc7nb/UCihmGCT+ubt2cUXQiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649588067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xctoUVYOaFhI2BODTogS4vA+LSWTcmrCe3hEFPVM0DE=;
        b=LVua1YcivD8GA7tHNef9KMP9CSegB5voGij+7H1EigtaIKIzgSfbJSg7trnptKbGuRkFJi
        I74F/IqhZ8+xhvDw==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Fix coding style in PIRQ table verification
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2203310017260.44113@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203310017260.44113@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164958806582.4207.2252840474773326464.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     c25f23459c117d950e657458b0d3dcaaf9039ec9
Gitweb:        https://git.kernel.org/tip/c25f23459c117d950e657458b0d3dcaaf9039ec9
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 31 Mar 2022 08:11:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:48:15 +02:00

x86/PCI: Fix coding style in PIRQ table verification

Remove an extraneous space with a cast in `pirq_check_routing_table'.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203310017260.44113@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index ceac715..a498b84 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -77,7 +77,7 @@ static inline struct irq_routing_table *pirq_check_routing_table(u8 *addr,
 	int i;
 	u8 sum;
 
-	rt = (struct irq_routing_table *) addr;
+	rt = (struct irq_routing_table *)addr;
 	if (rt->signature != PIRQ_SIGNATURE ||
 	    rt->version != PIRQ_VERSION ||
 	    rt->size % 16 ||
