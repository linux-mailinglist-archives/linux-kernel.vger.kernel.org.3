Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2F64A9FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiBDTJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:09:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiBDTJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:09:55 -0500
Date:   Fri, 4 Feb 2022 20:09:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644001793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ztGWZd/+VDoCCxVFgzszVEd5z8zhx+3EJ51jPTdbrY=;
        b=ABkPPnM+svtgEQcLiOg76O0Tt6etvRLaHAvB4ReM8bX0OytfvVx/JA9zVC6bTtICbq9QN8
        xK2BxvhwIvmbb3nBJVEH0y7rywShdnXtp5y2KXrBMHUM8L0473qKK78ACBTtCFnYiLmo3N
        n6jhqLRbcUb0ArxCBi6KIoftmGXoGzepFFceLNRmLePZI9DQo6LCJCIFJNGkPhGPPj/Rwu
        TTDntG1U+fjhvoVifv0vLqLW7b/1k0B+S1LoSXqD3shjPgyMuj733DpnTIqrMl9QVDLUH1
        wcGZDsOENzzsQvBTEGvCS8pwQzJKx2QfiUG7JGFKFTqFqhI+9tawKy1boAlr3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644001793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ztGWZd/+VDoCCxVFgzszVEd5z8zhx+3EJ51jPTdbrY=;
        b=Tk7lxMKmF2C9Aaui4dGo82bDhdyCtPzsOOyxQaRhJoGNs3dUiJLZ5l5mQ2UNsiWHXrK5BD
        EUR4qs8bMq8kpxAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [PATCH v4] arm64: mm: Make arch_faults_on_old_pte() check for
 migratability
Message-ID: <Yf16AFzch6B4o/uv@linutronix.de>
References: <20220127192437.1192957-1-valentin.schneider@arm.com>
 <Yf12lXHtPVXgAoFL@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yf12lXHtPVXgAoFL@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-04 18:55:17 [+0000], Catalin Marinas wrote:
> 
> The patch looks alright but what's the plan with it? Does it go into the
> preempt-rt tree, mainline? It's not a fix to be queued now, so:

It would be nice if if it could go mainline, too.

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Sebastian
