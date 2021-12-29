Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34981480FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 06:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbhL2FFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 00:05:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:51762 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhL2FFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 00:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640754345; x=1672290345;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NgPYfu7zoHGGFuSzTnIDWRnK89anlYMMDyrAAufhfxo=;
  b=ABkb5epUTaVT0EgYDucx+pQeSbQ9OCjT3CI5MUEjcu8QLlH/pp5O8K8R
   liNfDns7mWbMJkDqS/OyPm4ztl8TW36rJOXjxw3oFfQkifqXqA/Jdr6yS
   LjejHU2zQPUsanSFLQGmzKJKOiUdr2IbDC+qFJkIdBi/Sp0zAmfg4N8n5
   PT/bDWqVWdloStyIuNefwZocud9jRU8v5MbqBdCPbCfM+3YW/SS31r7rV
   NgP+/j8sylNxdOjs2sLH1NLFl5ND/B+lZ1WimLSidR+9VnPl7MKSTnmpi
   2dhhy5vFljIM8DzrlP4YJnjNg0THpru3RYGxyc7912qPEhdQiNfLogtzx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241676228"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="241676228"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 21:05:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="618936152"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Dec 2021 21:05:44 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2R9j-0008XS-Da; Wed, 29 Dec 2021 05:05:43 +0000
Date:   Wed, 29 Dec 2021 13:05:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:kprobe/multi 7/13]
 samples/kprobes/kprobe_example.c:124:5: error: 'struct kprobe' has no member
 named 'multi'
Message-ID: <202112291203.QEXXBIxn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git kprobe/multi
head:   774280c9bc95e4e50cda3cd09324bd03fec50b52
commit: 2bf53e58ccdc41fb37bc2768bfa17ed9f822bf1e [7/13] samples/kprobes: Add support for multi kprobe interface
config: x86_64-randconfig-c022-20211228 (https://download.01.org/0day-ci/archive/20211229/202112291203.QEXXBIxn-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=2bf53e58ccdc41fb37bc2768bfa17ed9f822bf1e
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf kprobe/multi
        git checkout 2bf53e58ccdc41fb37bc2768bfa17ed9f822bf1e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   samples/kprobes/kprobe_example.c: In function 'kprobe_init':
>> samples/kprobes/kprobe_example.c:124:5: error: 'struct kprobe' has no member named 'multi'
     124 |   kp.multi.symbols = (const char **) symbols;
         |     ^
   samples/kprobes/kprobe_example.c:125:5: error: 'struct kprobe' has no member named 'multi'
     125 |   kp.multi.cnt = cnt;
         |     ^


vim +124 samples/kprobes/kprobe_example.c

    98	
    99	static int __init kprobe_init(void)
   100	{
   101		char *p, *tmp, **symbols = NULL;
   102		int cnt, ret;
   103	
   104		kp.pre_handler = handler_pre;
   105		kp.post_handler = handler_post;
   106	
   107		if (strchr(symbol, ',')) {
   108			tmp = kstrdup(symbol, GFP_KERNEL);
   109			if (!tmp)
   110				return -ENOMEM;
   111	
   112			p = strchr(tmp, ',');
   113			while (p) {
   114				*p = ' ';
   115				p = strchr(p + 1, ',');
   116			}
   117	
   118			symbols = argv_split(GFP_KERNEL, tmp, &cnt);
   119			if (!symbols) {
   120				ret = -ENOMEM;
   121				goto out;
   122			}
   123	
 > 124			kp.multi.symbols = (const char **) symbols;
   125			kp.multi.cnt = cnt;
   126		}
   127	
   128		ret = register_kprobe(&kp);
   129		if (ret < 0) {
   130			pr_err("register_kprobe failed, returned %d\n", ret);
   131			goto out;
   132		}
   133	
   134		if (symbols)
   135			pr_info("Planted multi kprobe to %s\n", symbol);
   136		else
   137			pr_info("Planted kprobe at %p\n", kp.addr);
   138	
   139	out:
   140		kfree(tmp);
   141		if (symbols)
   142			argv_free(symbols);
   143		return ret;
   144	}
   145	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
