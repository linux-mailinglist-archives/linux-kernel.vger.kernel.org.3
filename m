Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A479483808
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 21:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiACUbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 15:31:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:24352 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbiACUbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 15:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641241877; x=1672777877;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ooqjYgr+pemPCjJv2e3hsbGu5xvUqKzf072B7q5r9cs=;
  b=SAN7OEihlN+KBDn/nP5oB3XOHgQyxuQGPo8sw8xeyH6aRo2DldOSbspo
   t+5LUYAG5yRM2HhhSzDJ+CqcRz0q/hnx1fTJIXKdA34+2UApKFZnvhNWb
   7xnBOalNhaNiYriJHfMoagSMa60SVmq23xdUJJM5euy8IZwQ1h8myBx5T
   8hH2tap3sv2ONSF1o9+HSbkomzBNYhL/BcvzMM48F6vxaDCMeOgINwi/m
   HBv/FmEqKuw/Wiy0QQAWJV9/bH2EM4t7uZI76cIq1FyEOrGXthZzifs0D
   D/wGJDxWgFa2AfeGf62VokMPrMyxOcCsP4Epdt+I/BgzVC0viIGjnpM1t
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="228935388"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="228935388"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:31:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="471760755"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Jan 2022 12:31:14 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4Tz7-000EP9-Dz; Mon, 03 Jan 2022 20:31:13 +0000
Date:   Tue, 4 Jan 2022 04:30:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>
Subject: drivers/usb/cdns3/cdnsp-gadget.c:1178:6: warning: variable 'temp_64'
 set but not used
Message-ID: <202201040405.a1EVUrln-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: 3d82904559f4f5a2622db1b21de3edf2eded7664 usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver
date:   1 year ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220104/202201040405.a1EVUrln-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 104a827ea6de0cbe0f5faef4407552ede31d165c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d82904559f4f5a2622db1b21de3edf2eded7664
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3d82904559f4f5a2622db1b21de3edf2eded7664
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/ drivers/net/ethernet/intel/ice/ drivers/usb/cdns3/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/cdns3/cdnsp-gadget.c:1178:6: warning: variable 'temp_64' set but not used [-Wunused-but-set-variable]
           u64 temp_64;
               ^
   1 warning generated.


vim +/temp_64 +1178 drivers/usb/cdns3/cdnsp-gadget.c

  1173	
  1174	static int cdnsp_run(struct cdnsp_device *pdev,
  1175			     enum usb_device_speed speed)
  1176	{
  1177		u32 fs_speed = 0;
> 1178		u64 temp_64;
  1179		u32 temp;
  1180		int ret;
  1181	
  1182		temp_64 = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
  1183		temp_64 &= ~ERST_PTR_MASK;
  1184		temp = readl(&pdev->ir_set->irq_control);
  1185		temp &= ~IMOD_INTERVAL_MASK;
  1186		temp |= ((IMOD_DEFAULT_INTERVAL / 250) & IMOD_INTERVAL_MASK);
  1187		writel(temp, &pdev->ir_set->irq_control);
  1188	
  1189		temp = readl(&pdev->port3x_regs->mode_addr);
  1190	
  1191		switch (speed) {
  1192		case USB_SPEED_SUPER_PLUS:
  1193			temp |= CFG_3XPORT_SSP_SUPPORT;
  1194			break;
  1195		case USB_SPEED_SUPER:
  1196			temp &= ~CFG_3XPORT_SSP_SUPPORT;
  1197			break;
  1198		case USB_SPEED_HIGH:
  1199			break;
  1200		case USB_SPEED_FULL:
  1201			fs_speed = PORT_REG6_FORCE_FS;
  1202			break;
  1203		default:
  1204			dev_err(pdev->dev, "invalid maximum_speed parameter %d\n",
  1205				speed);
  1206			fallthrough;
  1207		case USB_SPEED_UNKNOWN:
  1208			/* Default to superspeed. */
  1209			speed = USB_SPEED_SUPER;
  1210			break;
  1211		}
  1212	
  1213		if (speed >= USB_SPEED_SUPER) {
  1214			writel(temp, &pdev->port3x_regs->mode_addr);
  1215			cdnsp_set_link_state(pdev, &pdev->usb3_port.regs->portsc,
  1216					     XDEV_RXDETECT);
  1217		} else {
  1218			cdnsp_disable_port(pdev, &pdev->usb3_port.regs->portsc);
  1219		}
  1220	
  1221		cdnsp_set_link_state(pdev, &pdev->usb2_port.regs->portsc,
  1222				     XDEV_RXDETECT);
  1223	
  1224		cdnsp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
  1225	
  1226		writel(PORT_REG6_L1_L0_HW_EN | fs_speed, &pdev->port20_regs->port_reg6);
  1227	
  1228		ret = cdnsp_start(pdev);
  1229		if (ret) {
  1230			ret = -ENODEV;
  1231			goto err;
  1232		}
  1233	
  1234		temp = readl(&pdev->op_regs->command);
  1235		temp |= (CMD_INTE);
  1236		writel(temp, &pdev->op_regs->command);
  1237	
  1238		temp = readl(&pdev->ir_set->irq_pending);
  1239		writel(IMAN_IE_SET(temp), &pdev->ir_set->irq_pending);
  1240	
  1241		return 0;
  1242	err:
  1243		cdnsp_halt(pdev);
  1244		return ret;
  1245	}
  1246	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
