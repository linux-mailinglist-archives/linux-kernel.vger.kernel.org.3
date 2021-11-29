Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7D461CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243629AbhK2RwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:52:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349201AbhK2RuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:50:22 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638208022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2ew7rEiiBoKhPdB9XQCIND0i0U5BJKR1mY++87O42tk=;
        b=tFv3XIGUAOE/AP2IkfazYqoVZ8KK3UF/LI1axA2dWYK3Bti0/NTh3dktHBvND838AuwoTe
        hTnQX7h0d3SlL3DZIb0rXUWfMNnWmrY9EMbbEkGps1ZLe8KBu9fIgGgcq+2vY234vIYbux
        y8+Lk4Lml2wrL5t/Ce7/vP8vC/g2GgSGdc8nXcFS8S4toVrm6KXy2aDCM8DcFiGsbQEups
        gwGc8Xu6Wuk/QqAV4LFBeJ+Fef5EyRa/9EA5eMAt8zat9UOKgbsrNBBrpM1+F1mFsi2saf
        di/ljSutSsNfpl1CsYcPDen/jMDyXds2GY3easEtV9TxW28f2afOvWJ5TTCuGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638208022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2ew7rEiiBoKhPdB9XQCIND0i0U5BJKR1mY++87O42tk=;
        b=LlWgj+Qsh71MFHE26PL58yRU81Ftq0JvrWJim9rh08kIa2rLhesucwWsuzTmFclYuITmr9
        G+7UtvXQHNHr/+BQ==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 00/11] lockdep: Unbreak lockdep's selftest work on PREEMPT_RT.
Date:   Mon, 29 Nov 2021 18:46:43 +0100
Message-Id: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mini-series unbreaks lockdep's selftest on PREEMPT_RT.
The last two are needed to compile the rtmutex based spinlock
implementation which is used on PREEMPT_RT.

Sebastian


