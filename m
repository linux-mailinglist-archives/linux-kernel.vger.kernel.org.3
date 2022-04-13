Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1A950021D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbiDMW47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiDMW4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:56:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110FF2E9C9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649890467; x=1681426467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8V4OPc5qWzAYZSVwVpMIb8F9Q8695qCcFacUPCDjceI=;
  b=X3ZVKCkVSiaEuf9oxESpvnbcstPbFOkBXYlAqjpSLVmsHlJQpgUeL6HM
   LBUCoZvLdtQgl94sQ3IjP+hcPAIPwmaja00kspA4GR52kFlpfGODji4+q
   6oNaTClU6nMhwy8Hw0CKwl31yi01uPIBVZJaip/lKt8Y7Oad3lxILrwmh
   l8aTfiROmMCdaU1oYoel9LbC1worH9nspg+HPRafchA0SZYWja0+I+cDR
   l7SmuPX1zK78s2JuTp1wMEEQ0ewQFJwh8Anci+UpElDCu6GV76a/y3Jw3
   acGowP2ckXyuzOE18+6wt+grsrr83cCIvFnP39rqszGR9cKA3yUx/00nO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="250085799"
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="250085799"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 15:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="854968940"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Apr 2022 15:54:15 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nelsN-0000gs-2D;
        Wed, 13 Apr 2022 22:54:15 +0000
Date:   Thu, 14 Apr 2022 06:54:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yan Zhu <zhuyan34@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [ammarfaizi2-block:bpf/bpf-next/pr/bpf-sysctl 1/1]
 kernel/bpf/syscall.c:4944:13: warning: no previous prototype for function
 'unpriv_ebpf_notify'
Message-ID: <202204140608.VUvJxAlq-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block bpf/bpf-next/pr/bpf-sysctl
head:   2900005ea287b11dcc8c1b9fcf24893b7ff41d6d
commit: 2900005ea287b11dcc8c1b9fcf24893b7ff41d6d [1/1] bpf: Move BPF sysctls from kernel/sysctl.c to BPF core
config: arm64-buildonly-randconfig-r005-20220413 (https://download.01.org/0day-ci/archive/20220414/202204140608.VUvJxAlq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/2900005ea287b11dcc8c1b9fcf24893b7ff41d6d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block bpf/bpf-next/pr/bpf-sysctl
        git checkout 2900005ea287b11dcc8c1b9fcf24893b7ff41d6d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/syscall.c:4944:13: warning: no previous prototype for function 'unpriv_ebpf_notify' [-Wmissing-prototypes]
   void __weak unpriv_ebpf_notify(int new_state)
               ^
   kernel/bpf/syscall.c:4944:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __weak unpriv_ebpf_notify(int new_state)
   ^
   static 
   1 warning generated.


vim +/unpriv_ebpf_notify +4944 kernel/bpf/syscall.c

  4943	
> 4944	void __weak unpriv_ebpf_notify(int new_state)
  4945	{
  4946	}
  4947	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
