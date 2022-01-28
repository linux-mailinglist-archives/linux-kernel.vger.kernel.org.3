Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3FD49F486
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346982AbiA1Hk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346930AbiA1HkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:40:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C36AC061714;
        Thu, 27 Jan 2022 23:40:20 -0800 (PST)
Date:   Fri, 28 Jan 2022 07:40:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643355619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hrx152VwPOY2pFSr+OZw3dagCRYFwL5f1DQttlQdI0w=;
        b=yLl5p156817q3zG3Yajjd3MJcWG3sfA3sNVBd+u8lgJYnb3EZGvLXr/ECYaxvsXVR0glf3
        8dFkSlDm9rSY6c3hbzfHL1WTMwXf0qqXHlkDcqigLLTNBZT+84spJMVLUVGGySy5b3vOea
        nY9uel7nlFxEdeJcks+U/sZyn0jAQxes8zQ9spCFdLL1sVk2U/r5i9k4m84LRzs7L+3+ze
        r3BjRi0Da2rEeAwpyHqigdUH7I0boPjPrWFk7ZsuYVQaQ2X6Gu0GB8quzkm1Fauq/MfMWY
        lm3S8ewbHPPhXaOHn1Rtd1xTbdB8yTfwBkWFT7zc6DA7hVXeJclubaZIoPWOMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643355619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hrx152VwPOY2pFSr+OZw3dagCRYFwL5f1DQttlQdI0w=;
        b=zwdk2Gt3kaZ6oJbdI3OLMRUcrOZ7pnaT5Nj7rp/zLDqnwkCM0FYqI5FGEAnEdHHvJlsgsA
        Is4w+QrIQB5iSfCw==
From:   "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] MAINTAINERS: add Suren as psi co-maintainer
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220117120317.1581315-1-hannes@cmpxchg.org>
References: <20220117120317.1581315-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Message-ID: <164335561813.16921.7338748619322663181.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     16c8fd64c31c708c82f91dc529d3aae716867e65
Gitweb:        https://git.kernel.org/tip/16c8fd64c31c708c82f91dc529d3aae716867e65
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Mon, 17 Jan 2022 07:03:17 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Jan 2022 12:57:18 +01:00

MAINTAINERS: add Suren as psi co-maintainer

Suren wrote the poll() interface, which is a significant part of the
psi code and represents a large user of psi itself (Android). It's a
good idea to have him look at psi patches as well, and it's good to
have two people following things in case one of us is traveling.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220117120317.1581315-1-hannes@cmpxchg.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c9..07b0862 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15504,6 +15504,7 @@ F:	drivers/net/ppp/pptp.c
 
 PRESSURE STALL INFORMATION (PSI)
 M:	Johannes Weiner <hannes@cmpxchg.org>
+M:	Suren Baghdasaryan <surenb@google.com>
 S:	Maintained
 F:	include/linux/psi*
 F:	kernel/sched/psi.c
