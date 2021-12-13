Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9367B473449
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241983AbhLMSq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:46:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:20914 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234611AbhLMSqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639421215; x=1670957215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9skCXa1vdiokT9qe33jgpxewyeQKLLapHhl+dO0PgvI=;
  b=AL0+uJ4WR1cIVFHM/6KAUwU8yGAtuqgADu3XSK8uQ1jjY3QuTNrF3jHX
   MpbdI1lGgiSPCFujipeqs1WMdW5EQg3kiftq2vdsKYMrwEYyp+ARLhu0T
   vOjNjgthaT/OMN7/Af4n/oBz2KO8aQBjq5XwNZRrJFbb4Gg/ralbDy7nj
   RuSpAxl3bOkAYjiTHywE5q1WOJ9F5mHl+Pna9XmqlkqVVs4wNJ9Y6kz5L
   10D/Tl45iM8RsoF7Q/z1tMc9D5Lttby0nH7ZHM31l/aWtU0x7jsvhKZsm
   L/MOKNVxlU6/Tj3K1kgCUOhYWyPIPo2+2d/SDOtf/DJG7G8uEhFFFW5Xs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="218817697"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="218817697"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 10:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="681739065"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2021 10:46:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwqLc-0006wc-Gj; Mon, 13 Dec 2021 18:46:52 +0000
Date:   Tue, 14 Dec 2021 02:46:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [PATCH] virtio_mmio: pm: Add notification handlers for restore
 and freeze
Message-ID: <202112140201.xeCfVzym-lkp@intel.com>
References: <20211213160002.GA202134@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213160002.GA202134@opensynergy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mikhail-Golubev/virtio_mmio-pm-Add-notification-handlers-for-restore-and-freeze/20211214-001636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
config: m68k-randconfig-r033-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140201.xeCfVzym-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/86cd610f19003c4d848c13e5e00e38e9bc41f54e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mikhail-Golubev/virtio_mmio-pm-Add-notification-handlers-for-restore-and-freeze/20211214-001636
        git checkout 86cd610f19003c4d848c13e5e00e38e9bc41f54e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/virtio/virtio_mmio.c: In function 'virtio_mmio_freeze':
>> drivers/virtio/virtio_mmio.c:770:16: error: implicit declaration of function 'virtio_device_freeze'; did you mean 'virtio_device_ready'? [-Werror=implicit-function-declaration]
     770 |         return virtio_device_freeze(&vm_dev->vdev);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                virtio_device_ready
   drivers/virtio/virtio_mmio.c: In function 'virtio_mmio_restore':
>> drivers/virtio/virtio_mmio.c:778:16: error: implicit declaration of function 'virtio_device_restore'; did you mean 'virtio_mmio_restore'? [-Werror=implicit-function-declaration]
     778 |         return virtio_device_restore(&vm_dev->vdev);
         |                ^~~~~~~~~~~~~~~~~~~~~
         |                virtio_mmio_restore
   cc1: some warnings being treated as errors


vim +770 drivers/virtio/virtio_mmio.c

   764	
   765	static int __maybe_unused virtio_mmio_freeze(struct device *dev)
   766	{
   767		struct platform_device *pdev = to_platform_device(dev);
   768		struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
   769	
 > 770		return virtio_device_freeze(&vm_dev->vdev);
   771	}
   772	
   773	static int __maybe_unused virtio_mmio_restore(struct device *dev)
   774	{
   775		struct platform_device *pdev = to_platform_device(dev);
   776		struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
   777	
 > 778		return virtio_device_restore(&vm_dev->vdev);
   779	}
   780	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
