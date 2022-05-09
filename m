Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D45206C1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiEIVmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiEIVmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:42:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC2712DECB
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652132292; x=1683668292;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=asGdHUm9jav4NxkbdfLspD5nMQUiEtol9ex7uscKJs4=;
  b=JyHRytQLsIvNUrL5uvET29zIiVPx8GXRSH8o02bIJ7vwqL2IZtclPG5s
   qrV7gW1wrqHYX0kK8Sqz1jKegx7oJNARD6SHkTd/oflwbDChBUvQWFCrn
   BCb4WDmznq+ZD2lMVq/RXl7Qo5LF0OzSyHQzvMDvu+Z4HRIXagZrhZrkF
   X+BRUp7SZkci2aGvv4ndLNg7HnL/PzcR8hKsWcRjVNYaki85b+21FGH+q
   tftTLLW15OMbpdxHKuBKIciB7N9vemzrK9uz5u9M3n/yOtFHlyIEFqY8Y
   coHwE+i7rx/xq4keeewZ8ncDsft/VOAn2KaCN2FXCJey1hDxQoj00otj3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="332211301"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="332211301"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 14:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="570359796"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 May 2022 14:37:59 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noB4o-000Gvy-CP;
        Mon, 09 May 2022 21:37:58 +0000
Date:   Tue, 10 May 2022 05:37:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vitor Soares <vitor.soares@synopsys.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: drivers/i3c/master/dw-i3c-master.c:1198:34: warning:
 'dw_i3c_master_of_match' defined but not used
Message-ID: <202205100503.4rgeEuvV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
commit: 1dd728f5d4d4b8b53196c1e0fcf86bbaaee39cef i3c: master: Add driver for Synopsys DesignWare IP
date:   3 years, 5 months ago
config: i386-randconfig-r026-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100503.4rgeEuvV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1dd728f5d4d4b8b53196c1e0fcf86bbaaee39cef
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1dd728f5d4d4b8b53196c1e0fcf86bbaaee39cef
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/crypto/ drivers/i3c/master/ drivers/rtc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/i3c/master/dw-i3c-master.c: In function 'dw_i3c_master_priv_xfers':
   drivers/i3c/master/dw-i3c-master.c:837:38: warning: comparison is always false due to limited range of data type [-Wtype-limits]
     837 |                 if (i3c_xfers[i].len > COMMAND_PORT_ARG_DATA_LEN_MAX)
         |                                      ^
   drivers/i3c/master/dw-i3c-master.c: In function 'dw_i3c_master_i2c_xfers':
   drivers/i3c/master/dw-i3c-master.c:973:38: warning: comparison is always false due to limited range of data type [-Wtype-limits]
     973 |                 if (i2c_xfers[i].len > COMMAND_PORT_ARG_DATA_LEN_MAX)
         |                                      ^
   drivers/i3c/master/dw-i3c-master.c: In function 'dw_i3c_master_bus_init':
   drivers/i3c/master/dw-i3c-master.c:597:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
     597 |                 if (ret)
         |                    ^
   drivers/i3c/master/dw-i3c-master.c:599:9: note: here
     599 |         case I3C_BUS_MODE_PURE:
         |         ^~~~
   At top level:
>> drivers/i3c/master/dw-i3c-master.c:1198:34: warning: 'dw_i3c_master_of_match' defined but not used [-Wunused-const-variable=]
    1198 | static const struct of_device_id dw_i3c_master_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~


vim +/dw_i3c_master_of_match +1198 drivers/i3c/master/dw-i3c-master.c

  1197	
> 1198	static const struct of_device_id dw_i3c_master_of_match[] = {
  1199		{ .compatible = "snps,dw-i3c-master-1.00a", },
  1200		{},
  1201	};
  1202	MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
  1203	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
