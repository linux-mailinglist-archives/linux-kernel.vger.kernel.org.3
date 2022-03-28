Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6864E8F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbiC1Hw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiC1HwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:52:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D0552E33;
        Mon, 28 Mar 2022 00:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648453845; x=1679989845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jlKlj0NQNWN05aZExDwr/vExb1oiL3GMzMEuXefJ6b8=;
  b=Nkd0l+yoGr7efem7+WlSZXXxaE3p/hJm23bjIcbgBQ4hafCtb4eCAjUi
   n2xKWCOSfym+5w11GpAGfj6asa4jgNz0APh1Fvbbc569fX4sQ1ljnCMaS
   7lNLdpJfURl/0Ws2r9GAYLOV1si+NonRJ2bHLAfFRUnoRjNNrfESEU4DQ
   yh5uLefCAsvEh28pSTL07X2vS21ncXdOM1qB+04HogeFypeuBhG3sgUTa
   uSkU5w/6+whhpUyhBVniaIpst4rFliT2rNUosjND2ngAngTPsjwzLIFb+
   hR+AT2oWFwHBFEKLnHcRXEh029OCNtnMt7UGdFYXQBOJ1wsPMYTsTgsTY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="246426619"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="246426619"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 00:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="502423396"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2022 00:50:40 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYk99-0001qz-Ol; Mon, 28 Mar 2022 07:50:39 +0000
Date:   Mon, 28 Mar 2022 15:49:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>, linux-doc@vger.kernel.org
Subject: arch/riscv/kernel/cpu.c:113: warning: This comment starts with
 '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202203281524.uFcj0Opf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
commit: a9b202606c69312cdaa4db187837820ebf7213b2 RISC-V: Improve /proc/cpuinfo output for ISA extensions
date:   11 days ago
config: riscv-randconfig-r042-20220328 (https://download.01.org/0day-ci/archive/20220328/202203281524.uFcj0Opf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9b202606c69312cdaa4db187837820ebf7213b2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a9b202606c69312cdaa4db187837820ebf7213b2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ drivers/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/riscv/kernel/cpu.c:89: warning: cannot understand function prototype: 'struct riscv_isa_ext_data isa_ext_arr[] = '
>> arch/riscv/kernel/cpu.c:113: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * These are the only valid base (single letter) ISA extensions as per the spec.


vim +113 arch/riscv/kernel/cpu.c

   111	
   112	/**
 > 113	 * These are the only valid base (single letter) ISA extensions as per the spec.
   114	 * It also specifies the canonical order in which it appears in the spec.
   115	 * Some of the extension may just be a place holder for now (B, K, P, J).
   116	 * This should be updated once corresponding extensions are ratified.
   117	 */
   118	static const char base_riscv_exts[13] = "imafdqcbkjpvh";
   119	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
