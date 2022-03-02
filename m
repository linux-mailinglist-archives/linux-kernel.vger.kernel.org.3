Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FEA4CAF08
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbiCBTsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbiCBTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:48:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AC013D16
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646250460; x=1677786460;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iGkRRG4zw0fmlssS1NFBroUPfmpKdTzgwRLdPsQz+R8=;
  b=fOVUGswkRTmnQp+uFBsfTc0tTwb8bkAlNA4baFFfKyacTug7wu+o0I0f
   m/E8fTI9Vv1vvldabKgXOo1SjVkVx59YB8sB7nt8o1lZPr9Pbbk5s0doD
   xHqs3mWrctIMMwqxYBf+2SkzhKb/LM56KfZPqNKMIBgbOskTi0srpNZ+t
   IFfeW4X97CR/JRGq2JAt2DFY4wSFPinpfZjLn09TbQw12vapfUPyu5SVx
   0jr+fwojXG7OSWK/RVepJptyvGSUQf6BwwH0f89y+nIX6Jt/WsEkpYluO
   79yXL653/MfL7FKFtYbllDzVjv735D2nslk6CPi6pmsTJb1eqEEJAAGJa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="339922229"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="339922229"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 11:47:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="641823251"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2022 11:47:38 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPUwf-0001qp-70; Wed, 02 Mar 2022 19:47:33 +0000
Date:   Thu, 3 Mar 2022 03:47:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-trusty-5.4
 1704/6879] drivers/scsi/ufs/ufshcd-crypto.c:250:26: warning: no previous
 prototype for 'ufshcd_blk_crypto_mode_num_for_alg_dusize'
Message-ID: <202203030305.6dFYd0qt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-trusty-5.4
head:   d556bac5a4d65c759ce3c5a7529aef568f05f650
commit: b7b3af961465d23a733bb44d4a49bb78d4d5b08f [1704/6879] BACKPORT: FROMLIST: Update Inline Encryption from v5 to v6 of patch series
config: i386-randconfig-r002-20211019 (https://download.01.org/0day-ci/archive/20220303/202203030305.6dFYd0qt-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/b7b3af961465d23a733bb44d4a49bb78d4d5b08f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-trusty-5.4
        git checkout b7b3af961465d23a733bb44d4a49bb78d4d5b08f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mmc/core/ drivers/scsi/ufs/ kernel/power/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/ufs/ufshcd-crypto.c:250:26: warning: no previous prototype for 'ufshcd_blk_crypto_mode_num_for_alg_dusize' [-Wmissing-prototypes]
     250 | enum blk_crypto_mode_num ufshcd_blk_crypto_mode_num_for_alg_dusize(
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ufshcd_blk_crypto_mode_num_for_alg_dusize +250 drivers/scsi/ufs/ufshcd-crypto.c

   249	
 > 250	enum blk_crypto_mode_num ufshcd_blk_crypto_mode_num_for_alg_dusize(
   251						enum ufs_crypto_alg ufs_crypto_alg,
   252						enum ufs_crypto_key_size key_size)
   253	{
   254		/*
   255		 * This is currently the only mode that UFS and blk-crypto both support.
   256		 */
   257		if (ufs_crypto_alg == UFS_CRYPTO_ALG_AES_XTS &&
   258			key_size == UFS_CRYPTO_KEY_SIZE_256)
   259			return BLK_ENCRYPTION_MODE_AES_256_XTS;
   260	
   261		return BLK_ENCRYPTION_MODE_INVALID;
   262	}
   263	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
