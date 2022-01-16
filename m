Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0A448FD8C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 15:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiAPO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 09:58:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:63128 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbiAPO6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 09:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642345082; x=1673881082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bzPxHZqbkuB0REHy64qGRoG+Ajbjl06/KY2TnHteV7Y=;
  b=bCOyFwBzQljF76Pz09mtB9GfOE5FR4aME8ix0fRKK3whu+GJSJxJwk9k
   QimlCEtxlzYbUc+Jm3wDLYz529f3FE4xgxIMho2a0CP0ESrWx49WUnYyQ
   yfJlh6FJjrOTySuImULBtM5L4zkQlI46FVE4lajG271EAlFlJ/0LveDtr
   WyI9VsuuzeTyNud7rQo8C2sA3L1svMygGFt/P/Mfg9cP1mTy4KK/oE+zB
   a539AAuniugepR5xoCUeMmTgIWW5AiS82KoAvWSbNc8UuqX96Klthup7U
   ZExE+vRkvMpyhOPglcruRwvIbijw8MoLIa+vSBYNO4amiHO+1JHToa89K
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="244291586"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="244291586"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 06:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="517115931"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jan 2022 06:58:01 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n96ym-000An0-KY; Sun, 16 Jan 2022 14:58:00 +0000
Date:   Sun, 16 Jan 2022 22:57:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-move-scsi-pointer 16/18]
 drivers/scsi/fdomain.c:122:22: warning: no previous prototype for function
 'fdomain_scsi_pointer'
Message-ID: <202201162216.f5S0sjGW-lkp@intel.com>
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
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220116/202201162216.f5S0sjGW-lkp@intel.com/config)
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
