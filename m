Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF151985D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbiEDHhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345622AbiEDHg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:36:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B71924098
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651649585; x=1683185585;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KfgdqSk9odbLxeB6Wlsncoi63Xb5UE/LBNpGXNPnJOU=;
  b=TI4QYZCRN7XAX9wTZaGkY1UMfiIKwSO2y9y1j8iBYyucOF1T9YT9yWq0
   6l7vPaHV4u5/Qh4xDpvJOr1k2grh+tTv/1TmSWzKBALQLuO1Euako8cTv
   LbUPye1tsvtBxt4eWVKAqDRIKXa5mrJcwUdoFGbng1cdtcz5+4sLxujhk
   y4YPepWvU0bWfQ4ohLHOAkuuyds/Ud/YpKm8S4YIy0g0K0xpAUgfGWyEA
   is9Z2HoJDxabKvE8SQEJmBBOPg+naz1kciqE403LOWPTB42/1S0Zsydnq
   uiY7Wc0075poAR9y0gT26Zx+icENCFzWtP/aXibFrLxp8Ci9zTsqeGr6U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="255153715"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="255153715"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="631845182"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2022 00:32:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm9VI-000BB2-96;
        Wed, 04 May 2022 07:32:56 +0000
Date:   Wed, 4 May 2022 15:32:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kees:for-next/kspp 12/12] fs/gfs2/meta_io.h:44:12: error: casting
 from randomized structure pointer type 'struct address_space *' to 'struct
 gfs2_glock *'
Message-ID: <202205041550.naKxwCBj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/kspp
head:   1fe35f29cf8220a5f9ab39ee3e5c722eb716b6fa
commit: 1fe35f29cf8220a5f9ab39ee3e5c722eb716b6fa [12/12] randstruct: Enable Clang support
config: riscv-randconfig-c006-20220501 (https://download.01.org/0day-ci/archive/20220504/202205041550.naKxwCBj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=1fe35f29cf8220a5f9ab39ee3e5c722eb716b6fa
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/kspp
        git checkout 1fe35f29cf8220a5f9ab39ee3e5c722eb716b6fa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/gfs2/acl.c:23:
>> fs/gfs2/meta_io.h:44:12: error: casting from randomized structure pointer type 'struct address_space *' to 'struct gfs2_glock *'
                   return (((struct gfs2_glock *)mapping) - 1)->gl_name.ln_sbd;
                            ^
   1 error generated.


vim +44 fs/gfs2/meta_io.h

009d851837ab26 Steven Whitehouse 2009-12-08  39  
009d851837ab26 Steven Whitehouse 2009-12-08  40  static inline struct gfs2_sbd *gfs2_mapping2sbd(struct address_space *mapping)
009d851837ab26 Steven Whitehouse 2009-12-08  41  {
009d851837ab26 Steven Whitehouse 2009-12-08  42  	struct inode *inode = mapping->host;
009d851837ab26 Steven Whitehouse 2009-12-08  43  	if (mapping->a_ops == &gfs2_meta_aops)
15562c439d0a18 Bob Peterson      2015-03-16 @44  		return (((struct gfs2_glock *)mapping) - 1)->gl_name.ln_sbd;
1b2ad41214c9bf Steven Whitehouse 2014-03-31  45  	else if (mapping->a_ops == &gfs2_rgrp_aops)
1b2ad41214c9bf Steven Whitehouse 2014-03-31  46  		return container_of(mapping, struct gfs2_sbd, sd_aspace);
009d851837ab26 Steven Whitehouse 2009-12-08  47  	else
009d851837ab26 Steven Whitehouse 2009-12-08  48  		return inode->i_sb->s_fs_info;
009d851837ab26 Steven Whitehouse 2009-12-08  49  }
b3b94faa5fe596 David Teigland    2006-01-16  50  

:::::: The code at line 44 was first introduced by commit
:::::: 15562c439d0a1850b71aa1c0d92d1f4fb9503c8d GFS2: Move glock superblock pointer to field gl_name

:::::: TO: Bob Peterson <rpeterso@redhat.com>
:::::: CC: Bob Peterson <rpeterso@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
