Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7732A49DF56
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbiA0K0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:26:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:38933 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239411AbiA0KZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643279155; x=1674815155;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GGZkyX9fQUg3V3xZXKJeXhQG6xQszvu7c09h+vLRJio=;
  b=JBtqH/i5puhqvolfwCV9GiYyYPEQTNAyoLhZLyWvCGZtSXthg2sdvB3h
   v+Z769My9FY2PNZCUdnxJwHY5Q/Sjk4ytqXanUXAaydSst2XAU+FpVhFV
   t/uWKKx6weXUtnyLPr4zqXPsyePFXBF0eo1ysXolkGKiMQPiKnw80Wdhw
   faecw03xvZAgMS5WeuyE1NeT+quvP/gcP/D/WCy/MlWaSW9+yFU2n9bz0
   ofTb6fwb44mNKHqxNsruzIoXm0sm+jmpTVsGzR9dF9af18n0y+vGUcuwD
   i3g9JPMudNM53Y/46NvMQivZDxp1Nhd5FABpRpbJAKW+SxnBTCtRujFuJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246756160"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="246756160"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 02:25:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="535592177"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2022 02:25:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD1yS-000MTj-Cv; Thu, 27 Jan 2022 10:25:52 +0000
Date:   Thu, 27 Jan 2022 18:25:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 50/60] ERROR: modpost: "__umoddi3"
 [drivers/cxl/cxl_region.ko] undefined!
Message-ID: <202201271819.Os0X3tNX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   41c2d219a2c8e14de644f4e953e0c57402c3e884
commit: 84dbaed92240cd65eb70045a3c61b6b4050822c2 [50/60] cxl/region: Introduce a cxl_region driver
config: i386-randconfig-a003-20220124 (https://download.01.org/0day-ci/archive/20220127/202201271819.Os0X3tNX-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=84dbaed92240cd65eb70045a3c61b6b4050822c2
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 84dbaed92240cd65eb70045a3c61b6b4050822c2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [drivers/cxl/cxl_region.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
