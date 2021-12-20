Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AAF47B1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbhLTRCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:02:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:5251 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239926AbhLTRCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640019750; x=1671555750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nr0RyzS4So4IexhjbOwLJPNn/M4Hd8nuHZ5v80C4w8o=;
  b=oAuFUXxD+NhEyBrhSNvroED9h++M9Fe6VE55AVEWL2OoEiDZQTp/Ljpx
   0dTyLDx5JL8D5kr9bB3kiccWbwoFuWnLo2Rh0lBmThJMcBHcTdTcbVxIA
   LcIrEMgAZMCW6HGIRskVY0qRdRgXN+B9y8TlhJvuIR8gJP5hwMPuFKpZO
   ldf6RkD83XVcmRuAZNLEgvkL87u58H7mdvOl1ikmoIT0hpPnxog8G/j3m
   No0pfdxt68EqX/uNmQONHg5AEGSnCB7exDuvjW00Wr5g+WOM0+1XepecA
   rla1oBU15xhCMl9TazU/r464R3e8VqtLaJbtfqUYuiRlZ2koAoRgki/Uq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="220899788"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="220899788"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 09:02:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="484120413"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2021 09:02:13 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzM3B-00081H-1h; Mon, 20 Dec 2021 17:02:13 +0000
Date:   Tue, 21 Dec 2021 01:01:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Error: failed to load BTF from
 /kbuild/obj/consumer/x86_64-rhel-8.3-kselftests/vmlinux: Invalid argument
Message-ID: <202112210104.lQLxELOy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a7904a538933c525096ca2ccde1e60d0ee62c08e
commit: db16c1fe92d7ba7d39061faef897842baee2c887 bpf: Generate BTF_KIND_FLOAT when linking vmlinux
date:   8 months ago
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20211221/202112210104.lQLxELOy-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db16c1fe92d7ba7d39061faef897842baee2c887
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout db16c1fe92d7ba7d39061faef897842baee2c887
        # save the config file to linux build tree
        make W=1 ARCH=x86_64 SHELL=/bin/bash tools/all

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: failed to load BTF from /kbuild/obj/consumer/x86_64-rhel-8.3-kselftests/vmlinux: Invalid argument
   make[5]: *** [Makefile:140: /kbuild/worktree/build-ktools-consumer/tools/bpf/runqslower/.output/vmlinux.h] Error 22
   make[4]: *** [Makefile:84: .output/sbin/bpftool] Error 2
   make[3]: *** [Makefile:119: runqslower] Error 2
   make[3]: *** Waiting for unfinished jobs....
>> Error: failed to load BTF from /kbuild/obj/consumer/x86_64-rhel-8.3-kselftests/vmlinux: Invalid argument
   make[4]: *** [Makefile:140: /kbuild/obj/consumer/x86_64-rhel-8.3-kselftests/tools/bpf/bpftool/vmlinux.h] Error 22
   make[3]: *** [Makefile:110: bpftool] Error 2

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
