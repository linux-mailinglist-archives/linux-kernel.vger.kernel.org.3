Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66510480D12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 21:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhL1Utj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 15:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbhL1Uti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 15:49:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90261C061574;
        Tue, 28 Dec 2021 12:49:38 -0800 (PST)
Date:   Tue, 28 Dec 2021 20:49:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640724576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEhdu6tuQCAmySDUOdX+JF9ICOs9lZ/DgOwAja0ItfY=;
        b=pQfhq3Go06cyEu2kJOJ7KVa7d3CofO5r7wtLt5Te2804SOGwqRMBF8BYPVXgbb5afJ/5rY
        ejvrmzpUxACoMDwIwqOaflYDv+bWLxVKuPkkMCtNmqaisnm4jz/mkwhAco2BiU8UEfT1Wr
        Vdb1oWfiNJF3JIPNz7+a1dgrE2DpOJONmZqxbljCbzjzj+H1bOib+g0fRoOEqiEJnGUpcG
        Ji2pNP5ixmDvtpEAriHArYoOegn1o+clnUqBUdhdFypE+/S9WJf9r6ce+eYepRRIy7hvo0
        lXUQstmq7D+SmyO8D1ZKpBRI2e4A2B7nwyZR/dwsFIS8fhKVXb1p/f/hfsnV0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640724576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEhdu6tuQCAmySDUOdX+JF9ICOs9lZ/DgOwAja0ItfY=;
        b=mGtMdhocbbphIjGYty/ikTGZ+hr+juwzW8gLkr+E6TOyojl9OX/g+lJh9YnxpUKdIAdyQU
        NWI5ZPB70SKmVgBg==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/events/amd/iommu: Remove redundant assignment
 to variable shift
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211207185001.1412413-1-colin.i.king@gmail.com>
References: <20211207185001.1412413-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Message-ID: <164072457485.16921.17468682057656328578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0be4838f018c10d7f138a213c006d345db35ef5b
Gitweb:        https://git.kernel.org/tip/0be4838f018c10d7f138a213c006d345db35ef5b
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Tue, 07 Dec 2021 18:50:01 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 28 Dec 2021 21:30:05 +01:00

x86/events/amd/iommu: Remove redundant assignment to variable shift

Variable shift is being initialized with a value that is never read, it
is being re-assigned later inside a loop. The assignment is redundant
and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211207185001.1412413-1-colin.i.king@gmail.com
---
 arch/x86/events/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 913745f..b15f7b9 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -161,7 +161,7 @@ static int get_next_avail_iommu_bnk_cntr(struct perf_event *event)
 
 	raw_spin_lock_irqsave(&piommu->lock, flags);
 
-	for (bank = 0, shift = 0; bank < max_banks; bank++) {
+	for (bank = 0; bank < max_banks; bank++) {
 		for (cntr = 0; cntr < max_cntrs; cntr++) {
 			shift = bank + (bank*3) + cntr;
 			if (piommu->cntr_assign_mask & BIT_ULL(shift)) {
