Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1504B22D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348745AbiBKKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:12:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiBKKMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:12:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D5F125
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644574360; x=1676110360;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B6JVRlnUPIgo89MVFvwAVoplyYztYEv8R/ryAaiGIro=;
  b=l16WUYcET0nLiMf9s0J4oLB9wo3+TLgGvPgekdVnZ/O7uBYkHf1/dywC
   pdWpkv4RQKKwlxvIP2z7FYnASzXefpEUQ3CAvm9rUiCzAnglVtryifC72
   ccPtLiWBzDF5CronXIGlfUcqKxmXR4UQG9jdywHC4t4uTssWQsRSVpib4
   9ESpdiK0P//FtprQaU1YZkHanfrqJ4T/NFVeVL76VBh9O9L9Bc2xGqiZn
   1bbW4OZvTLnEU6wz/nBao18ZEbmg6roGiwKw38TJt4oRA/mAX9sy34a/S
   GUIvyeOxHC2pIv1R1dzCcAWXddry6iAk2djCFiZx/R1tShZqSTSYBa9yE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="248537023"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="248537023"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:12:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="568997477"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Feb 2022 02:12:38 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nISur-0004Qf-VP; Fri, 11 Feb 2022 10:12:37 +0000
Date:   Fri, 11 Feb 2022 18:11:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 34/35] ld.lld:
 error: undefined symbol: xa_store_range
Message-ID: <202202111814.4NEkwCTo-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   429e2bb6fb190f390ed23afc0d2308e877c43be5
commit: e9340673baaf1ff587aed3391aa411cf554bc42e [34/35] netfs: Slice a writeback from a dirty region
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220211/202202111814.4NEkwCTo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e9340673baaf1ff587aed3391aa411cf554bc42e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout e9340673baaf1ff587aed3391aa411cf554bc42e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: xa_store_range
   >>> referenced by flush.c:204 (fs/netfs/flush.c:204)
   >>>               netfs/flush.o:(netfs_flush_get_pages) in archive fs/built-in.a
   >>> referenced by flush.c:232 (fs/netfs/flush.c:232)
   >>>               netfs/flush.o:(netfs_flush_get_pages) in archive fs/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
