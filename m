Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2305A344C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiH0EJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0EJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:09:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F85E8302
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 21:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661573380; x=1693109380;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q4VRxOqftwJJgAc/ufgxNjEoozho+Cb/bVvwaSzfFAs=;
  b=jqvZafrhsJDdOwti+5zpyAIEE/lVh/Tf0IbnUigHSfoeQoC5ivI4QKh5
   gWxmdFtxGb8z7TVOarOeOijiAvvJjgObzS114MAB5RhgU/qmDVnqUy1HE
   zbSbUmn958w0NrDomkPnq4j9FmDE+qMMhhEMHr6iW2jDPGC9VsYjdtieD
   rWEjUdmcil+tqIO3KLbIhJQevJH9V0P7YMfQbr9x0jeAsHziyndjE/cKA
   EqJWrmBLrRXL9wyv5Z1IXcQ0VCJAqqEd7re/TREfNLsvLajoJeXSuhK3V
   65O6j2/U1DKy/99VFge1AvTmUqtWHNV3e5oI2YotwzIPr9rilNNpsw7EM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295905311"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="295905311"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 21:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="587529687"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Aug 2022 21:09:38 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRn8a-0000yU-1u;
        Sat, 27 Aug 2022 04:09:36 +0000
Date:   Sat, 27 Aug 2022 12:08:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [avpatel:riscv_pmem_v1 40/78] make[3]: *** No rule to make target
 'arch/riscv/lib/memcpy.S', needed by 'arch/riscv/purgatory/memcpy.o'.
Message-ID: <202208271154.2BxPFepd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_pmem_v1
head:   abd658639cf42f64e3b2cfe9f646ffeedb8e54d0
commit: f347c58a39e532e054c16041019ce3f78be2cc45 [40/78] riscv: optimized memcpy
config: riscv-randconfig-r006-20220827 (https://download.01.org/0day-ci/archive/20220827/202208271154.2BxPFepd-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/f347c58a39e532e054c16041019ce3f78be2cc45
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_pmem_v1
        git checkout f347c58a39e532e054c16041019ce3f78be2cc45
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'arch/riscv/lib/memcpy.S', needed by 'arch/riscv/purgatory/memcpy.o'.
   make[3]: Target '__build' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
