Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A184559AC30
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344152AbiHTHVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343762AbiHTHVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:21:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA7CC877C
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 00:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660980093; x=1692516093;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mT2OnrZKI+5b1XrN4GgaNeXcyUNY+BY7YaSiluFAXnk=;
  b=i5k52+pAozE+WF5BZ6bwpjPgkJnkd09AyYVMdStRuHgGRSjG19haScEE
   rLiFokO0tGz/702aE1a8/1utflsX97pnfxi2pec7G6ICCvdIOA0R19onN
   SCh3nqK/tz4WMvqY0nSoBoIJeWKCXIb+hr7QWEuOnQN6hibcy7zxIZ1Lw
   NbSfy46qxZjEHTyxx7zTbV2jY4bQA3Ejy2ksXjNz1UTci2GHL5vozI2Ji
   Cv8XFxC0S8uxC2/oxAmmz6IblUDRkGMozf5iP6/cNMpAxapxcpEtQqfAE
   3dM8q8GacQq/YQ5CdLwJn9OWJLnVwDPlzkcv0i4SU+oiGiz6qR/UpZD4y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="354885983"
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="354885983"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 00:21:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="676680674"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2022 00:21:31 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPInS-0002JP-1X;
        Sat, 20 Aug 2022 07:21:30 +0000
Date:   Sat, 20 Aug 2022 15:21:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: [jgunthorpe:iommufd 3/14] drivers/iommu/iommufd/main.c:277: warning:
 expecting prototype for iommufd_ctxet(). Prototype was for iommufd_ctx_get()
 instead
Message-ID: <202208201532.7dK1NH9N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   6624f48e554fe6a880b261074a1c9580dc9b5384
commit: a9a0de926a33cae4290bff0c0d7a0006fd1fd5a7 [3/14] iommufd: File descriptor, context, kconfig and makefiles
config: s390-randconfig-r035-20220820 (https://download.01.org/0day-ci/archive/20220820/202208201532.7dK1NH9N-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 0ac597f3cacf60479ffd36b03766fa7462dabd78)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/jgunthorpe/linux/commit/a9a0de926a33cae4290bff0c0d7a0006fd1fd5a7
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout a9a0de926a33cae4290bff0c0d7a0006fd1fd5a7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iommu/iommufd/main.c:277: warning: Function parameter or member 'ictx' not described in 'iommufd_ctx_get'
>> drivers/iommu/iommufd/main.c:277: warning: expecting prototype for iommufd_ctxet(). Prototype was for iommufd_ctx_get() instead
   drivers/iommu/iommufd/main.c:307: warning: Function parameter or member 'ictx' not described in 'iommufd_ctx_put'


vim +277 drivers/iommu/iommufd/main.c

   269	
   270	/**
   271	 * iommufd_ctxet - Get a context reference
   272	 * @ictx - Context to get
   273	 *
   274	 * The caller must already hold a valid reference to ictx.
   275	 */
   276	void iommufd_ctx_get(struct iommufd_ctx *ictx)
 > 277	{
   278		get_file(ictx->file);
   279	}
   280	EXPORT_SYMBOL_GPL(iommufd_ctx_get);
   281	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
