Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E75F497FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiAXMkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:40:01 -0500
Received: from foss.arm.com ([217.140.110.172]:60576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238278AbiAXMkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:40:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDB02D6E;
        Mon, 24 Jan 2022 04:39:59 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71E0E3F774;
        Mon, 24 Jan 2022 04:39:58 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Keeping <john@metanate.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/rt: Plug rt_mutex_setprio() vs push_rt_task() race
In-Reply-To: <20220121194718.5e32bc19.john@metanate.com>
References: <20220120194037.650433-1-valentin.schneider@arm.com> <8735li6vgq.mognet@arm.com> <20220121194718.5e32bc19.john@metanate.com>
Date:   Mon, 24 Jan 2022 12:39:56 +0000
Message-ID: <878rv5489v.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/22 19:47, John Keeping wrote:
> On Thu, 20 Jan 2022 19:47:01 +0000
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>
>> On 20/01/22 19:40, Valentin Schneider wrote:
>> > Link: http://lore.kernel.org/r/Yb3vXx3DcqVOi+EA@donbot
>> > Fixes: a7c81556ec4d ("sched: Fix migrate_disable() vs rt/dl balancing")
>> > Reported-by: John Keeping <john@metanate.com>
>> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>  
>> 
>> @John: it's slightly different than the few things we got you to try out,
>> so I didn't keep your tested-by, sorry!
>
> I ran a test with this version as well and as expected this does indeed
> fix the issue, so this is also:
>
> Tested-by: John Keeping <john@metanate.com>

Thanks for testing this again!
