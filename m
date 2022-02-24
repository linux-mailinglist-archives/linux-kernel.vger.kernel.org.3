Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B8C4C39FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbiBXX5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiBXX5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:57:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE25F4E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645747001; x=1677283001;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zN8gIqP7DXdhVvzNWMECCUTyj4Z3gZZ0ZKc7mIvoOcg=;
  b=ZsgiKGKKNxmWok7aMDemHpUIicfZqfBuLko6PBmxE8gy4t4CsKpUSt3y
   2XsBJBhbkP1GV8TmAZ1Y5nkaCASlULGDJDCikANgN0eiTOChTMO9dOy39
   I0kyBOYw3NgmpLr+q0nAEvx+Qd97KxW8pJKhV6BYkmqObRSw4mRoNdPGo
   3W/9gJgMvxmdwDnu4yRYrqF4rC1UlAH+Dxwt0dIgxyH1E2NPPAFpN3OOb
   Z9Y/1Wwk+k0+Ra2twgVM96WAqVx70BemPKtmEWuMKiQ8YuZduzQIQSaSp
   0MZf4fL19W0vsSb66G35PmMdJNVVpBtecRepo3MJLgkJb+UTQ53W3SwN6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="338814910"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="338814910"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="707663616"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Feb 2022 15:56:37 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNNyO-0003aQ-IQ; Thu, 24 Feb 2022 23:56:36 +0000
Date:   Fri, 25 Feb 2022 07:55:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [trondmy-nfs-2.6:testing 43/47] xxhash_generic.c:undefined reference
 to `xxh64'
Message-ID: <202202250739.uOaDW2T2-lkp@intel.com>
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

tree:   git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git testing
head:   18819db1468b966c49a5b95dade10d5e25216b83
commit: aa6b34ca6840595e2d817de4c75534966cb49ba3 [43/47] NFS: Convert readdir page cache to use a cookie based index
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20220225/202202250739.uOaDW2T2-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add trondmy-nfs-2.6 git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
        git fetch --no-tags trondmy-nfs-2.6 testing
        git checkout aa6b34ca6840595e2d817de4c75534966cb49ba3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: fs/nfs/dir.o: in function `nfs_readdir_page_get_locked':
   dir.c:(.text+0x2998): undefined reference to `xxh32'
   dir.c:(.text+0x2998): relocation truncated to fit: R_NIOS2_CALL26 against `xxh32'
   nios2-linux-ld: crypto/xxhash_generic.o: in function `xxhash64_digest':
>> xxhash_generic.c:(.text+0x98): undefined reference to `xxh64'
   xxhash_generic.c:(.text+0x98): relocation truncated to fit: R_NIOS2_CALL26 against `xxh64'
   nios2-linux-ld: crypto/xxhash_generic.o: in function `xxhash64_final':
>> xxhash_generic.c:(.text+0xfc): undefined reference to `xxh64_digest'
   xxhash_generic.c:(.text+0xfc): relocation truncated to fit: R_NIOS2_CALL26 against `xxh64_digest'
   nios2-linux-ld: crypto/xxhash_generic.o: in function `xxhash64_update':
>> xxhash_generic.c:(.text+0x158): undefined reference to `xxh64_update'
   xxhash_generic.c:(.text+0x158): relocation truncated to fit: R_NIOS2_CALL26 against `xxh64_update'
   nios2-linux-ld: crypto/xxhash_generic.o: in function `xxhash64_init':
>> xxhash_generic.c:(.text+0x184): undefined reference to `xxh64_reset'
   xxhash_generic.c:(.text+0x184): relocation truncated to fit: R_NIOS2_CALL26 against `xxh64_reset'
   nios2-linux-ld: crypto/xxhash_generic.o: in function `xxhash_mod_init':
>> xxhash_generic.c:(.init.text+0x10): undefined reference to `crypto_register_shash'
   xxhash_generic.c:(.init.text+0x10): relocation truncated to fit: R_NIOS2_CALL26 against `crypto_register_shash'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CRYPTO_XXHASH
   Depends on CRYPTO
   Selected by
   - NFS_FS && NETWORK_FILESYSTEMS && INET && FILE_LOCKING && MULTIUSER

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
