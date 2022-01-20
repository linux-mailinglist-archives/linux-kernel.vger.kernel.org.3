Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECDA494622
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358354AbiATD2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:28:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:39059 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbiATD2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642649330; x=1674185330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l3xM/5BGMvq/YAC36YxJBsiSO04CLWd5VQ8NRJu0gdU=;
  b=R7L97aDLeKmTpaAKT2I85+gPT8k2FTlpMmoSYdV7b3Gk9vMKZ6/9dzjF
   /0iL5x8mqQcmdkK0XPQ7eo+hLhaHgFGXoYr/MkfH3u1syIrsh8Zguckig
   PoxcGLFeMERm7x/9KC8rQm29WCLGJMdDz8edJDYKFZF06HhFrSkpfXGBO
   WZk23N6RHaVDVj+iQiky9vU/TSOL1pa8l5Fhr/mhWSYtDvBvf6IZHXNct
   bBtEcxR1EZnt/XSM1UyL4rcibAEYWxFSeiz13c6CMwhJLaSzeAnxo7LiV
   01Zf4nP4KMhUZyU0xnKrMvjRheFMh0CRDK4ruA6tjKim/cB9Y3n/U6e06
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="245216177"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="245216177"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 19:28:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="694046562"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Jan 2022 19:28:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAO7z-000Dxq-Jm; Thu, 20 Jan 2022 03:28:47 +0000
Date:   Thu, 20 Jan 2022 11:27:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amit Cohen <amcohen@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Subject: [jpirko-mlxsw:ubridge 73/78]
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:461:12: warning: stack
 frame size (1092) exceeds limit (1024) in
 'mlxsw_sp_fid_erif_eport_to_vid_map'
Message-ID: <202201201030.HA2UgQTx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw ubridge
head:   976afb368c2f7efc2dc2436013895cc96ab06774
commit: 6e0855a9b3824d98f266ac39a1a19c7bce925cd2 [73/78] mlxsw: spectrum_fid: Configure layer 3 egress VID classification
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220120/202201201030.HA2UgQTx-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/6e0855a9b3824d98f266ac39a1a19c7bce925cd2
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw ubridge
        git checkout 6e0855a9b3824d98f266ac39a1a19c7bce925cd2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:461:12: warning: stack frame size (1092) exceeds limit (1024) in 'mlxsw_sp_fid_erif_eport_to_vid_map' [-Wframe-larger-than]
   static int mlxsw_sp_fid_erif_eport_to_vid_map(struct mlxsw_sp_fid *fid,
              ^
>> drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:689:12: warning: stack frame size (1116) exceeds limit (1024) in '__mlxsw_sp_fid_port_vid_map' [-Wframe-larger-than]
   static int __mlxsw_sp_fid_port_vid_map(const struct mlxsw_sp_fid *fid,
              ^
   2 warnings generated.


vim +/mlxsw_sp_fid_erif_eport_to_vid_map +461 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c

   460	
 > 461	static int mlxsw_sp_fid_erif_eport_to_vid_map(struct mlxsw_sp_fid *fid,
   462						      u16 rif_index, bool valid)
   463	{
   464		struct mlxsw_sp *mlxsw_sp = fid->fid_family->mlxsw_sp;
   465		struct mlxsw_sp_fid_port_vid *port_vid, *tmp;
   466		char reiv_pl[MLXSW_REG_REIV_LEN] = {};
   467		bool records_to_write = false;
   468		u8 rec_num, current_page = 0;
   469		u16 last_local_port;
   470		int err;
   471	
   472		mlxsw_reg_reiv_pack(reiv_pl, current_page, rif_index);
   473		last_local_port = current_page * MLXSW_REG_REIV_REC_MAX_COUNT +
   474				  MLXSW_REG_REIV_REC_MAX_COUNT - 1;
   475	
   476		list_for_each_entry_safe(port_vid, tmp, &fid->port_vid_list, list) {
   477			/* The list is sorted by local_port. */
   478			if (port_vid->local_port > last_local_port)
   479				goto reg_write;
   480	
   481	new_record_fill:
   482			rec_num = port_vid->local_port % MLXSW_REG_REIV_REC_MAX_COUNT;
   483			mlxsw_reg_reiv_rec_update_set(reiv_pl, rec_num, true);
   484			mlxsw_reg_reiv_rec_evid_set(reiv_pl, rec_num,
   485						    valid ? port_vid->vid : 0);
   486			records_to_write = true;
   487			goto next_list_node;
   488	
   489	reg_write:
   490		err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(reiv), reiv_pl);
   491		if (err)
   492			return err;
   493	
   494		records_to_write = false;
   495		current_page++;
   496		memset(reiv_pl, 0, MLXSW_REG_REIV_LEN);
   497		mlxsw_reg_reiv_pack(reiv_pl, current_page, rif_index);
   498		last_local_port = current_page * MLXSW_REG_REIV_REC_MAX_COUNT +
   499				  MLXSW_REG_REIV_REC_MAX_COUNT - 1;
   500		goto new_record_fill;
   501	
   502	next_list_node:
   503			continue;
   504		}
   505	
   506		if (records_to_write)
   507			return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(reiv),
   508					       reiv_pl);
   509		return 0;
   510	}
   511	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
