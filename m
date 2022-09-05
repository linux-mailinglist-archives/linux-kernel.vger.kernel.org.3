Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E67A5ACCEB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiIEHnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIEHne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:43:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A4620BE8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662363814; x=1693899814;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e5QIpZBL/iSJnueuwkOHoNIM49dRADW4fRvNXZ3+bDs=;
  b=ZEc+c5cb0Au9xZA5N359mwVzYvzS0RoUItczy+p0RpULQwcH5KSJpoDM
   XxrBsugnOGVLD8jlpbhByW5GrnGxzeTXlsuJ0sNb3mo4W1hKuWU8z6UT+
   v9b8a4GvETElpIqijfcTlVYMO1HGamV0xhFjQDwTpigPnp8rC8izM8/kb
   dW9vJML8OBObw4Kq+s00hjzHQt3WOdIkEWWoS4xuI1zaEycgqFdaGhU5l
   j4xUIOxGrJ/hZKtFY8emZP1ZI4Mx3KRFBESHhMCLqilns9l9P65Rh6eCL
   JedaD5xYb/+lmTT+dnP1RB5rEDjT2yMEhF6HgATR0MMdtyEY+LjA/QEfY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="297117891"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="297117891"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="942007653"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2022 00:43:25 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oV6lR-0003wP-0d;
        Mon, 05 Sep 2022 07:43:25 +0000
Date:   Mon, 5 Sep 2022 15:43:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [char-misc:char-misc-next 20/24] ERROR: modpost:
 "auxiliary_device_init" [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko]
 undefined!
Message-ID: <202209051534.wmaw4ovY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-next
head:   50e177c5bfd9abc3828cb57e14e6169170f6764a
commit: 393fc2f5948fd340d016a9557eea6e1ac2f6c60c [20/24] misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.
config: x86_64-randconfig-c042-20220905 (https://download.01.org/0day-ci/archive/20220905/202209051534.wmaw4ovY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=393fc2f5948fd340d016a9557eea6e1ac2f6c60c
        git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
        git fetch --no-tags char-misc char-misc-next
        git checkout 393fc2f5948fd340d016a9557eea6e1ac2f6c60c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "auxiliary_device_init" [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!
>> ERROR: modpost: "__auxiliary_device_add" [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
