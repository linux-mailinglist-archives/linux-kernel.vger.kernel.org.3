Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D391346B0B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbhLGCh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:37:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:24882 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232285AbhLGCh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:37:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="261537629"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="261537629"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 18:34:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="462121764"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2021 18:34:26 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muQJG-000M1v-9S; Tue, 07 Dec 2021 02:34:26 +0000
Date:   Tue, 7 Dec 2021 10:33:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 15/15] xprtsock.c:undefined reference
 to `tls_client_hello_user'
Message-ID: <202112071022.scSDFcie-lkp@intel.com>
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
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20211207/202112071022.scSDFcie-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=667fe15e9d8a4b978367248bdf40bcd31620a08d
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout 667fe15e9d8a4b978367248bdf40bcd31620a08d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: net/sunrpc/xprtsock.o: in function `xs_tcp_tls_handshake_async':
>> xprtsock.c:(.text+0x75c): undefined reference to `tls_client_hello_user'
   xprtsock.c:(.text+0x75c): relocation truncated to fit: R_NIOS2_CALL26 against `tls_client_hello_user'
   nios2-linux-ld: net/sunrpc/xprtsock.o: in function `xs_tcp_tls_handshake_sync':
   xprtsock.c:(.text+0x7d8): undefined reference to `tls_client_hello_user'
   xprtsock.c:(.text+0x7d8): relocation truncated to fit: R_NIOS2_CALL26 against `tls_client_hello_user'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
