Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE14DE607
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 05:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbiCSEw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 00:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiCSEwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:52:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0195626935D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 21:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647665462; x=1679201462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WbLv099b2z66idmWMyyZ7YQCLj+VjAe6TNk7HYx2nu0=;
  b=Etkip47HjBFIjpvUqsoTcALExpQS4m7zZMzl9Ae53srWhv2Gpet9QHIz
   WTkVY/ZRZx8gZu3IKvK9Jnd/upXs9/DmkCF+ba9RLotsVCKwj5PV+4bmc
   kFZN3HMHTmhOWP7BmrNK6my25v6lBVODLL6Hp4TP4l3gTdXlkOeALlg/O
   azLskRR93xwkZx31Z3DjwSGJaieFh2AvHPpGzJ3wphyIqhjLYPxzr6IoS
   TvvKQWizshvFPS6DqpWmuiHR6tBopGKfavDw6w58QUMDBeqyCQAYLbpbh
   soEtieUEelPks27YAdjSxX7nptITLulp92gcgmThCp1MdOl8m83w1hDCP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="343710370"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343710370"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 21:51:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="582075207"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2022 21:51:01 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVR3M-000FbA-G0; Sat, 19 Mar 2022 04:51:00 +0000
Date:   Sat, 19 Mar 2022 12:50:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt-sparse 64/69] fs/ceph/crypto.h:230:19:
 warning: 'ceph_fscrypt_decrypt_extents' used but never defined
Message-ID: <202203191202.HeBYpWrc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt-sparse
head:   a6125c2dec56f1f523f5009ce8b25932ba4be812
commit: cf5a57fc1b4827a42e9662f23422b2b62b9e9d7b [64/69] ceph: plumb in decryption during sync reads
config: microblaze-randconfig-s031-20220317 (https://download.01.org/0day-ci/archive/20220319/202203191202.HeBYpWrc-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=cf5a57fc1b4827a42e9662f23422b2b62b9e9d7b
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt-sparse
        git checkout cf5a57fc1b4827a42e9662f23422b2b62b9e9d7b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/ceph/super.h:28,
                    from fs/ceph/file.c:16:
   fs/ceph/crypto.h:233:1: error: expected identifier or '(' before '{' token
     233 | {
         | ^
>> fs/ceph/crypto.h:230:19: warning: 'ceph_fscrypt_decrypt_extents' used but never defined
     230 | static inline int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ceph_fscrypt_decrypt_extents +230 fs/ceph/crypto.h

ba7e3fe2150bf3 Jeff Layton 2021-12-01  229  
8e0977c7c0cb14 Jeff Layton 2022-03-18 @230  static inline int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
8e0977c7c0cb14 Jeff Layton 2022-03-18  231  					u64 off, struct ceph_sparse_extent *map,
8e0977c7c0cb14 Jeff Layton 2022-03-18  232  					u32 ext_cnt);
8e0977c7c0cb14 Jeff Layton 2022-03-18  233  {
8e0977c7c0cb14 Jeff Layton 2022-03-18  234  	return 0;
8e0977c7c0cb14 Jeff Layton 2022-03-18  235  }
8e0977c7c0cb14 Jeff Layton 2022-03-18  236  

:::::: The code at line 230 was first introduced by commit
:::::: 8e0977c7c0cb145079b881a6035a98bb0ce71b1b ceph: new helper: ceph_fscrypt_decrypt_extents

:::::: TO: Jeff Layton <jlayton@kernel.org>
:::::: CC: Jeff Layton <jlayton@kernel.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
