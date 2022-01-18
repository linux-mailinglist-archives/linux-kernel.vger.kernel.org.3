Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D44492492
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbiARLSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:18:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35058 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiARLSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:18:10 -0500
Date:   Tue, 18 Jan 2022 11:18:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fn9ygYTqLFfV+Ie+MRMW4K6HS6Tmato9UGsJRMeZePg=;
        b=mJrdXPunEJH+NbkX+ihqZyyQ/YcBksIdMBRI6QRyPVGEnTVTaX0uAS3H+XOczNlBW5X+G2
        uY2n4NjhEXqUQJjggrQsOhDRlQHZmoI+o52a9QKGhl5bcX8EAAI2TcLIwVCaPmGDO5vngX
        abhblIpx87JdlGETmhNNFJDI2peC830sj5DVgQIzkzd6JJUW9lI2NtIEHiVN1ydqYMPvd8
        Oj1RZ+SbscJufQM0eR4nDi+9fUsLtvZ3ARs8eCFpw5GsaRSdt9KqqlbSh0MQpD6mP6Zhhn
        0iCiTG/wO73xqxEH1jHjGeZKR2T2hRbFPUGvrVp9BDNOD9N0/cGgmRLVHISeyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fn9ygYTqLFfV+Ie+MRMW4K6HS6Tmato9UGsJRMeZePg=;
        b=FPPg1zslR4yIKINWX4fblnQSkw21nPw5v1PG3PpehWU/V1H30ikdU4qrbpVcg7gp9rMABU
        oG3/P6Ixkkpg3OBA==
From:   "tip-bot2 for Hui Su" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] kernel/sched: Remove dl_boosted flag comment
Cc:     Hui Su <suhui_kernel@163.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220107095254.GA49258@localhost.localdomain>
References: <20220107095254.GA49258@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <164250468860.16921.1592195223294616313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     0e3872499de1a1230cef5221607d71aa09264bd5
Gitweb:        https://git.kernel.org/tip/0e3872499de1a1230cef5221607d71aa09264bd5
Author:        Hui Su <suhui_kernel@163.com>
AuthorDate:    Fri, 07 Jan 2022 17:52:54 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:10:00 +01:00

kernel/sched: Remove dl_boosted flag comment

since commit 2279f540ea7d ("sched/deadline: Fix priority
inheritance with multiple scheduling classes"), we should not
keep it here.

Signed-off-by: Hui Su <suhui_kernel@163.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lore.kernel.org/r/20220107095254.GA49258@localhost.localdomain
---
 include/linux/sched.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7a1f16d..7f8b449 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -614,10 +614,6 @@ struct sched_dl_entity {
 	 * task has to wait for a replenishment to be performed at the
 	 * next firing of dl_timer.
 	 *
-	 * @dl_boosted tells if we are boosted due to DI. If so we are
-	 * outside bandwidth enforcement mechanism (but only until we
-	 * exit the critical section);
-	 *
 	 * @dl_yielded tells if task gave up the CPU before consuming
 	 * all its available runtime during the last job.
 	 *
