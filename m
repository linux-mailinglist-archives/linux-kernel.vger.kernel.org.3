Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BD34EFD04
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 01:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353362AbiDAXOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 19:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiDAXOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 19:14:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE4D1AE232
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648854783; x=1680390783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OPzCag2JGWoNxMNwu7uFebgX4znndl20tsdpoJydaHM=;
  b=S1EpZM9VEzFwBVWExNW1N7YBCtF9Z9P3ewFoMrGRdjkhAxqo5oUTnf5n
   HW2zsBB0d+R8m6D+9I5xc/VQH3HcgRo+17cG8KyUJ2bVd1PHzh+L8Vy0Q
   CoFjjfE6pfyQ9lWfk1nNqRQPFEbjoTY1+fJNEcl1WL4ci/CUfBRbo3Wmb
   //y0Cz8RHMvaM8pwDle+eebE/PItcah0QuJn+5uObWqMqW+ovqv3R6oci
   GxeI9ym5K0I4tT2pdPPV7zIaEn8dHtW717s9AjrD6J6yL+WaFnghqrW+N
   02CiqRr86R9cgRqFo29tkl30C89jZgJxvakHDK/TaDTKGwZkI666L3fC6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="260234323"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="260234323"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 16:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="522948513"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2022 16:13:00 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naQRv-0001aS-Hq;
        Fri, 01 Apr 2022 23:12:59 +0000
Date:   Sat, 2 Apr 2022 07:12:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 25/28]
 drivers/misc/habanalabs/goya/goya.c:4265:5: warning: no previous prototype
 for 'goya_debugfs_read_dma'
Message-ID: <202204020706.ouqJkQDU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   fa59c43c5c906277ab3b753d782488ef4fd3ba62
commit: cb162eee0d9f31c21860a9f454563abde2ff30aa [25/28] habanalabs: remove debugfs read/write callbacks
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220402/202204020706.ouqJkQDU-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=cb162eee0d9f31c21860a9f454563abde2ff30aa
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout cb162eee0d9f31c21860a9f454563abde2ff30aa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/habanalabs/goya/goya.c:4265:5: warning: no previous prototype for 'goya_debugfs_read_dma' [-Wmissing-prototypes]
    4265 | int goya_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/goya_debugfs_read_dma +4265 drivers/misc/habanalabs/goya/goya.c

  4264	
> 4265	int goya_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
  4266					void *blob_addr)
  4267	{
  4268		dev_err(hdev->dev, "Reading via DMA is unimplemented yet\n");
  4269		return -EPERM;
  4270	}
  4271	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
