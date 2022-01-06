Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3CF4865C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiAFOE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:04:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:31806 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231302AbiAFOE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641477867; x=1673013867;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AJJ5hf9CBghkofZiP0xA3u2+hnoV2c0O4gDjNdgRCEo=;
  b=j7uRH/P38XEAmh5rWELIs5jrOEqCNbmLK2XgTT3JwILo17sRa5S7lnnt
   RVTko5VqWo3jT60N4vS/UQ06V9zYUvoPVdnvvPMk+aoj6f3uMjSOO0Pny
   F5SzOPYS1pEVD6pw0JeAj/t/3gluDwj6c1ZlV02QJWNPktE5zUJ12FrzN
   VBafkGbOMLGNsYE7M5JKVcl7NpDwuWc5khag+9MFZyImziNYSEvXW+eD2
   heKf5msQMnYS+PtDSjhuzhy75FRfC/UH2Kotanw7oDqjjqY7kdoOhtCk4
   t9/jBYYE+RB7SlQNzmTL/g3o+hqEOwYNaPqe5GhuGMAtLD1TNyjQhOvPJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222654603"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="222654603"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 06:04:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="472914332"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Jan 2022 06:04:22 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5TNN-000HhY-Os; Thu, 06 Jan 2022 14:04:21 +0000
Date:   Thu, 6 Jan 2022 22:03:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from
 `drivers/platform/chrome/cros_ec_trace.o' being placed in section
 `.ftrace.tramp'
Message-ID: <202201062107.ubU9XXN2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   75acfdb6fd922598a408a0d864486aeb167c1a97
commit: d453ceb6549af8798913de6a20444cb7200fdb69 platform/chrome: sensorhub: Add trace events for sample
date:   5 months ago
config: powerpc-randconfig-r024-20220106 (https://download.01.org/0day-ci/archive/20220106/202201062107.ubU9XXN2-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d453ceb6549af8798913de6a20444cb7200fdb69
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d453ceb6549af8798913de6a20444cb7200fdb69
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.ftrace.tramp'
   powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.ftrace.tramp'
   powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.ftrace.tramp'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
