Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFC748058E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 02:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhL1Bqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 20:46:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:33856 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234472AbhL1Bqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 20:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640656011; x=1672192011;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fguoMfwsfWdQCYpfU1ujGbRXCyvPhNKnNTDDd+YhCZk=;
  b=C+/HjIYvcz9qEeT61L94S/wE1rVDOos76eRZx3HTLwZ7Lf0tmDkwmGsA
   gZQUW1Rw+9ksFDdUVL31gVtyez/vVL0GMM6Iu8z3k+NEIg4n1JWOvUX0G
   IAKGVGNlLBDfcfaUw1G4ygC1lBPBPLo1SRkBMv311L/XMSOKdqLxSjpz0
   F1tzEKnvUUbeCn5RKJHkO+KPj0q2ETX4nmS3hz2FKvahuDL9QAjBNN3F6
   dmXuV5BIFkq/EvPMZRbezQvHJmlOb6ilr7TRRGJJKWWcq+OpXN8fykNbJ
   p1xqrmZeotQUl/3FOB1KWia0gi8Ui1thmHQkVX8N0fy6TY3YAmeaNAgN8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="240075330"
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="240075330"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 17:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="618610495"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Dec 2021 17:46:45 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n21Zc-00075O-Ll; Tue, 28 Dec 2021 01:46:44 +0000
Date:   Tue, 28 Dec 2021 09:46:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:kprobe/multi 5/13] kprobes.o:undefined reference to
 `kretprobe_blacklist'
Message-ID: <202112280906.Fvszj1xf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git kprobe/multi
head:   bc59262730d5cfc95d6cae84f247d2e8690a309b
commit: 153a69d9b55bec262e53409578c09b0705d035f2 [5/13] kprobe: Add support to register multiple ftrace kretprobes
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20211228/202112280906.Fvszj1xf-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=153a69d9b55bec262e53409578c09b0705d035f2
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf kprobe/multi
        git checkout 153a69d9b55bec262e53409578c09b0705d035f2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: kernel/kprobes.o: in function `check_ftrace_multi':
>> kprobes.o:(.text+0x4850): undefined reference to `kretprobe_blacklist'
>> hppa-linux-ld: kprobes.o:(.text+0x485c): undefined reference to `kretprobe_blacklist'
   hppa-linux-ld: kernel/kprobes.o: in function `.LC38':
   kprobes.o:(.rodata.cst4+0x2c): undefined reference to `kprobe_ftrace_multi_handler'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
