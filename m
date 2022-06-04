Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2353D61C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiFDI0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiFDI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 04:26:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4626F562E4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654331188; x=1685867188;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XoxA+ewcupI9T02sgAlzhzRiGzeulMywbsJxH7n10to=;
  b=hIU0g0nwZibDO8hkE9Sw0Kp43XE5VjBjvZePmh2iMTamEz6uEUE6sBjW
   rjhP0T3eEYDBRs33h3n/Z2CihoZO64Sg/RmD6Fftz5tkpXknbhXi+aDU4
   9BswqPKkv+luE2J6dx/JnL4lYokEkFCmboBXSl0r/bUf3OdRmiBZJlLtW
   I3BFgt+TBORR/6gcKWngyH1lhcE9XxGIOMe0CpNCg6gzYgwSxFn24Lr6s
   6YlSC29xfvkmwPI1zLpCq6VjH1sSs8ZGIyUM3FvVAJRWD/mL3V8pZ3OEs
   NeyatzINj69HcRY027g+DnD+AtBof/Zff8/ZU4JY6xifjI4uoMfa67QLv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="362777113"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="362777113"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 01:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="757807041"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2022 01:26:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxP71-000AV9-O3;
        Sat, 04 Jun 2022 08:26:23 +0000
Date:   Sat, 4 Jun 2022 16:25:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [akpm-mm:mm-unstable 179/180] fs/xfs/xfs_file.c:1273:1: warning: no
 previous prototype for function 'xfs_dax_fault'
Message-ID: <202206041624.kUCMuYuP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   f06e3c5104126b9a6660b58f29619b53bfa33b2b
commit: d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c [179/180] xfs: support CoW in fsdax mode
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220604/202206041624.kUCMuYuP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/xfs/ mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/xfs_file.c:1273:1: warning: no previous prototype for function 'xfs_dax_fault' [-Wmissing-prototypes]
   xfs_dax_fault(
   ^
   fs/xfs/xfs_file.c:1272:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   1 warning generated.


vim +/xfs_dax_fault +1273 fs/xfs/xfs_file.c

  1257	
  1258	#ifdef CONFIG_FS_DAX
  1259	int
  1260	xfs_dax_fault(
  1261		struct vm_fault		*vmf,
  1262		enum page_entry_size	pe_size,
  1263		bool			write_fault,
  1264		pfn_t			*pfn)
  1265	{
  1266		return dax_iomap_fault(vmf, pe_size, pfn, NULL,
  1267				(write_fault && !vmf->cow_page) ?
  1268					&xfs_dax_write_iomap_ops :
  1269					&xfs_read_iomap_ops);
  1270	}
  1271	#else
  1272	int
> 1273	xfs_dax_fault(
  1274		struct vm_fault		*vmf,
  1275		enum page_entry_size	pe_size,
  1276		bool			write_fault,
  1277		pfn_t			*pfn)
  1278	{
  1279		return 0;
  1280	}
  1281	#endif
  1282	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
