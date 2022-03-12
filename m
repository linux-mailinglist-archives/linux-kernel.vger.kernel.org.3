Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826AE4D6CC5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 06:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiCLFdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 00:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCLFdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:33:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A997240E14
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 21:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647063156; x=1678599156;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JLZVY2nF6O5jppxNpiQylKsj77+n7XWRvxJ/ERlgX7k=;
  b=jQsaCcjYmGD+Hlq+IdUZ6WEceYgIn/wvqi+AH7tqGA15nc4K8l6ZzTr8
   M1DFGh8eyl2shEw9ygO1hZCt0z9iObaZLJiTNQ9EtqizftgC4jwcaeKCi
   mzaG4J72sXQDxthOw8yFxfAnL2m7KvoF1CedRqD72DjfbmU73ekOsvYNV
   dUedAIZLfhr2OtCbK8MHSPwdgnFIeLic/YmZ/iFI+0llWOz6Dth8TXese
   GqWvcZQzoLouswUt1dHftZIwf0HbO2oWqvIWbWNem2j0O5rIAZk0CV/ZM
   dUML/wUh42DJuphmBW4tXN99Z7ziX7cTyddAqpTT0qir25VzOBnMojYaZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255948310"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255948310"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 21:32:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="514790888"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2022 21:32:24 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSuMZ-0007Xm-WB; Sat, 12 Mar 2022 05:32:23 +0000
Date:   Sat, 12 Mar 2022 13:31:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Youghandhar Chintala <youghand@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [ammarfaizi2-block:netdev/net-next/master 41/59] undefined reference
 to `ieee80211_sta_restart'
Message-ID: <202203121352.1fypugZn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block netdev/net-next/master
head:   0b3660695e80d53d1bab5b458f3a897a2c427a59
commit: 7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9 [41/59] mac80211: Add support to trigger sta disconnect on hardware restart
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220312/202203121352.1fypugZn-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block netdev/net-next/master
        git checkout 7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `pch_rx_snap_read':
   (.text+0x36c): undefined reference to `ioread64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `pch_tx_snap_read':
   (.text+0x3ec): undefined reference to `ioread64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `pch_set_station_address':
   (.text+0x4e0): undefined reference to `iowrite64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `ptp_pch_settime':
   ptp_pch.o:(.text+0x680): undefined reference to `iowrite64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `ptp_pch_adjtime':
   ptp_pch.o:(.text+0x758): undefined reference to `ioread64_lo_hi'
   hppa-linux-ld: ptp_pch.o:(.text+0x77c): undefined reference to `iowrite64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `ptp_pch_gettime':
   ptp_pch.o:(.text+0xa50): undefined reference to `ioread64_lo_hi'
   hppa-linux-ld: drivers/ptp/ptp_pch.o: in function `pch_probe':
   ptp_pch.o:(.text+0xda0): undefined reference to `iowrite64_lo_hi'
   hppa-linux-ld: net/mac80211/util.o: in function `ieee80211_reconfig':
>> (.text+0x86b0): undefined reference to `ieee80211_sta_restart'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
