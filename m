Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC5048DC73
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiAMRBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:01:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:49230 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229899AbiAMRBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642093274; x=1673629274;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vzfMmhfeCSHX75/JcR1l28cEtIIjKvWKBuCJsFoatUE=;
  b=OzNcPtoyubObQAceUInd43mOQxrxZsSedYmY52GAcPFwCO5d7RNXN0XK
   vCLQ5owahB7ddrrIKog57BaE32EQueAtlJIPnOdHbF438lw7epcK5h8rL
   UX8Aj7UTViVKa/DaR0thf/gIj5w4LiIa7rYbduea/uk31nFSrLt0ehWID
   55UUOrdYyzb6nD1uNz4gUS/hddXg4aUvCjZy5pUf7BHX9j5v1VpN76AEu
   AvQDsCOQR7NQq4MfUCjrjiCoyeKlhQpABNprkCnbzTUor77QqC3gfgOGt
   SGFfq5YSoMoHw9ZuTyVFBSAffQxdR9cExvyUzctiQz3YNllnEBm6wSlLi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242870117"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="242870117"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 09:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="529052094"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jan 2022 09:00:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n83T7-0007TJ-EC; Thu, 13 Jan 2022 17:00:57 +0000
Date:   Fri, 14 Jan 2022 01:00:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: qcom_q6v5.c:undefined reference to `qmp_send'
Message-ID: <202201140018.LhIkWb9F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   455e73a07f6e288b0061dfcf4fcf54fa9fe06458
commit: c1fe10d238c0256a77dbc4bf6493b9782b2a218d remoteproc: qcom: q6v5: Use qmp_send to update co-processor load state
date:   4 months ago
config: arm64-randconfig-r025-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140018.LhIkWb9F-lkp@intel.com/config)
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

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `q6v5_load_state_toggle':
>> qcom_q6v5.c:(.text+0xc4): undefined reference to `qmp_send'
   aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `qcom_q6v5_deinit':
>> (.text+0x2e4): undefined reference to `qmp_put'
   aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `qcom_q6v5_init':
>> (.text+0x778): undefined reference to `qmp_get'
>> aarch64-linux-ld: (.text+0x7d8): undefined reference to `qmp_put'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
