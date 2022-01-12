Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E26A48C59E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243863AbiALOHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:07:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:9247 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242320AbiALOHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641996474; x=1673532474;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ekJG+R3q5e1w11whW9x+IgKOhTxLlFzQODnqFxKuc6A=;
  b=l20XHz9+9JTPBwChzHZJHQUIfMMtWxagcyP4T5xPsg1sLDRnnViD/aKB
   dVgFH+b6s7UQmfBS6LmLjxJe+s62DGS00rMkZIeL7C9e71cPksJDtwBum
   fKEJN9Hb71xqvgY57ihEPL+wQNnGP9tq16o5oq8h/Iblah8QL//dEu5Vt
   pTTnB71JuUMxcK+e34IrkM0msQEIKy82xSTZKBEsm5oecvS7IwPM/DTUe
   OgMzdgfQnweTeJu7vj5XHpNiFByO1oOw9Clea+116I+o5zqtPCY0ambsv
   0uhkuhMvQ3OoeWo3PzrwbpG3jYEnO3uPl8l271eJddJIbti/tIgU0Hi5i
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="330085392"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="330085392"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 06:07:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="670155708"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2022 06:07:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7eI4-0005uG-9q; Wed, 12 Jan 2022 14:07:52 +0000
Date:   Wed, 12 Jan 2022 22:06:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:3827:5:
 warning: no previous prototype for 'sienna_cichlid_stb_get_data_direct'
Message-ID: <202201122225.jnBYBKaM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   daadb3bd0e8d3e317e36bc2c1542e86c528665e5
commit: db5b5c679e6cad2bb147337af6c378d278231b45 drm/amd/pm: Add STB support in sienna_cichlid
date:   7 weeks ago
config: arc-randconfig-r043-20220112 (https://download.01.org/0day-ci/archive/20220112/202201122225.jnBYBKaM-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db5b5c679e6cad2bb147337af6c378d278231b45
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout db5b5c679e6cad2bb147337af6c378d278231b45
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/

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
