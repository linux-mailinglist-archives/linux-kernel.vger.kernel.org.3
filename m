Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80C64E2C69
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350355AbiCUPhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345364AbiCUPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:37:30 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862FC52E39
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647876965; x=1679412965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=45BRElyQlnzf/S18fYMTUOtYkpVmV2cKz2ZBPWFwUqY=;
  b=LB7EHx8Q5mN+Handh3ajc973yWAzfNuk35FrmALCqI4MP2NQOEsW3uHz
   tmgRprZjoIxyakRh2V95Eec8LHquR0MJZ/62UiqMuzm5PYWyhQpctq62w
   8UvCy8HIuhHMxbQDbtp5Yfff5+u8729bCfv4RJwvQwbNQj02W4l+zbnJ3
   oSY8AVVYFMg5YtaSOfTaFkeAvVNwztzobn2AXjsIyEkn7f+CrhOK5bZR0
   C/urXOM2hTjAeOO5xTvw5SDxp9zBdmS89F66OaTqbrGZtmAmjim75jTCY
   NRSwieb5o94fwRLOKmoRCTAh1RB8auTS9bQzVUdIHrFoAC9BRRJy5+iP/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="318291346"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="318291346"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="648606062"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2022 08:36:03 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWK4g-000HwR-KK; Mon, 21 Mar 2022 15:36:02 +0000
Date:   Mon, 21 Mar 2022 23:35:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: [ammarfaizi2-block:bpf/bpf-next/master 251/258]
 kernel/bpf/core.c:847:9: error: use of undeclared identifier 'PMD_SIZE'
Message-ID: <202203212309.ifp4edvz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block bpf/bpf-next/master
head:   7ada3787e91c89b0aa7abf47682e8e587b855c13
commit: ef078600eec20f20eb7833cf597d4a5edf2953c1 [251/258] bpf: Select proper size for bpf_prog_pack
config: arm-randconfig-c002-20220321 (https://download.01.org/0day-ci/archive/20220321/202203212309.ifp4edvz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/ef078600eec20f20eb7833cf597d4a5edf2953c1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block bpf/bpf-next/master
        git checkout ef078600eec20f20eb7833cf597d4a5edf2953c1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/bpf/core.c:847:9: error: use of undeclared identifier 'PMD_SIZE'
           size = PMD_SIZE * num_online_nodes();
                  ^
   kernel/bpf/core.c:1629:12: warning: no previous prototype for function 'bpf_probe_read_kernel' [-Wmissing-prototypes]
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
              ^
   kernel/bpf/core.c:1629:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
   ^
   static 
   1 warning and 1 error generated.


vim +/PMD_SIZE +847 kernel/bpf/core.c

   841	
   842	static size_t select_bpf_prog_pack_size(void)
   843	{
   844		size_t size;
   845		void *ptr;
   846	
 > 847		size = PMD_SIZE * num_online_nodes();
   848		ptr = module_alloc(size);
   849	
   850		/* Test whether we can get huge pages. If not just use PAGE_SIZE
   851		 * packs.
   852		 */
   853		if (!ptr || !is_vm_area_hugepages(ptr))
   854			size = PAGE_SIZE;
   855	
   856		vfree(ptr);
   857		return size;
   858	}
   859	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
