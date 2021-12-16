Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26C0477310
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbhLPNYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:24:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:27070 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231752AbhLPNYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639661044; x=1671197044;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zboWqb90S4wzxS9Bv6e7DstXNtZxbkOG+qiSh7V3U3w=;
  b=a1yRVt1rlZU09WjdoZWC4Wxs0HGSpmq3Y7nYjw7n4xX0v1W/yEJc4ZS2
   TBYGnlymj9z1Hqp5yIBFrlfVCI80e3KeuXWR5aT0EGr+NwegS0ozn9gsW
   sjB2tCkfAaJ3hDInoiBHfye5aXNl7C4CZxWqAEInwup7jABlRVyzhbrnf
   Vzq0n8GcAEM0pfNIdph5hZlTKkKe5uqEa5+wYiPMooxYkRSzVI3/9Yh/r
   R/Ehg4v5wgTsqzFIFxbRp93i/C3dhsA06W8hrajYZ0T+x6M76zIf7Bkaw
   uH1G8G+rO+5BX7qQKI/11pGB2z0Gnb4tV6mDtM5H6utDDz1GwftEVXYIK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="238226335"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="238226335"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 05:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="615148914"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2021 05:24:02 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxqjq-0003CX-3P; Thu, 16 Dec 2021 13:24:02 +0000
Date:   Thu, 16 Dec 2021 21:23:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [qcom:arm64-for-5.17 60/89] Error:
 arch/arm64/boot/dts/qcom/sm6125.dtsi:452.28-29 syntax error
Message-ID: <202112162157.I3SOidyR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux arm64-for-5.17
head:   bf0a257a9418ebcbe6ab2a73728f76969942e52a
commit: 556a9f3ae17ef19deecac130fea38f258d5abeb2 [60/89] arm64: dts: qcom: sm6125: Add power domains to sdhc
config: arm64-buildonly-randconfig-r001-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162157.I3SOidyR-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?id=556a9f3ae17ef19deecac130fea38f258d5abeb2
        git remote add qcom https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux
        git fetch --no-tags qcom arm64-for-5.17
        git checkout 556a9f3ae17ef19deecac130fea38f258d5abeb2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/sm6125.dtsi:452.28-29 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
