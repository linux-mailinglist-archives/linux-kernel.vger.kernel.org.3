Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCD448D06F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiAMCad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:30:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:62274 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231593AbiAMCab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642041031; x=1673577031;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CCNDGKbmKQFYdJA5L4AqvM30QQMdoQ8PaBFXygVVKE4=;
  b=Tz2wRXKFH6kVoVhzw3cw5yZ9eYIJZ4SWtoosvYVxufWNoZ7kKXML+ppu
   HPN6Qx5cFlhbYHN8TPjVFhqCPsUZQ+tXII9vGTpiHFWgyDxMrZMLbBEQu
   9vv1SoR4h3bXuHzeL/ZrvaH9+MxGkMH+zfDjbCaymJcQmaKRxiueYiR/s
   sa7+wucOoTZP0f5COg/ZqB3zj9TdnRhfKUaXM0OFGagzcX9ZITSshdfeJ
   nPIQfQVARgA6smYBGDdL4PFDDIRoNURqgHb3Il1QuKojgDAj1JwbnZj4c
   2bBZOlt+HtX0N2j4tgp9FuSTA8bZGD/o2sCoAA//3GFCsQ94/C2/OlcVf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="244115369"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="244115369"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 18:30:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="623694290"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Jan 2022 18:30:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7psi-0006jy-IN; Thu, 13 Jan 2022 02:30:28 +0000
Date:   Thu, 13 Jan 2022 10:29:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/platform/x86/asus-tf103c-dock.c:253:22: sparse: sparse:
 symbol 'tf103c_dock_hid_ll_driver' was not declared. Should it be static?
Message-ID: <202201131019.hPdr89Fv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   362f533a2a1098fe95020cb59340023e9b11d062
commit: 0a6509b0926dea5ebbd2c86551b7681b00585961 platform/x86: Add Asus TF103C dock driver
date:   8 days ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220113/202201131019.hPdr89Fv-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0a6509b0926dea5ebbd2c86551b7681b00585961
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0a6509b0926dea5ebbd2c86551b7681b00585961
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/asus-tf103c-dock.c:253:22: sparse: sparse: symbol 'tf103c_dock_hid_ll_driver' was not declared. Should it be static?
>> drivers/platform/x86/asus-tf103c-dock.c:924:1: sparse: sparse: symbol 'tf103c_dock_pm_ops' was not declared. Should it be static?

vim +/tf103c_dock_hid_ll_driver +253 drivers/platform/x86/asus-tf103c-dock.c

   252	
 > 253	struct hid_ll_driver tf103c_dock_hid_ll_driver = {
   254		.parse = tf103c_dock_hid_parse,
   255		.start = tf103c_dock_hid_start,
   256		.stop = tf103c_dock_hid_stop,
   257		.open = tf103c_dock_hid_open,
   258		.close = tf103c_dock_hid_close,
   259		.raw_request = tf103c_dock_hid_raw_request,
   260	};
   261	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
