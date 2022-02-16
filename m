Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511FE4B8D49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiBPQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:08:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiBPQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:08:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343FEBB092
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:07:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4DF561AC2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6DBC004E1;
        Wed, 16 Feb 2022 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645027669;
        bh=0HJHmipc1EpwodMtV7RqS5BrYtIM0mdWqnKEK/qTb04=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YjuA07f6bSH/ZUz50x4SxoIusl/i6ekYRsBFP7qnCT4qbLlsPfIwWsn5Mbz94ZBaq
         Z4oLOwHmVRwir+Abw7xNMtBlVUwzw5wEsKgcFAD58+jP+r3TUsA27bNApPTqyKGZiT
         /RUIb3WZl1ookznMgF6Mj9Ue1eQ/d3e40976jD/crg0elpmM/PNBOebcnDoynzdNms
         FirGEWzY3lkqTOOzVwCVZykgNoH1/7asfMABv7Jvm7dX6SfKMIyKo1deCGMQsmp3RC
         xm2tIGEf0VL8aLV0K1wiEA5i3pHJVXn1x7ZYHle0k8NA8z2PdrlEdwIBMfC/JYJvc1
         uiRaotBUbChWA==
Date:   Wed, 16 Feb 2022 17:07:46 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     kernel test robot <lkp@intel.com>
cc:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/hid/hid-nintendo.c:403:29: error: 'JC_RUMBLE_ZERO_AMP_PKT_CNT'
 defined but not used
In-Reply-To: <202202140412.ltmfle7c-lkp@intel.com>
Message-ID: <nycvar.YFH.7.76.2202161707020.11721@cbobk.fhfr.pm>
References: <202202140412.ltmfle7c-lkp@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022, kernel test robot wrote:

> Hi Daniel,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
> commit: dad74e18f72a852ae40ad7b4246841a1b7e196b5 HID: nintendo: prevent needless queueing of the rumble worker
> date:   4 months ago
> config: parisc-randconfig-r024-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140412.ltmfle7c-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dad74e18f72a852ae40ad7b4246841a1b7e196b5
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout dad74e18f72a852ae40ad7b4246841a1b7e196b5
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/hid/ fs/notify/fanotify/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

Daniel, I understand that the constants are there for future reference, 
but could you please submit a patch that'd make them commented out for 
now?

Thanks,

-- 
Jiri Kosina
SUSE Labs

