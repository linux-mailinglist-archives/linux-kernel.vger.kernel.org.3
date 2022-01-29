Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13C64A3222
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 22:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353260AbiA2V6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 16:58:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:61873 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243871AbiA2V57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 16:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643493479; x=1675029479;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3uVJ7YJyh4EB2MMWlMTEaRxNHgtHzgBik6bYh5fyvkg=;
  b=BhtI0wVpOrNrldMyUQyEV90crpLj9kJLEP+Dbjk5TEwntRCS0HIoDymc
   2FQasQz4nYwjC9Mm3IuCfvRFVJGHkwE1VQ3l9f2P3sWpdP44Jg8sxgMGa
   JnlhJ5dUnHAOCQqgZ+VDMYvHEZKXX1IKSpW+WJNGbFFzb7G/nqAplNNwj
   Z8O5pLUXT0tVGLIlkbGKIe0d6HKEzbnFuQ+sEo11bfvzzoqlOLZiGd4r/
   znX/aqfU48F11MXFfOe/c+IvZqLaDi/GnwUxI5cDvyvTnmzsOPQ36HZAz
   ZZj6fkppSjMUzm/5cP12HNuqsrTt+j7WXPBaJEUOjfBA8duxRewRMRoXs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="227965443"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="227965443"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 13:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="770418807"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jan 2022 13:57:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDvjJ-000PgT-MB; Sat, 29 Jan 2022 21:57:57 +0000
Date:   Sun, 30 Jan 2022 05:57:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: collect2: error: ld returned 1 exit status
Message-ID: <202201300518.Q1ZGEJYY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexei,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cb323ee75d24e7acc2f188d123ba6df46159cf09
commit: d71fa5c9763c24dd997a2fa4feb7a13a95bab42c bpf: Add kernel module with user mode driver that populates bpffs.
date:   1 year, 5 months ago
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220130/202201300518.Q1ZGEJYY-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d71fa5c9763c24dd997a2fa4feb7a13a95bab42c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d71fa5c9763c24dd997a2fa4feb7a13a95bab42c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: skipping incompatible /usr/lib/x86_64-linux-gnu/libelf.so when searching for -lelf
   /usr/bin/ld: skipping incompatible /usr/lib/x86_64-linux-gnu/libelf.a when searching for -lelf
   /usr/bin/ld: cannot find -lelf
   /usr/bin/ld: skipping incompatible /usr/lib/x86_64-linux-gnu/libelf.so when searching for -lelf
   /usr/bin/ld: skipping incompatible /usr/lib/x86_64-linux-gnu/libz.so when searching for -lz
   /usr/bin/ld: skipping incompatible /usr/lib/x86_64-linux-gnu/libz.a when searching for -lz
   /usr/bin/ld: cannot find -lz
   /usr/bin/ld: skipping incompatible /usr/lib/x86_64-linux-gnu/libz.so when searching for -lz
>> collect2: error: ld returned 1 exit status

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
