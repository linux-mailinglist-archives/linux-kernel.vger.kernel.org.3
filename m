Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C14C221D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiBXDLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBXDLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:11:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D69246379
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645672262; x=1677208262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9EmUFqIg1GWaAbIjqrTM+RGEnJ987UvEwpJymzgaBoA=;
  b=EXbxm7Qy7jo+8H1RJvFRKfqdnxWHjFlx+ajEQNTdrsPmpBccGBEcUq8k
   efuUyx8xYfx2Ju1y9+Pvlo2zrAM7h5S5O7l14NqFKf+j1EstRKqjXVEp+
   b3AuGiKcIHjGMh6FoWqglB0JSeUvW+TmDkpvbrVovXowIk09EJrf6voaR
   mBX/wtTPBYnx0+1Vdhc9efWKpN30EFUO5FSWou2X4jTzXMaHTELM9aGX3
   DjPhXahnpuzTFynieQxRYrj4duwhboz/MT1FSvngwWI0KLPRVhIOLvvr/
   K8WU03fUwTvadbKR35fbtScsQ3Y0XCWrKrBE9rc/5J6l4Ym1j0hPmONRx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="338576947"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="338576947"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:11:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="639564085"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Feb 2022 19:11:00 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN4Wx-0002A5-Ii; Thu, 24 Feb 2022 03:10:59 +0000
Date:   Thu, 24 Feb 2022 11:10:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [trondmy-nfs-2.6:testing 42/44] ld.lld: error: undefined symbol:
 xxh32
Message-ID: <202202241119.1ZzPPbnV-lkp@intel.com>
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
head:   3882cc488a3048791d7f06393d3e7c55ba3eda6f
commit: 5d2f1b8a2961967f7712baaea33b6e83daf732f8 [42/44] NFS: Convert readdir page cache to use a cookie based index
config: arm-pcm027_defconfig (https://download.01.org/0day-ci/archive/20220224/202202241119.1ZzPPbnV-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add trondmy-nfs-2.6 git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
        git fetch --no-tags trondmy-nfs-2.6 testing
        git checkout 5d2f1b8a2961967f7712baaea33b6e83daf732f8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: xxh32
   >>> referenced by dir.c
   >>>               nfs/dir.o:(nfs_readdir_page_get_locked) in archive fs/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
