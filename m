Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1381B473247
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbhLMQyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:54:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:43773 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237902AbhLMQyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639414451; x=1670950451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3rR9f8V0Zfh3iEHfHiSxqqLiGvY0S5iAa8fkUsLGkbI=;
  b=B0u/SSJiinCxVVwTiXcA0c44BZC2P++kxB7/wa3m283OqHq3fsM1gl1q
   BlxLSdtWJ6Odn5G8Un9b5zF+pR0Lg482k792mpBXLM1A56Ftc6N0PcIxX
   1HvZgw6spB+Fg64TJ4OMwYpeEbNM2CEA7IxhFvK160vhOoGpyB3Su2M2y
   Jg2Yqw1t+csJ9172DBlYSfYWJYmLrVkLed3Dh2i1uotpKcKp/oNvgqxdl
   ACYZt7/emRIf4r7ndEe+zD5mBrPdQsjxKsj7RuMKfynNWKzh0EatTpKja
   t/BzXU7qcMtbtm3aYATEI+fifdpmLPS2pI/19v0imDT8FnqUTBxwBb7o+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="325046222"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="325046222"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 08:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="504974933"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 08:53:51 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwoaE-0006rM-Ks; Mon, 13 Dec 2021 16:53:50 +0000
Date:   Tue, 14 Dec 2021 00:53:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <quic_collinsd@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: Re: [PATCH] power_supply: Register cooling device outside of probe
Message-ID: <202112140005.7PqxIClA-lkp@intel.com>
References: <1639393841-17444-1-git-send-email-quic_manafm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639393841-17444-1-git-send-email-quic_manafm@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manaf,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Manaf-Meethalavalappu-Pallikunhi/power_supply-Register-cooling-device-outside-of-probe/20211213-191238
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: openrisc-randconfig-r033-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140005.7PqxIClA-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e5930a7ed9ae1b121e0dde177184ff74abbf0371
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Manaf-Meethalavalappu-Pallikunhi/power_supply-Register-cooling-device-outside-of-probe/20211213-191238
        git checkout e5930a7ed9ae1b121e0dde177184ff74abbf0371
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/power/supply/power_supply_core.c:1086:12: error: conflicting types for 'psy_register_cooler'; have 'int(struct power_supply *)'
    1086 | static int psy_register_cooler(struct power_supply *psy)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/power/supply/power_supply_core.c:129:12: note: previous declaration of 'psy_register_cooler' with type 'int(struct device *, struct power_supply *)'
     129 | static int psy_register_cooler(struct device *dev, struct power_supply *psy);
         |            ^~~~~~~~~~~~~~~~~~~
>> drivers/power/supply/power_supply_core.c:129:12: warning: 'psy_register_cooler' used but never defined
   drivers/power/supply/power_supply_core.c:1086:12: warning: 'psy_register_cooler' defined but not used [-Wunused-function]
    1086 | static int psy_register_cooler(struct power_supply *psy)
         |            ^~~~~~~~~~~~~~~~~~~


vim +1086 drivers/power/supply/power_supply_core.c

952aeeb3ee28bc drivers/power/power_supply_core.c        Ramakrishna Pallala 2012-10-09  1085  
952aeeb3ee28bc drivers/power/power_supply_core.c        Ramakrishna Pallala 2012-10-09 @1086  static int psy_register_cooler(struct power_supply *psy)
952aeeb3ee28bc drivers/power/power_supply_core.c        Ramakrishna Pallala 2012-10-09  1087  {
952aeeb3ee28bc drivers/power/power_supply_core.c        Ramakrishna Pallala 2012-10-09  1088  	/* Register for cooling device if psy can control charging */
9ba533eb99bb2a drivers/power/supply/power_supply_core.c Matthias Kaehlcke   2021-09-01  1089  	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT)) {
952aeeb3ee28bc drivers/power/power_supply_core.c        Ramakrishna Pallala 2012-10-09  1090  		psy->tcd = thermal_cooling_device_register(
297d716f6260cc drivers/power/power_supply_core.c        Krzysztof Kozlowski 2015-03-12  1091  			(char *)psy->desc->name,
952aeeb3ee28bc drivers/power/power_supply_core.c        Ramakrishna Pallala 2012-10-09  1092  			psy, &psy_tcd_ops);
9d2410c79b5b2d drivers/power/power_supply_core.c        Viresh Kumar        2014-09-04  1093  		return PTR_ERR_OR_ZERO(psy->tcd);
952aeeb3ee28bc drivers/power/power_supply_core.c        Ramakrishna Pallala 2012-10-09  1094  	}
9ba533eb99bb2a drivers/power/supply/power_supply_core.c Matthias Kaehlcke   2021-09-01  1095  
952aeeb3ee28bc drivers/power/power_supply_core.c        Ramakrishna Pallala 2012-10-09  1096  	return 0;
952aeeb3ee28bc drivers/power/power_supply_core.c        Ramakrishna Pallala 2012-10-09  1097  }
952aeeb3ee28bc drivers/power/power_supply_core.c        Ramakrishna Pallala 2012-10-09  1098  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
