Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA0246618C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345982AbhLBKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:40:13 -0500
Received: from foss.arm.com ([217.140.110.172]:33306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345449AbhLBKkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:40:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D45E142F;
        Thu,  2 Dec 2021 02:36:49 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44A8B3F7D7;
        Thu,  2 Dec 2021 02:36:48 -0800 (PST)
Date:   Thu, 2 Dec 2021 10:36:45 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/uclamp: Fix rq->uclamp_max not set on first enqueue
Message-ID: <20211202103645.rjzjsrb7szue3j4l@e107158-lin.cambridge.arm.com>
References: <20211125165233.1425633-1-qais.yousef@arm.com>
 <87wnkvb35n.mognet@arm.com>
 <20211130112356.25bm5s66sywtdgw4@e107158-lin.cambridge.arm.com>
 <875ys9bzcz.mognet@arm.com>
 <20211130154116.w5wjtbc4shpwcoku@e107158-lin.cambridge.arm.com>
 <296f08f4-f229-ec83-5dae-b8b499b81d49@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <296f08f4-f229-ec83-5dae-b8b499b81d49@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/21 10:20, Dietmar Eggemann wrote:
> On 30.11.21 16:41, Qais Yousef wrote:
> > On 11/30/21 12:29, Valentin Schneider wrote:
> >> On 30/11/21 11:23, Qais Yousef wrote:
> >>> Hi Valentin
> >>>
> >>> On 11/26/21 10:51, Valentin Schneider wrote:
> >>>> On 25/11/21 16:52, Qais Yousef wrote:
> >>>>> Commit d81ae8aac85c ("sched/uclamp: Fix initialization of struct
> >>>>> uclamp_rq") introduced a bug where uclamp_max of the rq is not reset to
> >>>>> match the woken up task's uclamp_max when the rq is idle. This only
> >>>>> impacts the first wake up after enabling the static key. And it only
> 
> LGTM.
> 
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks!

--
Qais Yousef
