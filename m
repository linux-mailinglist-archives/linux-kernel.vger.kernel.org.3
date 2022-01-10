Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C73448A107
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbiAJUmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:42:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:64093 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239618AbiAJUmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641847333; x=1673383333;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K73z+wiO+G4LzSOMCSj8wAZUA5AbfcvounfEuwgVICQ=;
  b=BdnIYO/J0yLVI6auOO13NT697OUuIquHyRt7u3RIW8kkit5HzJ1FOXOp
   0yHTsudnW+hYvjd08ByR7kVhTa3vCYqdrXwfkPrcku9PKWN8vGddQcoya
   1EuLwCDF+Qap+2iBYi0nTtI9JBDTll54gZ4wVNyCgMK9kPIhCo6NUOka6
   LCFVzpx0/0aMVRes6FCgBAPWbmCzZBmAm+ldk7A4I/RkupKVjYnO+LIIY
   Z+Lw3XVSb9ajm7WROHoGQcDKI6ybSNbuqO0kKP/yuyHiKaB0HD1hFnvOl
   MaY5h/ptnMwsLqswhz2UrKjZ4lBVkXSmEwVUt0JY4gJxm9+oll2meXInY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243113516"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="243113516"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 12:42:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="690710625"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2022 12:42:12 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n71UZ-0003wT-IX; Mon, 10 Jan 2022 20:42:11 +0000
Date:   Tue, 11 Jan 2022 04:41:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amit Cohen <amcohen@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:ubridge 24/24]
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:688:1: warning: the frame
 size of 1056 bytes is larger than 1024 bytes
Message-ID: <202201110412.gyFzNBL2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw ubridge
head:   0643bb3b26318a01d878d01f6f06f73f7a4fd302
commit: 0643bb3b26318a01d878d01f6f06f73f7a4fd302 [24/24] mlxsw: spectrum_fid:
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220111/202201110412.gyFzNBL2-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/0643bb3b26318a01d878d01f6f06f73f7a4fd302
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw ubridge
        git checkout 0643bb3b26318a01d878d01f6f06f73f7a4fd302
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c: In function 'mlxsw_sp_fid_erif_eport_to_vid_map_one.isra':
>> drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:688:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     688 | }
         | ^
   drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c: In function 'mlxsw_sp_fid_erif_eport_to_vid_map':
   drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:516:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     516 | }
         | ^


vim +688 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c

   673	
   674	static int
   675	mlxsw_sp_fid_erif_eport_to_vid_map_one(const struct mlxsw_sp_fid *fid,
   676					       u16 rif_index, u16 local_port, u16 vid,
   677					       bool valid)
   678	{
   679		u8 port_page = local_port / (MLXSW_REG_REIV_REC_MAX_COUNT - 1);
   680		u8 rec_num = local_port % MLXSW_REG_REIV_REC_MAX_COUNT;
   681		struct mlxsw_sp *mlxsw_sp = fid->fid_family->mlxsw_sp;
   682		char reiv_pl[MLXSW_REG_REIV_LEN];
   683	
   684		mlxsw_reg_reiv_pack(reiv_pl, port_page, rif_index);
   685		mlxsw_reg_reiv_rec_update_set(reiv_pl, rec_num, true);
   686		mlxsw_reg_reiv_rec_evid_set(reiv_pl, rec_num, valid ? vid : 0);
   687		return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(reiv), reiv_pl);
 > 688	}
   689	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
