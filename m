Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E380049EE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 23:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244215AbiA0Wcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 17:32:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:53360 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239018AbiA0Wca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643322750; x=1674858750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yIMIyCuJYRxROaLs4sN/pW9D6oG3VPapRovj30YlO5o=;
  b=WCDOc/dAjSbc8HKN6duK7pX+o1v8xMLPHwZfvwoQxkRiApnfraX+mtDg
   1v9epwtvOkzUgLhOcSj2TbqcaXJjV6eVZDdLgvSuYuzl84ruSnQ70a3Mt
   oqWz6zX08Ah1Mfaswho4qU/4C2R5REH52zjYivkdRqxasYz22ZpHwD21C
   np2/uGwU1un5ua0iPU4oc/FidlZB2K08IaGEfun41JiHMRMMG3ENXUeKW
   NMhUmXZ+H1Mtgw+BGHQe0uJMpymbuWPMFLApJKBYuD2sjh0Xb766x41Ed
   MMtOmbATE1dYLXZvgVWJ5lvdpSTNwwOlRiWO/nS38qAr+kTiaAmcv08NE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="244586951"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="244586951"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 14:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="478050000"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2022 14:32:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDDJc-000N7B-DN; Thu, 27 Jan 2022 22:32:28 +0000
Date:   Fri, 28 Jan 2022 06:31:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [davidhildenbrand:single_zone 4/4] drivers/base/memory.c:648:13:
 sparse: sparse: symbol 'early_node_zone_for_memory_block' was not declared.
 Should it be static?
Message-ID: <202201280621.HyzMsDkU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux single_zone
head:   176a3d535903312944f7489127f520c5494bc810
commit: 176a3d535903312944f7489127f520c5494bc810 [4/4] tmp
config: x86_64-randconfig-s021-20220124 (https://download.01.org/0day-ci/archive/20220128/202201280621.HyzMsDkU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/davidhildenbrand/linux/commit/176a3d535903312944f7489127f520c5494bc810
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand single_zone
        git checkout 176a3d535903312944f7489127f520c5494bc810
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/base/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/base/memory.c:648:13: sparse: sparse: symbol 'early_node_zone_for_memory_block' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
