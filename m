Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0A4684F6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385008AbhLDNTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:19:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:8424 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhLDNTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:19:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="217142368"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="217142368"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 05:15:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="678418666"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Dec 2021 05:15:51 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtUtK-000J2A-Fp; Sat, 04 Dec 2021 13:15:50 +0000
Date:   Sat, 4 Dec 2021 21:14:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tero Kristo <tero.kristo@linux.intel.com>
Subject: [t-kristo-pm:usi-5.16-rfc-v3-bpf 5/24] drivers/hid/hid-bpf.c:36:21:
 sparse: sparse: incompatible types in comparison expression (different
 address spaces):
Message-ID: <202112042132.CxoAUnPA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-rfc-v3-bpf
head:   d0f251812c57f49830816624bec858500e4e14c2
commit: 1995666cad0e362400a48617c5486a2a04f4d158 [5/24] HID: initial BPF implementation
config: i386-randconfig-s002-20211203 (https://download.01.org/0day-ci/archive/20211204/202112042132.CxoAUnPA-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/t-kristo/linux-pm/commit/1995666cad0e362400a48617c5486a2a04f4d158
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-rfc-v3-bpf
        git checkout 1995666cad0e362400a48617c5486a2a04f4d158
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/hid/hid-bpf.c:36:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/hid/hid-bpf.c:36:21: sparse:    struct bpf_prog_array [noderef] __rcu *
>> drivers/hid/hid-bpf.c:36:21: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:46:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:46:9: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:46:9: sparse:    struct bpf_prog_array *
>> drivers/hid/hid-bpf.c:59:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:75:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:75:21: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:75:21: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:85:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:85:9: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:85:9: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:98:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:94:5: sparse: sparse: symbol 'hid_bpf_prog_detach' was not declared. Should it be static?
>> drivers/hid/hid-bpf.c:151:27: sparse: sparse: symbol 'hid_prog_ops' was not declared. Should it be static?
>> drivers/hid/hid-bpf.c:184:31: sparse: sparse: symbol 'hid_verifier_ops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

vim +36 drivers/hid/hid-bpf.c

    25	
    26	static int __hid_bpf_prog_attach(struct hid_device *hdev, struct bpf_prog_array **array, struct bpf_prog *prog)
    27	{
    28		struct bpf_prog_array *old_array;
    29		struct bpf_prog_array *new_array;
    30		int ret;
    31	
    32		ret = mutex_lock_interruptible(&hdev->bpf.lock);
    33		if (ret)
    34			return ret;
    35	
  > 36		old_array = hid_bpf_rcu_dereference(*array);
    37		if (old_array && bpf_prog_array_length(old_array) >= BPF_MAX_PROGS) {
    38			ret = -E2BIG;
    39			goto unlock;
    40		}
    41	
    42		ret = bpf_prog_array_copy(old_array, NULL, prog, 0, &new_array);
    43		if (ret < 0)
    44			goto unlock;
    45	
    46		rcu_assign_pointer(*array, new_array);
    47		bpf_prog_array_free(old_array);
    48	
    49	unlock:
    50		mutex_unlock(&hdev->bpf.lock);
    51		return ret;
    52	
    53	}
    54	
    55	static int hid_bpf_prog_attach(struct hid_device *hdev, const union bpf_attr *attr, struct bpf_prog *prog)
    56	{
    57		switch (attr->attach_type) {
    58		case BPF_HID_RAW_EVENT:
  > 59			return __hid_bpf_prog_attach(hdev, &hdev->bpf.event_progs, prog);
    60		}
    61	
    62		return -EINVAL;
    63	}
    64	
    65	static int __hid_bpf_prog_detach(struct hid_device *hdev, struct bpf_prog_array **array, struct bpf_prog *prog)
    66	{
    67		struct bpf_prog_array *old_array;
    68		struct bpf_prog_array *new_array;
    69		int ret;
    70	
    71		ret = mutex_lock_interruptible(&hdev->bpf.lock);
    72		if (ret)
    73			return ret;
    74	
    75		old_array = hid_bpf_rcu_dereference(*array);
    76		ret = bpf_prog_array_copy(old_array, prog, NULL, 0, &new_array);
    77		/*
    78		 * Do not use bpf_prog_array_delete_safe() as we would end up
    79		 * with a dummy entry in the array, and the we would free the
    80		 * dummy in hid_bpf_free()
    81		 */
    82		if (ret)
    83			goto unlock;
    84	
    85		rcu_assign_pointer(*array, new_array);
    86		bpf_prog_array_free(old_array);
    87		bpf_prog_put(prog);
    88	
    89	unlock:
    90		mutex_unlock(&hdev->bpf.lock);
    91		return ret;
    92	}
    93	
    94	int hid_bpf_prog_detach(struct hid_device *hdev, struct bpf_prog *prog)
    95	{
    96		switch(prog->expected_attach_type) {
    97		case BPF_HID_RAW_EVENT:
    98			return __hid_bpf_prog_detach(hdev, &hdev->bpf.event_progs, prog);
    99		default:
   100			return -EINVAL;
   101		}
   102	
   103		return -EINVAL;
   104	}
   105	
   106	static int hid_bpf_prog_query(struct hid_device *hdev, const union bpf_attr *attr, union bpf_attr __user *uattr)
   107	{
   108		__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
   109		struct bpf_prog_array *progs;
   110		u32 cnt, flags = 0;
   111		int ret;
   112	
   113		if (attr->query.query_flags)
   114			return -EINVAL;
   115	
   116		ret = mutex_lock_interruptible(&hdev->bpf.lock);
   117		if (ret)
   118			return ret;
   119	
   120		switch (attr->expected_attach_type) {
   121		case BPF_HID_RAW_EVENT:
   122			progs = hid_bpf_rcu_dereference(hdev->bpf.event_progs);
   123			break;
   124	
   125		default:
   126			ret = -EINVAL;
   127			goto unlock;
   128		}
   129	
   130		cnt = progs ? bpf_prog_array_length(progs) : 0;
   131	
   132		if (copy_to_user(&uattr->query.prog_cnt, &cnt, sizeof(cnt))) {
   133			ret = -EFAULT;
   134			goto unlock;
   135		}
   136	
   137		if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags))) {
   138			ret = -EFAULT;
   139			goto unlock;
   140		}
   141	
   142		if (attr->query.prog_cnt != 0 && prog_ids && cnt)
   143			ret = bpf_prog_array_copy_to_user(progs, prog_ids, attr->query.prog_cnt);
   144	
   145	unlock:
   146		mutex_unlock(&hdev->bpf.lock);
   147		return ret;
   148	
   149	}
   150	
 > 151	const struct bpf_prog_ops hid_prog_ops = {
   152	};
   153	
   154	static const struct bpf_func_proto *
   155	hid_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
   156	{
   157		switch (func_id) {
   158		default:
   159			return bpf_base_func_proto(func_id);
   160		}
   161	}
   162	
   163	static bool hid_is_valid_access(int off, int size,
   164					enum bpf_access_type access_type,
   165					const struct bpf_prog *prog,
   166					struct bpf_insn_access_aux *info)
   167	{
   168		/* everything not in ctx is prohibited */
   169		if (off < 0 || off + size > sizeof(struct hid_bpf_ctx))
   170			return false;
   171	
   172		switch (off) {
   173		/* type, hdev are read-only */
   174		case bpf_ctx_range_till(struct hid_bpf_ctx, type, hdev):
   175			return access_type == BPF_READ;
   176		case bpf_ctx_range(struct hid_bpf_ctx, event):
   177			return true;
   178		/* everything else is read/write */
   179		}
   180	
   181		return true;
   182	}
   183	
 > 184	const struct bpf_verifier_ops hid_verifier_ops = {
   185		.get_func_proto  = hid_func_proto,
   186		.is_valid_access = hid_is_valid_access
   187	};
   188	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
