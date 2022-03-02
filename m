Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34944CB14D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245296AbiCBV3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245117AbiCBV3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:29:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA1C0857
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646256525; x=1677792525;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YX5dSX3n1Z8/v/QD4ve1uES21cKG+mkqJ0RqYPqesf0=;
  b=DCVp3xTgFJY28XRPuG32pm9l0yWj+huoMXncSJVx3H/9clV9XKk/BhTd
   PGglwPM/d6UlMxW1yYNw7JlyJyVQD1HlPfgCHlMrAnZJekOtgly4vpYaf
   cjOpZPYvTkACuWqQgKIxDO6/aLRcUD5V3BejZ5+tqinA7pqOscR9k++xA
   Eo2Xn4CmRi3lo7OHBsl5V1YDL1ZcjUdDNiDL/pHTJcPhLf8H673VlKUn6
   BLyFLnrjH73wsC+ucJPsZ29aoYjdocabi7kQ1gj8HBEoTBVBmDpJWOIFX
   InM3nyvSPVKkP1zGA9lkYTpZjNoo8yRqCP/MJwDtVEV9hWtCLyEB3/uQN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253238305"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253238305"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 13:28:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="493693034"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Mar 2022 13:28:44 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPWWZ-0001wG-C3; Wed, 02 Mar 2022 21:28:43 +0000
Date:   Thu, 3 Mar 2022 05:28:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-stable
 2233/9999] drivers/scsi/ufs/ufshcd-crypto.c:250:26: warning: no previous
 declaration for 'ufshcd_blk_crypto_mode_num_for_alg_dusize'
Message-ID: <202203030553.577m0VYs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-stable
head:   4ab5bac1598e3ed91a6267f6cada336467312112
commit: e12563c18d484e6379d03105b4565db7bb3a7975 [2233/9999] BACKPORT: FROMLIST: Update Inline Encryption from v5 to v6 of patch series
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220303/202203030553.577m0VYs-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/e12563c18d484e6379d03105b4565db7bb3a7975
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-stable
        git checkout e12563c18d484e6379d03105b4565db7bb3a7975
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mmc/core/ drivers/scsi/ufs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/ufs/ufshcd-crypto.c:250:26: warning: no previous declaration for 'ufshcd_blk_crypto_mode_num_for_alg_dusize' [-Wmissing-declarations]
    enum blk_crypto_mode_num ufshcd_blk_crypto_mode_num_for_alg_dusize(
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
