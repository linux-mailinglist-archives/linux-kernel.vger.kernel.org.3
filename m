Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9063F5ABD67
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiICGM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiICGM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:12:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEBB47BB1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662185576; x=1693721576;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TG63baOUdev2I2vWz0kT9zWvmxQSZng287puZsm3Trg=;
  b=KQWZbVLM2Q4slCaUxDkg0QXsLeJIoYMDy9HWtdW62COIQm6s9sXRcaFd
   eGG5CcMtjezh3yoOmYrAhwkhUPxKcj8tYDMO4jOpdO51r/DZuBhZJQPcB
   apkbP5gLF5PnCphAPLwVzqhP4g/EpUCLSnBSVLGRw/oA3Yfh7eHvw2pN4
   Ds4/vWc8X9pRsIWCjDvkSKdoyUA6LcuoL6sgxY8hYF4yjA+on3k4G/oAD
   4UnhtQLqr7ryWDBveE+7xkcZnxnrdc7uFasgNO++zScgL52IAVhN1XJ6k
   e3kYP8x77yhOziccqZFiIND91yz5a8TWWYSw++0++tZCV8VOC/4yLAOle
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="357849420"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="357849420"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 23:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="646351994"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2022 23:12:53 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUMOi-00019n-2f;
        Sat, 03 Sep 2022 06:12:52 +0000
Date:   Sat, 3 Sep 2022 14:12:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [char-misc:char-misc-testing 20/24] kismet: WARNING: unmet direct
 dependencies detected for GPIOLIB_IRQCHIP when selected by GP_PCI1XXXX
Message-ID: <202209031414.Y8YCEjmI-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-testing
head:   4ec7ac90ff399b7d9af81cc8afd430a22786c61b
commit: 393fc2f5948fd340d016a9557eea6e1ac2f6c60c [20/24] misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.
config: x86_64-kismet-CONFIG_GPIOLIB_IRQCHIP-CONFIG_GP_PCI1XXXX-0-0 (https://download.01.org/0day-ci/archive/20220903/202209031414.Y8YCEjmI-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=393fc2f5948fd340d016a9557eea6e1ac2f6c60c
        git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
        git fetch --no-tags char-misc char-misc-testing
        git checkout 393fc2f5948fd340d016a9557eea6e1ac2f6c60c
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_GPIOLIB_IRQCHIP --selectors CONFIG_GP_PCI1XXXX -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for GPIOLIB_IRQCHIP when selected by GP_PCI1XXXX
   
   WARNING: unmet direct dependencies detected for GPIOLIB_IRQCHIP
     Depends on [n]: GPIOLIB [=n]
     Selected by [y]:
     - GP_PCI1XXXX [=y] && PCI [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
