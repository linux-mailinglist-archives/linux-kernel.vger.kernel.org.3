Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BAF4BEA74
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiBUTGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:06:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBUTGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:06:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829EA13CE4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645470340; x=1677006340;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ypaInhFIxfeh7EXMlUI10RweM83KJs7oHDp6TtM0eM8=;
  b=edg477Iw3QbnFijCP0SyCSxvIfJlgUP8qKYx6HrwJFADB37LlsLLQP2u
   kBMzwewouV6a+jX9FTUshygoGdomNjrZHJ6vyJJXT+ScBi0fET0nrm+hR
   mW2mNo1RLZVH5a9kJF5Hnfq+FDY1blDlzuJk+bpiGKJBE/62uq92ZJ93Y
   DQXmAWBwUp3yzm02jIm5gnwb5u1wvWPqYAUCz69KUrx318NUHITUUYg36
   8Jb8hZXVfC499eikk+8ufi2VAJyN9uniqLixhOJGiUD0p/VNgRA1P8yNX
   MR5RGoejLkmzRzP9bOX5Ejb2oEW2X3fyjyYW3Q1ux9tTiHsfXJmCRY1wC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="250378951"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="250378951"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 11:05:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="547435014"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Feb 2022 11:05:38 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nME09-0001uE-KY; Mon, 21 Feb 2022 19:05:37 +0000
Date:   Tue, 22 Feb 2022 03:05:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.02.17a 73/73] make[3]: *** No rule to make
 target 'kernel/rcu/typesafe.o', needed by 'kernel/rcu/built-in.a'.
Message-ID: <202202220308.TNib9D2v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Paul,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.02.17a
head:   f5b2eaf791ebbd6af881947ab7c40ed70681e534
commit: f5b2eaf791ebbd6af881947ab7c40ed70681e534 [73/73] EXP torture: Add tests demoing SLAB_TYPESAFE_BY_RCU
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220222/202202220308.TNib9D2v-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=f5b2eaf791ebbd6af881947ab7c40ed70681e534
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2022.02.17a
        git checkout f5b2eaf791ebbd6af881947ab7c40ed70681e534
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'kernel/rcu/typesafe.o', needed by 'kernel/rcu/built-in.a'.
   make[3]: Target '__build' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
