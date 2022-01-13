Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88C48DF54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiAMVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:02:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:8868 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbiAMVCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642107726; x=1673643726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ftmbq4MhF254TtN2OkjaCBszJRBYw/W1sHTyP+uFt1U=;
  b=OM6nGzkvWKOM30gpfNJaL3IcvTnkJw8x5o1t5uQ28kecX2LfHhTsGuwh
   RIXJdQK9hHe+RhrKzhY0orxy4pxuVTAl6AVCao3HvmbGddXYbgIO7gh3M
   Kxc/NVW6jEXRIZU1gCrNMx3B1hXXbKtOKdIYf4RMM01HhjvvI8W+2e03O
   I0imgxPuLtnpHB8HTxjpoEmgq9PyUlSZm9JSKBKYJbY2847HRpuVhOl2A
   cMGqOsUGu/NCrNwM2W6aY/gsIfyqFIM1JQdyGu1BSXzwDic/B5fA+Bq9M
   bpRzuBhLvCFFRDvXk8sIY1so08beg1D93w/XRC5Atlke3a96vexbFvx4i
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="242927998"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="242927998"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 13:02:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="614099063"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jan 2022 13:02:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n87EQ-0007dZ-IH; Thu, 13 Jan 2022 21:02:02 +0000
Date:   Fri, 14 Jan 2022 05:01:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Iwona Winiarska <iwona.winiarska@intel.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v5 05/13] peci: Add peci-aspeed controller driver
Message-ID: <202201140455.rWgkX1hh-lkp@intel.com>
References: <20220112230247.982212-6-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112230247.982212-6-iwona.winiarska@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iwona,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linux/master linus/master v5.16 next-20220113]
[cannot apply to joel-aspeed/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Iwona-Winiarska/Introduce-PECI-subsystem/20220113-071131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: ia64-randconfig-r033-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140455.rWgkX1hh-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/9b4f2401a427cff2efc191f507d73ec8ae1ad872
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Iwona-Winiarska/Introduce-PECI-subsystem/20220113-071131
        git checkout 9b4f2401a427cff2efc191f507d73ec8ae1ad872
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_clk_hw_register" [drivers/peci/controller/peci-aspeed.ko] undefined!
>> ERROR: modpost: "__clk_get_name" [drivers/peci/controller/peci-aspeed.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
