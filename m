Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D58250A0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387039AbiDUNi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiDUNiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:38:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6EB1A075
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE2B561D25
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5236EC385A1;
        Thu, 21 Apr 2022 13:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650548134;
        bh=eLGAa2cd0FkC9XToUCSQLD37aQE0c11yNXzIpng6tjM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KC50i3AB3+M3gqZu26Uvv11CrsKFmCic2ZNFcGmUW6A282WK0fu5JIG2o6lKXwlO6
         3G4rdr9Pt1IgO2mpM0Mzfvlb0OX+/mt4Ze+n+0b+aW4Sfjyu0d/l3ddCDfCV9eOc7O
         lA7qayx0MXagGU3AaBLknJCyVXHyxqmncsGNMTdnH4cCG7tz9ClFqvFHI/EdNry7ZB
         Dpd808zZ+2FLZadWWWBVeC5IXz1a9eoSxmzsPXNbNzm2RhD+QDFUkPfMB+dCMwY1xJ
         Jtomv2LbEBv6DH8eXHXoqORNFFBwpgC54NIcLAjRa9q0DjJLi9WcpD34jiGtNWeOt7
         lUkDRleTnPeXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DF2C55C0143; Thu, 21 Apr 2022 06:35:33 -0700 (PDT)
Date:   Thu, 21 Apr 2022 06:35:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/dev.2022.04.18a 22/22]
 kernel/rcu/tree_nocb.h:1162:14: error: 'rcu_nocb_is_setup' undeclared; did
 you mean 'rcu_nocb_setup'?
Message-ID: <20220421133533.GQ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202204210054.ZtsFVPYs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204210054.ZtsFVPYs-lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 02:41:04PM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.04.18a
> head:   d6932dca19b1a7cbccad9d4acede8229e61cf97a
> commit: d6932dca19b1a7cbccad9d4acede8229e61cf97a [22/22] rcu/nocb: Add an option to offload all CPUs on boot
> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220421/202204210054.ZtsFVPYs-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/d6932dca19b1a7cbccad9d4acede8229e61cf97a
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev.2022.04.18a
>         git checkout d6932dca19b1a7cbccad9d4acede8229e61cf97a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

This one is no longer in tree, but a replacement should be on its way,
with attribution.

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/tree.c:5031:
>    kernel/rcu/tree_nocb.h: In function 'rcu_init_nohz':
> >> kernel/rcu/tree_nocb.h:1162:14: error: 'rcu_nocb_is_setup' undeclared (first use in this function); did you mean 'rcu_nocb_setup'?
>     1162 |         if (!rcu_nocb_is_setup) {
>          |              ^~~~~~~~~~~~~~~~~
>          |              rcu_nocb_setup
>    kernel/rcu/tree_nocb.h:1162:14: note: each undeclared identifier is reported only once for each function it appears in
> 
> 
> vim +1162 kernel/rcu/tree_nocb.h
> 
>   1153	
>   1154	void __init rcu_init_nohz(void)
>   1155	{
>   1156		int cpu;
>   1157		bool need_rcu_nocb_mask = false;
>   1158		bool offload_all = false;
>   1159		struct rcu_data *rdp;
>   1160	
>   1161	#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> > 1162		if (!rcu_nocb_is_setup) {
>   1163			need_rcu_nocb_mask = true;
>   1164			offload_all = true;
>   1165		}
>   1166	#endif
>   1167	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
