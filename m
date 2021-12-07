Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27A46B08B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbhLGC06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:26:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:61410 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238230AbhLGC05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:26:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237413736"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237413736"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 18:23:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="462118089"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2021 18:23:26 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muQ8b-000M15-Rf; Tue, 07 Dec 2021 02:23:25 +0000
Date:   Tue, 7 Dec 2021 10:23:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 15/15] ERROR: modpost:
 "tls_client_hello_user" [net/sunrpc/sunrpc.ko] undefined!
Message-ID: <202112071049.bwW2GUGp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   667fe15e9d8a4b978367248bdf40bcd31620a08d
commit: 667fe15e9d8a4b978367248bdf40bcd31620a08d [15/15] SUNRPC: RPC client support for TLS handshake upcall
config: ia64-defconfig (https://download.01.org/0day-ci/archive/20211207/202112071049.bwW2GUGp-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=667fe15e9d8a4b978367248bdf40bcd31620a08d
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout 667fe15e9d8a4b978367248bdf40bcd31620a08d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "tls_client_hello_user" [net/sunrpc/sunrpc.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
