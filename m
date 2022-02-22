Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429CA4BFB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiBVOyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiBVOyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:54:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5613A10C510
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:53:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9C27B81A8C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8887EC340E8;
        Tue, 22 Feb 2022 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645541629;
        bh=uBy8LXOusA1ix7pL5sPIhfdwuOfguqdegNKJEYRRpSo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eyGg0CRCNUvPILSGlJrnosS4M4re4+pFA2kFgNGTx1VoX1eFTjN8svS1yi+f7EXQl
         DuC7tqvihsUUx4ASrUHSQdYOIH+o0D7sy6uCxbbg/1C9YvJy5wQQaS3fipdUjk4A1w
         zqp+s3TJlXPgw1aCvZayX0N0JMGK0fNWFrA49eQr4Coh7BToOL6glw+FCyXvySnai4
         bI/5lCtQHp9X8PCivqU6X1QKiIsu9Xd3CxC1EPVy5AKxs7QrLP8gqg1OKFfbD2jYrl
         7/la1ElK/C1CQHSRoxl4rlcbJhD73QBWadcwiuh8QkYJlu7yr3J0z0zB4yw6LSmLYL
         Ef/zRhv+dn9uQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4DEDC5C015B; Tue, 22 Feb 2022 06:53:49 -0800 (PST)
Date:   Tue, 22 Feb 2022 06:53:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] Re: [paulmck-rcu:dev.2022.02.17a 73/73] make[3]:
 *** No rule to make target 'kernel/rcu/typesafe.o', needed by
 'kernel/rcu/built-in.a'.
Message-ID: <20220222145349.GH4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202202220308.TNib9D2v-lkp@intel.com>
 <20220221214736.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <b481fd02-7b4f-7752-8852-d1a61b4916f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b481fd02-7b4f-7752-8852-d1a61b4916f1@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 04:30:40PM +0800, Chen, Rong A wrote:
> 
> 
> On 2/22/2022 5:47 AM, Paul E. McKenney wrote:
> > On Tue, Feb 22, 2022 at 03:05:27AM +0800, kernel test robot wrote:
> > > Hi Paul,
> > > 
> > > First bad commit (maybe != root cause):
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.02.17a
> > > head:   f5b2eaf791ebbd6af881947ab7c40ed70681e534
> > > commit: f5b2eaf791ebbd6af881947ab7c40ed70681e534 [73/73] EXP torture: Add tests demoing SLAB_TYPESAFE_BY_RCU
> > > config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220222/202202220308.TNib9D2v-lkp@intel.com/config)
> > > compiler: arceb-elf-gcc (GCC) 11.2.0
> > > reproduce (this is a W=1 build):
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=f5b2eaf791ebbd6af881947ab7c40ed70681e534
> > >          git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > >          git fetch --no-tags paulmck-rcu dev.2022.02.17a
> > >          git checkout f5b2eaf791ebbd6af881947ab7c40ed70681e534
> > >          # save the config file to linux build tree
> > >          mkdir build_dir
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > > > make[3]: *** No rule to make target 'kernel/rcu/typesafe.o', needed by 'kernel/rcu/built-in.a'.
> > >     make[3]: Target '__build' not remade because of errors.
> > 
> > This is the only commit involving kernel/rcu/typesafe.o, so...
> > 
> > One the one hand, I do not plan to upstream this, so maybe it doesn't
> > matter.
> > 
> > I have been building this using the rcutorture scripting for some time,
> > same RCU-related .config as you are using.  But when I pulled it into
> > a clone in a neighboring directory, it failed just as it did for you.
> > The problem was that the update to kernel/rcu/Makefile somehow didn't
> > come across, so this line was missing:
> > 
> > 	obj-$(CONFIG_RCU_TYPESAFE_TEST) += typesafe.o
> > 
> > Which of course explains the build failure.
> > 
> > I blew away that clone and re-cloned it.  And it still failed, both
> > with "make" from the commandline and under rcutorture.
> > 
> > Hahahahahahaahaha!!!
> > 
> > I forgot "git add kernel/rcu/typesafe.c".
> > 
> > There is now a new typesafe.2022.02.21a tag with this file added.
> > 
> > Good catch!  That file happened to still be lying around.  The first
> > "git reset --hard" would have destroyed.  Thank you!!!
> > 
> > And with that fixed, my clone now builds correctly.  Does this fix
> > it for you?
> 
> Hi Paul,
> 
> I can't find the tag 'typesafe.2022.02.21a' from https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/refs/tags

That would be because I failed to push it out.  :-/

Which I just now did, apologies for my confusion.

							Thanx, Paul
