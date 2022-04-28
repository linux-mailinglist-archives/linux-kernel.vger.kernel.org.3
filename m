Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92360512940
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbiD1CEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiD1CEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:04:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D273A3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651111286; x=1682647286;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QvT8Ww2WqzBEAfsAspjkapxxd0bfenkW3RyH+pVjgqA=;
  b=ZtUJv5PHhsyXN33DsHIecwdeMAAUWhvgs/JjRZOU/ezWcjAJLmgvkjMM
   rslFyxqeHP+0Q7WADCYrVyPBlT4jdxpwnRSpIkBA38onZ/QSmKfk4J33+
   pEamg8tHObCiaRlOv5lvQebn2GpSlpbvbNVUDExrmp8iCitj8Xv8eRjs+
   x4N/jtO1ryT89N7VjzAaAQALal8z7vkSTyTtimKaS7rQcKxssMLic6182
   l3DbZITe8yRQjHNqGzn5LMud5Y0VnbjG9ZJi/KxGAzpToo9tJxuqwKAln
   ftjUg2hfCWdlJEl2W5bVv/JMZwANLEX77jdQGR2HneR14HWqxCJJiIesO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="263717247"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="263717247"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 19:01:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="617872832"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2022 19:01:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njtT9-0004yh-Vu;
        Thu, 28 Apr 2022 02:01:23 +0000
Date:   Thu, 28 Apr 2022 10:00:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:pr/22 176/189]
 drivers/net/ethernet/pensando/ionic/ionic_main.c:526:9: warning: 'strncpy'
 output truncated before terminating nul copying 31 bytes from a string of
 the same length
Message-ID: <202204280625.HZ8oGH5C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux pr/22
head:   7ee315306d1a3b0da8cf2a53e7f55889d0e7f034
commit: d071f4837f5b876643c26a6db8f118d1f80de1de [176/189] Makefile: Add -asahi EXTRAVERSION
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220428/202204280625.HZ8oGH5C-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/d071f4837f5b876643c26a6db8f118d1f80de1de
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux pr/22
        git checkout d071f4837f5b876643c26a6db8f118d1f80de1de
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/ethernet/pensando/ionic/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/pensando/ionic/ionic_main.c: In function 'ionic_identify':
>> drivers/net/ethernet/pensando/ionic/ionic_main.c:526:9: warning: 'strncpy' output truncated before terminating nul copying 31 bytes from a string of the same length [-Wstringop-truncation]
     526 |         strncpy(ident->drv.driver_ver_str, UTS_RELEASE,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     527 |                 sizeof(ident->drv.driver_ver_str) - 1);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +526 drivers/net/ethernet/pensando/ionic/ionic_main.c

