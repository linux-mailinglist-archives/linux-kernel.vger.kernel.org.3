Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD54E6834
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352433AbiCXR7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352424AbiCXR7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:59:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06872AF1DE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Cjz5MnPVg9Jg8YoFDVs5ilr8lwwIng9j6n3Dgw2BtI=; b=hX1Hl5PP5OUh2rwAf/B++DWVXh
        X6pmJbWhfZXVmKY0depjhtJsdKlZUKR3q8kk/mvlwC+SpEOQoJ9Dtz/4y+ldtcfXLfDGyLJ3Hv/Ib
        3/yJ+XACw0PR4wqp2mGoHQDVXqB9ixKtrgcjnBuBh0ssnhnpoBFJHyjc56F3uzvvD2uIyjHGcCkR2
        zAzOjkU1TApg+C6ZGgIHM+PyPNN18Ugxq/+5fqg9W9YbwWeBX5MAG01HKTH4bZqGRC7A2MSJOLr1u
        PMdQjZQY4/Bea9gziXlkYYWfrvxNmO6YsyEnnFrBOTa7wWPx9iRjDGg9TpZXmjqWkhKCVjMfxGRcJ
        J0jgIiIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXRil-00DdU7-KJ; Thu, 24 Mar 2022 17:58:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E6A5986205; Thu, 24 Mar 2022 18:58:01 +0100 (CET)
Date:   Thu, 24 Mar 2022 18:58:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:sched/core] BUILD SUCCESS
 3387ce4d8a5f2956fab827edf499fe6780e83faa
Message-ID: <20220324175801.GJ8939@worktop.programming.kicks-ass.net>
References: <6238fde0.Qe5umewxqwiDe2GE%lkp@intel.com>
 <YjkHkb7joeu5GCto@dev-arch.thelio-3990X>
 <24dd031a-8ea7-5f01-4d80-3fb30d212c8a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24dd031a-8ea7-5f01-4d80-3fb30d212c8a@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:39:41AM +0800, Chen, Rong A wrote:
> On 3/22/2022 7:17 AM, Nathan Chancellor wrote:
> > Hello,
> > 
> > On Tue, Mar 22, 2022 at 06:36:16AM +0800, kernel test robot wrote:
> > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> > > branch HEAD: 3387ce4d8a5f2956fab827edf499fe6780e83faa  headers/prep: Fix header to build standalone: <linux/psi.h>
> > > 
> > > elapsed time: 730m
> > > 
> > > configs tested: 114
> > > configs skipped: 3
> > > 
> > > The following configs have been built successfully.
> > > More configs may be tested in the coming days.
> > > 
> > > gcc tested configs:
> > ...
> > > arm                              allyesconfig
> > > arm                              allmodconfig
> > 

> > Are you sure these configurations built sucessfully?

...

> Thanks for your reminding, the problem commit is 4ff8f2ca6ccd
> ("sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h
> dependencies"),
> the bot has sent two build reports related to it:
> 
>   https://lore.kernel.org/all/202203152116.qphmikIZ-lkp@intel.com/
>   https://lore.kernel.org/all/202203152144.uFQqgVUf-lkp@intel.com/
> 
> and more reports were stopped to avoid too many noise, like below one:

...

> We'll adjust the strategy avoid blocking some important reports.

Oh *PLEASE* never report a branch as building if there's errors.
It could be I (force) push a branch multiple times before I get any
0day reports back (0day has gotten *soooo* slow) so I only ever look at
the latest report -- possibly days later.

If you then falsly report the branch as being good, because you're
suppressing errors, things *will* go bad.


