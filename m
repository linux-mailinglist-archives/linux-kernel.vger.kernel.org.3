Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F750A875
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391545AbiDUSwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391525AbiDUSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:52:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6B162E1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35F8DB82870
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16044C385A5;
        Thu, 21 Apr 2022 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650566995;
        bh=vUwF+jiRY0HlIRxcoc5KSc+V9HpW3TZPlhrBSGwnsxs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p5oxIyp/Odc9gfIf1LgMsuTmdW7ZI2a1ocCs6BYTa0CfR0g005pfX97pyh1w0u8Cn
         +Deu2b8lFX9UMVOkUfClfHcBGZu+VNnzTKmV3WEJc0xE1p4tBGJc7PGtM+KeedHGRj
         rLbOnErbadGA3p74byWTCrQPu9i1tnfFvyuZYAHg=
Date:   Thu, 21 Apr 2022 11:49:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nico Pache <npache@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v9] oom_kill.c: futex: Delay the OOM reaper to allow
 time for proper futex cleanup
Message-Id: <20220421114954.25b88bf0bbabbbc67a66f8d7@linux-foundation.org>
In-Reply-To: <5653e751-f81d-f64e-b4b5-b251949d13d9@redhat.com>
References: <20220414144042.677008-1-npache@redhat.com>
        <874k2mts8p.ffs@tglx>
        <5653e751-f81d-f64e-b4b5-b251949d13d9@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 12:25:58 -0400 Nico Pache <npache@redhat.com> wrote:

> can you please update the link when you add the ACKs.
> 
> Here is a more stable link:
> [1] https://elixir.bootlin.com/glibc/glibc-2.35/source/nptl/allocatestack.c#L370

Done.  Thanks, all.
