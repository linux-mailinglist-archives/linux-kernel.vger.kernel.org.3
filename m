Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3733A481808
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 02:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhL3BS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 20:18:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:12448 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233845AbhL3BS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 20:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640827108; x=1672363108;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pLvsmuDIczuRhtLhRDT0LsVQJJCF1zlJ/bT1QUBHxqY=;
  b=OYNhoz8FYTGE1gc/Q+wfqAIJSjAPKekFtOn242rPaz7/7MdNIFYKZ0xy
   U9wNlmCGeWZpzhzX1fWyamIYiMTFqL0fsC5AckzCeRhmnHcsGaNJUJA9G
   RNUIz0tI7rlHSwkI1fQ7vOB4gGc7HC86Gi202S931VwgIeWOKVpgjJMSq
   SAJ0iJvm+mXV+gK7MEZBIIzwcGzksyOt2KB4aZxBYmzJezbZZCVBhILUq
   awXx3hAel4rvqye9LhBTFc5mmUqywrBRg3zTUDfBRfnDi25UHjbGbo0uy
   +Xm0c3F6SVkMEEKSdOiBipXfOsBYAp36UCsjQFF7X+dVhNnq0cWRCOzvH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="222267369"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="222267369"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 17:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="687065076"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Dec 2021 17:18:26 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2k5J-0009XQ-FK; Thu, 30 Dec 2021 01:18:25 +0000
Date:   Thu, 30 Dec 2021 09:17:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [hyperv:hyperv-next 1/7] swiotlb.c:undefined reference to `memremap'
Message-ID: <202112300919.vfQIU5rt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
head:   e1878402ab2dca12d1426f2fea39757943f3332c
commit: 1a5e91d8375fc8369207cc0b9894a324f2bbf1d9 [1/7] swiotlb: Add swiotlb bounce buffer remap function for HV IVM
config: s390-randconfig-r014-20211230 (https://download.01.org/0day-ci/archive/20211230/202112300919.vfQIU5rt-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=1a5e91d8375fc8369207cc0b9894a324f2bbf1d9
        git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
        git fetch --no-tags hyperv hyperv-next
        git checkout 1a5e91d8375fc8369207cc0b9894a324f2bbf1d9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/swiotlb.o: in function `swiotlb_update_mem_attributes':
>> swiotlb.c:(.init.text+0x314): undefined reference to `memremap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
