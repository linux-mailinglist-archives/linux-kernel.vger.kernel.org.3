Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3CD4A86A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351788AbiBCOgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:36:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351235AbiBCOdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:52 -0500
Date:   Thu, 03 Feb 2022 14:33:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QItYorZ8UQSDLZlgHz4lTwClZ+u7I3cQdYj5DO98KxU=;
        b=okdMUJ01H+DPaG0Pfehhzfo3G2pZ5zcM8G91NaF2CSAWAzG1lXrjroAmw153YVU7HuRoLm
        1r02fL5aMN9V+aWViqz94c29mZ98aZWm+vl+5uVosZaohhyf32of73z1wlMIXxyPr+ILdd
        DiAlzsi+ugX1r309fwPmvJm1JMITTmPSbsSZDJqYlODf/k32RaRMy0GUWeVnsLJ7bG8uXv
        4y0h4FgBo6Wcc2Fd7ZDUqC0o9RnNkifbYF5ACyF5QZkVR+L26fCGd9NzahddE0V2ZRS9aQ
        qHo51JcnE5PibSHueFcNcUSliSa19w4wO627HzEv2EPsiDTKXkE8tESwNY5zlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QItYorZ8UQSDLZlgHz4lTwClZ+u7I3cQdYj5DO98KxU=;
        b=yOpORoFTPukXYKNhwXUh2E6EwhjHsDd2R+jSU9DhfgCiCgQOHASIjJaL6BWVIHkOTevMxu
        mQfx/61C8Y8c6FCw==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Remove useless assignment to cpu variable
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124171253.22072-4-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-4-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <164389883099.16921.4725274995214771640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     930378d056eac2c96407b02aafe4938d0ac9cc37
Gitweb:        https://git.kernel.org/tip/930378d056eac2c96407b02aafe4938d0ac9cc37
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:41 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:34 +01:00

selftests/rseq: Remove useless assignment to cpu variable

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-4-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/param_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 699ad5f..cc2cfc1 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -368,9 +368,7 @@ void *test_percpu_spinlock_thread(void *arg)
 		abort();
 	reps = thread_data->reps;
 	for (i = 0; i < reps; i++) {
-		int cpu = rseq_cpu_start();
-
-		cpu = rseq_this_cpu_lock(&data->lock);
+		int cpu = rseq_this_cpu_lock(&data->lock);
 		data->c[cpu].count++;
 		rseq_percpu_unlock(&data->lock, cpu);
 #ifndef BENCHMARK
