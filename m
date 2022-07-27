Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D66B582758
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiG0NE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiG0NEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:04:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B6222BCB;
        Wed, 27 Jul 2022 06:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658927065; x=1690463065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6SwQ9YOIn0PoKIrChETiUz4v21HjnRgy6rGCYq0XXgU=;
  b=irmfqzC2v/aBWpiqF88sbveXqeWEwh9bWkWsHJ8WFuhAd9SH9/nQt8/V
   9RohSGVX6dU9OLQ6tdwRDvJzQh4Wm/+Z42JKvNy37N8WOjHhqL/KZ4MEB
   MHrktjoPfjxSwduWoiYLRiHkXZbVu3JmYB9dN2qmjWS2QCW2tLj0ZUZIX
   qke674bF4BagRSIH2EhDEPffNhy1TuehSueth3BwGNLvowROy4I2d/kx3
   QgxT9dC8rgTiq4xlcGqKbhzhzXaN3ij5MXb87y7T8Qn690V1V/7WCX1/+
   fJCmboWc+4CUcYniRxcs7Bu/D0RqOa3ClYHKNWxn2HfoF82P4wDFxFpVI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="349931419"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="349931419"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 06:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="550839199"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jul 2022 06:04:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGgi5-0008iy-1E;
        Wed, 27 Jul 2022 13:04:21 +0000
Date:   Wed, 27 Jul 2022 21:04:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chetan C R <quic_cchinnad@quicinc.com>, jejb@linux.ibm.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Chetan C R <quic_cchinnad@quicinc.com>
Subject: Re: [PATCH V1] scsi: ufs: Get boot device storage type from command
 line
Message-ID: <202207272021.6YK4F8UV-lkp@intel.com>
References: <1658910535-31802-1-git-send-email-quic_cchinnad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658910535-31802-1-git-send-email-quic_cchinnad@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chetan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jejb-scsi/for-next]
[also build test WARNING on mkp-scsi/for-next linus/master v5.19-rc8 next-20220726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chetan-C-R/scsi-ufs-Get-boot-device-storage-type-from-command-line/20220727-163016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220727/202207272021.6YK4F8UV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/42a08523b91855ba31b0974a32f02c43b163c571
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chetan-C-R/scsi-ufs-Get-boot-device-storage-type-from-command-line/20220727-163016
        git checkout 42a08523b91855ba31b0974a32f02c43b163c571
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ufs/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/ufs/host/ufs-cmdline.c:19:13: warning: no previous prototype for 'get_storage_boot_device' [-Wmissing-prototypes]
      19 | const char *get_storage_boot_device(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +/get_storage_boot_device +19 drivers/ufs/host/ufs-cmdline.c

    18	
  > 19	const char *get_storage_boot_device(void)
    20	{
    21		if (android_boot_dev_v4 && strlen(android_boot_dev_v4))
    22			return android_boot_dev_v4;
    23	
    24		else if (strlen(android_boot_dev_v3))
    25			return android_boot_dev_v3;
    26	
    27		pr_err("Not able to get Bootconfig or Kernel command line param\n");
    28		return NULL;
    29	};
    30	EXPORT_SYMBOL_GPL(get_storage_boot_device);
    31	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
