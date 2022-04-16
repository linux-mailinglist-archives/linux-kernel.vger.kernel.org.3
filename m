Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7F503478
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 08:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiDPGf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 02:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiDPGfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 02:35:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3819AFCBDE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 23:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650090774; x=1681626774;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ocjQ3/eXentpzqQ+97CV2S3KCa4NtUBOQ49mGpfDFnM=;
  b=gyo+czqz2ur1j/FseD5r+KX85bDtpWOLTYcCCmh4BV1mtC4SbPs8c+rn
   4qivy8wx3jTwc0fXTMYKOZTu3MHJWGqH0yF55pAYCZjJHTSd/cKxyG1+2
   qb/aVBcwHRHTb67lVqYtrKMwXZjJqJyY/WOUnghvgyYvJpBMFEzSbw6tE
   pD6oTDbSvuh5ZqTK8xPpnvD406/hO4A87L76H068t+KIpxy2cQuUHIzt0
   wli9fzt0kMYW4P6KT1AC29Jo856nkD5hE6pncj9ErnuMKVoZEQILaTCoZ
   l141VlM7tKSv7Kf642K/2GSfDBAvvdxOwfZD2R4GCiTSUEGeavUxPmTl5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243854941"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="243854941"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 23:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="646292565"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2022 23:32:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfbzI-0002rV-1F;
        Sat, 16 Apr 2022 06:32:52 +0000
Date:   Sat, 16 Apr 2022 14:32:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [bvanassche:scsi-gap-zone 8/8] ERROR: modpost: "__aeabi_uldivmod"
 [drivers/scsi/scsi_debug.ko] undefined!
Message-ID: <202204161429.sPIXKI3Z-lkp@intel.com>
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

tree:   https://github.com/bvanassche/linux scsi-gap-zone
head:   5531f96720bc0e475e669eb56b7094401c53f928
commit: 5531f96720bc0e475e669eb56b7094401c53f928 [8/8] scsi_debug: Add gap zone support
config: arm-randconfig-r035-20220414 (https://download.01.org/0day-ci/archive/20220416/202204161429.sPIXKI3Z-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8e43cbab33765c476337571e5ed11b005199dd0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/bvanassche/linux/commit/5531f96720bc0e475e669eb56b7094401c53f928
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-gap-zone
        git checkout 5531f96720bc0e475e669eb56b7094401c53f928
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__aeabi_uldivmod" [drivers/scsi/scsi_debug.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
