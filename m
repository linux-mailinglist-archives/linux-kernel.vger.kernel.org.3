Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8DD57BB30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiGTQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiGTQQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:16:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC7C31208
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658333815; x=1689869815;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CIu6Dc7qQECzuaC54av4xYdeM5W2DYEAM19oVR7s0Zo=;
  b=HxH1pCRTeRK8rc3LiQ06FXVu7Tr8IayH4Lolse9RAg6xhR6T3CEKuINw
   cLswtLT7QZ+nksOBFWYWSuPiWrcyCm5AxhcGgke++ZxpH+cf3sLB/ADK2
   VnJixdVHtxe0UE/1HVCTy28qsTczg0WiMC3kWfmWl/eRmaWDG3J8I8xAB
   UCiIFrrNkndTtW/OAvmb5kbUeSI9cQoeYuD55trvlfqOM61vNjrnxYU3S
   FMegNFzVg6CKGqnQI9/1xebAumNzxklmzM0WcORHCUVYbzjEWYegR2vny
   l+y0kqtcAkSUWEJmMeZBa6i9Avzar1nuCPWjJe+aMuPE+4PtviEGlb2hm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="273661081"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="273661081"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 09:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="625727687"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Jul 2022 09:16:53 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oECNY-0000h3-Nd;
        Wed, 20 Jul 2022 16:16:52 +0000
Date:   Thu, 21 Jul 2022 00:16:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [drm-drm-intel:topic/core-for-CI 18/26]
 arch/powerpc/platforms/embedded6xx/Kconfig:2:error: recursive dependency
 detected!
Message-ID: <202207210032.5InIkhcX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joonas,

FYI, the error/warning still remains.

tree:   git://anongit.freedesktop.org/drm/drm-intel topic/core-for-CI
head:   c10ab299f4c8758563311265f1b05da8c3dfd6ba
commit: cb9fb008557afceed9ed3200a9509c8fbec9fe3d [18/26] Revert "drm/i915: Don't select BROKEN"
config: powerpc-allyesconfig
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-drm-intel git://anongit.freedesktop.org/drm/drm-intel
        git fetch --no-tags drm-drm-intel topic/core-for-CI
        git checkout cb9fb008557afceed9ed3200a9509c8fbec9fe3d
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 ARCH=powerpc  allyesconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 ARCH=powerpc 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/platforms/embedded6xx/Kconfig:2:error: recursive dependency detected!
   arch/powerpc/platforms/embedded6xx/Kconfig:2: symbol EMBEDDED6xx depends on BROKEN_ON_SMP
   init/Kconfig:117: symbol BROKEN_ON_SMP depends on BROKEN
   init/Kconfig:114: symbol BROKEN is selected by DRM_I915_DEBUG
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

a35e370cfd2ddfb Arnd Bergmann    2007-08-30 @2  config EMBEDDED6xx
a35e370cfd2ddfb Arnd Bergmann    2007-08-30  3  	bool "Embedded 6xx/7xx/7xxx-based boards"
be34fff07c3755b Christophe Leroy 2018-11-17  4  	depends on PPC_BOOK3S_32 && BROKEN_ON_SMP
14cf11af6cf608e Paul Mackerras   2005-09-26  5  

:::::: The code at line 2 was first introduced by commit
:::::: a35e370cfd2ddfb5d2f0ceae376ffeda273b357c [POWERPC] Move embedded6xx into multiplatform

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Paul Mackerras <paulus@samba.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
