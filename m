Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2D049F484
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346928AbiA1HkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:40:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346911AbiA1HkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:40:19 -0500
Date:   Fri, 28 Jan 2022 07:40:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643355618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ll+uJme3iIcM+zG07aIhG+7EbqfYIQE5F1Rx6NDd1U4=;
        b=1k8NsuiNFvoGTrIOrxHYyXx1vGpkqtybly20MrMarNYulVeS7Ih2JE+t4ygAFnwvduzvSV
        wxEsEcjYaLbMdmTB2uy6d37xtFdVXasRWE9Aeqa8ER1q8XYUDWHrf8IHA/Eb1VgtDSpLr9
        YeZqgAfD1b/eJUUM/MuEOZnhGhBwgB/o5pAgMIR69xkACOha50q1YX7327INtmGhZKNNT0
        T9K4JhdyyVaT2V46xDhMX7t38exkD2pqhaxzpgzn5UZYNo2msfCOSeE5LLwCvH1kK4IJPi
        rlDhy8MkI5SVoM++V/PkelD7y5/Kd7gRO7wEkr0UpvW4ZjAhVpfEuVcRrQpfEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643355618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ll+uJme3iIcM+zG07aIhG+7EbqfYIQE5F1Rx6NDd1U4=;
        b=cMT+lZZih7nlZP1TObjOV/wMUsmWHygk3xK1o4nBMSIwKCz2IZRfVPfdOJFXYG17pDgkxp
        724T8SX7sDkhWnDQ==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Export pelt_thermal_tp
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211028115005.873539-1-qais.yousef@arm.com>
References: <20211028115005.873539-1-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <164335561706.16921.5070884006412933278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     77cf151b7bbdfa3577b3c3f3a5e267a6c60a263b
Gitweb:        https://git.kernel.org/tip/77cf151b7bbdfa3577b3c3f3a5e267a6c60a263b
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 28 Oct 2021 12:50:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Jan 2022 12:57:18 +01:00

sched/core: Export pelt_thermal_tp

We can't use this tracepoint in modules without having the symbol
exported first, fix that.

Fixes: 765047932f15 ("sched/pelt: Add support to track thermal pressure")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211028115005.873539-1-qais.yousef@arm.com
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e4ae00..1d863d7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_thermal_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
