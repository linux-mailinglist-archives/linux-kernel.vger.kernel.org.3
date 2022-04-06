Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FA24F663E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiDFRIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbiDFRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:07:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F73106635
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:44:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1FC5B82447
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC7DC385AB;
        Wed,  6 Apr 2022 14:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649256260;
        bh=c22Qvz6Lg5G43oW+8cWIOzhioVkfZNZFgOgWMjC1cro=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CLRV4E4pRuSe3tC4hwf822B+SpgsWRuhhbgwHaavuw0HmmKVK6lFc+4SVVBL/hpPz
         n4UOPssFq9STYK0QlhvBAEAmUSXhCYnB4aQzBco6tRz1o6yps74+ogwjeNdd0umkfE
         X5UW0pPNxXwBWWfTPCvx7kTznQcB/aBg7HNY2PRuAHa22f0grJb4IUfL0DA2qoIozL
         bHuephcTTELTvU19n34Iv4b1GBAppB/feFOFHGX6LRxcL16dkrcXdbZqmcLeBvZPz3
         XrczjvNRjAz2c/IVdIGgTVU8sIEvq8rdn8qkL8gxjN4kJ+EPipvOwowcDLKJNnFyw/
         grUAtxctlg1/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D67735C03F4; Wed,  6 Apr 2022 07:44:19 -0700 (PDT)
Date:   Wed, 6 Apr 2022 07:44:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] Re:
 [ammarfaizi2-block:paulmck/linux-rcu/fastexp.2022.04.01a 109/158] WARNING:
 modpost: vmlinux.o(.text+0xbcac06): Section mismatch in reference from the
 function ieee802154_iface_init() to the variable .init.text:.L0
Message-ID: <20220406144419.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202204040012.4Fu9uBps-lkp@intel.com>
 <20220403183040.GP4285@paulmck-ThinkPad-P17-Gen-1>
 <53cf3eac-37d5-17d6-3805-416a71256e98@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53cf3eac-37d5-17d6-3805-416a71256e98@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 07:11:27PM +0800, Chen, Rong A wrote:
> 
> 
> On 4/4/2022 2:30 AM, Paul E. McKenney wrote:
> > On Mon, Apr 04, 2022 at 12:20:22AM +0800, kernel test robot wrote:
> > > tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/fastexp.2022.04.01a
> > > head:   d9f3e7d671416fdf5b61f094765754269b652db0
> > > commit: c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba [109/158] rcu: Add polled expedited grace-period primitives
> > > config: 	 (https://download.01.org/0day-ci/archive/20220404/202204040012.4Fu9uBps-lkp@intel.com/config)
> > > compiler: riscv32-linux-gcc (GCC) 11.2.0
> > > reproduce (this is a W=1 build):
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # https://github.com/ammarfaizi2/linux-block/commit/c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba
> > >          git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
> > >          git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/fastexp.2022.04.01a
> > >          git checkout c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba
> > >          # save the config file to linux build tree
> > >          mkdir build_dir
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > 
> > > > > WARNING: modpost: vmlinux.o(.text+0xbcac06): Section mismatch in reference from the function ieee802154_iface_init() to the variable .init.text:.L0
> > > The function ieee802154_iface_init() references
> > > the variable __init .L0 .
> > > This is often because ieee802154_iface_init lacks a __init
> > > annotation or the annotation of .L0 is wrong.
> > > 
> > > Note: the below error/warnings can be found in parent commit:
> > > << WARNING: modpost: vmlinux.o(.text+0x432e6): Section mismatch in reference from the function dma_get_required_mask() to the variable .init.text:.L0
> > > << WARNING: modpost: vmlinux.o(.text+0xe35ca): Section mismatch in reference from the function mlock_page_drain() to the variable .init.text:.LVL125
> > > << WARNING: modpost: vmlinux.o(.text+0x96a46e): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L0
> > > << WARNING: modpost: vmlinux.o(.text+0x96a5b4): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L0
> > > << WARNING: modpost: vmlinux.o(.text+0x96a5c0): Section mismatch in reference from the function rpmsg_send() to the variable .init.text:.L0
> > > << WARNING: modpost: vmlinux.o(.text+0x96a5d4): Section mismatch in reference from the function rpmsg_sendto() to the variable .init.text:.L0
> > > << WARNING: modpost: vmlinux.o(.text+0x96a5e8): Section mismatch in reference from the function rpmsg_send_offchannel() to the variable .init.text:.L0
> > > << WARNING: modpost: vmlinux.o(.text+0x96a5fc): Section mismatch in reference from the function rpmsg_trysend() to the variable .init.text:.L0
> > > << WARNING: modpost: vmlinux.o(.text+0x96a610): Section mismatch in reference from the function rpmsg_trysendto() to the variable .init.text:.L0
> > > << WARNING: modpost: vmlinux.o(.text+0x96a624): Section mismatch in reference from the function rpmsg_poll() to the variable .init.text:.L0
> > 
> > I freely confess that I have no idea what any of these error messages
> > are trying to tell me.  What is ".init.txt.L0"?  How did my patch affect
> > ieee802154_iface_init() or the register_netdevice_notifier() function
> > that it invokes?  For that matter, how did my patch cause an access to
> > be made to __init data from a non-__init function?
> > 
> > 							Thanx, Paul
> 
> Hi Paul,
> 
> Sorry for the inconvenience, only below warning was triggered by the commit:
> 
> >> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >>
> >>>> WARNING: modpost: vmlinux.o(.text+0xbcac06): Section mismatch in
> reference from the function ieee802154_iface_init() to the variable
> .init.text:.L0
> 
> the others are for reference only:
> >> Note: the below error/warnings can be found in parent commit
> 
> The problem has existed for some time before your patch, we'll add it to
> ignore list to avoid noise.

Thank you for getting back to me.

Very well, I will ignore subsequent errors that look like this.  ;-)

							Thanx, Paul
