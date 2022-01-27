Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569B749EA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbiA0SXy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jan 2022 13:23:54 -0500
Received: from foss.arm.com ([217.140.110.172]:48012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244957AbiA0SXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:23:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D19A0113E;
        Thu, 27 Jan 2022 10:23:52 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D754F3F7D7;
        Thu, 27 Jan 2022 10:23:49 -0800 (PST)
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
In-Reply-To: <YfJu3Z9wKOAjLuad@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com> <20210811201354.1976839-3-valentin.schneider@arm.com> <20210817170925.2jwqvgvmqab2glwu@linutronix.de> <87czq573et.mognet@arm.com> <YfF9I5PcZJA5532B@linutronix.de> <87r18u2wr8.mognet@arm.com> <YfJu3Z9wKOAjLuad@linutronix.de>
Date:   Thu, 27 Jan 2022 18:23:44 +0000
Message-ID: <87o83x2g27.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/22 11:07, Sebastian Andrzej Siewior wrote:
> On 2022-01-26 18:10:51 [+0000], Valentin Schneider wrote:
>> > | 2021-08-11 21:13 +0100 Valentin Schneider    ∙ sched: Introduce migratable()
>> > | 2021-08-11 21:13 +0100 Valentin Schneider    ∙ arm64: mm: Make arch_faults_on_old_pte() check for migratability
> …
>> Heh, had forgotten about those - I'm happy to repost with the
>> s/migratable/is_migratable/. I also need to go back to those splats I got
>> on my emag and fix the PMU/GPIO warnings...
>
> Now that I look at it gain, you might want to drop #1 and then #2 would
> switch to cant_migrate(). This might work…
>

Wasn't aware of cant_migrate(), that does look even better. Lemme give it a shot.

> Sebastian
