Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88AA51B034
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378528AbiEDVSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378518AbiEDVSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:18:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543450054
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651698864; x=1683234864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yo2p0itu5Zvw6ZR8LQJYmq9wVK3GsYpeMi2FneUCQnQ=;
  b=W/lyRV1RFwtLKSOJ72hTItvaqip3DAIOYRhGWfrf8EJH8igrj9MntusR
   vxbCVlozUNh6ppGxmPGNloqqN9FV5WvSoQz9sjOqokilD8/Ouj6Jx0xEa
   73Wu98d/pSHZG2vyI8lk3QCkXwIeezw4csb7iGVifbaGHrXMGSYe8IJFg
   XauUuC0U/gbyhapryjdRpLZMR9EYMZzVyaCmY6rArBwfjxdNqZHx6w68A
   2gxAvmrlohgMGfixvwyHsuFeqliT1FYvYNPBqWwJ+1afXra+lbcrFg9ov
   sfKAMUb+1Ms6yrIeBmGT2Q9d0dvFp6Cuz3921sQV+TnkrOWVwhN6FW+mL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293098141"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="293098141"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="537024685"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 14:14:04 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmMJw-000Bmt-3x;
        Wed, 04 May 2022 21:14:04 +0000
Date:   Thu, 5 May 2022 05:13:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Likun Gao <Likun.Gao@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [agd5f:drm-next 427/460]
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:129:6: warning: no previous
 prototype for 'amdgpu_ucode_print_imu_hdr'
Message-ID: <202205050542.SL1MkyhN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   d6ffefccf7f04eefddc8e8aa35fb4afe05a42e0c
commit: 289bcffb9d76f575995113dd48c09de7f2deb1d1 [427/460] drm/amdgpu: support imu for gfx11
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220505/202205050542.SL1MkyhN-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 289bcffb9d76f575995113dd48c09de7f2deb1d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:129:6: warning: no previous prototype for 'amdgpu_ucode_print_imu_hdr' [-Wmissing-prototypes]
     129 | void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/imu_v11_0.c:231:6: warning: no previous prototype for 'program_imu_rlc_ram' [-Wmissing-prototypes]
     231 | void program_imu_rlc_ram(struct amdgpu_device *adev,
         |      ^~~~~~~~~~~~~~~~~~~


vim +/amdgpu_ucode_print_imu_hdr +129 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c

   128	
 > 129	void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr)
   130	{
   131		uint16_t version_major = le16_to_cpu(hdr->header_version_major);
   132		uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
   133	
   134		DRM_DEBUG("IMU\n");
   135		amdgpu_ucode_print_common_hdr(hdr);
   136	
   137		if (version_major != 1) {
   138			DRM_ERROR("Unknown GFX ucode version: %u.%u\n", version_major, version_minor);
   139		}
   140	}
   141	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
