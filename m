Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7E749FAB9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348647AbiA1NcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:32:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:26542 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241847AbiA1NcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643376744; x=1674912744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hP89d+tDRiAYakC1oCcBtiTpLiS2SQ2fRn+qPnKYpnc=;
  b=JoafpSN/Sa3Dw9CWKxajZ8X7GctWrEGiaoPEI+XLcGgJqjA3mA32iGfN
   pEoVtGrlU/bwnZhvPQPfVAJ8NYgdzTl/TRjv+Ouia6tol7R+xIcdV2GNJ
   q6LKRZG7DTpRqTDEO7u57l8EN7VTc1/arHVQoXlZMtolEAxh4xm4FVvHV
   3wD8Ee0LcChka30g2i+DpAg4ZYPQI12eAdSb+DYDxN3VMyO9pWkJDMbQ0
   kcrQovfdDztq4Jaam2BBYwyxajntATWmvmqKY0Ul45Dc4fEkBhO6I+uP4
   KOywavZjjoXhaAegdsqXMhG8ZIBS+NQT9B9g7DhDKDcqSiCTYCZQBi0Qr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="230696706"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="230696706"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 05:32:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="496133790"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2022 05:32:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDRMT-000Nut-TQ; Fri, 28 Jan 2022 13:32:21 +0000
Date:   Fri, 28 Jan 2022 21:32:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [ammarfaizi2-block:rostedt/linux-trace/ftrace/core 13/13]
 kernel/trace/trace_events_synth.c:65:9: warning: 'strncpy' output truncated
 before terminating nul copying as many bytes from a string as its length
Message-ID: <202201282123.aqslEmh4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/ftrace/core
head:   f125ef075cd648a7794aa0cc61a188b1c40c8f94
commit: f125ef075cd648a7794aa0cc61a188b1c40c8f94 [13/13] tracing: Remove size restriction on synthetic event cmd error logging
config: parisc-randconfig-r011-20220124 (https://download.01.org/0day-ci/archive/20220128/202201282123.aqslEmh4-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f125ef075cd648a7794aa0cc61a188b1c40c8f94
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/ftrace/core
        git checkout f125ef075cd648a7794aa0cc61a188b1c40c8f94
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/trace_events_synth.c: In function 'last_cmd_set.part.0':
>> kernel/trace/trace_events_synth.c:65:9: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
      65 |         strncpy(last_cmd, str, strlen(str));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +65 kernel/trace/trace_events_synth.c

    54	
    55	static void last_cmd_set(const char *str)
    56	{
    57		if (!str)
    58			return;
    59	
    60		kfree(last_cmd);
    61		last_cmd = kzalloc(strlen(str) + 1, GFP_KERNEL);
    62		if (!last_cmd)
    63			return;
    64	
  > 65		strncpy(last_cmd, str, strlen(str));
    66	}
    67	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
