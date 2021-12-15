Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B2E47560D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbhLOKQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:16:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:22598 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhLOKQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639563418; x=1671099418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N1bnE2MaC7ppbJ+K9AtlutnOd4jq2oXcq3ZwkAs4BOA=;
  b=Q1VhnTqde/of4sRNu8SHvadQgg9aXtqnYjejkRuHfimGdDC5TlxgsFZl
   rykvQsuX3c7e2pihbiYVWulFJytBnUDO0NDDJz+RhQ5E5cFnJiUZ4dYb4
   Y951VM8+KndXNA0Jg/ccdlXcyuIz5XYKvgqnKqbfnYwjtbtshap1OxTpw
   ryX/iaYxYPnqFVa9H+tjabdW/A+iSIA0NmRwrfSfGErUrJvjNlQcYSIdv
   Cc9ViZoJfFbayr6U1arNDQ+BxGenpWqAC4QmXJOCk9wNtzhb1sSCsDOcL
   KOD17PwiTr8cLJhCvJAeYVewCEvMn8w1rm5xL/XBQOiBwv2gms8wRuhrO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="325475108"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="325475108"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 02:16:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="465530775"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2021 02:16:56 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxRLD-0001bV-RE; Wed, 15 Dec 2021 10:16:55 +0000
Date:   Wed, 15 Dec 2021 18:15:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Error: failed to load BTF from
 /kbuild/obj/consumer/x86_64-randconfig-a004-20211215/vmlinux: No such file
 or directory
Message-ID: <202112151834.E4Cf3891-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
commit: 66d9282523b3228183b14d9f812872dd2620704d mm/page_alloc: Correct return value of populated elements if bulk array is populated
date:   6 months ago
config: x86_64-randconfig-a004-20211215 (https://download.01.org/0day-ci/archive/20211215/202112151834.E4Cf3891-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66d9282523b3228183b14d9f812872dd2620704d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 66d9282523b3228183b14d9f812872dd2620704d
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 SHELL=/bin/bash tools/all

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: failed to load BTF from /kbuild/obj/consumer/x86_64-randconfig-a004-20211215/vmlinux: No such file or directory
   make[4]: *** [Makefile:180: /kbuild/obj/consumer/x86_64-randconfig-a004-20211215/tools/bpf/bpftool/vmlinux.h] Error 2
   make[4]: *** Waiting for unfinished jobs....
   make[3]: *** [Makefile:110: bpftool] Error 2
   make[3]: *** Waiting for unfinished jobs....
>> Error: failed to load BTF from /kbuild/obj/consumer/x86_64-randconfig-a004-20211215/vmlinux: No such file or directory
   make[5]: *** [Makefile:180: /kbuild/obj/consumer/x86_64-randconfig-a004-20211215/tools/bpf/runqslower/bpftool/vmlinux.h] Error 2
   make[4]: *** [Makefile:90: /kbuild/obj/consumer/x86_64-randconfig-a004-20211215/tools/bpf/runqslower/bpftool/bpftool] Error 2
   make[3]: *** [Makefile:119: runqslower] Error 2

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
