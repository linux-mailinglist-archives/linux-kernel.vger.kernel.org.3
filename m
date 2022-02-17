Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FD94B9533
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiBQBA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:00:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiBQBA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:00:26 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1639279935
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645059613; x=1676595613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sa0+H53QbR6s+x2fPNUtl0GBV42diuebABKKfl+pzcQ=;
  b=LvXaFz2QvonIQmwzJQgookLeLySqSB7BeIN5l2n000NB8QfYfWKeOT8E
   srO1UKP2UEowmQtXh1/JiTvda6sgKlHHeMCkvI4vHcx0bahi9jHSqEccf
   K+UD8XSUc1EmDWBDFVD8T+emiVQUU+EhYdK0CzVY5mOXCSKeyQ5F8Jeyy
   g2ZNdCxZJTw1CqHIuQa8mygl0j8x2vcC8yZRKsm7twTNBXLgfiBo4h7hQ
   wgm0g4pF0DnFTuIgyRwotaUEKHut71kz8o51SjBEUJefnmLDcbJssDObi
   YjH90A0r1X116K4wJM3MMLkWc8YMx/keAd+vA7heAhb3z1no/kE8KZpEq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="311501959"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="311501959"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="636801020"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Feb 2022 16:59:55 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKV9G-000BH9-Ik; Thu, 17 Feb 2022 00:59:54 +0000
Date:   Thu, 17 Feb 2022 08:59:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 36/42]
 nios2-linux-ld: buffered_flush.c:undefined reference to `xa_store_range'
Message-ID: <202202170816.VBJVpftr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   5cb7f190822d09757b30cd9539e57eef72552d1f
commit: 7c84dbfe72c00f7456ead2d9ba8af5ece7d58222 [36/42] netfs: Generate a buffered writeback from ->writepages()
config: nios2-randconfig-r001-20220216 (https://download.01.org/0day-ci/archive/20220217/202202170816.VBJVpftr-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7c84dbfe72c00f7456ead2d9ba8af5ece7d58222
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 7c84dbfe72c00f7456ead2d9ba8af5ece7d58222
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: fs/netfs/buffered_flush.o: in function `netfs_flush_get_pages':
   buffered_flush.c:(.text+0x53c): undefined reference to `xa_store_range'
   buffered_flush.c:(.text+0x53c): relocation truncated to fit: R_NIOS2_CALL26 against `xa_store_range'
>> nios2-linux-ld: buffered_flush.c:(.text+0x5a0): undefined reference to `xa_store_range'
   buffered_flush.c:(.text+0x5a0): relocation truncated to fit: R_NIOS2_CALL26 against `xa_store_range'
   `adc3xxx_i2c_remove' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
