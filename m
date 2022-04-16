Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D350353B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiDPIi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDPIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:38:48 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100FC90274;
        Sat, 16 Apr 2022 01:36:18 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AA6DA2CC;
        Sat, 16 Apr 2022 08:36:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AA6DA2CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650098177; bh=G/+2Nu5ER114v6pty794yAv+1PY/rd+Cq6aWyeNZqIE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D7E4h7Kxt9haXc+3y8+l4uaJ022BC8fGGWk2xAqF78EoQtrLTMyzXu86SvrhyUgV+
         rQr5UBsEZFVtDPjixO6lfj6bl4kNATXBCCxo1XPxp3hJXsXr3H0w7d/17szx97u/nH
         2XnauIJPiLM9NMf6F4Kb2YlHmAv3h+VYK+LokYZyqjdG6gTPLMx3Ol7KYrnLA8jN+c
         QDjxWOuKPo2AZDBZ8FkK9FodInv3Rwe7bJFZfmog6O/Z+BGYu3pxskM8S5E2Vv2+7p
         0CQOB2QRIGVlYS8XaWrH8H+t6U7pL0I2n+DAIjrEtSk5gVATfjwCUlqDZolzZ+FjPs
         WQGqCIYCZ/53Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "brookxu.cn" <brookxu.cn@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] docs/scheduler: Change unit of cpu_time and rq_time to
 nanoseconds
In-Reply-To: <YlA8AEfqK6eRnAPO@hirez.programming.kicks-ass.net>
References: <1649410266-32360-1-git-send-email-brookxu.cn@gmail.com>
 <YlAub2NXBPeNcyAS@casper.infradead.org>
 <YlA8AEfqK6eRnAPO@hirez.programming.kicks-ass.net>
Date:   Sat, 16 Apr 2022 02:36:12 -0600
Message-ID: <87h76t4e83.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> And that's 15 years and at least one SCHEDSTAT_VERSION ago (although
> this change itself didn't bump the version).
>
> So I'm thinking we can update the documentation and forget about this.

OK, I've applied the patch, thanks.

jon
