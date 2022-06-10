Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E177545CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346364AbiFJHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbiFJHJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:09:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B069E323880
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654844946; x=1686380946;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=prsKme4t8qsKePFyd1/lDxgNPz0quzkkSmZzNVZ8u2o=;
  b=SxB8HAOpmDo4RAA0mlijUapetTGt8Qxbbk847dSSc5KsgcGsFr5PYeDP
   Y39Y0USbZJJnGWsLp/So4Zopq6LLJXZcgqExxxsyCKtrr3xdC6zGO1uRp
   KAjC9tk6NSvewHKmpooReCizg5VdIKn9kufMMQN7nsXdd+FdiplNScAJH
   9LVDiedoNVV6jCX4KYmDuBBbxf+IMisYQRhVr0cVMqFcFdtPcW8bd7b/E
   sHTNi0zSZHhWl7amOEp+klKQDYrxzkEtHU/BLWlf3c+5eYndCIc6U0R+X
   SHoxvWnipZUN+Ww4CV3DDbhka+PUKr33ZZLsb54s+K/cMRG+514NxL36Y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341604184"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="341604184"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 00:09:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="828086581"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2022 00:09:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzYlT-000GmH-RB;
        Fri, 10 Jun 2022 07:09:03 +0000
Date:   Fri, 10 Jun 2022 15:08:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:fns 8/8] lib/find_bit.c:105:1: error: redefinition of
 '__ksymtab__find_first_bit'
Message-ID: <202206101503.SiKOLRsZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux fns
head:   785e34f40a6ad867ddc1fccf032a54bb41563865
commit: 785e34f40a6ad867ddc1fccf032a54bb41563865 [8/8] fns
config: hexagon-randconfig-r041-20220609 (https://download.01.org/0day-ci/archive/20220610/202206101503.SiKOLRsZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 70d35fe1257e429266b83025997b400e9f79110e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/785e34f40a6ad867ddc1fccf032a54bb41563865
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov fns
        git checkout 785e34f40a6ad867ddc1fccf032a54bb41563865
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/find_bit.c:105:1: error: redefinition of '__ksymtab__find_first_bit'
   EXPORT_SYMBOL(_find_first_bit);
   ^
   include/linux/export.h:150:29: note: expanded from macro 'EXPORT_SYMBOL'
   #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
                                           ^
   include/linux/export.h:147:34: note: expanded from macro '_EXPORT_SYMBOL'
   #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
                                           ^
   include/linux/export.h:140:39: note: expanded from macro '__EXPORT_SYMBOL'
   #define __EXPORT_SYMBOL(sym, sec, ns)   ___EXPORT_SYMBOL(sym, sec, ns)
                                           ^
   include/linux/export.h:96:2: note: expanded from macro '___EXPORT_SYMBOL'
           __KSYMTAB_ENTRY(sym, sec)
           ^
   include/linux/export.h:57:36: note: expanded from macro '__KSYMTAB_ENTRY'
           static const struct kernel_symbol __ksymtab_##sym               \
                                             ^
   <scratch space>:183:1: note: expanded from here
   __ksymtab__find_first_bit
   ^
   lib/find_bit.c:89:1: note: previous definition is here
   EXPORT_SYMBOL(_find_first_bit);
   ^
   include/linux/export.h:150:29: note: expanded from macro 'EXPORT_SYMBOL'
   #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
                                           ^
   include/linux/export.h:147:34: note: expanded from macro '_EXPORT_SYMBOL'
   #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
                                           ^
   include/linux/export.h:140:39: note: expanded from macro '__EXPORT_SYMBOL'
   #define __EXPORT_SYMBOL(sym, sec, ns)   ___EXPORT_SYMBOL(sym, sec, ns)
                                           ^
   include/linux/export.h:96:2: note: expanded from macro '___EXPORT_SYMBOL'
           __KSYMTAB_ENTRY(sym, sec)
           ^
   include/linux/export.h:57:36: note: expanded from macro '__KSYMTAB_ENTRY'
           static const struct kernel_symbol __ksymtab_##sym               \
                                             ^
   <scratch space>:168:1: note: expanded from here
   __ksymtab__find_first_bit
   ^
   1 error generated.


vim +/__ksymtab__find_first_bit +105 lib/find_bit.c

    91	
    92	unsigned long _find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
    93	{
    94		unsigned long idx, w;
    95	
    96		for (idx = 0; idx * BITS_PER_LONG < size; idx++, n -= w) {
    97			w = hweight_long(addr[idx]);
    98			if (w >= n)
    99				return min(idx * BITS_PER_LONG + fns(addr[idx], n), size);
   100		}
   101	
   102		return size;
   103	
   104	}
 > 105	EXPORT_SYMBOL(_find_first_bit);
   106	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
