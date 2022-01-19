Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93B493DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356066AbiASQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:07:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:20222 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355844AbiASQHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642608456; x=1674144456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xbh6oY7x3+ATxewkND+lIO4cNUs8cLzZEMO58y889FM=;
  b=S+YG1sU3b63nY5GP2Qa7pVjbe0yV79MhDkYf2D2h0gxpwZz6hsB888xS
   P1MlM6csw4UdqfCab4S+cFcjbUGFXI+xCs6m+9gp7Wnr09VEfaDhKyopo
   nY1/e3O12kbExCIdBrAKc1ESJp4Pv+62RyFY3/aCYvcA8Di/Ih7jgVzM2
   PzwD62IX8su0New03rXnP+Uc4oG0u6hcBJ3Q1Bd4mPc+NanerYMdBarcC
   dWxtZo29HlqiW+x7Nsu9lNu/D8Nz/s0ttXUQ25CVs4o/c2ofngp/nn73t
   cwC9p1ZsvU2fxIwr9GwLlcdkIZwCLULjKfKPSBI251gkkZNhgAGr7gjKW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="225772518"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="225772518"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 08:07:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="578856437"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2022 08:07:34 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nADUk-000Dci-7Z; Wed, 19 Jan 2022 16:07:34 +0000
Date:   Thu, 20 Jan 2022 00:06:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: net/bpf/bpf_dummy_struct_ops.c:122:6: error: unexpected token,
 expected comma
Message-ID: <202201200024.lLbhNvJC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d1df41c5a33359a00e919d54eaebfb789711fdc
commit: c196906d50e360d82ed9aa5596a9d0ce89b7ab78 bpf: Add dummy BPF STRUCT_OPS for test purpose
date:   3 months ago
config: mips-randconfig-r003-20220118 (https://download.01.org/0day-ci/archive/20220120/202201200024.lLbhNvJC-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c196906d50e360d82ed9aa5596a9d0ce89b7ab78
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c196906d50e360d82ed9aa5596a9d0ce89b7ab78
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/cxl/ mm// net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/bpf/bpf_dummy_struct_ops.c:122:6: error: unexpected token, expected comma
           if (put_user(prog_ret, &uattr->test.retval))
               ^
   arch/mips/include/asm/uaccess.h:112:33: note: expanded from macro 'put_user'
           access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
                                          ^
   arch/mips/include/asm/uaccess.h:177:18: note: expanded from macro '__put_user'
                   __put_data_asm(user_sw, __pu_ptr);                      \
                                  ^
   <inline asm>:3:10: note: instantiated into assembly here
           .set    eva
                      ^
>> net/bpf/bpf_dummy_struct_ops.c:122:6: error: invalid operand for instruction
           if (put_user(prog_ret, &uattr->test.retval))
               ^
   arch/mips/include/asm/uaccess.h:112:33: note: expanded from macro 'put_user'
           access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
                                          ^
   arch/mips/include/asm/uaccess.h:177:18: note: expanded from macro '__put_user'
                   __put_data_asm(user_sw, __pu_ptr);                      \
                                  ^
   <inline asm>:4:11: note: instantiated into assembly here
           swe $19, 0($2)
                    ^
   2 errors generated.


vim +122 net/bpf/bpf_dummy_struct_ops.c

    74	
    75	int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
    76				    union bpf_attr __user *uattr)
    77	{
    78		const struct bpf_struct_ops *st_ops = &bpf_bpf_dummy_ops;
    79		const struct btf_type *func_proto;
    80		struct bpf_dummy_ops_test_args *args;
    81		struct bpf_tramp_progs *tprogs;
    82		void *image = NULL;
    83		unsigned int op_idx;
    84		int prog_ret;
    85		int err;
    86	
    87		if (prog->aux->attach_btf_id != st_ops->type_id)
    88			return -EOPNOTSUPP;
    89	
    90		func_proto = prog->aux->attach_func_proto;
    91		args = dummy_ops_init_args(kattr, btf_type_vlen(func_proto));
    92		if (IS_ERR(args))
    93			return PTR_ERR(args);
    94	
    95		tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
    96		if (!tprogs) {
    97			err = -ENOMEM;
    98			goto out;
    99		}
   100	
   101		image = bpf_jit_alloc_exec(PAGE_SIZE);
   102		if (!image) {
   103			err = -ENOMEM;
   104			goto out;
   105		}
   106		set_vm_flush_reset_perms(image);
   107	
   108		op_idx = prog->expected_attach_type;
   109		err = bpf_struct_ops_prepare_trampoline(tprogs, prog,
   110							&st_ops->func_models[op_idx],
   111							image, image + PAGE_SIZE);
   112		if (err < 0)
   113			goto out;
   114	
   115		set_memory_ro((long)image, 1);
   116		set_memory_x((long)image, 1);
   117		prog_ret = dummy_ops_call_op(image, args);
   118	
   119		err = dummy_ops_copy_args(args);
   120		if (err)
   121			goto out;
 > 122		if (put_user(prog_ret, &uattr->test.retval))
   123			err = -EFAULT;
   124	out:
   125		kfree(args);
   126		bpf_jit_free_exec(image);
   127		kfree(tprogs);
   128		return err;
   129	}
   130	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
