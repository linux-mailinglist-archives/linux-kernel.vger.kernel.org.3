Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A60446B7EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhLGJwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:52:05 -0500
Received: from foss.arm.com ([217.140.110.172]:55490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234407AbhLGJwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:52:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 359D41042;
        Tue,  7 Dec 2021 01:48:33 -0800 (PST)
Received: from ubiquitous (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 487663F73B;
        Tue,  7 Dec 2021 01:48:32 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:48:26 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2 1/2] sched/fair: Fix asym_fits_capacity() task_util
 type
Message-ID: <20211207094826.GA852689@ubiquitous>
References: <20211118141411.2623521-1-vincent.donnefort@arm.com>
 <Ya4qJHxUbKMzl04d@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya4qJHxUbKMzl04d@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 04:20:04PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 18, 2021 at 02:14:10PM +0000, Vincent Donnefort wrote:
> > task_util is an unsigned long value, compared with a CPU capacity which is
> > unsigned long as well. There's no need for an intermediate implicit int
> > cast.
> > 
> > Fixes: b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")
> 
> Do either of these patches actually *fix* anything? Afaict they're an
> absolute no-op, even in terms of code-gen due to the promotion rules.
> 
> Yes, its arguably nicer to not rely on those implicit promotions etc..
> but I don't think this warrants a Fixes tag or even being split in two
> patches.
> 
> Hmm?

As far as I know it doesn't change anything functionally speaking. So yeah,
let's consider it as a cleanup. I'll merge the changes and drop the Fix tag.
