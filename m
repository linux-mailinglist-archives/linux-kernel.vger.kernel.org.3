Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99F04FBA26
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345754AbiDKKzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiDKKzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:55:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FDC3F891
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649674379; x=1681210379;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TY0gfpltESOQpALtYNIpJ+ufLKm19PGcf0G2k2M0WBM=;
  b=FXsY41rBWuu3CEwI2NKeVztPs3p9bDyL8bitfzT1l2W75cjx4fQTsf7l
   vfbcyRci5mEfFJjQT0qK2AjRP8c73X6rAGHNOYe8VXQLgPZeVaTfgTJew
   Ij9UvFdGQ8GUB6e+5yjJQVedMS8dUg/4V9IJet08v/56GMY2ME5o5NyAV
   wSWFSBG9IdtXisVz6ljhbdLrEjA8XZgv+LmpWpWt30Ogs92iWL7biA7YN
   BSo96iD0CTEQZ0krrFXaW1k8z5nOxPEBn26V100CizJ1TDsep+DV8vT4Q
   bylaMZEqKnkMJCUUlXXiz+k9M7RGjRzJjMqxEyJPvg2xiCiKQY9eFp+4w
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261831493"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="261831493"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="507063099"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2022 03:52:57 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndrfE-0001mx-LE;
        Mon, 11 Apr 2022 10:52:56 +0000
Date:   Mon, 11 Apr 2022 18:52:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [drm-drm-intel:topic/core-for-CI 16/30]
 arch/powerpc/platforms/embedded6xx/Kconfig:2:error: recursive dependency
 detected!
Message-ID: <202204111804.vHPI2rqO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joonas,

FYI, the error/warning still remains.

tree:   git://anongit.freedesktop.org/drm/drm-intel topic/core-for-CI
head:   0dc2696a4623d55f40e925e9185a0fcd4d34e568
commit: 039b696fcec3683d54246858378741854944417a [16/30] Revert "drm/i915: Don't select BROKEN"
config: powerpc-allnoconfig
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-drm-intel git://anongit.freedesktop.org/drm/drm-intel
        git fetch --no-tags drm-drm-intel topic/core-for-CI
        git checkout 039b696fcec3683d54246858378741854944417a
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=powerpc  allnoconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/platforms/embedded6xx/Kconfig:2:error: recursive dependency detected!
   arch/powerpc/platforms/embedded6xx/Kconfig:2: symbol EMBEDDED6xx depends on BROKEN_ON_SMP
   init/Kconfig:113: symbol BROKEN_ON_SMP depends on BROKEN
   init/Kconfig:110: symbol BROKEN is selected by DRM_I915_DEBUG
   drivers/gpu/drm/i915/Kconfig.debug:19: symbol DRM_I915_DEBUG depends on DRM_I915
   drivers/gpu/drm/i915/Kconfig:2: symbol DRM_I915 depends on DRM
   drivers/gpu/drm/Kconfig:8: symbol DRM depends on AGP
   drivers/char/agp/Kconfig:2: symbol AGP depends on PCI
   drivers/pci/Kconfig:16: symbol PCI depends on HAVE_PCI
   drivers/pci/Kconfig:7: symbol HAVE_PCI is selected by FORCE_PCI
   drivers/pci/Kconfig:11: symbol FORCE_PCI is selected by MVME5100
   arch/powerpc/platforms/embedded6xx/Kconfig:51: symbol MVME5100 depends on EMBEDDED6xx
   For a resolution refer to Documentation/kbuild/kconfig-language.rst
   subsection "Kconfig recursive dependency limitations"


vim +2 arch/powerpc/platforms/embedded6xx/Kconfig

a35e370cfd2ddf Arnd Bergmann    2007-08-30 @2  config EMBEDDED6xx
a35e370cfd2ddf Arnd Bergmann    2007-08-30  3  	bool "Embedded 6xx/7xx/7xxx-based boards"
be34fff07c3755 Christophe Leroy 2018-11-17  4  	depends on PPC_BOOK3S_32 && BROKEN_ON_SMP
14cf11af6cf608 Paul Mackerras   2005-09-26  5  

:::::: The code at line 2 was first introduced by commit
:::::: a35e370cfd2ddfb5d2f0ceae376ffeda273b357c [POWERPC] Move embedded6xx into multiplatform

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Paul Mackerras <paulus@samba.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
