Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2207F4AB655
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbiBGHvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbiBGHuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:50:14 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38D0C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644220213; x=1675756213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FGfwn148nXlfPgw58grgzzwnKl15CDZCmNZxMMTJ6JM=;
  b=BLwB2cgvbm4m94bIh1XeLyd5vuz9AHwtLnaCmU7Xz1yDND5gt2Pws3K4
   aiVbPD4VR76Nz9Kl4Cp/AGYkhsIA3G5FrMc6V+CkM71ePyQpV2AKkDn/L
   +iixt4RSMu6IL97FaGwJ+ihL+bpJdJRZrMnSnoFoJNOgul7yctiprcYGW
   JrvHpTvNRBeIAnCsiZvjqEHJXn+UAhxZaFSr58uUSQ8XTrsKFxZ0Rp7y1
   cvuyJg7LQsXCc6lDUzjYAxLRDur/BVw8W+UAGu8P3K5xlqFIO5N1jnbmn
   7fujgXaiT6HeqoKifp0aYXJxz6bZoidQ0rkKSuk2LX13hCc9ABh/UNNpt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="247498443"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="247498443"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 23:50:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="525039226"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 23:50:10 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGymo-0000FD-4C; Mon, 07 Feb 2022 07:50:10 +0000
Date:   Mon, 7 Feb 2022 15:49:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: Wrongly bound Elantech touchpad on Lenovo Yoga Slim 7
Message-ID: <202202071511.Vkx9UNQz-lkp@intel.com>
References: <s5hleyqwowl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hleyqwowl.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on hid/for-next linux/master linus/master v5.17-rc3 next-20220204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Takashi-Iwai/Wrongly-bound-Elantech-touchpad-on-Lenovo-Yoga-Slim-7/20220205-005753
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220207/202202071511.Vkx9UNQz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6daaf5a44925592c764c59219b0024ee06317028)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/9f3fbdd527662d97eb0bece1005d96a0a1b0fac2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Takashi-Iwai/Wrongly-bound-Elantech-touchpad-on-Lenovo-Yoga-Slim-7/20220205-005753
        git checkout 9f3fbdd527662d97eb0bece1005d96a0a1b0fac2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xe016ae): Section mismatch in reference from the function elan_probe() to the variable .init.rodata:elan_i2c_denylist
The function elan_probe() references
the variable __initconst elan_i2c_denylist.
This is often because elan_probe lacks a __initconst
annotation or the annotation of elan_i2c_denylist is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
