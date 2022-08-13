Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745CF5918EB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 07:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbiHMFeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 01:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238528AbiHMFdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:33:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE15979E6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 22:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660368791; x=1691904791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hMnryVYeFDtALetXD12TG+Eg8Uw+lXmQZEkKo2pjS5c=;
  b=d7qsKAigSo/Kp6sF+j3wwxinob4eEViVUfRmVKdMh9QgToQdScI7IIMp
   t/6Fc1Y1MnHaAEzFddj7uGnL9WrYietCpXzS4kc48xVWfsd3WrrH50P6F
   GLfL8y5hswagymUVNAqXYZ68odUPYr1xFCA2W7/MqDARzZOD8tIG3qswM
   I82LOQfSt8hSGmzzW7fXAtDrfZzCqoPAU/zLxbXJ7RnbR4T733mRs+/rI
   LjYh/ObB20jw97uq8Hxak9G7nlvVBV3Zts0Eqtt9Hu9v8Up0NLLS7Iw3H
   qbKYdSWPrd+++lmX68koOu5WJXMskgs/8WYT1zSy8uapBK8ipSVE5Bvzi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="274784620"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="274784620"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="695472804"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Aug 2022 22:33:09 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMjlk-0001Lj-3C;
        Sat, 13 Aug 2022 05:33:08 +0000
Date:   Sat, 13 Aug 2022 13:32:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: arch/s390/kvm/pci.h:47:69: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202208131353.8ChUuYVb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69dac8e431af26173ca0a1ebc87054e01c585bcc
commit: 73f91b004321f2510fa79e66035dbbf1870fcf56 KVM: s390: pci: enable host forwarding of Adapter Event Notifications
date:   5 weeks ago
config: s390-randconfig-s053-20220811 (https://download.01.org/0day-ci/archive/20220813/202208131353.8ChUuYVb-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=73f91b004321f2510fa79e66035dbbf1870fcf56
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 73f91b004321f2510fa79e66035dbbf1870fcf56
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/s390/kvm/interrupt.c: note: in included file:
>> arch/s390/kvm/pci.h:47:69: sparse: sparse: Using plain integer as NULL pointer
   arch/s390/kvm/pci.h:48:32: sparse: sparse: Using plain integer as NULL pointer
   arch/s390/kvm/pci.h:49:24: sparse: sparse: Using plain integer as NULL pointer

vim +47 arch/s390/kvm/pci.h

    43	
    44	static inline struct kvm *kvm_s390_pci_si_to_kvm(struct zpci_aift *aift,
    45							 unsigned long si)
    46	{
  > 47		if (!IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM) || aift->kzdev == 0 ||
    48		    aift->kzdev[si] == 0)
    49			return 0;
    50		return aift->kzdev[si]->kvm;
    51	};
    52	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
