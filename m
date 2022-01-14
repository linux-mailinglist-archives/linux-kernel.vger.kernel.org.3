Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4107F48E53F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiANIMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:12:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:51782 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235937AbiANIMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642147952; x=1673683952;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nPR9NTNmHo57PMwfZBShEgqqVxXrKsF4EaJy1sAERr8=;
  b=MuqL6ImgyQPJAn30kO1Wi9Df8A7S9G+KJQYUaty/muRm9ZbB+R5ILTPt
   HQqGPGNDoSKQTiPxA9NBf+UBfuuqv4ksyomsIvz+ArZ4+L+d3giEH928m
   v/ZvE9BU7902f1lrxNOQWf7RryCBZwx2BygZIC6SQmWP7R/bQUld6dX36
   7GzGf+qjw5t8YahUXa3HH8CSAyurcG2onLzV9+m+/SQBopLCkeL5E3g1F
   rRehholn0lIwQBDCUuG/ja4AAobf1tjY0Mvpgnhn1kByzNqP+xi1ntnNF
   baLuR95HrQHvFZeyawxMIIacUAfxjPZlln0S6X5K11/uhiH7umQuXI2yV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244000918"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="244000918"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 00:12:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="475697163"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2022 00:12:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8HhG-0008HM-8A; Fri, 14 Jan 2022 08:12:30 +0000
Date:   Fri, 14 Jan 2022 16:11:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1502/2382]
 ./usr/include/asm-generic/bpf_perf_event.h:4:10: fatal error:
 uapi/linux/ptrace.h: No such file or directory
Message-ID: <202201141653.fspoYEEZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: b5253c772f85973787772c6bd4ee3026cd5d9386 [1502/2382] headers/deps: bpf: Use <uapi/linux/ptrace.h> in <uapi/asm-generic/bpf_perf_event.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220114/202201141653.fspoYEEZ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b5253c772f85973787772c6bd4ee3026cd5d9386
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout b5253c772f85973787772c6bd4ee3026cd5d9386
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/asm/bpf_perf_event.h:1,
                    from ./usr/include/linux/bpf_perf_event.h:11,
                    from <command-line>:32:
>> ./usr/include/asm-generic/bpf_perf_event.h:4:10: fatal error: uapi/linux/ptrace.h: No such file or directory
       4 | #include <uapi/linux/ptrace.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
