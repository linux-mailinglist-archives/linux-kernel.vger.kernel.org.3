Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7BC4F1FA9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiDDW7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348353AbiDDW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:57:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911AE647C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649110426; x=1680646426;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IxXGkm32fmUmacCwJXHc2Kk/bukrG4SQABKoDYWW/7I=;
  b=X+xo89USouQ68q2ujLZX9PkBLznQh4j4GPrt7YddC/l2/w01yyJuNHPI
   mMg3pyFtuZq70HF4+cqzpyuJjZqbnAUlvnZtBYTOtBdQzgDnKiP3Vu6e8
   dKm9a9INiPLrVyeCZZ1tF0ydTndZcuS5nbJZ/Ui14uAST8/H37Ij8IRjL
   vesRi0o9Rmyy90PfhVmsVQ2B+/EFqCFmN2ZDi3scCzys7G5osxhol9r+x
   wnVDcVUk59IsKZgCOv3I0vQfyuvJe5r2E9Q3qKSAuAriIqIdf5BP7syEP
   sxYrp6yvUmNM7T0I2o1Gq+zcMRmNuVqvJuM1NTRV1pnVrNTRPp12xeWpp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="242761441"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="242761441"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 15:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="523749629"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2022 15:13:36 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbUx5-0002Ot-AG;
        Mon, 04 Apr 2022 22:13:35 +0000
Date:   Tue, 5 Apr 2022 06:12:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     YunQiang Su <yunqiang.su@cipunited.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/uart-16550.c:44:6: warning: no previous
 prototype for 'putc'
Message-ID: <202204050616.vblP4zPu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YunQiang,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: 31b2f3dc851c65fee288612432c4fc956f1a264e MIPS: enable both vmlinux.gz.itb and vmlinuz for generic
date:   3 months ago
config: mips-randconfig-r033-20220404 (https://download.01.org/0day-ci/archive/20220405/202204050616.vblP4zPu-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31b2f3dc851c65fee288612432c4fc956f1a264e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 31b2f3dc851c65fee288612432c4fc956f1a264e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/boot/compressed/uart-16550.c:44:6: warning: no previous prototype for 'putc' [-Wmissing-prototypes]
      44 | void putc(char c)
         |      ^~~~


vim +/putc +44 arch/mips/boot/compressed/uart-16550.c

1b93b3c3e94be2 Wu Zhangjin 2009-10-14  43  
1b93b3c3e94be2 Wu Zhangjin 2009-10-14 @44  void putc(char c)

:::::: The code at line 44 was first introduced by commit
:::::: 1b93b3c3e94be2605759735a89fc935ba5f58dcf MIPS: Add support for GZIP / BZIP2 / LZMA compressed kernel images

:::::: TO: Wu Zhangjin <wuzhangjin@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
