Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DB24D7778
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 19:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiCMSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiCMSbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 14:31:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03E21E15
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647196204; x=1678732204;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MQpBwZS3ovPRMMdmYBn8O8BYcS9SoVePQJQO7ECZh5E=;
  b=B6HBBH6i3ZGiB5BV6T265ozq2pfRPViNQiOFnzv7zXAqeXZ+aGkl7fdl
   b+9h8SKWxo8XIIH5qthl6PKeolxgl8HX89NqSciFkDOXHCm1DonbStPKa
   gCuSBZYS9n6vhxjQyk78R1PWeq0ZTTgtzDbJofcwAJBoCyO5B0CXB/oBQ
   OBX3UFspLnULIKz8Nha7V2PCr0no8rbyCzAEtP5z2iNVoThA9lA8rxWHr
   YJFYDGjZhPC9+TbVwpcua87qLhXJ6bYb0KcgwvFZ/dkHyPetffguFjM5Y
   JMrNBNqQukWG7dgAxU0X8Urj3QKlxYqdgbFdaW+/MqHL/9mfC75dz2tq+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="256075837"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="256075837"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 11:30:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713468672"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 11:30:02 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTSyf-0009Bs-Vh; Sun, 13 Mar 2022 18:30:01 +0000
Date:   Mon, 14 Mar 2022 02:29:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/mm/nohash/fsl_book3e.c:61:3: sparse: sparse: symbol
 'tlbcam_addrs' was not declared. Should it be static?
Message-ID: <202203140259.PkwZKhTz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aad611a868d16cdc16a7d4a764cef955293e47e3
commit: 44c14509b0dabb909ad1ec28800893ea71762732 powerpc/fsl_booke: Fix setting of exec flag when setting TLBCAMs
date:   5 months ago
config: powerpc-randconfig-s031-20220313 (https://download.01.org/0day-ci/archive/20220314/202203140259.PkwZKhTz-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44c14509b0dabb909ad1ec28800893ea71762732
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 44c14509b0dabb909ad1ec28800893ea71762732
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/nohash/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/mm/nohash/fsl_book3e.c:61:3: sparse: sparse: symbol 'tlbcam_addrs' was not declared. Should it be static?
   arch/powerpc/mm/nohash/fsl_book3e.c:63:15: sparse: sparse: symbol 'tlbcam_sz' was not declared. Should it be static?
>> arch/powerpc/mm/nohash/fsl_book3e.c:277:30: sparse: sparse: Using plain integer as NULL pointer

vim +/tlbcam_addrs +61 arch/powerpc/mm/nohash/fsl_book3e.c

14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  53  
78f622377f7d31 arch/powerpc/mm/fsl_booke_mmu.c Kumar Gala     2010-05-13  54  #define NUM_TLBCAMS	(64)
78f622377f7d31 arch/powerpc/mm/fsl_booke_mmu.c Kumar Gala     2010-05-13 @55  struct tlbcam TLBCAM[NUM_TLBCAMS];
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  56  
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  57  struct tlbcamrange {
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  58  	unsigned long start;
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  59  	unsigned long limit;
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  60  	phys_addr_t phys;
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26 @61  } tlbcam_addrs[NUM_TLBCAMS];
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  62  

:::::: The code at line 61 was first introduced by commit
:::::: 14cf11af6cf608eb8c23e989ddb17a715ddce109 powerpc: Merge enough to start building in arch/powerpc.

:::::: TO: Paul Mackerras <paulus@samba.org>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
