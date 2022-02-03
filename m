Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12064A85BE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351009AbiBCOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:06:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:17208 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350985AbiBCOGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643897176; x=1675433176;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HsvNAv8kzSDaL+asITdsL2k4xIlySdOZpXrVjG0sppo=;
  b=OhzvU8eFIj8kwAd8ijrWiAjEvJo7y9yveoV8yzyJjO4SZy22PVJxqSfg
   eRx3+6JHNbTuPka0qB9U85KnmkZtZDH0pwNL8Qo8C8arFqeCrCRWHCcTV
   hjdXwsl+waPX8J0vBvUWvuqmajqZGrZvej9vFy20E0DlpZ4Uqt/O9sxqb
   jXF3ulZB2hbcvKHI7Dw1AIqlCZ6nc2syMTyQ8NQSA+5Q3tw6wLnjMHdtI
   K7SOwL4PjZ67SZxagmSzaHK3toeqajnlKwCWDHQaeNX++y6sQ9tt96qRy
   qJo8q3Y60IHjj/rarDHRTa5mrh0FNPth/vaW+HF2gzc/PV3iXxwc6NkMc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272644544"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="272644544"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="583797527"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Feb 2022 06:06:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFckY-000WBx-Dv; Thu, 03 Feb 2022 14:06:14 +0000
Date:   Thu, 3 Feb 2022 22:05:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ast-bpf:skel 1/5] kernel/bpf/syscall.c:4794:56: warning: cast to
 pointer from integer of different size
Message-ID: <202202031502.vruI1NMM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git skel
head:   90109bb4d0dabc315c7fa82d193d9e7a54ee18c7
commit: e20a0273d1b34b0a5f1ec45b3ad2038b465f0b54 [1/5] bpf: Extend sys_bpf commands for bpf_syscall programs.
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220203/202202031502.vruI1NMM-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?id=e20a0273d1b34b0a5f1ec45b3ad2038b465f0b54
        git remote add ast-bpf https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git
        git fetch --no-tags ast-bpf skel
        git checkout e20a0273d1b34b0a5f1ec45b3ad2038b465f0b54
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function '____bpf_sys_bpf':
>> kernel/bpf/syscall.c:4794:56: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    4794 |                 attr->test.retval = bpf_prog_run(prog, (void *) attr->test.ctx_in);
         |                                                        ^


vim +4794 kernel/bpf/syscall.c

  4759	
  4760	BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size)
  4761	{
  4762		struct bpf_prog *prog;
  4763	
  4764		switch (cmd) {
  4765		case BPF_MAP_CREATE:
  4766		case BPF_MAP_UPDATE_ELEM:
  4767		case BPF_MAP_FREEZE:
  4768		case BPF_PROG_LOAD:
  4769		case BPF_BTF_LOAD:
  4770		case BPF_LINK_CREATE:
  4771		case BPF_RAW_TRACEPOINT_OPEN:
  4772			break;
  4773		case BPF_PROG_TEST_RUN:
  4774			if (attr->test.data_in || attr->test.data_out ||
  4775			    attr->test.ctx_out || attr->test.duration ||
  4776			    attr->test.repeat || attr->test.flags)
  4777				return -EINVAL;
  4778	
  4779			prog = bpf_prog_get_type(attr->test.prog_fd, BPF_PROG_TYPE_SYSCALL);
  4780			if (IS_ERR(prog))
  4781				return PTR_ERR(prog);
  4782	
  4783			if (attr->test.ctx_size_in < prog->aux->max_ctx_offset ||
  4784			    attr->test.ctx_size_in > U16_MAX) {
  4785				bpf_prog_put(prog);
  4786				return -EINVAL;
  4787			}
  4788	
  4789			if (!__bpf_prog_enter_sleepable(prog)) {
  4790				/* recursion detected */
  4791				bpf_prog_put(prog);
  4792				return -EBUSY;
  4793			}
> 4794			attr->test.retval = bpf_prog_run(prog, (void *) attr->test.ctx_in);
  4795			__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats */);
  4796			bpf_prog_put(prog);
  4797			return 0;
  4798		default:
  4799			return -EINVAL;
  4800		}
  4801		return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size);
  4802	}
  4803	EXPORT_SYMBOL(bpf_sys_bpf);
  4804	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
