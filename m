Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1A4D6A33
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiCKW4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiCKW4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:56:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E5C207C27
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647038695; x=1678574695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XsjIZ9/THF8UwghyLOYq64MJUoSOIgQ9Gi1heuMDU1Y=;
  b=bgVXq9aaNVKLDzzG738Cr8mV+Us85jdJ05XM/sq99RGbX8fm3HqZslTj
   uMlWfuf9rYaHW0YrU7Wf6uI3WONGhCl9MVup3WUpbLjAdmlopB00cn2at
   pAZQySGK7qeo7E0emsiF6kH/nI5Q7VqsjuqfnuvVD0XmTpOvtzIieR3FP
   ZiL03OrJAGuVN/K1qweHwy/aCsKSufxxU1J6Vgl4uzE+Vphyn6WONi/co
   fVe21xcXr48zsmdQPC4aSkBXj3UecZffhrN2C/UIZwDDfOqyvdwGtPbA0
   YknGJfOjDw/XsPFiJejugxbHXCxXxa1zv66SwbR6iIqIgdSFBztEn/jBc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255857145"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255857145"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 14:44:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="712994015"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2022 14:44:53 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSo0D-0007CM-7F; Fri, 11 Mar 2022 22:44:53 +0000
Date:   Sat, 12 Mar 2022 06:44:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anuj Gupta <anuj20.g@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [mcgrof-next:20220311-io-uring-cmd 6/17] exit.c:(.text+0x740):
 multiple definition of `io_uring_cmd_import_fixed';
 kernel/fork.o:fork.c:(.text+0x700): first defined here
Message-ID: <202203120639.6YXxwLZF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20220311-io-uring-cmd
head:   abe791464a630c1cc3821258e002a0a623dc9b5a
commit: 6e63b680e18e66346f48ea7b637f778e146fb82f [6/17] io_uring: prep for fixed-buffer enabled uring-cmd
config: m68k-randconfig-r034-20220310 (https://download.01.org/0day-ci/archive/20220312/202203120639.6YXxwLZF-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=6e63b680e18e66346f48ea7b637f778e146fb82f
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20220311-io-uring-cmd
        git checkout 6e63b680e18e66346f48ea7b637f778e146fb82f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: kernel/exit.o: in function `io_uring_cmd_import_fixed':
>> exit.c:(.text+0x740): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x700): first defined here
   m68k-linux-ld: fs/exec.o: in function `io_uring_cmd_import_fixed':
   exec.c:(.text+0x10c0): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x700): first defined here

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
