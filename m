Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E74DE543
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 03:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbiCSDAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 23:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbiCSDAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 23:00:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9EE19F226
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 19:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647658739; x=1679194739;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l1b0sC5LyV2Lf4aW+ACBo//XGZHe+g5y0gLml3l8wcI=;
  b=EZRWqtsd1OsSvW3F9t5oDdtbTf0vxiSjnT1EMIKJwHC24E0KOCNO2nS1
   4C4ac5zdVHr/04UeI8VavI6N1MWtfdcrmocuOrKqPOJsC+h8DWYIe/XgR
   OkCe4EonOE6Z7sGPpACeAZ6Zvyxuu7DIA/CFf7NhFTUMVcMYGvOQG0F0Z
   kOQ4Keh1sg68BEFaJGowKpcd0gvIjrhM6ir9jEo9BspEKAdov3gasesin
   d2mhBxcpIfMZElZFwCraUUUfxuCVr2bjaYOf0pEkpqaF3Hsvx67lOYqWW
   P+9OtvKhYMsOSsiDQ8dkzB8MAidKUdzpVdKupSzHEOTBbzIVmWiEuYINC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257216010"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257216010"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 19:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558787005"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2022 19:58:58 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVPIv-000FSl-Mn; Sat, 19 Mar 2022 02:58:57 +0000
Date:   Sat, 19 Mar 2022 10:58:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt-sparse 62/69] fs/ceph/crypto.h:233:1: error:
 expected identifier or '(' before '{' token
Message-ID: <202203191032.JfjdgbaE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt-sparse
head:   a6125c2dec56f1f523f5009ce8b25932ba4be812
commit: 8e0977c7c0cb145079b881a6035a98bb0ce71b1b [62/69] ceph: new helper: ceph_fscrypt_decrypt_extents
config: microblaze-randconfig-s031-20220317 (https://download.01.org/0day-ci/archive/20220319/202203191032.JfjdgbaE-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=8e0977c7c0cb145079b881a6035a98bb0ce71b1b
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt-sparse
        git checkout 8e0977c7c0cb145079b881a6035a98bb0ce71b1b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/ceph/super.h:28,
                    from fs/ceph/super.c:20:
>> fs/ceph/crypto.h:233:1: error: expected identifier or '(' before '{' token
     233 | {
         | ^
   fs/ceph/crypto.h:230:19: warning: 'ceph_fscrypt_decrypt_extents' declared 'static' but never defined [-Wunused-function]
     230 | static inline int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +233 fs/ceph/crypto.h

   229	
   230	static inline int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
   231						u64 off, struct ceph_sparse_extent *map,
   232						u32 ext_cnt);
 > 233	{
   234		return 0;
   235	}
   236	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
