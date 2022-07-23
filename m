Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E560557F0F3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 20:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbiGWShs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 14:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiGWShq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 14:37:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162A818B2B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658601466; x=1690137466;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uQL5QhpeAoVHlgqTor7WE5xP814hbCKUtqsReiBGVLo=;
  b=AkVqVl/enlZp7GCpXCXDmpTsFc7rzyCD4mRsFAjgZsS2KdwfLL5A65jB
   acPgytQnnQtWK+WXhvRmsPi+9AcmawXtkO3w3igm5HoBhTr6PyFhtqMMf
   oSAadAswO5yR5eNDcuyvbbpdxBmzlDr4QjQTTuJV/ZAhpfZmx7dNgyA4T
   wpQxaszcpU8iyN1cgZLtDa6YmkUgn+MKboV7N1aZUjb/9PBY8xR4/RKxW
   VlUtUtlkLfZrFLR5+DAvhJKftC3+BlyF08CLmda/X88cpA4f89CV2X5z7
   a5cYe/ICqhnbkoa0W85ifFpSdWrjrPVbMMNPsx5IhRq6WdragV1BflrAj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="274345253"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="274345253"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 11:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="688608798"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jul 2022 11:37:44 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFK0V-0002xl-0r;
        Sat, 23 Jul 2022 18:37:43 +0000
Date:   Sun, 24 Jul 2022 02:37:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jean Delvare <jdelvare@suse.de>
Subject: drivers/regulator/mt6380-regulator.c:333:34: warning:
 'mt6380_of_match' defined but not used
Message-ID: <202207240252.ZY5hSCNB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: 31d7b359a94b8c96e54c6e3b438e6c7b65b9acb1 soc: mediatek: place Kconfig for all SoC drivers under menu
date:   4 years, 9 months ago
config: i386-buildonly-randconfig-r004-20220718 (https://download.01.org/0day-ci/archive/20220724/202207240252.ZY5hSCNB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31d7b359a94b8c96e54c6e3b438e6c7b65b9acb1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 31d7b359a94b8c96e54c6e3b438e6c7b65b9acb1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/crypto/ drivers/i2c/busses/ drivers/mailbox/ drivers/misc/eeprom/ drivers/regulator/ drivers/soc/mediatek/ drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/regulator/mt6380-regulator.c:333:34: warning: 'mt6380_of_match' defined but not used [-Wunused-const-variable=]
     333 | static const struct of_device_id mt6380_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~
--
>> drivers/soc/mediatek/mtk-pmic-wrap.c:1436:34: warning: 'of_pwrap_match_tbl' defined but not used [-Wunused-const-variable=]
    1436 | static const struct of_device_id of_pwrap_match_tbl[] = {
         |                                  ^~~~~~~~~~~~~~~~~~
>> drivers/soc/mediatek/mtk-pmic-wrap.c:1370:34: warning: 'of_slave_match_tbl' defined but not used [-Wunused-const-variable=]
    1370 | static const struct of_device_id of_slave_match_tbl[] = {
         |                                  ^~~~~~~~~~~~~~~~~~


vim +/mt6380_of_match +333 drivers/regulator/mt6380-regulator.c

a551e27368dea2 Chenglin Xu 2017-08-15  332  
a551e27368dea2 Chenglin Xu 2017-08-15 @333  static const struct of_device_id mt6380_of_match[] = {
a551e27368dea2 Chenglin Xu 2017-08-15  334  	{ .compatible = "mediatek,mt6380-regulator", },
a551e27368dea2 Chenglin Xu 2017-08-15  335  	{ /* sentinel */ },
a551e27368dea2 Chenglin Xu 2017-08-15  336  };
a551e27368dea2 Chenglin Xu 2017-08-15  337  MODULE_DEVICE_TABLE(of, mt6380_of_match);
a551e27368dea2 Chenglin Xu 2017-08-15  338  

:::::: The code at line 333 was first introduced by commit
:::::: a551e27368dea202cbef3e8861c21d965427cfe6 regulator: mt6380: Add support for MT6380

:::::: TO: Chenglin Xu <chenglin.xu@mediatek.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
