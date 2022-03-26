Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA194E8054
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiCZKPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiCZKOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:14:49 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10440D5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648289593; x=1679825593;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KDZPnrzf99teYk8PBL93ASXPkFz5c8amVMcfciGlSPQ=;
  b=DuLZFFu/DCxiVwJKXdn7ZnORG8io46TZdlT0DmkPvWu0iexAytoTMwA/
   t83Sj066P6vP0/q4yngn3kTTnfArC1it/KTBCviQsbZaBQRdV4Ovpg/dj
   QzH1k8IgGuswJAjpE44V0iopfYgklh3Ehya0hGX1pHgK03osQkE8Q6mlz
   nxroZTpW8SKT/VIFBcbtKCXSuy31amgLepbdX+Jk8PSxKfWVxGYO21o2a
   mvMCAt4BPSshiZbU5AaDsJYpvQGaEFtcsJHR2UBF9RF3QVsv8n7Ur3CkI
   9GCFg15pYIj7KuayeqAiCTE2bYrRLU5iOkG3VnyhtZmhBVpvdrwv0F9Md
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="319476573"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="319476573"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 03:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="502031803"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Mar 2022 03:13:11 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY3Py-000NGz-Lu; Sat, 26 Mar 2022 10:13:10 +0000
Date:   Sat, 26 Mar 2022 18:12:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [andersson:wip/sc8180x-next-20220301 6/27] undefined reference to
 `typec_switch_get_drvdata'
Message-ID: <202203261815.l1iy2Lb5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220301
head:   0289eb1e5447f549241a40b2a0742a796467ecd8
commit: 2b468636da740585f10846641a44f7f8c1ce89c3 [6/27] phy: qcom-qmp: Register as a typec switch for orientation detection
config: microblaze-buildonly-randconfig-r003-20220325 (https://download.01.org/0day-ci/archive/20220326/202203261815.l1iy2Lb5-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/2b468636da740585f10846641a44f7f8c1ce89c3
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220301
        git checkout 2b468636da740585f10846641a44f7f8c1ce89c3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `qcom_qmp_phy_typec_switch_set':
>> (.text+0x414): undefined reference to `typec_switch_get_drvdata'
   microblaze-linux-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `qcom_qmp_phy_probe':
>> (.text+0x1170): undefined reference to `typec_switch_register'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
