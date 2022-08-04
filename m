Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1AF589597
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 03:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiHDBHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 21:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiHDBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 21:07:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B81219294
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 18:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659575255; x=1691111255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yuMRliv/Xko/CIxE/5Z++R9kKH7OBEKZT7VsN3z1eFM=;
  b=CfxhOIknh3keshFxon7v8/pqd0kSemF9nY/bSkwbRL2JeShyoic3wbfP
   lKZFKo0yixto1gWwa+pYmgrbrTW9/361mVk32xyZRg+LjrtAxT7oYCoyF
   TQmTAejFbz9CWE6Ag/UK32YVI33RfRTdkarjl4+huTRUJLD82xxsUH3FZ
   COaqgowEEfnWZuJ3tdElVRdK6i9fX0YRHCK5RNnvSirR5nlAD8TTLVZQD
   zFz3vXFPSM08ZuuBPm0LgUgi1/G4AM5HEyKr5Mz/PQoY0MgXoFyY0G1ee
   zYPCtXJ3cJ4KMK+5HPgtc0eamyAVipW5LIdZb60lrXclllBokXTnvHWzy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="276729468"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="276729468"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 18:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="671069376"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2022 18:07:33 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJPKm-000HsC-1K;
        Thu, 04 Aug 2022 01:07:32 +0000
Date:   Thu, 4 Aug 2022 09:06:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 2/15] drivers/dma/apple-admac.c:260:5:
 warning: no previous prototype for function 'admac_cyclic_read_residue'
Message-ID: <202208040845.ssI1CdgG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   ddf6983d9229819248d0373854d32b4e4a0e123d
commit: 594ea25c7f3f1ee8d0e952c6547bcd06843f9045 [2/15] dmaengine: apple-admac: Add Apple ADMAC driver
config: arm64-buildonly-randconfig-r002-20220803 (https://download.01.org/0day-ci/archive/20220804/202208040845.ssI1CdgG-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 495519e5f8232d144ed26e9c18dbcbac6a5f25eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/594ea25c7f3f1ee8d0e952c6547bcd06843f9045
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 594ea25c7f3f1ee8d0e952c6547bcd06843f9045
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/apple-admac.c:260:5: warning: no previous prototype for function 'admac_cyclic_read_residue' [-Wmissing-prototypes]
   u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
       ^
   drivers/dma/apple-admac.c:260:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
   ^
   static 
   1 warning generated.


vim +/admac_cyclic_read_residue +260 drivers/dma/apple-admac.c

   256	
   257	/*
   258	 * Read from hardware the residue of a cyclic dmaengine transaction.
   259	 */
 > 260	u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
   261	{
   262		u32 ring1, ring2;
   263		u32 residue1, residue2;
   264		int nreports;
   265		size_t pos;
   266	
   267		ring1 =    admac_peek(ad, REG_REPORT_RING(channo));
   268		residue1 = admac_peek(ad, REG_RESIDUE(channo));
   269		ring2 =    admac_peek(ad, REG_REPORT_RING(channo));
   270		residue2 = admac_peek(ad, REG_RESIDUE(channo));
   271	
   272		if (residue2 > residue1) {
   273			// engine must have loaded next descriptor between the two residue reads
   274			nreports = admac_ring_noccupied_slots(ring1) + 1;
   275		} else {
   276			// no descriptor load between the two reads, ring2 is safe to use
   277			nreports = admac_ring_noccupied_slots(ring2);
   278		}
   279	
   280		pos = adtx->reclaimed_pos + adtx->period_len * (nreports + 1) \
   281							 - residue2;
   282	
   283		return adtx->buf_len - pos % adtx->buf_len;
   284	}
   285	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
