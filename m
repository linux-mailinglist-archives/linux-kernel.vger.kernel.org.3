Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0479C4A6AAD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244146AbiBBEAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:00:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:61422 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232069AbiBBEAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643774438; x=1675310438;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vcWUoZ0TuetPjMrwbxcGWNQEaVtYZwTvGy9C2RqpUM4=;
  b=UIcUvTGAWk8+3A8ncANab/K2nnRUPYMZUD5AmyerysU9whG4+XLv4OZg
   atbdnpdAqwiNlCED4zd6Gvwxw6nhCo6TyQKIRq/P8eD55pHI0+Oi2Kcmj
   0rRa3G9t/eNpWjtmUN1zuXDrnlu03ykR7XyPFZYEWnSr0VetK3L7S5ERL
   51V57+tJuZaeHmeUWFAWtF5EKq5f9bbylZCp7p3Vzo1Hc+B1sjV5dFwZq
   vpMLk7NbYAHTGPX8Ipr4hVufBD07qnFfmzSv+ekVPruj2mvBncL2wPTEW
   jD+dG9GY1aKaIihsClP5JcF2SQ0ZLKCt23MOtQ+KE6kR6HboxzxiRmslQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="308575383"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="308575383"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 20:00:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="538093039"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Feb 2022 20:00:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nF6ou-000U78-Et; Wed, 02 Feb 2022 04:00:36 +0000
Date:   Wed, 2 Feb 2022 12:00:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 68/167] ERROR: modpost:
 "tdx_vm_init" [arch/x86/kvm/kvm-intel.ko] undefined!
Message-ID: <202202021153.LRePqSPt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   ae19e4b18af5a4b4b7d7b3d9c86614006d0a0216
commit: bbe264453457b346b87dd85571ddd33b1ce5237f [68/167] KVM: TDX: create/destroy VM structure
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220202/202202021153.LRePqSPt-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/bbe264453457b346b87dd85571ddd33b1ce5237f
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout bbe264453457b346b87dd85571ddd33b1ce5237f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "tdx_vm_init" [arch/x86/kvm/kvm-intel.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
