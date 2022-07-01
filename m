Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D48D5634BB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiGANxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGANxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:53:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25E52C648
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E2D6B82DDC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 13:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42939C3411E;
        Fri,  1 Jul 2022 13:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656683626;
        bh=dVNFg89+mDLmTWPi6mKY7mz9CcYeyfjyk2+ivszQfdo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=liNmo2iUrQDmotIrk7q7IAwgniQ231lb+/ZX3IxZXyiwhdPeZvxhR2FHhPVKgWTCc
         AsTvkcaP3r43Apdkj0qNLuhaJ6YmcLrvTvGwOwI0kaa02iZy48g1Rkmhu+jHstNWoe
         1RdkIqyIN/cd/sbjZeu+0RrRCmvjyms1iOttrHJYmC+yoNt2SW660AGJymYV0LcIkl
         Q222NyZCLWBWWdAsbPIijzX8q6TA2qGveYBeztFnUOqm59OiIJbuYSOJfMWr0H/a8R
         Nx84k4c7Fqp+++e8SF19FmROcKg3vREcT+/JYIO5W6TlRVO1zP17iKiy8qfeaUEn2l
         37yZigTwv8dIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E044B5C06A1; Fri,  1 Jul 2022 06:53:45 -0700 (PDT)
Date:   Fri, 1 Jul 2022 06:53:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] Re:
 [ammarfaizi2-block:paulmck/linux-rcu/pmladek.2022.06.15a 123/140]
 xtensa-linux-ld: arch/xtensa/kernel/entry.o:undefined reference to
 `context_tracking_user_exit'
Message-ID: <20220701135345.GP1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202207010405.MVCHQe6d-lkp@intel.com>
 <20220630230823.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <fe28b30e-dbc9-dba3-7275-2baa2e68197a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe28b30e-dbc9-dba3-7275-2baa2e68197a@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 06:15:50PM +0800, Chen, Rong A wrote:
> 
> 
> On 7/1/2022 7:08 AM, Paul E. McKenney wrote:
> > On Fri, Jul 01, 2022 at 04:15:11AM +0800, kernel test robot wrote:
> > > tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/pmladek.2022.06.15a
> > > head:   0ba7324b44282870af740a5a121add62c7f5f730
> > > commit: 9d16390cc0d00ae1100bca4f4adb0ae2906631ec [123/140] context_tracking: Take idle eqs entrypoints over RCU
> > > config: xtensa-randconfig-r004-20220629 (https://download.01.org/0day-ci/archive/20220701/202207010405.MVCHQe6d-lkp@intel.com/config)
> > > compiler: xtensa-linux-gcc (GCC) 11.3.0
> > > reproduce (this is a W=1 build):
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # https://github.com/ammarfaizi2/linux-block/commit/9d16390cc0d00ae1100bca4f4adb0ae2906631ec
> > >          git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
> > >          git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/pmladek.2022.06.15a
> > >          git checkout 9d16390cc0d00ae1100bca4f4adb0ae2906631ec
> > >          # save the config file
> > >          mkdir build_dir && cp config build_dir/.config
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > This should be fixed in the current version of this commit:
> > 
> > 6a87dff9f33a ("context_tracking: Take idle eqs entrypoints over RCU")
> > 
> > Please let me know if this commit does not address the problem.
> > 
> > 							Thaxn, Paul
> 
> 
> Hi Paul,
> 
> I have confirmed that there's no such issue on commit 6a87dff9f33a,
> but I'm not sure the commit fixed the issue, I can't find the error on
> parent commit 24a9c54182b3 too.
> 
>   $ git log --oneline -2 6a87dff9f33a
>   6a87dff9f33af context_tracking: Take idle eqs entrypoints over RCU
>   24a9c54182b37 context_tracking: Split user tracking Kconfig

I will defer to Frederic on this one.  ;-)

							Thanx, Paul

> Best Regards,
> Rong Chen
> 
> > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > > > xtensa-linux-ld: arch/xtensa/kernel/entry.o:(.text+0x0): undefined reference to `context_tracking_user_exit'
> > > > > xtensa-linux-ld: arch/xtensa/kernel/entry.o:(.text+0xc): undefined reference to `context_tracking_user_enter'
> > >     xtensa-linux-ld: arch/xtensa/kernel/entry.o: in function `common_exception':
> > >     arch/xtensa/kernel/entry.S:459: undefined reference to `context_tracking_user_exit'
> > >     xtensa-linux-ld: arch/xtensa/kernel/entry.o: in function `common_exception_return':
> > >     arch/xtensa/kernel/entry.S:542: undefined reference to `context_tracking_user_enter'
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://01.org/lkp
> > _______________________________________________
> > kbuild-all mailing list -- kbuild-all@lists.01.org
> > To unsubscribe send an email to kbuild-all-leave@lists.01.org
> > 
