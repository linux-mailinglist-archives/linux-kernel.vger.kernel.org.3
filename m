Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCBC4C57CA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 20:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiBZTOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 14:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiBZTOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 14:14:45 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079BF50062
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645902849; x=1677438849;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lsaBfyn5qGrTgcE+xIMmhDbMYzBpoNLSF9JDzDjIEOA=;
  b=dpBbd/cGuChypikcGArdYALmThktzTdMDu9fUMXqGwu6teIPU3629UZj
   PgsHZx6FevaSsGmkAheZnLANlqkZRWxNf3833n5khx9Qy4sZjUyyZ6kYZ
   9hClFJRqSTgJkkq3+Z/dz0fla1Quw/LHIvm3lqKVemacb//fRwf8oUy6e
   BuvivUwR6XolkDCRet0HD9byBSA+fRPN1pFTQtuK/ifRlfrdBDPG/bvMl
   moHMd7TTSPLZg2+R8Jfb98j0fkKA9tyVi1RfYiJdHiQjFRnY2WD1RMIGF
   xCkFWbLVXCb/06Qqfl7X64b7iCmY3Lg6YlmU9xkBoiFZBCWVKhaNRFHvm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="252408082"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="252408082"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 11:14:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="509618684"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2022 11:14:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO2W6-0005rz-1v; Sat, 26 Feb 2022 19:14:06 +0000
Date:   Sun, 27 Feb 2022 03:14:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 142/159] ERROR: modpost:
 "nvme_keyring_insert_tls" [drivers/nvme/host/nvme-tcp.ko] undefined!
Message-ID: <202202262118.1B2yhvRS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   21b520ae0b338bd30496feb1ca90a2820dab7a65
commit: 4c6b8023e6fd977739a1df4a3309c661a21bb65e [142/159] nvme-tcp: derive keys and start TLS if requested
config: m68k-buildonly-randconfig-r004-20220226 (https://download.01.org/0day-ci/archive/20220226/202202262118.1B2yhvRS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=4c6b8023e6fd977739a1df4a3309c661a21bb65e
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 4c6b8023e6fd977739a1df4a3309c661a21bb65e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "nvme_keyring_insert_tls" [drivers/nvme/host/nvme-tcp.ko] undefined!
ERROR: modpost: "nvme_keyring_lookup_dhchap" [drivers/nvme/host/nvme-tcp.ko] undefined!
ERROR: modpost: "nvme_keyring_lookup_psk" [drivers/nvme/host/nvme-tcp.ko] undefined!
>> ERROR: modpost: "nvme_keyring_lookup_tls" [drivers/nvme/host/nvme-tcp.ko] undefined!
ERROR: modpost: "nvme_keyring_init" [drivers/nvme/host/nvme-core.ko] undefined!
ERROR: modpost: "nvme_keyring_exit" [drivers/nvme/host/nvme-core.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
