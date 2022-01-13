Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CCF48D557
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiAMKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:01:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:14926 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232699AbiAMKBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642068100; x=1673604100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XiJnz2HvbclBbjtnG/Bu+gUXsSJjh4bYfAYYOcAa/kA=;
  b=mj77h6Jq29uToDWS57P7qxxM0zSvSyDJ32xkW3OLUG5bZ4cAsaZd+k1d
   bf6KULe0+QrA+vcS4mnTNhmj2D4O1F1nbYWmfasExmzyaFOGD826NoaF+
   JqSVlRCa2o395RT0d1xIGtjPvzwAW+ctY6bTGrX7he26RwqxJ+K3HLwq8
   PklMLUtEzwEywsbcoj87EKipphcNLytagOz33nWvGX8ExPfnt4N0Sa9Fc
   /s5T1s5yVVEfZClvmYWvZqwKvP1EeEWN9BQvksCtELCE1idv7e3EACdE2
   HeNhw7R2pDjLZYs1ywNPR4DPGgXOE+eF7RdTn1JdKDN5xqzl0A31D4zH5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242793202"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242793202"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:01:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="691748471"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2022 02:01:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7wvJ-00074T-R3; Thu, 13 Jan 2022 10:01:37 +0000
Date:   Thu, 13 Jan 2022 18:01:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 18/19] xprtsock.c:undefined reference
 to `tls_client_hello_user'
Message-ID: <202201131717.0cAQPcmU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   0fd328ea53e7d539bf8bb160d773e1d027c60fea
commit: adb54a631895e050da6ed9a18f9b503f927b642d [18/19] SUNRPC: RPC client support for TLS handshake upcall
config: m68k-mvme16x_defconfig (https://download.01.org/0day-ci/archive/20220113/202201131717.0cAQPcmU-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=adb54a631895e050da6ed9a18f9b503f927b642d
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout adb54a631895e050da6ed9a18f9b503f927b642d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: net/sunrpc/xprtsock.o: in function `xs_tcp_tls_handshake_async':
>> xprtsock.c:(.text+0x8cc): undefined reference to `tls_client_hello_user'
   m68k-linux-ld: net/sunrpc/xprtsock.o: in function `xs_tcp_tls_handshake_sync':
   xprtsock.c:(.text+0x958): undefined reference to `tls_client_hello_user'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
