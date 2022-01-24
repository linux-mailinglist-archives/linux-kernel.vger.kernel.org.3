Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5520C498432
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243363AbiAXQEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:04:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:8835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243307AbiAXQD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643040238; x=1674576238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=17zqfEkQdJLAK/211DWVQkarvodRYPP8SbHf4uGm+qY=;
  b=kPv2wRzvYxOaYbScKwJrRDGcKhpIAR66GvKdm4j0OPLmH/iVpSNFwVXI
   EvfV9lo1PZkHnYXW4h/dFrXVkGHcfxk1ON2j/ql38IY6K5ZyL3Apdj08R
   TPfCMtajienn7NeNcfoxUeZ+AltsE4GXR71r4PCnlakPZU9LI0xB8Eq7G
   u7ABGbwmw7W0fRyycCpgEXp0lv7JmLMmHL0coD+C27eWoDgsbd5Pzv/ix
   DtUoxeTrv0sWXmg06Xuw1qUNpfSL7Th1lYUzKFiCMrb3+jcy518HeCWCw
   tt5RK+P+KfsH6ncDbPz4SSgmlZqCfHm8ZPmoQnN7e/CXbrTRGHQ8MbENa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246021445"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246021445"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 08:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627541906"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 08:03:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC1ov-000IZv-PA; Mon, 24 Jan 2022 16:03:53 +0000
Date:   Tue, 25 Jan 2022 00:03:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-move-scsi-pointer 24/45]
 drivers/scsi/mac53c94.h:219:22: warning: no previous prototype for
 'mac53c94_scsi_pointer'
Message-ID: <202201242330.fIUDhR7w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-move-scsi-pointer
head:   83b0eca2b3e354c26f2dbfcc765d97c35de34a57
commit: 7d78660acf74697fe6470e6f95fbeacca3113524 [24/45] mac53c94: Move the SCSI pointer to private command data
config: powerpc-ppc6xx_defconfig (https://download.01.org/0day-ci/archive/20220124/202201242330.fIUDhR7w-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/7d78660acf74697fe6470e6f95fbeacca3113524
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-move-scsi-pointer
        git checkout 7d78660acf74697fe6470e6f95fbeacca3113524
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/scsi/mac53c94.c:34:
>> drivers/scsi/mac53c94.h:219:22: warning: no previous prototype for 'mac53c94_scsi_pointer' [-Wmissing-prototypes]
     219 | struct scsi_pointer *mac53c94_scsi_pointer(struct scsi_cmnd *cmd)
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mac53c94.c: In function 'mac53c94_init':
   drivers/scsi/mac53c94.c:128:13: warning: variable 'x' set but not used [-Wunused-but-set-variable]
     128 |         int x;
         |             ^


vim +/mac53c94_scsi_pointer +219 drivers/scsi/mac53c94.h

   218	
 > 219	struct scsi_pointer *mac53c94_scsi_pointer(struct scsi_cmnd *cmd)
   220	{
   221		struct mac53c94_cmd_priv *mcmd = scsi_cmd_priv(cmd);
   222	
   223		return &mcmd->scsi_pointer;
   224	}
   225	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
