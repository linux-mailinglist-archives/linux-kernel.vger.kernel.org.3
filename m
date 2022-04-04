Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693FC4F15D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352548AbiDDN2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351560AbiDDN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:28:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D8D3CFF3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649078777; x=1680614777;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bPNDHc2IrURiPZ9S1AjKe38F+wtf6/LMN8LnjfAWkYU=;
  b=B/189FnO09SDOVeP4DqYzVtIbAThE/pgwNPGAelD9DGuIZY0K7RydBJU
   jQwF4phOnoaa/XrR0CyaakInmTVFCwCQWqPxESDcxOTY17j6dgbsiw/eD
   F1AXIxSE3xnUu08dihMfrG/qOQK8UsOnf+Yvi4PrrCh9UxOzQxHhG5mVS
   EhITA/UW4AKtoqI8xJzHSEb7U3ExeQw4GTApEqbSU4PdFHHLwBJJyOzjI
   umOxd8ugitP+W34AFeXqygPxMSWjrTRqC3UGanpKCE7smwK/2vVKrzpwT
   dq0+Hb0C0LNqDgozdjYDTxI+0eMKhrwUUmS95P9a+i1aCqWxL5HfEaooR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="240449865"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="240449865"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:26:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="504903802"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Apr 2022 06:26:15 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbMik-00025D-HJ;
        Mon, 04 Apr 2022 13:26:14 +0000
Date:   Mon, 4 Apr 2022 21:25:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [pza:reset/next 11/11] drivers/reset/core.c:1114:22: error: implicit
 declaration of function 'acpi_has_method'; did you mean 'acpi_has_watchdog'?
Message-ID: <202204042122.vBjzQg7a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.pengutronix.de/git/pza/linux reset/next
head:   7272ce0fa39b66aa91c934a27e9196082a3ffc40
commit: 7272ce0fa39b66aa91c934a27e9196082a3ffc40 [11/11] reset: ACPI reset support
config: h8300-randconfig-m031-20220404 (https://download.01.org/0day-ci/archive/20220404/202204042122.vBjzQg7a-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add pza https://git.pengutronix.de/git/pza/linux
        git fetch --no-tags pza reset/next
        git checkout 7272ce0fa39b66aa91c934a27e9196082a3ffc40
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/reset/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/reset/core.c: In function '__device_reset':
>> drivers/reset/core.c:1114:22: error: implicit declaration of function 'acpi_has_method'; did you mean 'acpi_has_watchdog'? [-Werror=implicit-function-declaration]
    1114 |                 if (!acpi_has_method(handle, "_RST"))
         |                      ^~~~~~~~~~~~~~~
         |                      acpi_has_watchdog
   cc1: some warnings being treated as errors


vim +1114 drivers/reset/core.c

  1095	
  1096	/**
  1097	 * __device_reset - find reset controller associated with the device
  1098	 *                  and perform reset
  1099	 * @dev: device to be reset by the controller
  1100	 * @optional: whether it is optional to reset the device
  1101	 *
  1102	 * Convenience wrapper for __reset_control_get() and reset_control_reset().
  1103	 * This is useful for the common case of devices with single, dedicated reset
  1104	 * lines. _RST firmware method will be called for devices with ACPI.
  1105	 */
  1106	int __device_reset(struct device *dev, bool optional)
  1107	{
  1108		struct reset_control *rstc;
  1109		int ret;
  1110	
  1111		acpi_handle handle = ACPI_HANDLE(dev);
  1112	
  1113		if (handle) {
> 1114			if (!acpi_has_method(handle, "_RST"))
  1115				return optional ? 0 : -ENOENT;
  1116			if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL,
  1117							      NULL)))
  1118				return -EIO;
  1119		}
  1120	
  1121		rstc = __reset_control_get(dev, NULL, 0, 0, optional, true);
  1122		if (IS_ERR(rstc))
  1123			return PTR_ERR(rstc);
  1124	
  1125		ret = reset_control_reset(rstc);
  1126	
  1127		reset_control_put(rstc);
  1128	
  1129		return ret;
  1130	}
  1131	EXPORT_SYMBOL_GPL(__device_reset);
  1132	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
