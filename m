Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1879A4F20A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 04:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiDECAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiDEB76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 21:59:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5563568CE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649121365; x=1680657365;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P7TngUwlH5TGDyK5h7dBrH4QJh3YwqOqlGAIIeRM8tM=;
  b=iTj3yWeTZRARGk6jgYcVS6jz3Bl1SF5rIYG82f/cBiYZOm3aa4oLLpFw
   8Wcv+NowjuKzsrnbqB9VoT15ynx1eBKprfhVW4TFyt8aaFea/6SFMhJrV
   /YS2638MApivF4jMxdukOYa2FvKm9JWjeNpSB1ICUx9JJQJdaxndqs8GL
   +ydJBP2Mz4Lwz1T9AulJ+AXF9V+SgYczBysvJcNc6Fg8VNc49XDDiEhUu
   GNFdMv78rr5YWdoCYjMb2V41YyhH7vA5xiVsUfi5HJSIuAs5IYzVduref
   u1eLd6p8S+z7YdfpOF1NgwYggjj2ARN3BYxlKP/JNv20Y5ooYu1n1pBu5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="285589010"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="285589010"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 17:04:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="548850835"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Apr 2022 17:04:39 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbWgY-0002TP-Kp;
        Tue, 05 Apr 2022 00:04:38 +0000
Date:   Tue, 5 Apr 2022 08:03:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 25/29] arch/riscv/kvm/aia.c:204:36:
 sparse: sparse: incorrect type in argument 2 (different address spaces)
Message-ID: <202204050835.ITBYCuGd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   dab41b5c8f55fb8e864a5e10fd181dd0d4443778
commit: 74de87a8890ab0c58f3e5142ff49d219872a0eb5 [25/29] RISC-V: KVM: Implement guest external interrupt line management
config: riscv-randconfig-s032-20220404 (https://download.01.org/0day-ci/archive/20220405/202204050835.ITBYCuGd-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/avpatel/linux/commit/74de87a8890ab0c58f3e5142ff49d219872a0eb5
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout 74de87a8890ab0c58f3e5142ff49d219872a0eb5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kvm/aia.c:204:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void * @@     got struct aia_hgei_control [noderef] __percpu * @@
   arch/riscv/kvm/aia.c:204:36: sparse:     expected void *
   arch/riscv/kvm/aia.c:204:36: sparse:     got struct aia_hgei_control [noderef] __percpu *

vim +204 arch/riscv/kvm/aia.c

   200	
   201	static void aia_hgei_exit(void)
   202	{
   203		/* Free per-CPU SGEI interrupt */
 > 204		free_irq(hgei_parent_irq, &aia_hgei);
   205	}
   206	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
