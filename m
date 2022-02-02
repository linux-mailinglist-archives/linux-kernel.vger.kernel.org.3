Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A854A7067
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbiBBL65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:58:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:26729 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232566AbiBBL64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643803136; x=1675339136;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X6sulG0VhU3EPk+1QVkZUD/dBkSL2RmLEFhar6KZX0s=;
  b=F2etJLl++o7xPSzN2b3EVZjkYN2moWAl6b342P8qK/0uXk7BswSxaQ2L
   Hk6SnOErpVPgfkj7lz75KYjdXThCN6v7CyYK+pAl6TxBcsv5lnyyrdXjT
   WFUpZbdbI6rzSQhnooI8XqA94/OhsNuryA4aAh2BNgbW6v6+hnRQ8uc1K
   hXofSFKsy0FLWDmkVi6KrxvIoAlp3vJD3fdgapD7sZH8Y7WCzU5ENYWUF
   Kg8LrzZ+Jf7uoXftc2z22AMuaVuXu0Hly27qpJUd6aHdm6FX32xYNBq+e
   Pd0GnfE0gqyq9PQAbzKlvaJ1N0xhA2nFGuQX7UqjvvTTEpcFbjOfjwJdD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="246730109"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="246730109"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 03:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="482803594"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2022 03:58:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFEHl-000UX7-Sb; Wed, 02 Feb 2022 11:58:53 +0000
Date:   Wed, 2 Feb 2022 19:58:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:for-next/memcpy 15/15]
 drivers/gpu/drm/gma500/intel_bios.c:547:42: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202202021936.6v5Ix9KS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/memcpy
head:   0b27a15c23f17d6ca9a01505f38b477178fabb52
commit: 0b27a15c23f17d6ca9a01505f38b477178fabb52 [15/15] fortify: Add Clang support
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220202/202202021936.6v5Ix9KS-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=0b27a15c23f17d6ca9a01505f38b477178fabb52
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/memcpy
        git checkout 0b27a15c23f17d6ca9a01505f38b477178fabb52
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/gma500/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/gma500/intel_bios.c:547:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/gpu/drm/gma500/intel_bios.c:547:42: sparse:     expected void const *const p
   drivers/gpu/drm/gma500/intel_bios.c:547:42: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/gpu/drm/gma500/intel_bios.c:548:40: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/gma500/intel_bios.c:558:24: sparse: sparse: cast removes address space '__iomem' of expression
--
   drivers/gpu/drm/gma500/opregion.c:297:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct opregion_header *header @@
   drivers/gpu/drm/gma500/opregion.c:297:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/gma500/opregion.c:297:25: sparse:     got struct opregion_header *header
>> drivers/gpu/drm/gma500/opregion.c:327:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got void [noderef] __iomem *[assigned] base @@
   drivers/gpu/drm/gma500/opregion.c:327:20: sparse:     expected void const *const p
   drivers/gpu/drm/gma500/opregion.c:327:20: sparse:     got void [noderef] __iomem *[assigned] base
   drivers/gpu/drm/gma500/opregion.c:333:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct opregion_header *header @@     got void [noderef] __iomem *[assigned] base @@
   drivers/gpu/drm/gma500/opregion.c:333:26: sparse:     expected struct opregion_header *header
   drivers/gpu/drm/gma500/opregion.c:333:26: sparse:     got void [noderef] __iomem *[assigned] base
   drivers/gpu/drm/gma500/opregion.c:334:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *vbt @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/gma500/opregion.c:334:23: sparse:     expected void *vbt
   drivers/gpu/drm/gma500/opregion.c:334:23: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/gma500/opregion.c:341:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct opregion_acpi *acpi @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/gma500/opregion.c:341:32: sparse:     expected struct opregion_acpi *acpi
   drivers/gpu/drm/gma500/opregion.c:341:32: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/gma500/opregion.c:346:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct opregion_asle *asle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/gma500/opregion.c:346:32: sparse:     expected struct opregion_asle *asle
   drivers/gpu/drm/gma500/opregion.c:346:32: sparse:     got void [noderef] __iomem *

