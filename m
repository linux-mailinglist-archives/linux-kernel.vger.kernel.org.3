Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A077749DFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbiA0KrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:47:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:54846 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239592AbiA0Kq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643280417; x=1674816417;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QJhp/N3xJdfmiwV0DzQPvI7LofbYu97sLmmJ5fBVpVg=;
  b=gwJ+4OVUOh0O7TCnVY9gmzRSoE9BIyEiARZryf2BhEhetCE0O/tHF0kH
   LizqMwTWDQL9oM9RlZ9EGuV8vXDNV5K2Y9GMZN2My/5ZLE8U7q5r70y3W
   knajs9mojqYtK//kh6wJ8wpvbMqH6hOAIIqy/IshuO1kiNv1DiF2sNYo1
   YiTVVrnllpDYXspF/Kbq7isZEhS9DBFJ9TOl6SzOP3bQD99UCjsXyCtsP
   VNqJFzS4MBflJHo6lpOtEpPhXIoNZcf8lOTN+O2tQ5zxzgoxqK6CRrU3T
   VgQchFOb+VuaaipoLs4yEl9r9/M2/3mOJIhJSHMN/jQr9rEgTsrWiMkTu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="244415820"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="244415820"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 02:46:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="628641846"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2022 02:46:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD2Im-000MUo-Tf; Thu, 27 Jan 2022 10:46:52 +0000
Date:   Thu, 27 Jan 2022 18:46:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Victor Zhao <Victor.Zhao@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 181/190]
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined
 preprocessor identifier 'CONFIG_ARM64'
Message-ID: <202201271847.hDKOwNao-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   63e583c8843f305a3e334a96d5de00435f4d38a2
commit: 6131c5e0ffa8e616ac27c10f3fae3b431c54f232 [181/190] drm/amdgpu: add determine passthrough under arm64
config: csky-randconfig-s031-20220124 (https://download.01.org/0day-ci/archive/20220127/202201271847.hDKOwNao-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 6131c5e0ffa8e616ac27c10f3fae3b431c54f232
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/atombios_crtc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/atombios_crtc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:295:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:295:25: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:295:25: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:296:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:296:17: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:296:17: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:345:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:345:17: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:345:17: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:637:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:637:23: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:637:23: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:639:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:639:25: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:639:25: sparse:    struct dma_fence *
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/atom.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/atom.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/atombios_dp.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/atombios_dp.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/atombios_encoders.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/atombios_encoders.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/atombios_i2c.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/atombios_i2c.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vf_error.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vf_error.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/amdgpu_object.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1418:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1418:25: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1418:25: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1419:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1419:17: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1419:17: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1478:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1478:17: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1478:17: sparse:    struct dma_fence *
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/amdgpu_object.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c:120:1: sparse: sparse: no newline at end of file
   drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/si_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/si_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/si.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/si.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/si_dma.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/si_dma.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/vi.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/vi.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/emu_soc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/emu_soc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/arct_reg_init.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/arct_reg_init.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/soc15.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/soc15.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/nv.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/nv.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/df_v1_7.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/df_v1_7.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/aldebaran_reg_init.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/aldebaran_reg_init.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/df_v3_6.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/df_v3_6.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/aldebaran.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/aldebaran.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/aldebaran.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/umc_v6_7.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/umc_v6_7.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/umc_v6_7.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/umc_v6_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/umc_v6_0.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/umc_v6_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/umc_v6_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/umc_v6_1.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/umc_v6_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/umc_v8_7.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/umc_v8_7.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/umc_v8_7.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/cz_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/cz_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/vega10_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/vega10_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/vega20_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/vega20_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/iceland_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/iceland_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/navi10_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/navi10_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/psp_v13_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/psp_v13_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/psp_v12_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/psp_v12_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/tonga_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/tonga_ih.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/athub_v2_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/athub_v2_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/athub_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/athub_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/athub_v2_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/athub_v2_1.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/smuio_v11_0_6.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/smuio_v11_0_6.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/mca_v3_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/mca_v3_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu12/renoir_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu12/renoir_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/cyan_skillfish_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/cyan_skillfish_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu12/smu_v12_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu12/smu_v12_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu10_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu10_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu8_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu8_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega12_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega12_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/navi10_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/navi10_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega10_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega10_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/arcturus_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/arcturus_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:658:17: sparse: sparse: incompatible types in conditional expression (different base types):
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:658:17: sparse:    void
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:658:17: sparse:    int
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:900:9: sparse: sparse: incompatible types in conditional expression (different base types):
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:900:9: sparse:    void
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:900:9: sparse:    int
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:932:9: sparse: sparse: incompatible types in conditional expression (different base types):
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:932:9: sparse:    void
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:932:9: sparse:    int
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:1026:9: sparse: sparse: incompatible types in conditional expression (different base types):
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:1026:9: sparse:    void
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:1026:9: sparse:    int
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu7_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu7_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/ci_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/ci_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/polaris10_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/polaris10_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/fiji_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/fiji_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_clockpowergating.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_clockpowergating.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/processpptables.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/processpptables.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu9_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu9_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/tonga_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/tonga_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vegam_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vegam_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_powertune.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_powertune.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/pp_psm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/pp_psm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu8_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu8_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/common_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/common_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_processpptables.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_processpptables.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_processpptables.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_processpptables.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_powertune.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_powertune.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_powertune.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_powertune.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu10_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu10_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_processpptables.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_processpptables.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_smc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_smc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/tonga_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/tonga_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/polaris_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/polaris_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ci_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ci_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/fiji_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/fiji_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu9_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu9_baco.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_psr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_psr.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_psr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/legacy_dpm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/legacy_dpm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_crc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_crc.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/amd_powerplay.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/amd_powerplay.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_services.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_services.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_pm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_pm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_color.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_color.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/amd_powerplay.h, ...):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_hwmgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
--
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_ARM64'
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:315:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"

vim +/CONFIG_ARM64 +299 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h

   294	
   295	static inline bool is_virtual_machine(void)
   296	{
   297	#ifdef CONFIG_X86
   298		return boot_cpu_has(X86_FEATURE_HYPERVISOR);
 > 299	#elif CONFIG_ARM64
   300		return !is_kernel_in_hyp_mode();
   301	#else
   302		return false;
   303	#endif
   304	}
   305	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
