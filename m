Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2756D4D78E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 01:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiCNASD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 20:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiCNAR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 20:17:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F06432B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 17:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647217008; x=1678753008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FzP7/R1vz6/0gooNdhTFj/f/GipTNRZSpNhdFVE26Rk=;
  b=WRBlry8ygMbU3/AERnYIHmx16pVkG0/iyC0/wDhKlSuBuyO2gHFpsF/5
   myy5QKAPKLzxNHVjA1EaHW8HxfCHFsVMRdrsvMBNJDs7iRCAL6mzaJ2It
   /9RNHojHWBpDmOYH5RS2SdVtlcz7eD7VepYQHJ5kbfwh8/4Iktqbx5jHi
   JEeMhbVBzOCrBkHPwGTZCJsYf1daM603j9xlwCz43GJLAbbuuca8+hM/A
   MifCKNwMvtr6g2VEL/PfFZbo/iezLhKHWE1RKOQCRUyku61zpD4RFeyQr
   g3+djf+rBY9MHoi+LDp/QIf9SJJvzfsgqde5hmME7lz2zVw/+4bf/dNWT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="238079874"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="238079874"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 17:16:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="497413071"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Mar 2022 17:16:45 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTYOC-0009Pi-Qf; Mon, 14 Mar 2022 00:16:44 +0000
Date:   Mon, 14 Mar 2022 08:16:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: [toke:xdp-queueing-03 7/9] kernel/bpf/verifier.c:1580:39: sparse:
 sparse: mixing different enum types:
Message-ID: <202203140808.WyoqkliI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-03
head:   3e7f25d58b1bfd5ad623678bf9e11f27c98a8094
commit: 28d9ca982b9ae96bcad2bee81647ba18ae049a69 [7/9] bpf: Enable direct packet access for dequeue packets
config: s390-randconfig-s031-20220313 (https://download.01.org/0day-ci/archive/20220314/202203140808.WyoqkliI-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=28d9ca982b9ae96bcad2bee81647ba18ae049a69
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-03
        git checkout 28d9ca982b9ae96bcad2bee81647ba18ae049a69
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/verifier.c:1580:39: sparse: sparse: mixing different enum types:
>> kernel/bpf/verifier.c:1580:39: sparse:    unsigned int enum bpf_reg_type
>> kernel/bpf/verifier.c:1580:39: sparse:    unsigned int enum bpf_type_flag
   kernel/bpf/verifier.c:13799:38: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar

vim +1580 kernel/bpf/verifier.c

  1568	
  1569	static void mark_btf_ld_reg(struct bpf_verifier_env *env,
  1570				    struct bpf_reg_state *regs, u32 regno,
  1571				    enum bpf_reg_type reg_type,
  1572				    struct btf *btf, u32 reg_id,
  1573				    enum bpf_type_flag flag)
  1574	{
  1575		if (reg_type == SCALAR_VALUE) {
  1576			mark_reg_unknown(env, regs, regno);
  1577			return;
  1578		}
  1579		mark_reg_known_zero(env, regs, regno);
> 1580		regs[regno].type = reg_type | flag;
  1581		/* If not PTR_TO_BTF_ID, it is a pkt pointer */
  1582		if (reg_type != PTR_TO_BTF_ID) {
  1583			regs[regno].pkt_uid = reg_id;
  1584			return;
  1585		}
  1586		regs[regno].btf = btf;
  1587		regs[regno].btf_id = reg_id;
  1588	}
  1589	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
