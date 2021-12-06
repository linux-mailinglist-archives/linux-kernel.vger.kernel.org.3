Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D5469FE9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376886AbhLFPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390423AbhLFPmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:42:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB35C0A885D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:26:21 -0800 (PST)
Date:   Mon, 6 Dec 2021 16:26:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638804379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G79sw6/0z/0eODfTOvxtYkj/vnuVGjvdh1Kx9RSIc3g=;
        b=A30NItyk6DCAGtHoyWNHltXT66ie8O6LRiAGq288j5FqCA+RrXXaUJUwEa3ZVrKxQK44jt
        wVYaI+G7mwCBte3q2Xa48m/IxgCPqOgwUpJTqIMxDqb04+2fcj44JrmdoScUqTRBhO7VrA
        eKdmdCdyEEuMiPTVOS0pXzublm2Sg0fg3U9DfV2CmzzwJ6qS9BhUvlAZ0bi0jO4dSdKCDk
        eOOcG1wdlq+rWlkT4Vr4JaV9hH5OS7/HXHeYbgKoWY+604x0QGDw9f73iQX/JXrX3s82JO
        yiKQReowghtYiyyD2n3A8DUfJEryb9CXygoudT3a8qt9yZYlSDyGuYy7F9dD7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638804379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G79sw6/0z/0eODfTOvxtYkj/vnuVGjvdh1Kx9RSIc3g=;
        b=QVNn/Q73anjzIpJR/0TqLBSV3a8VdMUxd2MRhC3NKXfHz0v3DJFfWz+3WXKBOjPRl2cW1O
        J2ZIkCjXl8ROrBDg==
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
Message-ID: <20211206152618.avqghqegykwjnxm5@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
 <20211202211253.GC16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211202211253.GC16608@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-02 22:12:53 [+0100], Peter Zijlstra wrote:
> Thanks! (fixed up that first thiny), lemme feed it to the robots.

Thank you. I see bots' commit mail for 1-9. I don't see them for 10+11
but then I also don't see those two in your tree.
What should I do with them?

Sebastian
