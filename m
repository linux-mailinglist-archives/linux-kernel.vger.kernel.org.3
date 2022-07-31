Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69F9585D19
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 05:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiGaDqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 23:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiGaDqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 23:46:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F13B1C6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 20:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659239173; x=1690775173;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=82rzporq48OWhtWa4az//AgXUoNPt/dqR4sBVxI6eBs=;
  b=nI7CgiLoHIXzYBKaK/lGkFKOy6buAJgMT8hJvfoqpHpOjIvJJE0p6fK2
   AD3OHPUBlIMOXT7G6ljqH+sPHqpTSCsRmeBEjvMpIVXGRF7c1B8UqtOIx
   7YVou94MYMLrCiNRClvjWSD2WO0FarTuTiUJ25/2HoPOFCYpjM7OYIj4p
   efjmvp/V2DwiCSN3M+PE17gYupuzix4z3Mtzc4MfC9Ggu9llEdUrtj1Fk
   X0hZyc7916TCbio7I08GYkTPud+ooLZSME2ovCoqhnMUlOZmDsAsDwSgB
   hCMVPxKLT5HcR3lXp0cmU18Uc/384VpKkaQu+ivu2Av5zrNGa556XyWME
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="289735872"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="289735872"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 20:46:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="629828845"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2022 20:46:11 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHzu7-000Ddf-1H;
        Sun, 31 Jul 2022 03:46:11 +0000
Date:   Sun, 31 Jul 2022 11:46:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/watchdog/sa1100_wdt.c:241:24: sparse: sparse: symbol
 'sa1100dog_driver' was not declared. Should it be static?
Message-ID: <202207311101.UT0Jnlfs-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a010258447d386186ca10cd374d888ac66ffe1a
commit: e86bd43bcfc579cf8935c1913e92cb76b4ba81c2 watchdog: sa1100: use platform device registration
date:   3 months ago
config: arm-randconfig-s043-20220731 (https://download.01.org/0day-ci/archive/20220731/202207311101.UT0Jnlfs-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e86bd43bcfc579cf8935c1913e92cb76b4ba81c2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e86bd43bcfc579cf8935c1913e92cb76b4ba81c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/watchdog/sa1100_wdt.c:241:24: sparse: sparse: symbol 'sa1100dog_driver' was not declared. Should it be static?

vim +/sa1100dog_driver +241 drivers/watchdog/sa1100_wdt.c

   240	
 > 241	struct platform_driver sa1100dog_driver = {
   242		.driver.name = "sa1100_wdt",
   243		.probe	  = sa1100dog_probe,
   244		.remove	  = sa1100dog_remove,
   245	};
   246	module_platform_driver(sa1100dog_driver);
   247	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
