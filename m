Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D75AD022
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiIEK1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiIEK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:27:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A611D0EC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662373631; x=1693909631;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V1tGW8dWAXa8/m+Bv55G1wJMFPix5qC5rEoUzXc3DKU=;
  b=R3gfMpQ7Pp4KF70KVF4hVHcQWFnKkB25LCTvkSA2MNYRNJ6xoqZBlnkD
   rWmqEM2bWix4VN1cKofHp2kjuDbpLfc1W3/4fYWIgKAmwkVsTKGd5YWq2
   iZbLnawhlymkyGaWyWFHHM33wmfk3hYvGokTH+cXOJTv3TP4wug11B7/t
   65jgZNcjvGJEXZLZA2Cj9dbRJcRYL9JHcB09F7SuoSulS2PK2okvH0s5y
   UORNny1nCY5IDcs9FmcAsdaPjcK6obsyN8KV7UbrcnyZyjLvxa6YERqUh
   DS88fl7iSADFxjjwsV87bBL1KSMTOCm3LF+76uHlH3Zt0lBIyrlXQSVOD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="295097722"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="295097722"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 03:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="702843129"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2022 03:27:10 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oV9Jt-00042Z-20;
        Mon, 05 Sep 2022 10:27:09 +0000
Date:   Mon, 5 Sep 2022 18:26:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [char-misc:char-misc-next 21/24] ERROR: modpost:
 "auxiliary_driver_unregister"
 [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
Message-ID: <202209051843.L37B3c76-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-next
head:   50e177c5bfd9abc3828cb57e14e6169170f6764a
commit: 7d3e4d807df2a216b9aa2944372f2b3f6ef3f205 [21/24] misc: microchip: pci1xxxx: load gpio driver for the gpio controller auxiliary device enumerated by the auxiliary bus driver.
config: x86_64-randconfig-c042-20220905 (https://download.01.org/0day-ci/archive/20220905/202209051843.L37B3c76-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=7d3e4d807df2a216b9aa2944372f2b3f6ef3f205
        git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
        git fetch --no-tags char-misc char-misc-next
        git checkout 7d3e4d807df2a216b9aa2944372f2b3f6ef3f205
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "auxiliary_device_init" [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!
ERROR: modpost: "__auxiliary_device_add" [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!
>> ERROR: modpost: "auxiliary_driver_unregister" [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
>> ERROR: modpost: "__auxiliary_driver_register" [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
