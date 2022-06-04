Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E475C53D633
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 11:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiFDJKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 05:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiFDJKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:10:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D43632EE1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654333829; x=1685869829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ArDUs+VY4m6+3YIbtca6Fc+W4gg9QXBnrvPNisPEYOw=;
  b=eymP10bDXEMsYxxY+EoApStJFLiC4tY8b4oH9FvjIds7Ov3uNxn9fpGO
   ScGES1pXmmBUHVbud2yNk5+LDB6GZ9xhwpT5JY6wGg9+L1R/z4mOQqCbu
   TNae3oH/kNVzCbjIActqZW9jRJ8aSrSctybNs+D5mVaSpyIwAdILiag9/
   zJyowdTwKZpdt2TzxtHAEP/kugGF1a44JgY1vPH4fMfmAELVj7ACob7r/
   ILafbL788ACq9tE7gQ/wOVqhDC1ty2qixlSoGI0V0gqVXbh5GuYipFtYp
   cSdh4SJ5TF/OJ8Q8lEulDypUK6Lj6Lp/wfKV+1ENnHJaaj7B26mQhWGFm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="275215931"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="275215931"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 02:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="708375606"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Jun 2022 02:10:27 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxPne-000AYw-Nu;
        Sat, 04 Jun 2022 09:10:26 +0000
Date:   Sat, 4 Jun 2022 17:09:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: drivers/vhost/vringh.c:586:18: sparse: sparse: restricted __virtio16
 degrades to integer
Message-ID: <202206041728.NyW4skUB-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: a97b693c3712f040c5802f32b2d685352e08cefa uaccess: fix nios2 and microblaze get_user_8()
date:   3 months ago
config: microblaze-randconfig-s031-20220603 (https://download.01.org/0day-ci/archive/20220604/202206041728.NyW4skUB-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a97b693c3712f040c5802f32b2d685352e08cefa
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a97b693c3712f040c5802f32b2d685352e08cefa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/vhost/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/vhost/vringh.c:586:18: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vringh.c:586:18: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vringh.c:586:18: sparse: sparse: cast to restricted __virtio16

vim +586 drivers/vhost/vringh.c

f87d0fbb579818 Rusty Russell      2013-03-20  581  
f87d0fbb579818 Rusty Russell      2013-03-20  582  /* Userspace access helpers: in this case, addresses are really userspace. */
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  583  static inline int getu16_user(const struct vringh *vrh, u16 *val, const __virtio16 *p)
f87d0fbb579818 Rusty Russell      2013-03-20  584  {
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  585  	__virtio16 v = 0;
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12 @586  	int rc = get_user(v, (__force __virtio16 __user *)p);
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  587  	*val = vringh16_to_cpu(vrh, v);
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  588  	return rc;
f87d0fbb579818 Rusty Russell      2013-03-20  589  }
f87d0fbb579818 Rusty Russell      2013-03-20  590  

:::::: The code at line 586 was first introduced by commit
:::::: b9f7ac8c72894c19bf258a54ecaa708df4ffbe80 vringh: update for virtio 1.0 APIs

:::::: TO: Michael S. Tsirkin <mst@redhat.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
