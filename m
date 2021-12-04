Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDBC4685FB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 16:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345640AbhLDPmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 10:42:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:15326 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234711AbhLDPmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 10:42:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="297927006"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="297927006"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 07:38:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="461294264"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Dec 2021 07:38:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtX7k-000J8i-I7; Sat, 04 Dec 2021 15:38:52 +0000
Date:   Sat, 4 Dec 2021 23:38:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [t-kristo-pm:usi-5.16-rfc-v3-bpf 17/24]
 drivers/hid/hid-bpf.c:229:23: sparse: sparse: symbol 'hid_bpf_add_report'
 was not declared. Should it be static?
Message-ID: <202112042321.22HhAzT8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-rfc-v3-bpf
head:   d0f251812c57f49830816624bec858500e4e14c2
commit: e4c4cfe6fd7edf4bdd3bbd2e408759db9b02290e [17/24] HID: bpf: compile fix for bpf_hid_foreach_rdesc_item
config: i386-randconfig-s002-20211203 (https://download.01.org/0day-ci/archive/20211204/202112042321.22HhAzT8-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/t-kristo/linux-pm/commit/e4c4cfe6fd7edf4bdd3bbd2e408759db9b02290e
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-rfc-v3-bpf
        git checkout e4c4cfe6fd7edf4bdd3bbd2e408759db9b02290e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/hid/hid-bpf.c:36:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:36:21: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:36:21: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:46:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:46:9: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:46:9: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:79:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:81:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:103:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:103:21: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:103:21: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:113:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:113:9: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:113:9: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:147:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:149:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:151:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:151:26: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:151:26: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:214:27: sparse: sparse: symbol 'hid_prog_ops' was not declared. Should it be static?
>> drivers/hid/hid-bpf.c:229:23: sparse: sparse: symbol 'hid_bpf_add_report' was not declared. Should it be static?
>> drivers/hid/hid-bpf.c:257:6: sparse: sparse: symbol 'hid_bpf_free_reports' was not declared. Should it be static?
   drivers/hid/hid-bpf.c:615:31: sparse: sparse: symbol 'hid_verifier_ops' was not declared. Should it be static?
   drivers/hid/hid-bpf.c:844:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bpf_prog const *prog @@     got struct bpf_prog [noderef] __rcu *rdesc_fixup_prog @@
   drivers/hid/hid-bpf.c:898:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bpf_prog *prog @@     got struct bpf_prog [noderef] __rcu *rdesc_fixup_prog @@

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
