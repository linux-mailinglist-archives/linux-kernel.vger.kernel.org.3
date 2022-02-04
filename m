Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8427E4A97E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357802AbiBDKcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:32:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:15289 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231259AbiBDKcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643970738; x=1675506738;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SEicvIAPb5hGpZodOcw1U2NYpLEQGwVOn+uul1O+Xuo=;
  b=mT7L36YlpfEfGHLOkliCHqIHTHY199ETLEUQ9B0o1/XMB7O3HCp1kjDf
   Vg+/SzU+6WZLASb8WUHMV2ozHYZFS29qAx5MmDzEBagofiUFHuzaX5492
   SMe7j9gNXUtp2cvKmkt1YhNoZVj3S4PvUZWFf7GBWsBcrkfgzJExk8kP1
   rSPQxlExKPBDMi3tuanaYVxSlPwqIUDvrbDBBzcHX8dZPHhmltUpgxEVE
   zNnh+4kJ4J8yZmLRJIrgYFFP/JhBgxIJJDWqQ6gv8urYO5vimOj4OYnB6
   0WM+CuSsrR8hU1RWgqGZca6fqBqJHq7URrskeCFcyjeu0lnofqv27vE3Z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="247178765"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="247178765"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 02:32:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="539124687"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Feb 2022 02:32:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFvt1-000XTh-S5; Fri, 04 Feb 2022 10:32:15 +0000
Date:   Fri, 4 Feb 2022 18:31:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nsaenz-rpi:pcplists-rcu-drain-v1 1/2] mm/page_alloc.c:1481:30:
 sparse: sparse: incorrect type in assignment (different modifiers)
