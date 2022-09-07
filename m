Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316025B0D8F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiIGT4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIGT4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:56:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F087F8D3F8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fR+uY3bGGpxBS89mrcSW6oj49yHUnTRga6zx1F+991A=; b=KiYpUsS9UkanSdseuyWsIDa6Mg
        2WoiL8b/BvTFlWqwKfoJzHjhyUVFYuBMXqZ5zjz+H7DEkVr4dDyrgAxgv/DPrJFpYglSTXzK6OKPj
        6MrowD6ihkMrkZCGXrNoxCLbM5Fy9SQknaELyggJMFhXs7TTeClJto7LnCaNKmnoU1w3/X5t25UBx
        l2OmZ5NfcGfimnx8rMEdvaRBwGWaN+b0UrsxEQ4/fASTJTP/5NLR2ksw1gOOsWkJCgBkj89SqKBkE
        qJy9p89oiiF5Ll3fNTZ5SY26Xsxp3aVHvyS0oJyKGmh1cQDEY+KzCpohRnCij/McWb48X7rLH8B3C
        EL98RSAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oW19L-00Bhzo-5R; Wed, 07 Sep 2022 19:55:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A723E300074;
        Wed,  7 Sep 2022 21:55:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D95D2B9DA6E4; Wed,  7 Sep 2022 21:55:48 +0200 (CEST)
Date:   Wed, 7 Sep 2022 21:55:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        kernel test robot <lkp@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:sched/psi 11/11]
 include/linux/cgroup-defs.h:432:38: error: 'NR_PSI_RESOURCES' undeclared
 here (not in a function)
Message-ID: <Yxj3RN9SXl6Azs7G@hirez.programming.kicks-ass.net>
References: <202209070242.7EuRnstk-lkp@intel.com>
 <e95c6e55-a023-b6f7-1dce-4195dc22114a@bytedance.com>
 <Yxi4os4PUWSARTS/@slm.duckdns.org>
 <YxjzAnztFtvrtr96@hirez.programming.kicks-ass.net>
 <YxjzM9vv55meOAPU@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxjzM9vv55meOAPU@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:38:27AM -1000, Tejun Heo wrote:
> On Wed, Sep 07, 2022 at 09:37:38PM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 07, 2022 at 05:28:34AM -1000, Tejun Heo wrote:
> > > On Wed, Sep 07, 2022 at 10:45:55AM +0800, Chengming Zhou wrote:
> > > > 2. This patchset depends on Tejun's commit e2691f6b44ed ("cgroup: Implement cgroup_file_show()") in linux-next
> > > > 
> > > >    Maybe peterz-queue should include that first? I don't know what's the normal way to handle.
> > > 
> > > FYI, this patch is in the Greg's driver-core/driver-core-next branch. If
> > > it'd be better to route these through the cgroup tree, let me know.
> > 
> > I can base sched/psi off of sched/core and driver-core-next and do a
> > separate late pull for it I suppose.
> > 
> > I'm guessing that is more or less what you'd end up doing too, right?
> 
> Yeap.

OK, I just pushed out a new sched/psi which is based on a combination of
sched/core and driver-core-next. Lets see if the robots have more
complaints ;-)

