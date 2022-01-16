Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45948FDA9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 16:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiAPPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 10:38:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:9728 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233304AbiAPPiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 10:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642347484; x=1673883484;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VRQRfxDj7ZKfHbEj/AsMl41WqOilGgjxJMPYxRMOKkE=;
  b=GKdbqgOz4FOams81f52OQPq30af8+QqdxtKs3k8B7U9AVFldNFTI0MRh
   YdS2IGu4CkBiW/O5xLI1MfZ1SLLaei8+Blv8baoyz9s2CCszQOlSrxn6e
   z/OLjvA9IezXPmBk6HusEkfAGRZXtMgRWjSWn3ayfWx5P0MNl+K0hidVw
   yq9UXxZ6sTmNHC7MyxoXaU0A2F2U2NCiKOFh4aSPMWj/yxEAMvklBvf6u
   Bk3Run6KQLUuvxdQecuBZkMd2288sStuSzIN7J6qfZR5OsLHXek8Ar8rm
   5InfK+rond75PSVNIs7/vsk73519hMKfsc2abHJmOPbIeZ7gZlRIVAuB7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="305230307"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="305230307"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 07:38:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="692808092"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2022 07:38:01 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n97bV-000AoE-63; Sun, 16 Jan 2022 15:38:01 +0000
Date:   Sun, 16 Jan 2022 23:37:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-move-scsi-pointer 16/18]
 drivers/scsi/fdomain.c:122:22: warning: no previous prototype for function
 'fdomain_scsi_pointer'
Message-ID: <202201162349.t2n6wgaH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-move-scsi-pointer
head:   7173550f8dd7130891118452742bb6e99b63fd27
commit: 6eea006091e2b2b428a910feb8041bbb99aa707d [16/18] fdomain: Move the SCSI pointer to private command data
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220116/202201162349.t2n6wgaH-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/6eea006091e2b2b428a910feb8041bbb99aa707d
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-move-scsi-pointer
        git checkout 6eea006091e2b2b428a910feb8041bbb99aa707d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/fdomain.c:122:22: warning: no previous prototype for function 'fdomain_scsi_pointer' [-Wmissing-prototypes]
   struct scsi_pointer *fdomain_scsi_pointer(struct scsi_cmnd *cmd)
                        ^
   drivers/scsi/fdomain.c:122:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct scsi_pointer *fdomain_scsi_pointer(struct scsi_cmnd *cmd)
   ^
   static 
   1 warning generated.


vim +/fdomain_scsi_pointer +122 drivers/scsi/fdomain.c

   121	
 > 122	struct scsi_pointer *fdomain_scsi_pointer(struct scsi_cmnd *cmd)
   123	{
   124		struct fdomain_priv *fcmd = scsi_cmd_priv(cmd);
   125	
   126		return &fcmd->scsi_pointer;
   127	}
   128	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
