Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9FA49EB02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245532AbiA0T2I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jan 2022 14:28:08 -0500
Received: from foss.arm.com ([217.140.110.172]:51768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232674AbiA0T2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:28:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD662113E;
        Thu, 27 Jan 2022 11:28:06 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B31F53F7D7;
        Thu, 27 Jan 2022 11:28:03 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3 2/4] sched: Introduce migratable()
In-Reply-To: <YfF9I5PcZJA5532B@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com> <20210811201354.1976839-3-valentin.schneider@arm.com> <20210817170925.2jwqvgvmqab2glwu@linutronix.de> <87czq573et.mognet@arm.com> <YfF9I5PcZJA5532B@linutronix.de>
Date:   Thu, 27 Jan 2022 19:27:56 +0000
Message-ID: <87v8y5nflv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/22 17:56, Sebastian Andrzej Siewior wrote:
> On 2021-08-22 19:14:18 [+0100], Valentin Schneider wrote:
>> Thanks for carrying it through, I'll keep that change for the next version.
>
> Just a quick question. This series ended with 3 patches in my queue. It
> got decimated further due to Frederic series which ended up in
> v5.17-rc1. I still have
> | 2021-08-11 21:13 +0100 Valentin Schneider    ∙ sched: Introduce migratable()
> | 2021-08-11 21:13 +0100 Valentin Schneider    ∙ arm64: mm: Make arch_faults_on_old_pte() check for migratability
>
> what do we do about these two? I could repost these two if there are no
> objections…
>

While I'm at it, I see you're still carrying

  6ab5bb09040d arm64/sve: Make kernel FPU protection RT friendly

If you're OK with it, I'll repost that:
https://lore.kernel.org/lkml/20210722175157.1367122-1-valentin.schneider@arm.com/

> Sebastian
