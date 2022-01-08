Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117A448814B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 05:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiAHE2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 23:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiAHE2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 23:28:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAFFC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 20:28:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01B22B82627
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B49C36AE0;
        Sat,  8 Jan 2022 04:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641616129;
        bh=00KpkfETKBNFzTQ2r0RXyaLcukVc2JqwH1AAYaCfME4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZWMPriyYR1YuCWkV7d1zhgBqZHQ2ka7lkqpJuM3LHyrNUAip4Ws3Bixh7cG9sPriz
         H2mOuEStYl3BCyuCsTWIIsLlWPx6EdR/5oHK5KNeDWqyVmEEl9I1x1I8a4ev/omSiH
         p3g9sFBQnEgCT+f+UdnLslKgaz5mgHYH9u1S/J6RrkkJX7hlksXFZdg9w8iOKmRiyB
         zXGjl/S3Ozp25V3eGOnE2MbXYY9FmPK8qIilMGM9xyib5fCL+xejhUp6wPavlZeyxI
         AUACnYr05QooWxKTGpvU3g7DmqusJjeGaic5q9qk9p1a2NFippIifz+uRY4cbGKNQr
         IWxLyhYPnkhnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5111E5C1AB8; Fri,  7 Jan 2022 20:28:49 -0800 (PST)
Date:   Fri, 7 Jan 2022 20:28:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2022.01.04a 55/55] kernel/time/timer.c:1776:6:
 warning: no previous prototype for 'tick_setup_sched_timer_dump'
Message-ID: <20220108042849.GS4202@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202201080834.rGuSv2SS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201080834.rGuSv2SS-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 08:41:32AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.01.04a
> head:   64595d0dff992756e8c6d53c0e9f1e3e50c451f7
> commit: 64595d0dff992756e8c6d53c0e9f1e3e50c451f7 [55/55] squash! EXP timers: Non-nohz_full last-resort jiffies update on IRQ entry
> config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220108/202201080834.rGuSv2SS-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=64595d0dff992756e8c6d53c0e9f1e3e50c451f7
>         git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags paulmck-rcu dev.2022.01.04a
>         git checkout 64595d0dff992756e8c6d53c0e9f1e3e50c451f7
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash kernel/time/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Good catch, but this was due to debug code that has since been removed.

							Thanx, Paul

> All warnings (new ones prefixed by >>):
> 
>    kernel/time/timer.c:254:5: warning: no previous prototype for 'timer_migration_handler' [-Wmissing-prototypes]
>      254 | int timer_migration_handler(struct ctl_table *table, int write,
>          |     ^~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/time/timer.c:1776:6: warning: no previous prototype for 'tick_setup_sched_timer_dump' [-Wmissing-prototypes]
>     1776 | void tick_setup_sched_timer_dump(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/tick_setup_sched_timer_dump +1776 kernel/time/timer.c
> 
>   1775	
> > 1776	void tick_setup_sched_timer_dump(void)
>   1777	{
>   1778		int cpu;
>   1779		int j = jiffies;
>   1780	
>   1781		pr_alert("%s state", __func__);
>   1782		for_each_possible_cpu(cpu)
>   1783			pr_cont(" j/c %x/%d %c",
>   1784				(int)(j - per_cpu(tick_setup_sched_timer_jiffies, cpu)) & 0xfff,
>   1785				per_cpu(tick_setup_sched_timer_jiffies_count, cpu),
>   1786				".H"[per_cpu(tick_setup_sched_timer_help_needed, cpu)]);
>   1787		pr_cont("\n");
>   1788	}
>   1789	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
