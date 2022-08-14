Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F61B591FDF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 15:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiHNNXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 09:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHNNXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 09:23:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C4615A33
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 06:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660483380; x=1692019380;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yutm+A18q5PpK6Xs5uY6uwtnR+6YgExOzenNVgUyOZQ=;
  b=BwNJ/MWZ9IFOtaP16VllvO+MWFbOviLqZHir9sOelFs+ZYkn5k8HKU+A
   R8d7oRBdF4huDT7u7SZ21eBPXkkrEUxVEm/AL7k5zjAKRUkceMhFgbAdJ
   4JJNSGBX+Tmoq61C3lIU5skN22jHrzlLTkqeZf1x5SZe+MlO7d0pFpm44
   KUQNPsSOSLVmz9FS7+6tvFk6/sX7L3DKWmR2100NsGNQ68zEXctavdYOf
   d6yaZN/fvjbfhc6MOonKzJxyL9BzvqBZueFh+2ty2iIw6bNd6FPYQvth8
   B9rrEwrgrlSZ273Z9d16okZc9BxvY/8HohStojFdqKLio5GZpSlAfqxnf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="289394177"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="289394177"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 06:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="674568248"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2022 06:22:58 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNDZx-00007r-2Y;
        Sun, 14 Aug 2022 13:22:57 +0000
Date:   Sun, 14 Aug 2022 21:21:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: vfio_pci_zdev.c:undefined reference to `kvm_s390_pci_register_kvm'
Message-ID: <202208142157.vqcg59kg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: 8061d1c31f1a018281bc9877ecce44bfc779e21d vfio-pci/zdev: add open/close device hooks
date:   5 weeks ago
config: s390-randconfig-r011-20220814 (https://download.01.org/0day-ci/archive/20220814/202208142157.vqcg59kg-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8061d1c31f1a018281bc9877ecce44bfc779e21d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8061d1c31f1a018281bc9877ecce44bfc779e21d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/vfio/pci/vfio_pci_zdev.o: in function `vfio_pci_zdev_open_device':
>> vfio_pci_zdev.c:(.text+0x232): undefined reference to `kvm_s390_pci_register_kvm'
   s390-linux-ld: drivers/vfio/pci/vfio_pci_zdev.o: in function `vfio_pci_zdev_close_device':
>> vfio_pci_zdev.c:(.text+0x286): undefined reference to `kvm_s390_pci_unregister_kvm'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