Message-ID: <202202041807.DLd23Ex7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git pcplists-rcu-drain-v1
head:   01b58921eae8d67b3ad6b05e73c2a1dd7106ae28
commit: eb4d0c9ef79083312513bfbbf26d6ef7defcc6b3 [1/2] mm/page_alloc: Access lists in 'struct per_cpu_pages' indirectly
config: h8300-randconfig-s032-20220201 (https://download.01.org/0day-ci/archive/20220204/202202041807.DLd23Ex7-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git/commit/?id=eb4d0c9ef79083312513bfbbf26d6ef7defcc6b3
        git remote add nsaenz-rpi https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
        git fetch --no-tags nsaenz-rpi pcplists-rcu-drain-v1
        git checkout eb4d0c9ef79083312513bfbbf26d6ef7defcc6b3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/page_alloc.c:1481:30: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct list_head *list @@     got struct list_head [noderef] * @@
   mm/page_alloc.c:1481:30: sparse:     expected struct list_head *list
   mm/page_alloc.c:1481:30: sparse:     got struct list_head [noderef] *
>> mm/page_alloc.c:3442:40: sparse: sparse: incorrect type in argument 2 (different modifiers) @@     expected struct list_head *head @@     got struct list_head [noderef] * @@
   mm/page_alloc.c:3442:40: sparse:     expected struct list_head *head
   mm/page_alloc.c:3442:40: sparse:     got struct list_head [noderef] *
   mm/page_alloc.c:3733:14: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct list_head *list @@     got struct list_head [noderef] * @@
   mm/page_alloc.c:3733:14: sparse:     expected struct list_head *list
   mm/page_alloc.c:3733:14: sparse:     got struct list_head [noderef] *
>> mm/page_alloc.c:3734:15: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected int *count @@     got int [noderef] * @@
   mm/page_alloc.c:3734:15: sparse:     expected int *count
   mm/page_alloc.c:3734:15: sparse:     got int [noderef] *
>> mm/page_alloc.c:5356:18: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct list_head *pcp_list @@     got struct list_head [noderef] * @@
   mm/page_alloc.c:5356:18: sparse:     expected struct list_head *pcp_list
   mm/page_alloc.c:5356:18: sparse:     got struct list_head [noderef] *
   mm/page_alloc.c:5357:15: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected int *count @@     got int [noderef] * @@
   mm/page_alloc.c:5357:15: sparse:     expected int *count
   mm/page_alloc.c:5357:15: sparse:     got int [noderef] *
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
   mm/page_alloc.c:6068:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct per_cpu_pages [noderef] __percpu ** @@
   mm/page_alloc.c:6068:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   mm/page_alloc.c:6068:17: sparse:     got struct per_cpu_pages [noderef] __percpu **
>> mm/page_alloc.c:7022:47: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct list_head *list @@     got struct list_head [noderef] * @@
   mm/page_alloc.c:7022:47: sparse:     expected struct list_head *list
   mm/page_alloc.c:7022:47: sparse:     got struct list_head [noderef] *
>> mm/page_alloc.c:1466:17: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:1521:9: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3163:13: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3164:42: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3277:29: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3282:37: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3443:9: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3445:13: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c: note: in included file (through include/linux/mm.h):
   include/linux/gfp.h:368:27: sparse: sparse: restricted gfp_t degrades to integer
   include/linux/gfp.h:368:27: sparse: sparse: restricted gfp_t degrades to integer
   mm/page_alloc.c:5971:76: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:6065:76: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:6068:17: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:6068:17: sparse: sparse: dereference of noderef expression

vim +1481 mm/page_alloc.c

  1445	
  1446	/*
  1447	 * Frees a number of pages from the PCP lists
  1448	 * Assumes all pages on list are in same zone.
  1449	 * count is the number of pages to free.
  1450	 */
  1451	static void free_pcppages_bulk(struct zone *zone, int count,
  1452				       int batch, struct pcplists *lp)
  1453	{
  1454		int pindex = 0;
  1455		int batch_free = 0;
  1456		int nr_freed = 0;
  1457		unsigned int order;
  1458		bool isolated_pageblocks;
  1459		struct page *page, *tmp;
  1460		LIST_HEAD(head);
  1461	
  1462		/*
  1463		 * Ensure proper count is passed which otherwise would stuck in the
  1464		 * below while (list_empty(list)) loop.
  1465		 */
> 1466		count = min(lp->count, count);
  1467		while (count > 0) {
  1468			struct list_head *list;
  1469	
  1470			/*
  1471			 * Remove pages from lists in a round-robin fashion. A
  1472			 * batch_free count is maintained that is incremented when an
  1473			 * empty list is encountered.  This is so more pages are freed
  1474			 * off fuller lists instead of spinning excessively around empty
  1475			 * lists
  1476			 */
  1477			do {
  1478				batch_free++;
  1479				if (++pindex == NR_PCP_LISTS)
  1480					pindex = 0;
> 1481				list = &lp->lists[pindex];
  1482			} while (list_empty(list));
  1483	
  1484			/* This is the only non-empty list. Free them all. */
  1485			if (batch_free == NR_PCP_LISTS)
  1486				batch_free = count;
  1487	
  1488			order = pindex_to_order(pindex);
  1489			BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_WIDTH));
  1490			do {
  1491				page = list_last_entry(list, struct page, lru);
  1492				/* must delete to avoid corrupting pcp list */
  1493				list_del(&page->lru);
  1494				nr_freed += 1 << order;
  1495				count -= 1 << order;
  1496	
  1497				if (bulkfree_pcp_prepare(page))
  1498					continue;
  1499	
  1500				/* Encode order with the migratetype */
  1501				page->index <<= NR_PCP_ORDER_WIDTH;
  1502				page->index |= order;
  1503	
  1504				list_add_tail(&page->lru, &head);
  1505	
  1506				/*
  1507				 * We are going to put the page back to the global
  1508				 * pool, prefetch its buddy to speed up later access
  1509				 * under zone->lock. It is believed the overhead of
  1510				 * an additional test and calculating buddy_pfn here
  1511				 * can be offset by reduced memory latency later. To
  1512				 * avoid excessive prefetching due to large count, only
  1513				 * prefetch buddy for the first pcp->batch nr of pages.
  1514				 */
  1515				if (batch) {
  1516					prefetch_buddy(page);
  1517					batch--;
  1518				}
  1519			} while (count > 0 && --batch_free && !list_empty(list));
  1520		}
  1521		lp->count -= nr_freed;
  1522	
  1523		/*
  1524		 * local_lock_irq held so equivalent to spin_lock_irqsave for
  1525		 * both PREEMPT_RT and non-PREEMPT_RT configurations.
  1526		 */
  1527		spin_lock(&zone->lock);
  1528		isolated_pageblocks = has_isolate_pageblock(zone);
  1529	
  1530		/*
  1531		 * Use safe version since after __free_one_page(),
  1532		 * page->lru.next will not point to original list.
  1533		 */
  1534		list_for_each_entry_safe(page, tmp, &head, lru) {
  1535			int mt = get_pcppage_migratetype(page);
  1536	
  1537			/* mt has been encoded with the order (see above) */
  1538			order = mt & NR_PCP_ORDER_MASK;
  1539			mt >>= NR_PCP_ORDER_WIDTH;
  1540	
  1541			/* MIGRATE_ISOLATE page should not go to pcplists */
  1542			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
  1543			/* Pageblock could have been isolated meanwhile */
  1544			if (unlikely(isolated_pageblocks))
  1545				mt = get_pageblock_migratetype(page);
  1546	
  1547			__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
  1548			trace_mm_page_pcpu_drain(page, order, mt);
  1549		}
  1550		spin_unlock(&zone->lock);
  1551	}
  1552	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
