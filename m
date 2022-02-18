Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EEF4BAEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiBRA5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:57:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiBRA5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:57:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DCE40E5B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645145846; x=1676681846;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vj2CsOTUkQBHhjNBO3qfYzU6/jLsbz73fewBTx19X8E=;
  b=Z9c1WlXExUJbSR4Q2MGZEIUcWN9aba3IJxurKwl29slhikI/EpWdzNf/
   xHkmDauLFI2+tdCOR60tVmM22yzMyM3LouwLYsphm6DiTTHv+75pUpoKs
   6eOzmX4yTCS74HXqHn82kte5435zoIzjpQ4TQXmQmFFeLNFY4f/ftqrag
   vleiZL/tsD/UTLx5Jg5hhUhv15N6d1J1tLjQG42gpVseU502V9HRNXIw1
   vxj168IzU/fbZc5ScwD/c0LTflnmGeJICWh4OLJKVtgzVpH0eVqfl5hN+
   7OFaXNAaXWGXYczZ8BEToKlux6jZIN2TKLU51py0UjGWQ1YzTj6GHVVTB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="337461547"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="337461547"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 16:55:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="682263638"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2022 16:55:07 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKrYB-0000mT-Ag; Fri, 18 Feb 2022 00:55:07 +0000
Date:   Fri, 18 Feb 2022 08:54:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amit Cohen <amcohen@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:ubridge 44/50]
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:818:1: warning: stack
 frame size (1080) exceeds limit (1024) in
 'mlxsw_sp_fid_erif_eport_to_vid_map_one'
Message-ID: <202202180823.WrBulKvy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw ubridge
head:   a9a4f2bd50dde60a52d9dda03d38875255fe0b9c
commit: df1dd79ad7b8bcecdae432f7ce94ded5a2358f20 [44/50] WIP: Add FID families
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220218/202202180823.WrBulKvy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/df1dd79ad7b8bcecdae432f7ce94ded5a2358f20
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw ubridge
        git checkout df1dd79ad7b8bcecdae432f7ce94ded5a2358f20
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:545:12: warning: stack frame size (1096) exceeds limit (1024) in 'mlxsw_sp_fid_erif_eport_to_vid_map' [-Wframe-larger-than]
   static int mlxsw_sp_fid_erif_eport_to_vid_map(struct mlxsw_sp_fid *fid,
              ^
>> drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:818:1: warning: stack frame size (1080) exceeds limit (1024) in 'mlxsw_sp_fid_erif_eport_to_vid_map_one' [-Wframe-larger-than]
   mlxsw_sp_fid_erif_eport_to_vid_map_one(const struct mlxsw_sp_fid *fid,
   ^
   2 warnings generated.


vim +/mlxsw_sp_fid_erif_eport_to_vid_map_one +818 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c

237f4f76837b01 Amit Cohen 2022-01-06  816  
e6f8d1542cdc49 Amit Cohen 2022-01-10  817  static int
e6f8d1542cdc49 Amit Cohen 2022-01-10 @818  mlxsw_sp_fid_erif_eport_to_vid_map_one(const struct mlxsw_sp_fid *fid,
e6f8d1542cdc49 Amit Cohen 2022-01-10  819  				       u16 rif_index, u16 local_port, u16 vid,
e6f8d1542cdc49 Amit Cohen 2022-01-10  820  				       bool valid)
e6f8d1542cdc49 Amit Cohen 2022-01-10  821  {
e6f8d1542cdc49 Amit Cohen 2022-01-10  822  	u8 port_page = local_port / (MLXSW_REG_REIV_REC_MAX_COUNT - 1);
e6f8d1542cdc49 Amit Cohen 2022-01-10  823  	u8 rec_num = local_port % MLXSW_REG_REIV_REC_MAX_COUNT;
e6f8d1542cdc49 Amit Cohen 2022-01-10  824  	struct mlxsw_sp *mlxsw_sp = fid->fid_family->mlxsw_sp;
e6f8d1542cdc49 Amit Cohen 2022-01-10  825  	char reiv_pl[MLXSW_REG_REIV_LEN];
e6f8d1542cdc49 Amit Cohen 2022-01-10  826  
e6f8d1542cdc49 Amit Cohen 2022-01-10  827  	mlxsw_reg_reiv_pack(reiv_pl, port_page, rif_index);
e6f8d1542cdc49 Amit Cohen 2022-01-10  828  	mlxsw_reg_reiv_rec_update_set(reiv_pl, rec_num, true);
e6f8d1542cdc49 Amit Cohen 2022-01-10  829  	mlxsw_reg_reiv_rec_evid_set(reiv_pl, rec_num, valid ? vid : 0);
e6f8d1542cdc49 Amit Cohen 2022-01-10  830  	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(reiv), reiv_pl);
e6f8d1542cdc49 Amit Cohen 2022-01-10  831  }
e6f8d1542cdc49 Amit Cohen 2022-01-10  832  

:::::: The code at line 818 was first introduced by commit
:::::: e6f8d1542cdc497206db6e9cd460cba6ca34e9a3 mlxsw: spectrum_fid: Configure layer 3 egress VID classification

:::::: TO: Amit Cohen <amcohen@nvidia.com>
:::::: CC: Amit Cohen <amcohen@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
