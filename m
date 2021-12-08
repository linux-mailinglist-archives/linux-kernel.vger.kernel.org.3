Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D9746C899
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbhLHA0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:26:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:50143 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239976AbhLHA0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:26:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237530276"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="237530276"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 16:21:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="679671642"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2021 16:21:17 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mukhx-000N7c-2w; Wed, 08 Dec 2021 00:21:17 +0000
Date:   Wed, 8 Dec 2021 08:21:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander K <ak@tempesta-tech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:topic-rpc-with-tls 1/9] net/tls/tls_internal.h:29:10: fatal
 error: asm/fpu/api.h: No such file or directory
Message-ID: <202112080816.X2h68yRr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls
head:   0a17eed0a75672ad449f0b8c8dbe8d67220003f9
commit: 674ca98f07d168e6fbeea6852b81d3536b26d864 [1/9] Port of Tempesta TLS handshakes to the Linux 5.10.68
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112080816.X2h68yRr-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=674ca98f07d168e6fbeea6852b81d3536b26d864
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls
        git checkout 674ca98f07d168e6fbeea6852b81d3536b26d864
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from net/tls/dhm.c:34:
>> net/tls/tls_internal.h:29:10: fatal error: asm/fpu/api.h: No such file or directory
      29 | #include <asm/fpu/api.h>
         |          ^~~~~~~~~~~~~~~
   compilation terminated.
--
>> net/tls/ttls.c:28:10: fatal error: asm/fpu/api.h: No such file or directory
      28 | #include <asm/fpu/api.h>
         |          ^~~~~~~~~~~~~~~
   compilation terminated.
--
>> net/tls/bignum_x86-64.S:21:10: fatal error: asm/export.h: No such file or directory
      21 | #include <asm/export.h>
         |          ^~~~~~~~~~~~~~
   compilation terminated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CRYPTO_SHA1_SSSE3
   Depends on CRYPTO && X86 && 64BIT
   Selected by
   - TLS_HANDSHAKE && NET && TLS


vim +29 net/tls/tls_internal.h

    27	
    28	#include <linux/types.h>
  > 29	#include <asm/fpu/api.h>
    30	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
