Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2E54D7602
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiCMPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiCMPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:08:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C845D58E4E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647184028; x=1678720028;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=voVt/B9+1NdMUoTqV4DsvzseRROgdcRRHrDMDTqVUqk=;
  b=hWOQswjuU7DMYOOe1s8w7revX4bf33PKfScOixX7I6A3/neDor8FY5iN
   SzCauaJKwb3l0Yrc/z/UlP9TRdJWrXiOEI+j4tlPqmGLjVWBdjs49NEqa
   WGH+vJRQeTd3GP/EC0YXqOm6iLT6Nxpn/58A+gJF/4ErT4cIrVLLT6ykP
   /FTdDI6Y2BzYriyofdJvwjEpV2ZHCENB3sRRfAPFSQG/odQ9T7MXWuNSc
   tFrrILdVpoDlFm4kF9TwhkKypRekoGNlyIY9+hOGf9ZnoHCu2VZE6UEV+
   UDBhVxJQzJOJ4qSrvcxPGFzgYQ40d8tArVWRFu+9JNmzG4OIaDTjMukOJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="236479651"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="236479651"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 08:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="539626703"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2022 08:06:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTPoA-00093A-IY; Sun, 13 Mar 2022 15:06:58 +0000
Date:   Sun, 13 Mar 2022 23:06:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 145/156] tcp.c:undefined reference to
 `tls_client_hello'
Message-ID: <202203132246.owOt14i2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 0683576e9521319c36f3a3a728cc0f9205a51065 [145/156] nvme-tcp: start TLS if requested
config: riscv-randconfig-m031-20220313 (https://download.01.org/0day-ci/archive/20220313/202203132246.owOt14i2-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=0683576e9521319c36f3a3a728cc0f9205a51065
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 0683576e9521319c36f3a3a728cc0f9205a51065
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
   core.c:(.exit.text+0x8): undefined reference to `nvme_keyring_exit'
   riscv64-linux-ld: drivers/nvme/host/core.o: in function `.L0 ':
   core.c:(.init.text+0x17c): undefined reference to `nvme_keyring_init'
   riscv64-linux-ld: drivers/nvme/host/tcp.o: in function `.L414':
   tcp.c:(.text+0x1f3c): undefined reference to `nvme_keyring_lookup_generated_key'
   riscv64-linux-ld: drivers/nvme/host/tcp.o: in function `.L0 ':
   tcp.c:(.text+0x1fb0): undefined reference to `nvme_keyring_lookup_tls'
   riscv64-linux-ld: drivers/nvme/host/tcp.o: in function `.L367':
   tcp.c:(.text+0x1fe6): undefined reference to `nvme_keyring_lookup_retained_key'
   riscv64-linux-ld: drivers/nvme/host/tcp.o: in function `.L0 ':
   tcp.c:(.text+0x201a): undefined reference to `nvme_keyring_insert_tls'
   riscv64-linux-ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_teardown_io_queues.part.0':
>> tcp.c:(.text+0x209c): undefined reference to `tls_client_hello'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
