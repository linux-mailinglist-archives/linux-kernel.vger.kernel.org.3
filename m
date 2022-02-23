Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C894C1FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbiBWXdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244813AbiBWXdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:33:22 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E062593AE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645659174; x=1677195174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0tMbZiJu34aB9PD1euiLsq76yrW0ci1L0OTsb5W6Cqg=;
  b=iqYUE0ozleTBT+8Qz9oV+JYn2zlU/PHfDQg+ll7cs3S6MQGyR5QmWtms
   fLMLtFLs7Rh6djEZ732/ctlVlb3lxjEC0Yy+JUhIJnIh66kEnCRRHqBf/
   H759y9xJiTZVDU3Yo/WWn20crf/qyg+JANZC7/OX37EncpJD6d+odtlw0
   tBpRH75cyhkYbm2h3fI0DR7DqvnxR/zShQn7c4fCxGUQKDug2hGIeM77u
   JXbhkP6WkTJ5TnS/1PhQtw47Nmo5S03oACK+idjyFf9cD4OjxeM1kU2ZS
   zAFbuqzPVo4oTKXg1ebhWfHsPzgDM5SbLurce+46RuXWuV0TxqP+NW9ZL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312823635"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="312823635"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:32:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="543503863"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Feb 2022 15:32:52 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN17r-0001wo-F9; Wed, 23 Feb 2022 23:32:51 +0000
Date:   Thu, 24 Feb 2022 07:32:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 37/67] undefined reference to
 `nvme_keyring_exit'
Message-ID: <202202240718.RNDH1Q2b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   ac729ea3c52bda460616c71d5f5fc47b2e64da6d
commit: 425d51ead0df0006cc5a3e361f294e33de2c1e0c [37/67] nvme: register .nvme keyring
config: microblaze-randconfig-r026-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240718.RNDH1Q2b-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=425d51ead0df0006cc5a3e361f294e33de2c1e0c
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 425d51ead0df0006cc5a3e361f294e33de2c1e0c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
>> (.exit.text+0x8): undefined reference to `nvme_keyring_exit'
   microblaze-linux-ld: drivers/nvme/host/core.o: in function `nvme_core_init':
>> (.init.text+0x178): undefined reference to `nvme_keyring_init'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
