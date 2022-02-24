Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA274C2093
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245241AbiBXA0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbiBXA0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:26:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB9F60CD5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645662355; x=1677198355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v2BVoCfWfHpNvJcrURlziIA5fS7lCJAOiQG7Q87o/64=;
  b=U3t/P9fLU/nR8W7QeiSA6xqVOs4t26gGnpE0O/gjXe9AtJi8RC+/0otk
   AbbHDmwTVRlafF+R5LcHHLhCiH6+LAegSp0Y0IYBqK20Wx3HENK6cGajz
   e49+dAzHefomn0tfGDjdLNDiXPdJS6ADzHDPi9Ej1bL5JJvdwv3wUDQzd
   kIKzItL7eiFbrhuIuae2gB9hoTgBDiusr+xfJHvVPtH7wkrR0qRbBXeTl
   G/aZ4fr2oPYI6FH/mVosIRhhyHBbrDJpQSgNfgv+aLjLuyny07y6rRvZS
   7qIC9FwS/npGS/YumEaEQjdaOwEXeNjGlgmJmBA1Ud/897jK8SeBqkur5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251850952"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="251850952"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:25:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="506123244"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2022 16:25:54 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN1xB-00021M-B2; Thu, 24 Feb 2022 00:25:53 +0000
Date:   Thu, 24 Feb 2022 08:25:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 37/67] core.c:undefined reference to
 `nvme_keyring_exit'
Message-ID: <202202240835.oLOc3XHC-lkp@intel.com>
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
head:   ac729ea3c52bda460616c71d5f5fc47b2e64da6d
commit: 425d51ead0df0006cc5a3e361f294e33de2c1e0c [37/67] nvme: register .nvme keyring
config: arm-buildonly-randconfig-r003-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240835.oLOc3XHC-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=425d51ead0df0006cc5a3e361f294e33de2c1e0c
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 425d51ead0df0006cc5a3e361f294e33de2c1e0c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
>> core.c:(.exit.text+0x4): undefined reference to `nvme_keyring_exit'
   arm-linux-gnueabi-ld: drivers/nvme/host/core.o: in function `nvme_core_init':
   core.c:(.init.text+0x184): undefined reference to `nvme_keyring_init'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
