Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AFB4F0BC7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 20:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359774AbiDCScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359769AbiDCScg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 14:32:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EE93968A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 11:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD92260AE5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 18:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11620C340ED;
        Sun,  3 Apr 2022 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649010641;
        bh=r7mWSwZMasS4C49kWtfE9+LBz/r2q4pqIO2g2ZINkQ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gfV3vs1WlpfK74gyMmTWeQF2aGzBouxm1D6+hbMIVMCkh2RSgg5WUNDD2Qqng2Z3A
         o8alkiAgj+dUFzPX1vTkJ5+E37L++AqfN1Lno7zZ0jZhyer3/tueRIq42abWfes+Km
         nz75HLwlpNjb8njHEdCVPPM/QNRe/szFau1WOa/L7y/vUsc3gYRcAWenkSo0DATihL
         A2k61Aw2t49y6RtkbIGbk8g4jD8zrXgSP1cwKJuWdeBiwLJSLvMEy1nsKIXirg8ekP
         hj3t5evR/+eiSLktgQYuL+txUGh9VlZJ5PKx3XXcu7z6sKRw5WQhnu9jXAMS7jFh84
         raMx0heJzRK7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9D4AD5C0555; Sun,  3 Apr 2022 11:30:40 -0700 (PDT)
Date:   Sun, 3 Apr 2022 11:30:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/fastexp.2022.04.01a
 109/158] WARNING: modpost: vmlinux.o(.text+0xbcac06): Section mismatch in
 reference from the function ieee802154_iface_init() to the variable
 .init.text:.L0
Message-ID: <20220403183040.GP4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202204040012.4Fu9uBps-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204040012.4Fu9uBps-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 12:20:22AM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/fastexp.2022.04.01a
> head:   d9f3e7d671416fdf5b61f094765754269b652db0
> commit: c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba [109/158] rcu: Add polled expedited grace-period primitives
> config: riscv-randconfig-r002-20220403 (https://download.01.org/0day-ci/archive/20220404/202204040012.4Fu9uBps-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/fastexp.2022.04.01a
>         git checkout c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: vmlinux.o(.text+0xbcac06): Section mismatch in reference from the function ieee802154_iface_init() to the variable .init.text:.L0
> The function ieee802154_iface_init() references
> the variable __init .L0 .
> This is often because ieee802154_iface_init lacks a __init
> annotation or the annotation of .L0 is wrong.
> 
> Note: the below error/warnings can be found in parent commit:
> << WARNING: modpost: vmlinux.o(.text+0x432e6): Section mismatch in reference from the function dma_get_required_mask() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xe35ca): Section mismatch in reference from the function mlock_page_drain() to the variable .init.text:.LVL125
> << WARNING: modpost: vmlinux.o(.text+0x96a46e): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a5b4): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a5c0): Section mismatch in reference from the function rpmsg_send() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a5d4): Section mismatch in reference from the function rpmsg_sendto() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a5e8): Section mismatch in reference from the function rpmsg_send_offchannel() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a5fc): Section mismatch in reference from the function rpmsg_trysend() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a610): Section mismatch in reference from the function rpmsg_trysendto() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a624): Section mismatch in reference from the function rpmsg_poll() to the variable .init.text:.L0

I freely confess that I have no idea what any of these error messages
are trying to tell me.  What is ".init.txt.L0"?  How did my patch affect
ieee802154_iface_init() or the register_netdevice_notifier() function
that it invokes?  For that matter, how did my patch cause an access to
be made to __init data from a non-__init function?

							Thanx, Paul
