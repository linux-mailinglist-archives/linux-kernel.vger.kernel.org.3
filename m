Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CBF503333
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiDPCGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiDPCFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:05:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE974137F7C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 18:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650074087; x=1681610087;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tnWW8RHrYAEi7ZmsFv26NaD1X/SNeXSnVLg9q3uTZX0=;
  b=jG4m61zRmBUbrSmWSxX5gFoRGorGu2DOC5SOmdAMOOMTNODputQXnXUM
   A2sccxmKf+dGYu4yauFH9hp5XDiZlCSrbuk8/20yFuyomPwssB4CpzlXJ
   Pi3tpjPbs16bg4SpxnR6vH9YyjxBgpYGHDXBui3RX1axYvBViyLZGzh6z
   Tk51smowqeR4HldiqMIfDtdGwZquu/C57xomiYVFmgGQQFJo2AW4c1Erp
   ezTp18hSO9Ky5AYVOpAUDqJzeAGoHdBBiEuruR0KEakNBxPz1kk37+eY4
   W+q5QqqVw8Lsrqvp653KyT5u7LEc8WVfOzfuNIZxMYjZ2QM6x8oKF1J/T
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="260856691"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="260856691"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 18:47:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="701239795"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2022 18:47:43 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfXXK-0002e6-Mh;
        Sat, 16 Apr 2022 01:47:42 +0000
Date:   Sat, 16 Apr 2022 09:47:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [bvanassche:scsi-gap-zone 8/8] ERROR: modpost: "__umoddi3"
 [drivers/scsi/scsi_debug.ko] undefined!
Message-ID: <202204160900.KLzxt1Xe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-gap-zone
head:   5531f96720bc0e475e669eb56b7094401c53f928
commit: 5531f96720bc0e475e669eb56b7094401c53f928 [8/8] scsi_debug: Add gap zone support
config: riscv-randconfig-r042-20220414 (https://download.01.org/0day-ci/archive/20220416/202204160900.KLzxt1Xe-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8e43cbab33765c476337571e5ed11b005199dd0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/bvanassche/linux/commit/5531f96720bc0e475e669eb56b7094401c53f928
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-gap-zone
        git checkout 5531f96720bc0e475e669eb56b7094401c53f928
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [drivers/scsi/scsi_debug.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
