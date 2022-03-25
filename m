Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762B64E6D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356931AbiCYEbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356765AbiCYEbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:31:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADA9A147D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 21:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648182570; x=1679718570;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vz2sASJO+qCZDekvkLGguImZppYnyBsLDN4sX2+KMAI=;
  b=oEmF0c9L/WiLRQyhfV2pIYa44/MiC5v0OcDuyGScI0u6eBQAaZZ3cQdj
   G9NuKKZjqmnF+LZYPa5KiGVkPs2WLDWuzAou0EAL/eG0Gh5Ar9ofd3osd
   WgHaSIxm4ILUCG9iLNvyTCLO4i/L+klre2LJGqTnxdVPJBjqjFpRSck3X
   Fb7k4eCcXzLofvjihVX3JaIFDf3pRXr6rKCylHhAVWGKjV8E7RKUK5REK
   NImN4Aq4MbBRCrmrpCtVp0rhsAI7IH1Y8GrruAU8Ey+tWGZi/MXvxvpSi
   q5Ip+IAo/C2fsoTwG0lKxpMxmoI4bBuZ5dKUybP2331bgrwMYIU7ElkdO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="344988907"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="344988907"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 21:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="520066486"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 24 Mar 2022 21:29:29 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXbZo-000LnH-Fk; Fri, 25 Mar 2022 04:29:28 +0000
Date:   Fri, 25 Mar 2022 12:28:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [agd5f:amd-staging-drm-next 1307/1318]
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:628: warning: expecting prototype
 for amdgpu_vm_free_table(). Prototype was for amdgpu_vm_pt_free() instead
Message-ID: <202203251221.2xwHTw12-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git amd-staging-drm-next
head:   97c2bccc87d3d7bc08400c3d3773c327492a0f3d
commit: 59f2ef3cadef58fdee8d794bf28fc31b9613dc47 [1307/1318] drm/amdgpu: separate VM PT handling into amdgpu_vm_pt.c
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220325/202203251221.2xwHTw12-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f amd-staging-drm-next
        git checkout 59f2ef3cadef58fdee8d794bf28fc31b9613dc47
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:628: warning: expecting prototype for amdgpu_vm_free_table(). Prototype was for amdgpu_vm_pt_free() instead


vim +628 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c

   621	
   622	/**
   623	 * amdgpu_vm_free_table - fre one PD/PT
   624	 *
   625	 * @entry: PDE to free
   626	 */
   627	static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 > 628	{
   629		struct amdgpu_bo *shadow;
   630	
   631		if (!entry->bo)
   632			return;
   633		shadow = amdgpu_bo_shadowed(entry->bo);
   634		entry->bo->vm_bo = NULL;
   635		list_del(&entry->vm_status);
   636		amdgpu_bo_unref(&shadow);
   637		amdgpu_bo_unref(&entry->bo);
   638	}
   639	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
