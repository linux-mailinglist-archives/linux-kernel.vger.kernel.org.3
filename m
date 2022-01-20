Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4449550B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347153AbiATTrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:47:10 -0500
Received: from foss.arm.com ([217.140.110.172]:51358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232634AbiATTrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:47:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AE916D;
        Thu, 20 Jan 2022 11:47:08 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE5563F774;
        Thu, 20 Jan 2022 11:47:06 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Keeping <john@metanate.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/rt: Plug rt_mutex_setprio() vs push_rt_task() race
In-Reply-To: <20220120194037.650433-1-valentin.schneider@arm.com>
References: <20220120194037.650433-1-valentin.schneider@arm.com>
Date:   Thu, 20 Jan 2022 19:47:01 +0000
Message-ID: <8735li6vgq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/22 19:40, Valentin Schneider wrote:
> Link: http://lore.kernel.org/r/Yb3vXx3DcqVOi+EA@donbot
> Fixes: a7c81556ec4d ("sched: Fix migrate_disable() vs rt/dl balancing")
> Reported-by: John Keeping <john@metanate.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

@John: it's slightly different than the few things we got you to try out,
so I didn't keep your tested-by, sorry!