vim +547 drivers/gpu/drm/gma500/intel_bios.c

1fb28e9e737e26 Alan Cox          2012-04-25  500  
1fb28e9e737e26 Alan Cox          2012-04-25  501  
f910b411053f04 Alan Cox          2011-11-03  502  /**
f910b411053f04 Alan Cox          2011-11-03  503   * psb_intel_init_bios - initialize VBIOS settings & find VBT
f910b411053f04 Alan Cox          2011-11-03  504   * @dev: DRM device
f910b411053f04 Alan Cox          2011-11-03  505   *
f910b411053f04 Alan Cox          2011-11-03  506   * Loads the Video BIOS and checks that the VBT exists.  Sets scratch registers
f910b411053f04 Alan Cox          2011-11-03  507   * to appropriate values.
f910b411053f04 Alan Cox          2011-11-03  508   *
f910b411053f04 Alan Cox          2011-11-03  509   * VBT existence is a sanity check that is relied on by other i830_bios.c code.
f910b411053f04 Alan Cox          2011-11-03  510   * Note that it would be better to use a BIOS call to get the VBT, as BIOSes may
f910b411053f04 Alan Cox          2011-11-03  511   * feed an updated VBT back through that, compared to what we'll fetch using
f910b411053f04 Alan Cox          2011-11-03  512   * this method of groping around in the BIOS data.
f910b411053f04 Alan Cox          2011-11-03  513   *
f910b411053f04 Alan Cox          2011-11-03  514   * Returns 0 on success, nonzero on failure.
f910b411053f04 Alan Cox          2011-11-03  515   */
0317c6cecd3d6c Dan Carpenter     2012-06-27  516  int psb_intel_init_bios(struct drm_device *dev)
f910b411053f04 Alan Cox          2011-11-03  517  {
f71635e893c383 Thomas Zimmermann 2021-09-20  518  	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
a2c68495b57986 Thomas Zimmermann 2020-12-01  519  	struct pci_dev *pdev = to_pci_dev(dev->dev);
f910b411053f04 Alan Cox          2011-11-03  520  	struct vbt_header *vbt = NULL;
1fb28e9e737e26 Alan Cox          2012-04-25  521  	struct bdb_header *bdb = NULL;
1fb28e9e737e26 Alan Cox          2012-04-25  522  	u8 __iomem *bios = NULL;
f910b411053f04 Alan Cox          2011-11-03  523  	size_t size;
f910b411053f04 Alan Cox          2011-11-03  524  	int i;
f910b411053f04 Alan Cox          2011-11-03  525  
d112a8163f8375 Zhao Yakui        2012-08-08  526  
d112a8163f8375 Zhao Yakui        2012-08-08  527  	dev_priv->panel_type = 0xff;
d112a8163f8375 Zhao Yakui        2012-08-08  528  
1fb28e9e737e26 Alan Cox          2012-04-25  529  	/* XXX Should this validation be moved to intel_opregion.c? */
1fb28e9e737e26 Alan Cox          2012-04-25  530  	if (dev_priv->opregion.vbt) {
1fb28e9e737e26 Alan Cox          2012-04-25  531  		struct vbt_header *vbt = dev_priv->opregion.vbt;
1fb28e9e737e26 Alan Cox          2012-04-25  532  		if (memcmp(vbt->signature, "$VBT", 4) == 0) {
1fb28e9e737e26 Alan Cox          2012-04-25  533  			DRM_DEBUG_KMS("Using VBT from OpRegion: %20s\n",
1fb28e9e737e26 Alan Cox          2012-04-25  534  					 vbt->signature);
1fb28e9e737e26 Alan Cox          2012-04-25  535  			bdb = (struct bdb_header *)((char *)vbt + vbt->bdb_offset);
1fb28e9e737e26 Alan Cox          2012-04-25  536  		} else
1fb28e9e737e26 Alan Cox          2012-04-25  537  			dev_priv->opregion.vbt = NULL;
1fb28e9e737e26 Alan Cox          2012-04-25  538  	}
1fb28e9e737e26 Alan Cox          2012-04-25  539  
1fb28e9e737e26 Alan Cox          2012-04-25  540  	if (bdb == NULL) {
f910b411053f04 Alan Cox          2011-11-03  541  		bios = pci_map_rom(pdev, &size);
f910b411053f04 Alan Cox          2011-11-03  542  		if (!bios)
f910b411053f04 Alan Cox          2011-11-03  543  			return -1;
f910b411053f04 Alan Cox          2011-11-03  544  
f910b411053f04 Alan Cox          2011-11-03  545  		/* Scour memory looking for the VBT signature */
f910b411053f04 Alan Cox          2011-11-03  546  		for (i = 0; i + 4 < size; i++) {
f910b411053f04 Alan Cox          2011-11-03 @547  			if (!memcmp(bios + i, "$VBT", 4)) {
f910b411053f04 Alan Cox          2011-11-03  548  				vbt = (struct vbt_header *)(bios + i);
f910b411053f04 Alan Cox          2011-11-03  549  				break;
f910b411053f04 Alan Cox          2011-11-03  550  			}
f910b411053f04 Alan Cox          2011-11-03  551  		}
f910b411053f04 Alan Cox          2011-11-03  552  
f910b411053f04 Alan Cox          2011-11-03  553  		if (!vbt) {
f910b411053f04 Alan Cox          2011-11-03  554  			dev_err(dev->dev, "VBT signature missing\n");
f910b411053f04 Alan Cox          2011-11-03  555  			pci_unmap_rom(pdev, bios);
f910b411053f04 Alan Cox          2011-11-03  556  			return -1;
f910b411053f04 Alan Cox          2011-11-03  557  		}
f910b411053f04 Alan Cox          2011-11-03  558  		bdb = (struct bdb_header *)(bios + i + vbt->bdb_offset);
1fb28e9e737e26 Alan Cox          2012-04-25  559  	}
f910b411053f04 Alan Cox          2011-11-03  560  
1fb28e9e737e26 Alan Cox          2012-04-25  561  	/* Grab useful general dxefinitions */
f910b411053f04 Alan Cox          2011-11-03  562  	parse_general_features(dev_priv, bdb);
642c52fcc98aa4 Alan Cox          2012-04-25  563  	parse_driver_features(dev_priv, bdb);
f910b411053f04 Alan Cox          2011-11-03  564  	parse_lfp_panel_data(dev_priv, bdb);
f910b411053f04 Alan Cox          2011-11-03  565  	parse_sdvo_panel_data(dev_priv, bdb);
1fb28e9e737e26 Alan Cox          2012-04-25  566  	parse_sdvo_device_mapping(dev_priv, bdb);
1fb28e9e737e26 Alan Cox          2012-04-25  567  	parse_device_mapping(dev_priv, bdb);
f910b411053f04 Alan Cox          2011-11-03  568  	parse_backlight_data(dev_priv, bdb);
d112a8163f8375 Zhao Yakui        2012-08-08  569  	parse_edp(dev_priv, bdb);
f910b411053f04 Alan Cox          2011-11-03  570  
1fb28e9e737e26 Alan Cox          2012-04-25  571  	if (bios)
f910b411053f04 Alan Cox          2011-11-03  572  		pci_unmap_rom(pdev, bios);
f910b411053f04 Alan Cox          2011-11-03  573  
f910b411053f04 Alan Cox          2011-11-03  574  	return 0;
f910b411053f04 Alan Cox          2011-11-03  575  }
f910b411053f04 Alan Cox          2011-11-03  576  

:::::: The code at line 547 was first introduced by commit
:::::: f910b411053f04d5ccd6219a912eaea2b6f5ea6e gma500: Add the glue to the various BIOS and firmware interfaces

:::::: TO: Alan Cox <alan@linux.intel.com>
:::::: CC: Dave Airlie <airlied@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
