Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B39A591AAB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbiHMNiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiHMNiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:38:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4949DB7D2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660397901; x=1691933901;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KiBWmdwpCRItEUdENhqfv8yltxc1wlV3phZO95W28rg=;
  b=cvOjyoemnTYMwv/qBLVF6M8C5OC3DQTtImUtEVjBZpJhhMxj3tZW+Hs5
   Ovv30aS5S0NQc32UsQbZ4xVfZ8sSQGTJjVgAqXrMm2wQAsIIUFLcARrfR
   ZNR/Xp7A1gsFlJYkTjzDTQtdaoPvAlRsaDoyNpeYAbAfg2zZHItLfg3tV
   gX+OEuoOYIo32ibUO2GtOf6lx8Vtub+X9/tOvdeXTLC1VgEDO9gbqTPCx
   /888iy8YaQQw3b05CJJ0VUgITVWebujxEQsXBjx9tMJYFMoKSeLx9iLAM
   tnmGHZH9FurLKpEfVcpBiW1HlNSpvcVpWIxeAufF/kH5tTvcdyhfF+DsI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292548618"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="292548618"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 06:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="582390113"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Aug 2022 06:38:19 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMrLG-0001iY-30;
        Sat, 13 Aug 2022 13:38:18 +0000
Date:   Sat, 13 Aug 2022 21:37:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/light/cm32181.c:508:1: sparse: sparse: symbol
 'cm32181_pm_ops' was not declared. Should it be static?
Message-ID: <202208132158.Lo65077F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69dac8e431af26173ca0a1ebc87054e01c585bcc
commit: 68c1b3dd5c48b2323067f8c1f0649ae2f31ab20b iio: light: cm32181: Add PM support
date:   5 weeks ago
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220813/202208132158.Lo65077F-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68c1b3dd5c48b2323067f8c1f0649ae2f31ab20b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 68c1b3dd5c48b2323067f8c1f0649ae2f31ab20b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iio/light/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/light/cm32181.c:508:1: sparse: sparse: symbol 'cm32181_pm_ops' was not declared. Should it be static?

vim +/cm32181_pm_ops +508 drivers/iio/light/cm32181.c

   507	
 > 508	DEFINE_SIMPLE_DEV_PM_OPS(cm32181_pm_ops, cm32181_suspend, cm32181_resume);
   509	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
