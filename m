Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59C5489D33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiAJQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:11:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42798 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:11:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4A16B81661;
        Mon, 10 Jan 2022 16:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614E3C36AE5;
        Mon, 10 Jan 2022 16:11:43 +0000 (UTC)
Date:   Mon, 10 Jan 2022 11:11:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <20220110111142.7900913e@gandalf.local.home>
In-Reply-To: <YdxZhsQ2NQ3dpUVR@hirez.programming.kicks-ass.net>
References: <20220107025212.177040-1-xiujianfeng@huawei.com>
        <YdxZhsQ2NQ3dpUVR@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 17:06:30 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jan 07, 2022 at 10:52:12AM +0800, Xiu Jianfeng wrote:
> > Make use of struct_size() helper instead of an open-coded calculation.
> > There is no functional change in this patch.  
> 
> Why ?!? This makes something that was trivial to read into something
> weird.

Please take his last patch (which only modifies the update to size) and
makes it more robust.

  https://lore.kernel.org/all/20220110012354.144394-1-xiujianfeng@huawei.com/

Which is much easier to read.

We should really replace all open coded struct_size() code.

-- Steve
