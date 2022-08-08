Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72158CA6F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbiHHOUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiHHOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:20:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB3FD130
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659968429; x=1691504429;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1Gs2p+rzLbLqP9Oo2mEc2AFXerz6OxC0YE6EMDkcWwY=;
  b=gvFIRjRGoHJZQCkRDHPVPWI/dHG/8hx1Qo4SDO6AFGc1A+KuKQtIQ1yk
   ofxMbEsiTUDTwFEJpRocOQxsGlizkST9skvo4hAf5xiP2oDrOAUylFu+d
   sSITJMLUOllUe0ZG8ch0ZzVfP4u8NGyp/AX9M0tkADVg2NX23omKF3+i8
   0ZDWeNIv1VVg9yj1/OCMqIZQQOSgXBBIJJT03+qHYJPgYLngw1SJMbUNl
   LPCEll/vqAw0j5id5W+6SE8mzuHD/ql+O6XSAaSzVoCSddNs9xTKbP8/K
   cCawcGAjkZBUu49c9eaZuODRAEDDWKPeFEDBeZ6nYW2i4GjocwcYdQY+R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291838461"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291838461"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="663965956"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Aug 2022 07:20:25 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oL3cG-000MJt-31;
        Mon, 08 Aug 2022 14:20:24 +0000
Date:   Mon, 8 Aug 2022 22:19:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>, Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c:676:1: sparse:
 sparse: symbol 'gv100_disp_core_mthd_base' was not declared. Should it be
 static?
Message-ID: <202208082250.FRtA3DVc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4e23eeebb2e57f5a28b36221aa776b5a1122dde5
commit: acbe9ecfb7fb14db868ddbeda8f43e623026316b drm/nouveau/disp: merge head/outp/ior code into chipset files
date:   13 days ago
config: alpha-randconfig-s031-20220807 (https://download.01.org/0day-ci/archive/20220808/202208082250.FRtA3DVc-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=acbe9ecfb7fb14db868ddbeda8f43e623026316b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout acbe9ecfb7fb14db868ddbeda8f43e623026316b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c:676:1: sparse: sparse: symbol 'gv100_disp_core_mthd_base' was not declared. Should it be static?

vim +/gv100_disp_core_mthd_base +676 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c

   632	
   633	static const struct nvkm_disp_mthd_list
   634	gv100_disp_core_mthd_head = {
   635		.mthd = 0x0400,
   636		.addr = 0x000400,
   637		.data = {
   638			{ 0x2000, 0x682000 },
   639			{ 0x2004, 0x682004 },
   640			{ 0x2008, 0x682008 },
   641			{ 0x200c, 0x68200c },
   642			{ 0x2014, 0x682014 },
   643			{ 0x2018, 0x682018 },
   644			{ 0x201c, 0x68201c },
   645			{ 0x2020, 0x682020 },
   646			{ 0x2028, 0x682028 },
   647			{ 0x202c, 0x68202c },
   648			{ 0x2030, 0x682030 },
   649			{ 0x2038, 0x682038 },
   650			{ 0x203c, 0x68203c },
   651			{ 0x2048, 0x682048 },
   652			{ 0x204c, 0x68204c },
   653			{ 0x2050, 0x682050 },
   654			{ 0x2054, 0x682054 },
   655			{ 0x2058, 0x682058 },
   656			{ 0x205c, 0x68205c },
   657			{ 0x2060, 0x682060 },
   658			{ 0x2064, 0x682064 },
   659			{ 0x2068, 0x682068 },
   660			{ 0x206c, 0x68206c },
   661			{ 0x2070, 0x682070 },
   662			{ 0x2074, 0x682074 },
   663			{ 0x2078, 0x682078 },
   664			{ 0x207c, 0x68207c },
   665			{ 0x2080, 0x682080 },
   666			{ 0x2088, 0x682088 },
   667			{ 0x2090, 0x682090 },
   668			{ 0x209c, 0x68209c },
   669			{ 0x20a0, 0x6820a0 },
   670			{ 0x20a4, 0x6820a4 },
   671			{ 0x20a8, 0x6820a8 },
   672			{ 0x20ac, 0x6820ac },
   673			{ 0x2180, 0x682180 },
   674			{ 0x2184, 0x682184 },
   675			{ 0x218c, 0x68218c },
 > 676			{ 0x2194, 0x682194 },
   677			{ 0x2198, 0x682198 },
   678			{ 0x219c, 0x68219c },
   679			{ 0x21a0, 0x6821a0 },
   680			{ 0x21a4, 0x6821a4 },
   681			{ 0x2214, 0x682214 },
   682			{ 0x2218, 0x682218 },
   683			{}
   684		}
   685	};
   686	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
