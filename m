Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AE75A0034
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbiHXRSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbiHXRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:17:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF67C1BF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661361471; x=1692897471;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z1/O7amcxbtN985zP7+aET+15/X1umd9NB3glHzKYzc=;
  b=DUBgrFnENRJ/9eiGR3goJktbRbDtptkUmaXllEHdqeH60pUb8dp6Tkaw
   AFdeTYj0MJeRn1P+O6gR30Z9btE8eW9+1utrDNvUCBOseFrYwNM68N888
   q3Za+7Uy3IBG1pv0xJXXWIXaZ9ubbmP0hPrC8UtNHSzdxaedtotftFyQh
   ItPPwoybk42J+D6aYJ3Up+xxXgivycFHbtwYVtvRKAR9huRSto7y6sy4W
   cTlihmptlhSKxf2o0U2jl43WIkTrYg1VRYr9+BAzBIFXY1OVBv1aDWVmT
   7vq3kK6QCO1wEZZxdX017ztphyIcn5P1XPk2wV6Hwxbj5mHZ6+EfpPD2O
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="355750989"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="355750989"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 10:17:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="586516159"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2022 10:17:26 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQu0L-0000t9-1U;
        Wed, 24 Aug 2022 17:17:25 +0000
Date:   Thu, 25 Aug 2022 01:16:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:vfio_iommufd 28/29] drivers/vfio/vfio_main.c:618:6:
 warning: no previous prototype for 'vfio_assert_device_open'
Message-ID: <202208250108.KV0cgfXO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux vfio_iommufd
head:   d2ab4343c9f524e9404059830828188b0f8a15b6
commit: 5016830b7f1d1bf8af24d4ee80fc07a68d835af4 [28/29] vfio: Make vfio_container optionally compiled
config: sparc64-randconfig-r014-20220824 (https://download.01.org/0day-ci/archive/20220825/202208250108.KV0cgfXO-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/5016830b7f1d1bf8af24d4ee80fc07a68d835af4
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe vfio_iommufd
        git checkout 5016830b7f1d1bf8af24d4ee80fc07a68d835af4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/vfio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vfio/vfio_main.c:618:6: warning: no previous prototype for 'vfio_assert_device_open' [-Wmissing-prototypes]
     618 | bool vfio_assert_device_open(struct vfio_device *device)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/vfio_assert_device_open +618 drivers/vfio/vfio_main.c

cba3345cc494ad drivers/vfio/vfio.c      Alex Williamson 2012-07-31  616  
eadd86f835c637 drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-11  617  /* true if the vfio_device has open_device() called but not close_device() */
79d394f0b0cd09 drivers/vfio/vfio_main.c Jason Gunthorpe 2022-02-18 @618  bool vfio_assert_device_open(struct vfio_device *device)
eadd86f835c637 drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-11  619  {
eadd86f835c637 drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-11  620  	return !WARN_ON_ONCE(!READ_ONCE(device->open_count));
eadd86f835c637 drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-11  621  }
eadd86f835c637 drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-11  622  

:::::: The code at line 618 was first introduced by commit
:::::: 79d394f0b0cd096e2eadbcc0e84b9035efa529c8 vfio: Move container code into vfio_container.c

:::::: TO: Jason Gunthorpe <jgg@nvidia.com>
:::::: CC: Jason Gunthorpe <jgg@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
