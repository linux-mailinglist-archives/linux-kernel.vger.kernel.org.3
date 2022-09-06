Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ECA5ADE86
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 06:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiIFETO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 00:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIFETM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 00:19:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF912717C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 21:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662437950; x=1693973950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k2YfQ+d0zveQEXwYZuF1QR9LokcOIGHbAE13EXsZB+E=;
  b=SyNQygu8jxrVFkRWXPKV0maxsS/0GZzbkgRr2lznlTZksblljwQOnjfI
   56iTCuxY090X8KOoS7Dl1cy7wztx3qr+0e7b7Iv46rTqvVSTcYc3vggre
   v0Oh+08A2hydXnFlTclBsNPqdn6ofdGdCFPRC+f5qaLFMfCmERxKW+4Xb
   QSKds5HQEAd1AQXCqZXjf5U40jkvd0fpDSX4y2966tmYq403uypU3AVfa
   LHI6IWSKKePzF4QGxZtLIwy44HJE9mThXvW4uYXrFMXFO2yLyilqDcXeP
   CbEBdbRXvf9noCyQ3c1kGFUWsaccvH9t2NHrxEfY5cv481m6jkpto6kNN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="295234205"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="295234205"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 21:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="591115890"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Sep 2022 21:19:08 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVQ3I-0004nd-10;
        Tue, 06 Sep 2022 04:19:08 +0000
Date:   Tue, 6 Sep 2022 12:18:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 21/41] timer-clint.c:undefined reference
 to `ipi_mux_create'
Message-ID: <202209061231.mLdi9QLh-lkp@intel.com>
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

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   98a7169ff2516ac22eecb21f2267097400d67ea9
commit: 7a7eae3dbc24b9a2169dc19a742f0e6da65fe69b [21/41] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-c023-20220905 (https://download.01.org/0day-ci/archive/20220906/202209061231.mLdi9QLh-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/7a7eae3dbc24b9a2169dc19a742f0e6da65fe69b
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout 7a7eae3dbc24b9a2169dc19a742f0e6da65fe69b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/clocksource/timer-clint.o: in function `.L47':
>> timer-clint.c:(.init.text+0x3f4): undefined reference to `ipi_mux_create'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
