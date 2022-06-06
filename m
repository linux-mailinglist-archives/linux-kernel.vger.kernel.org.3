Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75A553E26C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiFFGJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiFFGJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:09:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352B5140F1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 23:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654495750; x=1686031750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xIVdycnCP3O5522nSyL8XFF/gIjyhnKfHb6iFznAe+I=;
  b=CR5UgGx3LNe8YcVyZFhbb42LOtQWkVAOLzGouOObVjkBCkFOC3jPUTxe
   RkEh1uV4YaP2HP89gAiuHkwMUARIy/bChI44ETHPmVMRMuUlyFUjKRLSF
   wFVxuP8TW8gv5b0vA8a9Hj6o4pPqJmq6I/NdYNJqska/xuoFV/GREFG2d
   YfwpmJFRzFOlfPlAoR394yCC2uui2ATpaenfCpKI3XEBaYumRdoV7MRVg
   lAzd7IZEKljsFj/kdonaVKPNoe49giRvDB/cqcKFzhFIl+eBPhGGA2E9B
   CaHdGQRMXUH+aQq6Td3bI4qDDGa2mtmT7FR8yKaFj5Jbojcw3a7ZeNjqB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="256465436"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="256465436"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 23:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="647346201"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2022 23:09:08 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny5vI-000CXl-40;
        Mon, 06 Jun 2022 06:09:08 +0000
Date:   Mon, 6 Jun 2022 14:08:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 36/63] powerpc64-linux-gcc: error: unrecognized
 command-line option '-msse'
Message-ID: <202206061319.9h4BFbCh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   0401cdad37f8a62e64363b2a6fc16c7fafba66e2
commit: 9b0e0d433f743790e4afde2b81fc30d8f8beb7d7 [36/63] drm/amd/display: Add dependant changes for DCN32/321
config: powerpc64-buildonly-randconfig-r002-20220605 (https://download.01.org/0day-ci/archive/20220606/202206061319.9h4BFbCh-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 9b0e0d433f743790e4afde2b81fc30d8f8beb7d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> powerpc64-linux-gcc: error: unrecognized command-line option '-msse'
>> powerpc64-linux-gcc: error: unrecognized command-line option '-msse2'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
