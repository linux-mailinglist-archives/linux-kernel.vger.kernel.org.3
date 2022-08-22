Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9859C59D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbiHVSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiHVSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:00:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7714620A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661191201; x=1692727201;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CPFy24F8sy/omsQamBjsDDWtFQi9GRtcPb64gkgr7Dg=;
  b=TlxDTKJV7C6Mqd3a47CnHsTly9zEKaVmQ6SqZcVl59aKZlsOvV/O6dpf
   QDuoQy3zEtBDVoC5dsOjAJbszd2GTVhbCYU3N0Muny3MO5V9Tq7G+QTf7
   NXYocQbJwdY0GQvZqvVNdnlR6xIAYDvr7sO3oRLAyfrvn9UeU+OTjCwFB
   kxsHVqS7MpAGfyrwZqx0o2XFeu+HZ2+KOSjPoDTxxloZ+miaDzxTVy7os
   sD9ek2Y9Z3hotlHyIuDvEyvX9nzwSUXy19cX/W4wWbZQVLCrovqshDLHa
   sHXnlxEQJfeCa4at/SfUHL7ipcBFdr0SXSC3ZJRa/p/1/qggKf8ola8li
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273235463"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="273235463"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 11:00:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="751379047"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Aug 2022 10:59:58 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQBiQ-0000Y5-12;
        Mon, 22 Aug 2022 17:59:58 +0000
Date:   Tue, 23 Aug 2022 01:59:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Subject: ld.lld: error: undefined symbol: drm_gem_fb_begin_cpu_access
Message-ID: <202208230156.Vo2ozAm4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c23f9e627a7b412978b4e852793c5e3c3efc555
commit: 08971eea06db3377ea1f9ff4f95a5df5f6c9aeb7 drm/mipi-dbi: Use framebuffer dma-buf helpers
date:   1 year, 1 month ago
config: x86_64-randconfig-a002-20220822 (https://download.01.org/0day-ci/archive/20220823/202208230156.Vo2ozAm4-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=08971eea06db3377ea1f9ff4f95a5df5f6c9aeb7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 08971eea06db3377ea1f9ff4f95a5df5f6c9aeb7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: drm_gem_fb_begin_cpu_access
   >>> referenced by drm_mipi_dbi.c:207 (drivers/gpu/drm/drm_mipi_dbi.c:207)
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_gem_fb_end_cpu_access
   >>> referenced by drm_mipi_dbi.c:227 (drivers/gpu/drm/drm_mipi_dbi.c:227)
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