fbfb8031533c92 Shannon Nelson 2019-09-03  515  
fbfb8031533c92 Shannon Nelson 2019-09-03  516  int ionic_identify(struct ionic *ionic)
fbfb8031533c92 Shannon Nelson 2019-09-03  517  {
fbfb8031533c92 Shannon Nelson 2019-09-03  518  	struct ionic_identity *ident = &ionic->ident;
fbfb8031533c92 Shannon Nelson 2019-09-03  519  	struct ionic_dev *idev = &ionic->idev;
fbfb8031533c92 Shannon Nelson 2019-09-03  520  	size_t sz;
fbfb8031533c92 Shannon Nelson 2019-09-03  521  	int err;
fbfb8031533c92 Shannon Nelson 2019-09-03  522  
fbfb8031533c92 Shannon Nelson 2019-09-03  523  	memset(ident, 0, sizeof(*ident));
fbfb8031533c92 Shannon Nelson 2019-09-03  524  
fbfb8031533c92 Shannon Nelson 2019-09-03  525  	ident->drv.os_type = cpu_to_le32(IONIC_OS_TYPE_LINUX);
1fcbebf115d9ce Shannon Nelson 2020-03-06 @526  	strncpy(ident->drv.driver_ver_str, UTS_RELEASE,
fbfb8031533c92 Shannon Nelson 2019-09-03  527  		sizeof(ident->drv.driver_ver_str) - 1);
fbfb8031533c92 Shannon Nelson 2019-09-03  528  
fbfb8031533c92 Shannon Nelson 2019-09-03  529  	mutex_lock(&ionic->dev_cmd_lock);
fbfb8031533c92 Shannon Nelson 2019-09-03  530  
fbfb8031533c92 Shannon Nelson 2019-09-03  531  	sz = min(sizeof(ident->drv), sizeof(idev->dev_cmd_regs->data));
fbfb8031533c92 Shannon Nelson 2019-09-03  532  	memcpy_toio(&idev->dev_cmd_regs->data, &ident->drv, sz);
fbfb8031533c92 Shannon Nelson 2019-09-03  533  
fbfb8031533c92 Shannon Nelson 2019-09-03  534  	ionic_dev_cmd_identify(idev, IONIC_IDENTITY_VERSION_1);
fbfb8031533c92 Shannon Nelson 2019-09-03  535  	err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
fbfb8031533c92 Shannon Nelson 2019-09-03  536  	if (!err) {
fbfb8031533c92 Shannon Nelson 2019-09-03  537  		sz = min(sizeof(ident->dev), sizeof(idev->dev_cmd_regs->data));
fbfb8031533c92 Shannon Nelson 2019-09-03  538  		memcpy_fromio(&ident->dev, &idev->dev_cmd_regs->data, sz);
fbfb8031533c92 Shannon Nelson 2019-09-03  539  	}
fbfb8031533c92 Shannon Nelson 2019-09-03  540  	mutex_unlock(&ionic->dev_cmd_lock);
fbfb8031533c92 Shannon Nelson 2019-09-03  541  
a21b5d49e77a2e Shannon Nelson 2020-10-01  542  	if (err) {
36b20b7fb1c3cb Shannon Nelson 2021-10-01  543  		dev_err(ionic->dev, "Cannot identify ionic: %d\n", err);
a21b5d49e77a2e Shannon Nelson 2020-10-01  544  		goto err_out;
a21b5d49e77a2e Shannon Nelson 2020-10-01  545  	}
fbfb8031533c92 Shannon Nelson 2019-09-03  546  
36b20b7fb1c3cb Shannon Nelson 2021-10-01  547  	if (isprint(idev->dev_info.fw_version[0]) &&
36b20b7fb1c3cb Shannon Nelson 2021-10-01  548  	    isascii(idev->dev_info.fw_version[0]))
36b20b7fb1c3cb Shannon Nelson 2021-10-01  549  		dev_info(ionic->dev, "FW: %.*s\n",
36b20b7fb1c3cb Shannon Nelson 2021-10-01  550  			 (int)(sizeof(idev->dev_info.fw_version) - 1),
36b20b7fb1c3cb Shannon Nelson 2021-10-01  551  			 idev->dev_info.fw_version);
36b20b7fb1c3cb Shannon Nelson 2021-10-01  552  	else
36b20b7fb1c3cb Shannon Nelson 2021-10-01  553  		dev_info(ionic->dev, "FW: (invalid string) 0x%02x 0x%02x 0x%02x 0x%02x ...\n",
36b20b7fb1c3cb Shannon Nelson 2021-10-01  554  			 (u8)idev->dev_info.fw_version[0],
36b20b7fb1c3cb Shannon Nelson 2021-10-01  555  			 (u8)idev->dev_info.fw_version[1],
36b20b7fb1c3cb Shannon Nelson 2021-10-01  556  			 (u8)idev->dev_info.fw_version[2],
36b20b7fb1c3cb Shannon Nelson 2021-10-01  557  			 (u8)idev->dev_info.fw_version[3]);
36b20b7fb1c3cb Shannon Nelson 2021-10-01  558  
a21b5d49e77a2e Shannon Nelson 2020-10-01  559  	err = ionic_lif_identify(ionic, IONIC_LIF_TYPE_CLASSIC,
a21b5d49e77a2e Shannon Nelson 2020-10-01  560  				 &ionic->ident.lif);
a21b5d49e77a2e Shannon Nelson 2020-10-01  561  	if (err) {
a21b5d49e77a2e Shannon Nelson 2020-10-01  562  		dev_err(ionic->dev, "Cannot identify LIFs: %d\n", err);
a21b5d49e77a2e Shannon Nelson 2020-10-01  563  		goto err_out;
a21b5d49e77a2e Shannon Nelson 2020-10-01  564  	}
fbfb8031533c92 Shannon Nelson 2019-09-03  565  
fbfb8031533c92 Shannon Nelson 2019-09-03  566  	return 0;
fbfb8031533c92 Shannon Nelson 2019-09-03  567  
a21b5d49e77a2e Shannon Nelson 2020-10-01  568  err_out:
fbfb8031533c92 Shannon Nelson 2019-09-03  569  	return err;
fbfb8031533c92 Shannon Nelson 2019-09-03  570  }
fbfb8031533c92 Shannon Nelson 2019-09-03  571  

:::::: The code at line 526 was first introduced by commit
:::::: 1fcbebf115d9ce077c2ba5ecfb521cc1eedcb467 ionic: drop ethtool driver version

:::::: TO: Shannon Nelson <snelson@pensando.io>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
