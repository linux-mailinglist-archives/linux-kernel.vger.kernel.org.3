Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E363C48D924
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbiAMNhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:37:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:61579 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235328AbiAMNhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642081070; x=1673617070;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0moxA1lCdI5ugcQRXln+ImaNFqLpbC6L4ShiuHrUqVI=;
  b=SpyL/KEGuXb4duPPbEmFZuUYPqCw+6PIWdRcf1C5zTqf3tWposLfv98L
   0Yxm2Q+ITjZMVftg++iSWs2iY9eL09si/7w/NqF1aO1lHbBvzoo9FrWCH
   1DKbHBk8u9LQOOiYy08NNkdgMgw3k+/qIHEiWL9OoHNY9Wy2wgcQXLgqw
   tyXz6iz4bnIiaztczNA9hWQlwYa74btZfOfrU4JDR+uxNmWb5XO1sNVQ1
   NlRgm6UDXiAkU6qvqW0S/g+PDqsVh+gvr3oLJTHamFN8FYhD9+OfGxT8X
   FL5y+tLBSAbySQrEeBellFdWrwFuYIDjNyK8kVjJe+y+BFSYITbn4ZoK7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="304742093"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="304742093"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 05:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="691802843"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2022 05:37:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n80IW-0007F1-4f; Thu, 13 Jan 2022 13:37:48 +0000
Date:   Thu, 13 Jan 2022 21:37:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 16/19] ERROR: modpost:
 "inet6_getname" [net/tls/tls.ko] undefined!
Message-ID: <202201132110.eYE2iS4l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   0fd328ea53e7d539bf8bb160d773e1d027c60fea
commit: 021aa32bd7f87e46837a5f8774a010f9aa347e61 [16/19] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220113/202201132110.eYE2iS4l-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=021aa32bd7f87e46837a5f8774a010f9aa347e61
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout 021aa32bd7f87e46837a5f8774a010f9aa347e61
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "inet6_getname" [net/tls/tls.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
