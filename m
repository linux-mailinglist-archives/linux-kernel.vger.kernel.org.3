Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C1B55D46E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbiF1IdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiF1IdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:33:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDA42B26A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656405198; x=1687941198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PqOZK4p5iy5VlTvZkF+x67ZPH9QxdCWJtvI/8U16WnI=;
  b=HJe8yvAB2dHJn/Di9dyPzM6p5oszldxamStj/LMhtoROswyjjP86Nbw7
   HLDYlxJToM/p3rWBojYqPuLHOJccelx/G2UcUQSPkZKDJxirZhoBo+tIi
   bc14fdhym6I19wVBb5+y0XmJMoXvbsUp0zGVQeSuC0l8Df0QdsSifkvS+
   ng0GJC1uo9uN+3GjOUC2uvqs9hYqtjIUEOeEDGSMcghIxQTqAgJ3cTguh
   6gEASqM2BprQnEEjd+QUggnGI6OwMlf5AAwFxTuI+XxvtJ4SVCjoaF19m
   asaNBkA5dvZrhwtrJLYbu1+VzV4ff3Rwm5jkdMQZ+SQQBL3UwS1LcWrBd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367987900"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="367987900"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646818500"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2022 01:33:16 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o66eq-0009lT-2Q;
        Tue, 28 Jun 2022 08:33:16 +0000
Date:   Tue, 28 Jun 2022 16:32:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: [hare-scsi-devel:auth.v15 10/11] drivers/nvme/target/auth.c:491:18:
 warning: format specifies type 'unsigned long' but the argument has type
 'size_t' (aka 'unsigned int')
Message-ID: <202206281641.MOCcvNmX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git auth.v15
head:   2a3a7d0493841ac5944dc0ba861b53d1c2b28014
commit: 59e3ea5fe9113bf2026d17fc969d69001bc1b746 [10/11] nvmet-auth: Diffie-Hellman key exchange support
config: riscv-randconfig-c006-20220627 (https://download.01.org/0day-ci/archive/20220628/202206281641.MOCcvNmX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 016342e319fd31e41cf5ed16a6140a8ea2de74dd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=59e3ea5fe9113bf2026d17fc969d69001bc1b746
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel auth.v15
        git checkout 59e3ea5fe9113bf2026d17fc969d69001bc1b746
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvme/target/auth.c:491:18: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                           ctrl->cntlid, ctrl->dh_keysize, buf_size);
                                         ^~~~~~~~~~~~~~~~
   include/linux/printk.h:528:37: note: expanded from macro 'pr_warn'
           printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                      ~~~     ^~~~~~~~~~~
   include/linux/printk.h:475:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:447:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.


vim +491 drivers/nvme/target/auth.c

   478	
   479	int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
   480					u8 *buf, int buf_size)
   481	{
   482		struct nvmet_ctrl *ctrl = req->sq->ctrl;
   483		int ret = 0;
   484	
   485		if (!ctrl->dh_key) {
   486			pr_warn("ctrl %d no DH public key!\n", ctrl->cntlid);
   487			return -ENOKEY;
   488		}
   489		if (buf_size != ctrl->dh_keysize) {
   490			pr_warn("ctrl %d DH public key size mismatch, need %lu is %d\n",
 > 491				ctrl->cntlid, ctrl->dh_keysize, buf_size);
   492			ret = -EINVAL;
   493		} else {
   494			memcpy(buf, ctrl->dh_key, buf_size);
   495			pr_debug("%s: ctrl %d public key %*ph\n", __func__,
   496				 ctrl->cntlid, (int)buf_size, buf);
   497		}
   498	
   499		return ret;
   500	}
   501	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
