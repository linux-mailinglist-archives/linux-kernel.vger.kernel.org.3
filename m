Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA1F5853B0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbiG2Qme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiG2QmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:42:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B9E45066
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659112932; x=1690648932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nAAmuEMRTOluKqezs5cXfmMpYvyr3ZN4FTsrdJtzU2c=;
  b=dH4Hx0kgBajm6MpUXwstoCKfaXUACizY9DaflsQc0AWCM5Td8fS4T4gc
   I9FSBcRjGRjDuSTgmqn9+cnE42P+niLH62sicY2JPMWO5jLzm7SgHZ7cx
   OSmyqMqE3Y2cBA+C1YEmjnPo5WHmtPOyY2BvEoBLbIe4nKBXOWkmkYo3y
   u7XP2KDmI3bgmKt6LfAzNf98bevtNbDKQwNe+LXYOhCKUWN7ZX7dgJ/Om
   EdtZRVmU5qizRv4OM/IrimSdln8N/504ULuJ9bTVqx/qX2bxW4ZNDYF0n
   rlBi2+ciG2sdpX9Wx5LouHJfSWa8FDZfq8kVuAWPcXIVbMh3qbjZsfa9u
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="288816562"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="288816562"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 09:42:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="743588403"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2022 09:42:11 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHT3y-000BsA-1n;
        Fri, 29 Jul 2022 16:42:10 +0000
Date:   Sat, 30 Jul 2022 00:41:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 8/8]
 include/vdso/processor.h:10:10: fatal error: asm/vdso/processor.h: No such
 file or directory
Message-ID: <202207300010.uSYFJfOe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   02d56061c924adece19bdfad05ea4add32de4b63
commit: 02d56061c924adece19bdfad05ea4add32de4b63 [8/8] random: implement getrandom() in vDSO
config: arc-randconfig-r043-20220729 (https://download.01.org/0day-ci/archive/20220730/202207300010.uSYFJfOe-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/02d56061c924adece19bdfad05ea4add32de4b63
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout 02d56061c924adece19bdfad05ea4add32de4b63
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/vdso/datapage.h:17,
                    from drivers/char/random.c:62:
>> include/vdso/processor.h:10:10: fatal error: asm/vdso/processor.h: No such file or directory
      10 | #include <asm/vdso/processor.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +10 include/vdso/processor.h

d8bb6993d871f5 Vincenzo Frascino 2020-03-20   9  
d8bb6993d871f5 Vincenzo Frascino 2020-03-20 @10  #include <asm/vdso/processor.h>
d8bb6993d871f5 Vincenzo Frascino 2020-03-20  11  

:::::: The code at line 10 was first introduced by commit
:::::: d8bb6993d871f5d3cd6d65d3772e4b1f4ef17380 common: Introduce processor.h

:::::: TO: Vincenzo Frascino <vincenzo.frascino@arm.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
