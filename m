Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A72497B07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiAXJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:07:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:19243 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236407AbiAXJH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643015247; x=1674551247;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ANmmsgI45eUwG7SYlBwEQ7Ek8Xv052sncdNciT50LJ4=;
  b=GEYgjx63jJPambwB5TU/atIkgTP9zmcPieZiUHT+iJh5MkWZI7KkpPaU
   3AumqiqZjk8VS6pFvbLssD4qOE9q7jNNhw4F8uQq2LltsWAu3mV/WVuEv
   KdQCf9z5WThe6nLWhJqvBEKf/rcJDmfmxPW3APjCUb1ZHw7KO1nS/UVR1
   SfB9nakerNUqLM+xJE41mdR4kiqWohinQDIOeok5uo+67f2E7xS9Agb0a
   7DANS/9WkTg5p8ki47CJwZhzYwhdgkKYGLqAHycjmsZ+xcA87LYuM59pd
   iCdEb6reE/gbPQ2UdSfCDep5RPoh2IkEbHoEqyt7bP8z634dqV2D/w/f/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245946749"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245946749"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 01:07:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596732330"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2022 01:07:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBvJs-000I4v-Te; Mon, 24 Jan 2022 09:07:24 +0000
Date:   Mon, 24 Jan 2022 17:07:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 15/18] arc-elf-ld:
 af_tlsh.c:undefined reference to `inet6_recvmsg'
Message-ID: <202201241735.neUrpkni-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   da4c27539d2deaa2b9624c470a903b880497e398
commit: 2d835a81bb38c6378f4cc53d0eb2320248a11a4c [15/18] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: arc-randconfig-r043-20220123 (https://download.01.org/0day-ci/archive/20220124/202201241735.neUrpkni-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=2d835a81bb38c6378f4cc53d0eb2320248a11a4c
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout 2d835a81bb38c6378f4cc53d0eb2320248a11a4c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: net/tls/af_tlsh.o: in function `tlsh_recvmsg':
   af_tlsh.c:(.text+0xc2): undefined reference to `inet6_recvmsg'
>> arc-elf-ld: af_tlsh.c:(.text+0xc2): undefined reference to `inet6_recvmsg'
   arc-elf-ld: net/tls/af_tlsh.o: in function `tlsh_sendmsg':
   af_tlsh.c:(.text+0xde): undefined reference to `inet6_sendmsg'
>> arc-elf-ld: af_tlsh.c:(.text+0xde): undefined reference to `inet6_sendmsg'
   arc-elf-ld: net/tls/af_tlsh.o: in function `tlsh_getname':
   af_tlsh.c:(.text+0x12a): undefined reference to `inet6_getname'
>> arc-elf-ld: af_tlsh.c:(.text+0x12a): undefined reference to `inet6_getname'
   arc-elf-ld: net/tls/af_tlsh.o: in function `tlsh_release':
   af_tlsh.c:(.text+0x4f6): undefined reference to `inet6_release'
>> arc-elf-ld: af_tlsh.c:(.text+0x4f6): undefined reference to `inet6_release'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
