Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E24747112A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 04:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhLKDVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 22:21:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:8636 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235552AbhLKDVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 22:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639192649; x=1670728649;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qgzVKScY9Kq64aGu0JyH4nHSDHx1FSgJsX9TqzDSi4g=;
  b=JHoaWh6El1AQcp9qmTENYSw8I7GU3gT1a0az/wS42TPdUsWRnadQWAEr
   chuLSPcKsJpRYHapfC2rUP1IhtTWxPvZmoF39sA1mlml+h8eSy/YTZm6N
   rHxHZ4nXOeQOKcYK8sPxjkLLac1iICseno6Ykfk1/ddM9wy4ETu07ZzB2
   lZh7LeudOKOcJb4emnNlXBb/dpIPNngdWpkDKVpvcaEed46R66xBUJ2gB
   +A2ZeXRghiZrt/bC35Dpjut1MB2dLEraYVUS+c2/7d2sEuLNE1fJ0P5Ke
   f0JSaegsGKR4aju9GlhN9WZRSXaootRufuoIzqJtEMKUUgLksAQQZnq/v
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="218523597"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="218523597"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 19:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="504195913"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 19:17:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvst4-00042I-MQ; Sat, 11 Dec 2021 03:17:26 +0000
Date:   Sat, 11 Dec 2021 11:17:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: qcom_q6v5.c:undefined reference to `qmp_send'
Message-ID: <202112111134.GCaDwqAi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9e65da135b39cabd82dc2f56b0db526b65a8d690
commit: c1fe10d238c0256a77dbc4bf6493b9782b2a218d remoteproc: qcom: q6v5: Use qmp_send to update co-processor load state
date:   2 months ago
config: arm64-randconfig-r013-20211211 (https://download.01.org/0day-ci/archive/20211211/202112111134.GCaDwqAi-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1fe10d238c0256a77dbc4bf6493b9782b2a218d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c1fe10d238c0256a77dbc4bf6493b9782b2a218d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `q6v5_load_state_toggle':
>> qcom_q6v5.c:(.text+0xac): undefined reference to `qmp_send'
   qcom_q6v5.c:(.text+0xac): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `qmp_send'
   aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `qcom_q6v5_deinit':
>> (.text+0x204): undefined reference to `qmp_put'
   (.text+0x204): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `qmp_put'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
