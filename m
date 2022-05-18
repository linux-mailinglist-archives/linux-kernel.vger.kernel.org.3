Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0306952C280
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbiERSlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241489AbiERSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:40:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A23CDBB
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652899249; x=1684435249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4WtiDK54AT5D3xJgbES/KqYOfqBsw80Ux8SMTshx1Sk=;
  b=VWLiWaEUwQiCYpTlGyPo42/ClISZ8jfdmDM/+OjI1SvlwD5Hg8AH/Z+D
   4UGFeJfL1RdrHD3qRpdXYfHMVlpLtcntelwR3NXm3fO39/KxVvbOkkfjb
   COdKmv099OxcbdqfgtTvD8+qVwKxa3EJGyjh6+wtQR7XYgSRL7lzbDvMC
   7O/scRrvmHf3+NXRlOHX2yQQY9crtZDag4Cf1MqwDEW0jkfM8zEat0mnT
   rcRKqLqtubVpuh9A8gXwSSNJOYmrnJZOFT5gRD73bwIG25bXuu6QUMhW4
   Vxdp+BZi8bPa/nksAy5CEz4EbcqdMdyTekxsxXLtpQ3V3FfnqDmxmcSeO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="270663372"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="270663372"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="597972314"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 May 2022 11:38:44 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrOZI-0002W0-5H;
        Wed, 18 May 2022 18:38:44 +0000
Date:   Thu, 19 May 2022 02:38:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:auth.v12 10/11] <command-line>: warning: format
 '%lu' expects argument of type 'long unsigned int', but argument 9 has type
 'size_t' {aka 'unsigned int'}
Message-ID: <202205190200.Z1ecsIW1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git auth.v12
head:   94e00927012f48bfff384a6e5e40d8e6a34a1ae5
commit: e858b89b4b9d5cbe4d533c16feaf4c5bfca10e5b [10/11] nvmet-auth: Diffie-Hellman key exchange support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220519/202205190200.Z1ecsIW1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=e858b89b4b9d5cbe4d533c16feaf4c5bfca10e5b
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel auth.v12
        git checkout e858b89b4b9d5cbe4d533c16feaf4c5bfca10e5b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/nvme/target/

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
   include/linux/printk.h:570:9: note: in expansion of macro 'dynamic_pr_debug'
     570 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/nvme/target/fabrics-cmd-auth.c:371:9: note: in expansion of macro 'pr_debug'
     371 |         pr_debug("%s: ctrl %d qid %d seq %d transaction %d hl %d dhvlen %lu\n",
         |         ^~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
