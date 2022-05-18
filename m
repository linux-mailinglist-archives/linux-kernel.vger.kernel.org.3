Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488F852C038
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbiERQni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbiERQne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:43:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E539E72236
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7248B616E4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 16:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF90C385A5;
        Wed, 18 May 2022 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652892212;
        bh=N0jqf98S6MCwY3SB9ldiOE4WNRUDEyBxsZ4YKe4A7+w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R2lh2k6a1E1AJCYojMbcn9iHe1kIMsfgFmNhWkHsUM0kxo/AFAuvIDwtHnvOIU+R6
         zyljShRnT4m0Q4/YjdWyCAMueMkMCJfjQMPrNsB5EEiukM9YIeMKg4+/hQoJlFZr76
         6E46ZUfdVAdHjT8gh4F2i8f9eog22NCQcArxDhorzNjuVF+0y8bSi0IaMKySA+JHpi
         nJLuoNAiE+S/GsJoVYvZbXyzG8c1WMMAhUZSI88nZxaCIY2EVOkpORk9J8ErLbG1ku
         rfwR3R/Q5yKmyA11sIV0a35GKghRQ+Ao+TxxVDr48LT7mInLKzZgFaOy5tdNaVb4aI
         4fZSysEQ87iUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6C3565C042D; Wed, 18 May 2022 09:43:32 -0700 (PDT)
Date:   Wed, 18 May 2022 09:43:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/dev 43/51] ERROR: modpost:
 "rcu_tasks_trace_qs_blkd" [kernel/torture.ko] undefined!
Message-ID: <20220518164332.GP1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202205181919.oILbHBZa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205181919.oILbHBZa-lkp@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 08:00:00PM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
> head:   9a9671fb7a3966dfc7dc67f6aa80acdfe185d72d
> commit: 7c98805ebf93263213dac7b52846d73cebe983f3 [43/51] tasks-rcu: Track blocked RCU Tasks Trace readers
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220518/202205181919.oILbHBZa-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/7c98805ebf93263213dac7b52846d73cebe983f3
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
>         git checkout 7c98805ebf93263213dac7b52846d73cebe983f3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "rcu_tasks_trace_qs_blkd" [kernel/torture.ko] undefined!
> >> ERROR: modpost: "rcu_tasks_trace_qs_blkd" [kernel/rcu/rcuscale.ko] undefined!

Good catch, folding an EXPORT_SYMBOL_GPL() into the original commit
with attribution, thank you!

							Thanx, Paul
