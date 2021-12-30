Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA22481ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbhL3I0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:26:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:21160 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231140AbhL3I0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640852761; x=1672388761;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oveBdkXV3ba325O3t6JAq2e+zS1O/VWsTpqVPJS/d50=;
  b=VO0RZOKjg0AW1fE+vwSHp/BLdsi53T3jk6X2dD+u0iNvA8ioD/FxaoXa
   sBpj6A9o//uu+KCVGzICV+6PsrlaoUBEe+XeuonQ2RLW+ubzDzggwbu4E
   d5tFo25f/bzZVY9yT5yMsjqFbjhkTN0opJ23bCoEjkwUuOipXYC58c9ke
   HOsTUiQXXkER6rZ5G4VhJqvZp+pJZQsCbuZqyJv8RlcIdkUmL8yPlCORv
   X7c2TRcxDvvjaTFsm7KqZkdHh6/UBRit6fcJgvC/msBsF4r08LILdUCB3
   fo5XPhuTWtzADAPjRtnBAnnmWvh82N9h1G3vNjmpYNPOmQxAV0d3t9X3t
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="239181109"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="239181109"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 00:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="554738728"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Dec 2021 00:25:49 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2qkt-0009wD-FJ; Thu, 30 Dec 2021 08:25:47 +0000
Date:   Thu, 30 Dec 2021 16:25:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>
Subject: [agd5f:drm-next-5.17 92/342]
 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:3827:5:
 warning: no previous prototype for 'sienna_cichlid_stb_get_data_direct'
Message-ID: <202112301643.dtvsIJca-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

FYI, the error/warning still remains.

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next-5.17
head:   46dbcbf47e6871e142ada8a8188b7a4fc8f1d808
commit: db5b5c679e6cad2bb147337af6c378d278231b45 [92/342] drm/amd/pm: Add STB support in sienna_cichlid
config: alpha-randconfig-r004-20211122 (https://download.01.org/0day-ci/archive/20211230/202112301643.dtvsIJca-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next-5.17
        git checkout db5b5c679e6cad2bb147337af6c378d278231b45
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:3827:5: warning: no previous prototype for 'sienna_cichlid_stb_get_data_direct' [-Wmissing-prototypes]
    3827 | int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sienna_cichlid_stb_get_data_direct +3827 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c

  3826	
> 3827	int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
  3828					       void *buf,
  3829					       uint32_t size)
  3830	{
  3831		uint32_t *p = buf;
  3832		struct amdgpu_device *adev = smu->adev;
  3833	
  3834		/* No need to disable interrupts for now as we don't lock it yet from ISR */
  3835		spin_lock(&smu->stb_context.lock);
  3836	
  3837		/*
  3838		 * Read the STB FIFO in units of 32bit since this is the accessor window
  3839		 * (register width) we have.
  3840		 */
  3841		buf = ((char *) buf) + size;
  3842		while ((void *)p < buf)
  3843			*p++ = cpu_to_le32(RREG32_PCIE(MP1_Public | smnMP1_PMI_3));
  3844	
  3845		spin_unlock(&smu->stb_context.lock);
  3846	
  3847		return 0;
  3848	}
  3849	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
