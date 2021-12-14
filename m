Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8F4746D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhLNPwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:52:23 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57828 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhLNPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:52:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 72C0BCE1995
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C5EC34601;
        Tue, 14 Dec 2021 15:52:18 +0000 (UTC)
Date:   Tue, 14 Dec 2021 10:52:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     cgel.zte@gmail.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] sched/fair: fix boolreturn.cocci warning
Message-ID: <20211214105216.1f313e72@gandalf.local.home>
In-Reply-To: <b1cb1fd9be34d2fcec2578e06facc4168de4f554.camel@perches.com>
References: <20211214113845.439392-1-deng.changcheng@zte.com.cn>
        <20211214091446.383ec08e@gandalf.local.home>
        <b1cb1fd9be34d2fcec2578e06facc4168de4f554.camel@perches.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 07:24:34 -0800
Joe Perches <joe@perches.com> wrote:

> Perhaps it is more a change for consistency than a fix for correctness.
> 
> $ git grep -P 'return\s+(?:true|false)' kernel/sched/ | wc -l
> 209

As with those other changes, it should be fixed when the function is
updated. No need to add the churn now.

-- Steve
