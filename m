Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B40582653
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiG0MYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiG0MYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:24:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C645F5B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658924662; x=1690460662;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BTfWJ5YkCqWlVDNOuJcNi+zyYR54OTfBH59W530eXqk=;
  b=XO0t1mGphoswxfwrkxWznq91FsoNF2dKT0AVDbpYTD2qfKLvnIkQTa4I
   0KgKW4AwIcKIcJuFMQSyclc09Jk2BrhQx6xMrxxJfiGfi5f/i9U4kA02D
   +RVDUdDTd+QLIRUdvaHP2NKKTLgaNtRCbZyVgqKse3U/m4reKHWn6AUW4
   ONhY3MEtZllgr0NiWIil7F8t7a+MhKlvx44exFq1dg/FnJ887GPLffDQ0
   B2WL6oAVZIc54AAbxw4tUozCX2vgioaDSSyUFmAq85E8QuNnnueXPr3e+
   F2INWdSnHnX6vZGEU6Cs/fo8v2x0ASPVVXMbTluu1NA9eLDVDS86fkpsF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="286974472"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="286974472"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 05:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="776684694"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2022 05:24:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGg5M-0008hl-0g;
        Wed, 27 Jul 2022 12:24:20 +0000
Date:   Wed, 27 Jul 2022 20:23:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dongjin Kim <tobetter@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tobetter:odroid-5.19.y 78/99]
 drivers/gpu/drm/tiny/ili9488_pio.c:335:36: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202207272019.ttAMYBVJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjin,

First bad commit (maybe != root cause):

tree:   https://github.com/tobetter/linux odroid-5.19.y
head:   c7c464300e75e7dc0e654a0550f885685d92a092
commit: c2ea0f2f2bc571f7a2a63b1acc3d84b9b23621bb [78/99] ODROID-COMMON: Revert "drm/dbi: Print errors for mipi_dbi_command()"
config: sparc64-randconfig-s051-20220727 (https://download.01.org/0day-ci/archive/20220727/202207272019.ttAMYBVJ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/tobetter/linux/commit/c2ea0f2f2bc571f7a2a63b1acc3d84b9b23621bb
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.19.y
        git checkout c2ea0f2f2bc571f7a2a63b1acc3d84b9b23621bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/gpu/drm/tiny/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/tiny/ili9488_pio.c:335:36: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/tiny/ili9488_pio.c:336:47: sparse: sparse: Using plain integer as NULL pointer

vim +335 drivers/gpu/drm/tiny/ili9488_pio.c

74edc5034eba24 Dongjin Kim 2021-02-09  333  
74edc5034eba24 Dongjin Kim 2021-02-09  334  static const struct of_device_id ili9488_dt_ids[] = {
74edc5034eba24 Dongjin Kim 2021-02-09 @335  	{ .compatible = "ili9488", 0 },
74edc5034eba24 Dongjin Kim 2021-02-09  336  	{ .compatible = "hardkernel,ili9488", 0 },
74edc5034eba24 Dongjin Kim 2021-02-09  337  	{ },
74edc5034eba24 Dongjin Kim 2021-02-09  338  };
74edc5034eba24 Dongjin Kim 2021-02-09  339  

:::::: The code at line 335 was first introduced by commit
:::::: 74edc5034eba2493a877af69795d09e191ae3b4e ODROID-COMMON: gpu/drm: Add new Tiny DRM driver with Ili9488

:::::: TO: Dongjin Kim <tobetter@gmail.com>
:::::: CC: Dongjin Kim <tobetter@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
