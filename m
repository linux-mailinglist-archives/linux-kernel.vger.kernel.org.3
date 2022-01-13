Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFEE48E11F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbiAMXqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:46:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:28667 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbiAMXqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642117575; x=1673653575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jXQMqB5M1B1k0ZRciPQ8qceliwv38BwKOA73t7XuYu8=;
  b=TgXpTxxwzLmR/3IwBp8/lcyhEJL8ngPb9WPgc4wRyU6EKJurxY/7tW4D
   SF/qnZmGf2fYLJLIcZSw2ceoYKozaIjyWznnBeTDlwkLTenkb+4Rqhjb6
   uSooiDur4LQr7K629zCGG6Bf8uEt1ISlR3aYzYnidbYYs6w8quu4BFxjl
   zapLzg/jRh6+veTywUTRlenyrodAxkAwK74ALHVle1lE4WY2v5YJuk62l
   jvEbIZ3j+r2DN0/ReGPay3Xg6N30YktaOCtB0xeRElVHowRN39Qksf8TK
   9gtva8bCPDDR+IJLyqtUmlYMO2WCSMdTUNFDNzlRdfPA8A6Vsjpcnsb1e
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="243936699"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="243936699"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:46:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="473436275"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2022 15:46:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n89nJ-0007mw-NR; Thu, 13 Jan 2022 23:46:13 +0000
Date:   Fri, 14 Jan 2022 07:45:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Biggers <ebiggers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ebiggers:blk-crypto-sysfs-testing 4/4]
 drivers/block/virtio_blk.c:763:5: error: no member named 'crypto_profile' in
 'struct request_queue'
Message-ID: <202201140721.JP8Zzews-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git blk-crypto-sysfs-testing
head:   59eaf05f0496aed45c6825a931254a94381d36ac
commit: 59eaf05f0496aed45c6825a931254a94381d36ac [4/4] virtio-blk: add fake crypto profile for testing
config: hexagon-randconfig-r045-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140721.JP8Zzews-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=59eaf05f0496aed45c6825a931254a94381d36ac
        git remote add ebiggers https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
        git fetch --no-tags ebiggers blk-crypto-sysfs-testing
        git checkout 59eaf05f0496aed45c6825a931254a94381d36ac
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/block/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/block/virtio_blk.c:763:5: error: no member named 'crypto_profile' in 'struct request_queue'
           q->crypto_profile = profile;
           ~  ^
   1 error generated.


vim +763 drivers/block/virtio_blk.c

   751	
   752	static void virtblk_add_crypto_profile(struct request_queue *q)
   753	{
   754		struct blk_crypto_profile *profile;
   755	
   756		profile = kzalloc(sizeof(*profile), GFP_KERNEL);
   757	
   758		blk_crypto_profile_init(profile, 32);
   759		profile->modes_supported[BLK_ENCRYPTION_MODE_AES_256_XTS] =
   760			4096 | 8192;
   761		profile->max_dun_bytes_supported = 8;
   762	
 > 763		q->crypto_profile = profile;
   764	}
   765	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
