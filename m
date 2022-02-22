Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F3E4BF22B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiBVGmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:42:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiBVGmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:42:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F1592D26
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645512117; x=1677048117;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=565ws47WFEYIbaEqthwqBMUwnShZctz+uzY1q5fYvfA=;
  b=TLXWUyPD67zlywD7xTwIJvGsgJU3EDIbPcFr5Da1yxUWfxP2EVDQTDjL
   1DeQQjUX7D4Ogct6S0+qrcQKmxbX20q9ukoWKLHxqKksLHMglDfIugnSk
   grAfk2e16f4djfGWoMmsjKDLF2C6IEieN2yv0tNRCnBz+kqHdoO3pFrNk
   ZgkKJNSbzX1XJYlQwwGx8WlA3LJAryH9nq4ksD2qBiz5KRmdFd0pK4Xrt
   vkrP9sVXeEa8v2I8oe8Eu/+v+TOFCh1U4CVMj8xcdsmMfR4FPvb1gCv0/
   et+TT5sPLXyMPeIjL+rclM8kP7jDpGrKYSFoOkpButiMfCx7+bH/bx2np
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="235164886"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="235164886"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 22:41:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="490678994"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2022 22:41:55 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMOry-0002Pi-KH; Tue, 22 Feb 2022 06:41:54 +0000
Date:   Tue, 22 Feb 2022 14:41:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [mkp-scsi:for-next 93/154] ERROR: modpost: "sas_execute_ata_cmd"
 [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
Message-ID: <202202221415.NGi65lH3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
head:   2988062985d598d6871f47cb8eb70318af5b5b2d
commit: 13685dfbad9831580335dc6e2f7a3be14b769686 [93/154] scsi: libsas: Add sas_execute_ata_cmd()
config: openrisc-randconfig-r031-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221415.NGi65lH3-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=13685dfbad9831580335dc6e2f7a3be14b769686
        git remote add mkp-scsi https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
        git fetch --no-tags mkp-scsi for-next
        git checkout 13685dfbad9831580335dc6e2f7a3be14b769686
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "sas_execute_ata_cmd" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
