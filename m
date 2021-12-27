Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD18480280
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhL0Q5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:57:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:51368 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhL0Q5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640624253; x=1672160253;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N6IRj2BOEi48w6QjzPj5e4XO/BA37Jd5yXOXI+LBQxc=;
  b=fR7u7D15dT2pYQtIs0qC7LsMoq7qOIP+1xeglUGx+ATpBIEQL3OMckDK
   3bDZIydZz2r7ISxYQjiZhTTZ4lD4StmPW1lYMPL7RlFxE/v7sG4qmDiLV
   /ruPvun2t2+cgYkvDcZlbjtQnJPLlY40mTS174gJacODxt7WOTc7C3aaV
   j7THVrcksDXlDAGQA/l+rqIhXqNe98DEWesT0mDyo531GYZZPbhMIiGrK
   /duCN34WCaED0EXS02ieohRDGObgNFWabdNFDe+TbQJ5ABXzm6e0WUGao
   JyEgqTKgXsrqy/LfxzfUB6SBVcj29J87CZKGriKYfWRDxRhV4FIE1TxMX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="265460335"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="265460335"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 08:57:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="572083572"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2021 08:57:30 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1tJS-0006bd-1D; Mon, 27 Dec 2021 16:57:30 +0000
Date:   Tue, 28 Dec 2021 00:57:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:kprobe/multi 8/13] kernel/bpf/syscall.c:3099:32:
 warning: initialization of 'struct kretprobe *' from 'int' makes pointer
 from integer without a cast
Message-ID: <202112280010.ufkJQV03-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git kprobe/multi
head:   bc59262730d5cfc95d6cae84f247d2e8690a309b
commit: 9308a22da930865f9cc80a47f3d0ced38aae1a0a [8/13] bpf: Add kprobe link for attaching raw kprobes
config: nds32-randconfig-r032-20211227 (https://download.01.org/0day-ci/archive/20211228/202112280010.ufkJQV03-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=9308a22da930865f9cc80a47f3d0ced38aae1a0a
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf kprobe/multi
        git checkout 9308a22da930865f9cc80a47f3d0ced38aae1a0a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_perf_link_attach':
   kernel/bpf/syscall.c:3021:17: error: 'ENOTSUP' undeclared (first use in this function); did you mean 'ENOTSUPP'?
    3021 |         return -ENOTSUP;
         |                 ^~~~~~~
         |                 ENOTSUPP
   kernel/bpf/syscall.c:3021:17: note: each undeclared identifier is reported only once for each function it appears in
   kernel/bpf/syscall.c: In function 'kretprobe_dispatcher':
   kernel/bpf/syscall.c:3099:32: error: implicit declaration of function 'get_kretprobe'; did you mean 'get_kprobe'? [-Werror=implicit-function-declaration]
    3099 |         struct kretprobe *rp = get_kretprobe(ri);
         |                                ^~~~~~~~~~~~~
         |                                get_kprobe
>> kernel/bpf/syscall.c:3099:32: warning: initialization of 'struct kretprobe *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   kernel/bpf/syscall.c: In function 'bpf_perf_link_attach':
   kernel/bpf/syscall.c:3022:1: error: control reaches end of non-void function [-Werror=return-type]
    3022 | }
         | ^
   cc1: some warnings being treated as errors


vim +3099 kernel/bpf/syscall.c

  3095	
  3096	static int
  3097	kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
  3098	{
> 3099		struct kretprobe *rp = get_kretprobe(ri);
  3100		struct bpf_kprobe_link *kprobe_link;
  3101	
  3102		kprobe_link = container_of(rp, struct bpf_kprobe_link, rp);
  3103		return kprobe_link_prog_run(kprobe_link, regs);
  3104	}
  3105	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
