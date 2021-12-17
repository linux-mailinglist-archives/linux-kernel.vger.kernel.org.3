Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B26478200
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhLQBUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:20:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:11069 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhLQBUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639704034; x=1671240034;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KdNS2igUlIaBd7oMETpPxnplZBWgkb8hOV7I8TmPuxM=;
  b=FR3WoQdVy/BCixt5uuqYxT+NMktBE1mKnfLdAenfw09vClzMFsxqIw+v
   sa66bF7dHHH1o/a90d1jHYaKMV21/M6Dm9L/3nh4JpB6e3dV+nvi1/ggs
   LM7ykgOZHoh4O+zv0+vmF/vuWKufRyhbiDAOigFW1DBOiPJAuMZB7OyB9
   h+VkqtnJC7oRvviJM25zS5s0rMIPiiZvTYb9Z3EU+/Wn27NtLOYdhrMdK
   g5N7I7SgXD6d3qf8M5Z2jwjl6gQxjzL8TsMS4UegPKQLeE2nniBgpbtxp
   +KKrDqVivH1ouD8VNi8NytO0j0GYbt/WLxbvddAKbGeQv1O0+qwb80OEU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="237190801"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="237190801"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 17:20:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="466307445"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 17:20:32 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my1vE-00043P-6D; Fri, 17 Dec 2021 01:20:32 +0000
Date:   Fri, 17 Dec 2021 09:20:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [t-kristo-pm:usi-5.16-v5-bpf 15/19] drivers/hid/hid-bpf.c:87:52:
 sparse: sparse: incorrect type in argument 2 (different address spaces)
Message-ID: <202112170956.AkNj0dHk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-v5-bpf
head:   82a2c7cbd9682f2664179cd7e01647e46272c316
commit: 8f11b49b2cc9d2bf0e94f43218c8e9de47fd960f [15/19] HID: bpf: change hid_bpf_prog_attach/detach_rdesc to be more generic
config: arm64-randconfig-s031-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170956.AkNj0dHk-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/t-kristo/linux-pm/commit/8f11b49b2cc9d2bf0e94f43218c8e9de47fd960f
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-v5-bpf
        git checkout 8f11b49b2cc9d2bf0e94f43218c8e9de47fd960f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hid/ drivers/pinctrl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/hid/hid-bpf.c:38:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:38:21: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:38:21: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:48:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:48:9: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:48:9: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:68:20: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:68:20: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:68:20: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:68:20: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:68:20: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:68:20: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:83:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:83:59: sparse:     expected struct bpf_prog_array **array
   drivers/hid/hid-bpf.c:83:59: sparse:     got struct bpf_prog_array [noderef] __rcu **
   drivers/hid/hid-bpf.c:85:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:85:59: sparse:     expected struct bpf_prog_array **array
   drivers/hid/hid-bpf.c:85:59: sparse:     got struct bpf_prog_array [noderef] __rcu **
>> drivers/hid/hid-bpf.c:87:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog **target @@     got struct bpf_prog [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:87:52: sparse:     expected struct bpf_prog **target
   drivers/hid/hid-bpf.c:87:52: sparse:     got struct bpf_prog [noderef] __rcu **
   drivers/hid/hid-bpf.c:109:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:109:21: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:109:21: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:119:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:119:9: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:119:9: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:138:20: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:138:20: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:138:20: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:138:20: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:138:20: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:138:20: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:154:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:154:59: sparse:     expected struct bpf_prog_array **array
   drivers/hid/hid-bpf.c:154:59: sparse:     got struct bpf_prog_array [noderef] __rcu **
   drivers/hid/hid-bpf.c:156:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:156:59: sparse:     expected struct bpf_prog_array **array
   drivers/hid/hid-bpf.c:156:59: sparse:     got struct bpf_prog_array [noderef] __rcu **
   drivers/hid/hid-bpf.c:158:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:158:26: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:158:26: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:221:27: sparse: sparse: symbol 'hid_prog_ops' was not declared. Should it be static?
   drivers/hid/hid-bpf.c:236:23: sparse: sparse: symbol 'hid_bpf_add_report' was not declared. Should it be static?
   drivers/hid/hid-bpf.c:264:6: sparse: sparse: symbol 'hid_bpf_free_reports' was not declared. Should it be static?
   drivers/hid/hid-bpf.c:622:31: sparse: sparse: symbol 'hid_verifier_ops' was not declared. Should it be static?
   drivers/hid/hid-bpf.c:816:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bpf_prog const *prog @@     got struct bpf_prog [noderef] __rcu *rdesc_fixup_prog @@
   drivers/hid/hid-bpf.c:868:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bpf_prog *prog @@     got struct bpf_prog [noderef] __rcu *rdesc_fixup_prog @@

vim +87 drivers/hid/hid-bpf.c

    76	
    77	static int hid_bpf_prog_attach(struct hid_device *hdev, const union bpf_attr *attr, struct bpf_prog *prog)
    78	{
    79		int ret;
    80	
    81		switch (attr->attach_type) {
    82		case BPF_HID_RAW_EVENT:
    83			return __hid_bpf_prog_attach_array(hdev, &hdev->bpf.event_progs, prog);
    84		case BPF_HID_KERNEL_EVENT:
    85			return __hid_bpf_prog_attach_array(hdev, &hdev->bpf.kevent_progs, prog);
    86		case BPF_HID_RDESC_FIXUP:
  > 87			ret = __hid_bpf_prog_attach(hdev, &hdev->bpf.rdesc_fixup_prog, prog);
    88			if (ret)
    89				return ret;
    90	
    91			return hid_reconnect(hdev);
    92		}
    93	
    94		return -EINVAL;
    95	}
    96	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
