Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4324D1F40
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245268AbiCHRmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349225AbiCHRmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:42:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E345574A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:41:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1E0061389
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EE3C340F4;
        Tue,  8 Mar 2022 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646761276;
        bh=p6KlrMRMnYTHTzTImYZR0x+q7YuvtOChjw2m1PNis14=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BVSNoou6eQpBzpktK8b99C/dRr6Z8fHEt/4ONAzNGvKJjvrsENdU57luOZjYSneFY
         oLCZzvgF+8sVIcTr2ydDr7DbO7wCajG/11rD6L40LUWpcBMXgnahnZR8ay1OB/altg
         mJJt/7X+3Y5je02CLGsBaL3PVffxYz1izuJOn3FGaK7xppLctfsRYWbaJd3tcSx84s
         jw40s21XkoN9ldn3JJXg5iWvk9X6g/V7RlUaM/hC7PlZGJKBfZRsN+okXDA6HeziIZ
         qIe2cDc4newDW/dH86cj6V6ree5DcILlPMlHNIYbPOBhzkmd0+f7452EvEh+wV/oPD
         3wNRVDr7jhgtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D05A15C08A0; Tue,  8 Mar 2022 09:41:15 -0800 (PST)
Date:   Tue, 8 Mar 2022 09:41:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/dev 82/84]
 kernel/rcu/tree.c:2678:17: error: implicit declaration of function
 'rcu_tasks_classic_qs'
Message-ID: <20220308174115.GU4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202203082147.h7DGjo3z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203082147.h7DGjo3z-lkp@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 09:15:35PM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
> head:   fb8d1afe45bd6fcb50dff8bac4636725358fde94
> commit: c8c42c80febd4e6d346f7f62958300eb8205aa31 [82/84] rcu-tasks: Make Tasks RCU account for userspace execution
> config: arm-oxnas_v6_defconfig (https://download.01.org/0day-ci/archive/20220308/202203082147.h7DGjo3z-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/c8c42c80febd4e6d346f7f62958300eb8205aa31
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
>         git checkout c8c42c80febd4e6d346f7f62958300eb8205aa31
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/rcu/tree.c: In function 'rcu_sched_clock_irq':
> >> kernel/rcu/tree.c:2678:17: error: implicit declaration of function 'rcu_tasks_classic_qs' [-Werror=implicit-function-declaration]
>     2678 |                 rcu_tasks_classic_qs(current, false);
>          |                 ^~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Good catch!  Does the patch below fix this for you?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index e7c39c200e2b0..1a32036c918cd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -196,6 +196,7 @@ void synchronize_rcu_tasks_rude(void);
 void exit_tasks_rcu_start(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
+#define rcu_tasks_classic_qs(t, preempt) do { } while (0)
 #define rcu_tasks_qs(t, preempt) do { } while (0)
 #define rcu_note_voluntary_context_switch(t) do { } while (0)
 #define call_rcu_tasks call_rcu
