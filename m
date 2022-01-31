Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9764B4A46B6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376437AbiAaMRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:17:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:7664 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376611AbiAaMRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643631445; x=1675167445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dwqBDqOQlSjSJFkHUy4/qSrW94wE6B2ASgNdy8pW+64=;
  b=RZd99I5QKuh+G8xOzbVZj8HCGfMbZ5iIOaOScWjlQgqVgHFq3s1OFEQj
   0k/aq5i5wjQcnaBVq1m60hxc/HmHeB/RjcPt4b7+2S/nQCVsD3iKOxUDV
   +trbutWJHbn+BLvqjlINDNXWxgf2YMtQrlaJfaM17CJNSeE1mJQJ14voA
   QVKF8DMJ6cuJ1PcpLx5A/y2fqh8TxSVlLSGKWT38QW6tfK5BkSK4k6Ngj
   eCw7OHLutJyL9koGhvlBgP/h508YvbmdGxBgzvxR5LulBtDbYYofH3pew
   3e+pboqWQlQ5Idp4jVyEfNb6c03xpYw7ouIu0iETuETya7/ubefzPyWkM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="246282363"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="246282363"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 04:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="619366968"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jan 2022 04:17:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEVcZ-000RtH-AG; Mon, 31 Jan 2022 12:17:23 +0000
Date:   Mon, 31 Jan 2022 20:17:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amit Cohen <amcohen@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:ubridge 24/39]
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:687:1: warning: the frame
 size of 1056 bytes is larger than 1024 bytes
Message-ID: <202201312057.VGGmaz9I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw ubridge
head:   c28f9c08c88cef81d174cecf88f8e426f3bc3aeb
commit: c136514a00f9392d94f357b2cedbf5e04c910c44 [24/39] mlxsw: spectrum_fid: Configure layer 3 egress VID classification
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20220131/202201312057.VGGmaz9I-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/c136514a00f9392d94f357b2cedbf5e04c910c44
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw ubridge
        git checkout c136514a00f9392d94f357b2cedbf5e04c910c44
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c: In function 'mlxsw_sp_fid_erif_eport_to_vid_map_one.isra':
>> drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:687:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     687 | }
         | ^
   drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c: In function 'mlxsw_sp_fid_erif_eport_to_vid_map':
   drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:510:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     510 | }
         | ^


vim +687 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c

   672	
   673	static int
   674	mlxsw_sp_fid_erif_eport_to_vid_map_one(const struct mlxsw_sp_fid *fid,
   675					       u16 rif_index, u16 local_port, u16 vid,
   676					       bool valid)
   677	{
   678		u8 port_page = local_port / (MLXSW_REG_REIV_REC_MAX_COUNT - 1);
   679		u8 rec_num = local_port % MLXSW_REG_REIV_REC_MAX_COUNT;
   680		struct mlxsw_sp *mlxsw_sp = fid->fid_family->mlxsw_sp;
   681		char reiv_pl[MLXSW_REG_REIV_LEN];
   682	
   683		mlxsw_reg_reiv_pack(reiv_pl, port_page, rif_index);
   684		mlxsw_reg_reiv_rec_update_set(reiv_pl, rec_num, true);
   685		mlxsw_reg_reiv_rec_evid_set(reiv_pl, rec_num, valid ? vid : 0);
   686		return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(reiv), reiv_pl);
 > 687	}
   688	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
