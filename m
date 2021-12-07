Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3D746BDBD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbhLGOea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhLGOe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:34:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB85C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:30:58 -0800 (PST)
Date:   Tue, 7 Dec 2021 15:30:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638887457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j7FSja05TcNMG1IM6zYFLnpLO1M2NBLUmO8T/fP2duk=;
        b=j3T8wThMnfkr4JJfVWVCKL9YEDp3QSbKkGGw7UXx9FJNkIUpVOvypAopG2Xpt9OHu4k4Ig
        zNftZtchY4nV2V8E8fz9OC3Bx5BxY34jof4/tcUFQHymNO3RexvDpL++VijSXvHR+zWxhk
        XKYhaDculj7kCkBGHItZmLH48nC3gPguJpfbo+TiPfpMAN1KI+1u3Q0LEriOPLnwKMsD/9
        EdVBbgaSm+lTlRZ9FA/Vp3xMzCHd/jV0szRBqed3Z+D7VTlQudS8npGvFGzwWgj8y1pH79
        G+EgC6LRlU5cYdAapnikKI+wKgioaPEaowCcT6WxhWSXkD2lj6B/vk1oLEoO+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638887457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j7FSja05TcNMG1IM6zYFLnpLO1M2NBLUmO8T/fP2duk=;
        b=rEDsDwmjfvfyW2pz9NzCmn/ExPMe7U3ba3jeElB6HYCztyuOuvD4srfAgBdssNWub1Tcxc
        L+eDxmAHj7ivmbDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/11] lockdep: Unbreak lockdep's selftest work on
 PREEMPT_RT.
Message-ID: <20211207143055.mxrpyo5b62kvleld@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
 <20211202211253.GC16608@worktop.programming.kicks-ass.net>
 <20211206152618.avqghqegykwjnxm5@linutronix.de>
 <Ya4vkmFek71v88+t@hirez.programming.kicks-ass.net>
 <Ya9tguFHUePjEh/W@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ya9tguFHUePjEh/W@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-07 15:19:46 [+0100], Peter Zijlstra wrote:
> Still now clue how they got lost, but it should be sorted now.

Thank you good Sir. There is still the possibility that you had a better
solution :)

Sebastian
