Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A94756293F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiGAClZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGAClY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:41:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A8361D71
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656643283; x=1688179283;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oDk6q32MtovJ4lorASbnkX/SG98a50WieSs/VcndFyw=;
  b=Qm/XGscFdwpaR9U2Qn5z4B/+BYxSFRGh0rWGZZlvdDJPSnBpYQydS8OA
   ZQVWrEKla6FaEa5XfouLRQh8HW1znkajlMXAvOZ8pY2b5M0rf5ZGhewEo
   Vu0ffxP71fgFEAT54iHxgsvWGwAQf2mQgmHJj16nj8UCeBBxhb6mNxzvw
   RJLOtFNv+nynKuqqRR5AGcg4wnASPmiY5MbmSYZkDrLxiDE6oXvjTZRfD
   zK+P84iR8Jy7jOqtKscL9m+DMTSmthvIL+uCJhmNZy+ahJuAo4lmcA3BC
   rbuJsR2agiI8XgI50Z+7IzYIP/eDiX4NHZqhawVLmwB8GeTUTVJBXNXak
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="271305291"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="271305291"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 19:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="596067783"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2022 19:41:21 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o76au-000DRq-Sm;
        Fri, 01 Jul 2022 02:41:20 +0000
Date:   Fri, 1 Jul 2022 10:40:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 56/56]
 ld.lld: error: undefined symbol: __fscache_resize_cookie
Message-ID: <202207011046.63cgHZ5l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   acac17cdb0f9f6db9fc03eea371e399906146f96
commit: acac17cdb0f9f6db9fc03eea371e399906146f96 [56/56] netfs: Implement truncation
config: arm64-randconfig-r001-20220629 (https://download.01.org/0day-ci/archive/20220701/202207011046.63cgHZ5l-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/acac17cdb0f9f6db9fc03eea371e399906146f96
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout acac17cdb0f9f6db9fc03eea371e399906146f96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __fscache_resize_cookie
   >>> referenced by fscache.h:387 (include/linux/fscache.h:387)
   >>> netfs/truncate.o:(netfs_truncate) in archive fs/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
