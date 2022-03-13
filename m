Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65924D755A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 13:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiCMMyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 08:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiCMMyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 08:54:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FCA13D14
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647175979; x=1678711979;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SzaVluKN8sAT5nGputOeHFWsq+1JUQ3j0V3G5q/hjl4=;
  b=AiE2AWq0lIWBP6Eb2AiWoVKCWFOmCjPj5fZw25AbCRP005lsbAX2QafK
   C5YBoxcfMpD6yf/bKb7E7NAX9QzIe3/XiMFU7wNEQy8SvInIJHgWTwBJy
   h1d4gTjAqUhU4g2WPCvJmItSMEdxNd/20ZRPZppm63K2O7ILJCgVpUx/w
   TcNzFkOGJS0c98za48YhUArbcM6tvMJ+hjImahw9hwGlhe3jOyGxN1Gki
   1JuuKOtx3uHV0WIhgmdIUBLdgsxdg1kCKkVfk3EgXYMUFttMIQDJdKgx/
   Zros0KXo5RtcveHNQFYgmStPfzKcJ4uu79eiQjbnm8ZGSz+b7/Ozay5fL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="342292753"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="342292753"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 05:52:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713401124"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 05:52:57 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTNiS-0008xY-Uz; Sun, 13 Mar 2022 12:52:56 +0000
Date:   Sun, 13 Mar 2022 20:52:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 116/156] <command-line>: warning:
 format '%lu' expects argument of type 'long unsigned int', but argument 9
 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202203132003.70vHWjP1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hannes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 3e155fab03919dae359f4f87a1a38d7b0e080f1a [116/156] nvmet-auth: Diffie-Hellman key exchange support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220313/202203132003.70vHWjP1-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=3e155fab03919dae359f4f87a1a38d7b0e080f1a
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 3e155fab03919dae359f4f87a1a38d7b0e080f1a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/nvme/target/ net/tls/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvme/target/fabrics-cmd-auth.c: In function 'nvmet_auth_challenge':
>> <command-line>: warning: format '%lu' expects argument of type 'long unsigned int', but argument 9 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
   drivers/nvme/target/fabrics-cmd-auth.c:7:21: note: in expansion of macro 'KBUILD_MODNAME'
       7 | #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
         |                     ^~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in expansion of macro 'pr_fmt'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/nvme/target/fabrics-cmd-auth.c:371:9: note: in expansion of macro 'pr_debug'
     371 |         pr_debug("%s: ctrl %d qid %d seq %d transaction %d hl %d dhvlen %lu\n",
         |         ^~~~~~~~

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
