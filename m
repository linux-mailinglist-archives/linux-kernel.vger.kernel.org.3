Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5688F54E7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378162AbiFPQpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377280AbiFPQoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:44:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C743289A6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE656B82346
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1E6C34114;
        Thu, 16 Jun 2022 16:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655397856;
        bh=EolkjpCPZI2MjBzt62Su7lhjjW4xiamLc2eTna4D4RY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t/4p6pGthRLYB+t18wzKMBvG8YhBSmOj9OtlHdRZkkzCg6TPbfVT8Ym9er2q+OG/T
         eU5+83JXJEKYQUx/QfhsWf37Dp7FF1iKXdivRNJra/69Vw+popfCVdqFGw90ruWGPR
         dZTvPbCQ7oUJXojmCDmvO1AOOW2IKp1m5X9pbW2IYE10EWjb7spFHlCFQI9H23suvy
         9LNu+aVdWeUD7Mi9cjocgqhLlSEMBpqZoT6Qp0r6r7DaA+HCQbNR4s+qfLMezv5Tf5
         oN/ocqb4jVxWj1pdBu8t2496S3rgRAm/yaldO+WHgA735SDWRM/MIkHZsEsv7UXoIa
         uTsl0FD9FSzQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1DDD05C0546; Thu, 16 Jun 2022 09:44:16 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:44:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/pmladek.2022.06.15a
 133/140] vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to
 __kasan_check_read() leaves .noinstr.text section
Message-ID: <20220616164416.GA2130702@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202206160411.v3iL3YC0-lkp@intel.com>
 <20220615204039.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220615211717.GA972937@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNMswUJhqfttxZGbkfN7X5d5FLiS1yPXzzGDivLtWDB9=g@mail.gmail.com>
 <20220616134021.GP1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616134021.GP1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 06:40:21AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 16, 2022 at 10:19:18AM +0200, Marco Elver wrote:
> > On Wed, 15 Jun 2022 at 23:17, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Jun 15, 2022 at 01:40:39PM -0700, Paul E. McKenney wrote:
> > > > On Thu, Jun 16, 2022 at 04:26:16AM +0800, kernel test robot wrote:
> > > > > tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/pmladek.2022.06.15a
> > > > > head:   0ba7324b44282870af740a5a121add62c7f5f730
> > > > > commit: db21b02f8044e812f8a5e3811f602409290e3ede [133/140] context_tracking: Convert state to atomic_t
> > > > > config: x86_64-randconfig-r003-20220516 (https://download.01.org/0day-ci/archive/20220616/202206160411.v3iL3YC0-lkp@intel.com/config)
> > > > > compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> > > > > reproduce (this is a W=1 build):
> > > > >         # https://github.com/ammarfaizi2/linux-block/commit/db21b02f8044e812f8a5e3811f602409290e3ede
> > > > >         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
> > > > >         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/pmladek.2022.06.15a
> > > > >         git checkout db21b02f8044e812f8a5e3811f602409290e3ede
> > > > >         # save the config file
> > > > >         mkdir build_dir && cp config build_dir/.config
> > > > >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > > > >
> > > > > If you fix the issue, kindly add following tag where applicable
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > >
> > > > > All warnings (new ones prefixed by >>):
> > > > >
> > > > > >> vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to __kasan_check_read() leaves .noinstr.text section
> > > > > >> vmlinux.o: warning: objtool: __ct_user_enter+0x7f: call to __kasan_check_read() leaves .noinstr.text section
> > > >
> > > > Marco, Dmitry, my guess is that this is due to the ct->active check in
> > > > both functions.  Are we supposed to do something to make this sort of
> > > > thing safe for KASAN?
> > >
> > > This time actually CCing Marco and Dmitry...
> > 
> > It's due to the atomic_read()s within the noinstr function. Within
> > noinstr you can use arch_atomic_read() to avoid the instrumentation.
> 
> Thank you, will fix!

And please see below for an alleged fix.

							Thanx, Paul

------------------------------------------------------------------------

commit 81e24ca26ee9933bcacf67a61e3f6ae41a025442
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Jun 16 09:30:37 2022 -0700

    context_tracking: Use arch_atomic_read() in __ct_state for KASAN
    
    Context tracking's __ct_state() function can be invoked from noinstr state
    where RCU is not watching.  This means that its use of atomic_read()
    causes KASAN to invoke the non-noinstr __kasan_check_read() function
    from the noinstr function __ct_state().  This is problematic because
    someone tracing the __kasan_check_read() function could get a nasty
    surprise because of RCU not watching.
    
    This commit therefore replaces the __ct_state() function's use of
    atomic_read() with arch_atomic_read(), which KASAN does not attempt to
    add instrumention to.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Frederic Weisbecker <frederic@kernel.org>
    Cc: Marco Elver <elver@google.com>

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 0aecc07fb4f50..81c51e5f03143 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -49,7 +49,7 @@ DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
 static __always_inline int __ct_state(void)
 {
-	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
+	return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
 }
 #endif
 
