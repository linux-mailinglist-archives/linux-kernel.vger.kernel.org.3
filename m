Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B091658E59D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiHJDrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiHJDrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:47:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F394BD16
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660103229; x=1691639229;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+28lw+7dUUsqcLBAMm2Sh9p8wAh+1ntA70NRC6apqUI=;
  b=g91rJXWTDYXSIStGzf3orxGjKf/HCxon4BE0RA/e9hB6owNWKXkpNXTL
   lMzHujS7QhOordXFnfQToyMQ8nESyRS9jbKsl+2MRQgDu7LdVl6L1HlEB
   uaUVgDXwf9w6yZvkqusFCeaxe8WlOOl/KuCBCu9Hf7YJ0WnZHpyDyeJYo
   0C+Ydcd9iORVKupFVRehEd3inMcpUP+vNtNKrwWyIFgpofXF7jI4ly3th
   WqWD+Z6b1ulgY74w78YM0oRd9+g92B/VFQLDQwNiAT1fhRl1A1nZ6OYUG
   zHewePKhhtZ97KqwSy2lZBeEa+fRzgeFyAuzNH+EB0rn3KkBsqwbh/Aff
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="290989963"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="290989963"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 20:47:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="581066740"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Aug 2022 20:47:07 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLcgV-000NU5-0O;
        Wed, 10 Aug 2022 03:47:07 +0000
Date:   Wed, 10 Aug 2022 11:46:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rmk-arm:ktext 13/19] arch/arm64/mm/mmu.c:737:13: warning: no
 previous prototype for function 'create_kernel_nid_map'
Message-ID: <202208101140.WHKcrIlq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm ktext
head:   9065be4a87799659473e7d135f6db3f7419a7553
commit: 2154e376802fd896345339e0940fca399b893515 [13/19] arm64: text replication: setup page tables for copied kernel
config: arm64-randconfig-r004-20220810 (https://download.01.org/0day-ci/archive/20220810/202208101140.WHKcrIlq-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm ktext
        git checkout 2154e376802fd896345339e0940fca399b893515
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/mm/mmu.c:737:13: warning: no previous prototype for function 'create_kernel_nid_map' [-Wmissing-prototypes]
   void __init create_kernel_nid_map(pgd_t *pgdp, void *ktext)
               ^
   arch/arm64/mm/mmu.c:737:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init create_kernel_nid_map(pgd_t *pgdp, void *ktext)
   ^
   static 
   1 warning generated.


vim +/create_kernel_nid_map +737 arch/arm64/mm/mmu.c

   736	
 > 737	void __init create_kernel_nid_map(pgd_t *pgdp, void *ktext)
   738	{
   739		pgprot_t text_prot = kernel_text_pgprot();
   740	
   741		create_kernel_mapping(pgdp, __pa(ktext), _stext, _etext, text_prot, 0);
   742		create_kernel_mapping(pgdp, __pa_symbol(__start_rodata),
   743				      __start_rodata, __inittext_begin,
   744				      PAGE_KERNEL, NO_CONT_MAPPINGS);
   745		create_kernel_mapping(pgdp, __pa_symbol(__inittext_begin),
   746				      __inittext_begin, __inittext_end,
   747				      text_prot, 0);
   748		create_kernel_mapping(pgdp, __pa_symbol(__initdata_begin),
   749				      __initdata_begin, __initdata_end,
   750				      PAGE_KERNEL, 0);
   751		create_kernel_mapping(pgdp, __pa_symbol(_data), _data, _end,
   752				      PAGE_KERNEL, 0);
   753	}
   754	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
