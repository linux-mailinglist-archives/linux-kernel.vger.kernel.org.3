Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7706647315C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbhLMQOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:14:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:23403 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233692AbhLMQOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639412042; x=1670948042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bwc/v2EAT1exqJQKRtyhv+kK3QsmQEtpMN0hzZWbS5Q=;
  b=bZy39FfrrmCxNV4q6PFV9Tq7EZfI1HEv8P+0NH3oN/JtBp+rYJXQHYIt
   WKs9URSun6qq2+VNwotQtKoyiIV8TJ7opn8D04os0Qa7C+JqqxWADoW0G
   jT7Lw8DBUAj79yzVfWtwqxC8WB5usL+yTh04eABJ5cCgrjI13X+K1Mo4u
   0Cui7WeXbPt8OyZ68WCtK5ov+lDgvZ9YlE8qDXJ5v+tzvc01ZNsKPHQdE
   8paD7dp8aCAvgnRC3g9mDpoG/T1gjub2Janb1BArPscJJwsm0cy/xuOZv
   dCzo6xn14jzFeBFYuVqhtpKFVRVVOqwxkdtzAod2ElAcOCBARyJYrcEyA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="299548725"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="299548725"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 08:12:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="566734864"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2021 08:12:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwnwY-0006p0-1e; Mon, 13 Dec 2021 16:12:50 +0000
Date:   Tue, 14 Dec 2021 00:12:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <quic_collinsd@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: Re: [PATCH] power_supply: Register cooling device outside of probe
Message-ID: <202112132307.mubGFyNy-lkp@intel.com>
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Manaf-Meethalavalappu-Pallikunhi/power_supply-Register-cooling-device-outside-of-probe/20211213-191238
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: i386-randconfig-s001-20211213 (https://download.01.org/0day-ci/archive/20211213/202112132307.mubGFyNy-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/e5930a7ed9ae1b121e0dde177184ff74abbf0371
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Manaf-Meethalavalappu-Pallikunhi/power_supply-Register-cooling-device-outside-of-probe/20211213-191238
        git checkout e5930a7ed9ae1b121e0dde177184ff74abbf0371
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/power/supply/power_supply_core.c:1086:12: error: conflicting types for 'psy_register_cooler'
    1086 | static int psy_register_cooler(struct power_supply *psy)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/power/supply/power_supply_core.c:129:12: note: previous declaration of 'psy_register_cooler' was here
     129 | static int psy_register_cooler(struct device *dev, struct power_supply *psy);
         |            ^~~~~~~~~~~~~~~~~~~
>> drivers/power/supply/power_supply_core.c:129:12: warning: 'psy_register_cooler' used but never defined
   drivers/power/supply/power_supply_core.c:1086:12: warning: 'psy_register_cooler' defined but not used [-Wunused-function]
    1086 | static int psy_register_cooler(struct power_supply *psy)
         |            ^~~~~~~~~~~~~~~~~~~


vim +/psy_register_cooler +129 drivers/power/supply/power_supply_core.c

   128	
 > 129	static int psy_register_cooler(struct device *dev, struct power_supply *psy);
   130	/*
   131	 * Notify that power supply was registered after parent finished the probing.
   132	 *
   133	 * Often power supply is registered from driver's probe function. However
   134	 * calling power_supply_changed() directly from power_supply_register()
   135	 * would lead to execution of get_property() function provided by the driver
   136	 * too early - before the probe ends.
   137	 * Also, registering cooling device from the probe will execute the
   138	 * get_property() function. So register the cooling device after the probe.
   139	 *
   140	 * Avoid that by waiting on parent's mutex.
   141	 */
   142	static void power_supply_deferred_register_work(struct work_struct *work)
   143	{
   144		struct power_supply *psy = container_of(work, struct power_supply,
   145							deferred_register_work.work);
   146	
   147		if (psy->dev.parent) {
   148			while (!mutex_trylock(&psy->dev.parent->mutex)) {
   149				if (psy->removing)
   150					return;
   151				msleep(10);
   152			}
   153		}
   154	
   155		power_supply_changed(psy);
   156		psy_register_cooler(psy->dev.parent, psy);
   157	
   158		if (psy->dev.parent)
   159			mutex_unlock(&psy->dev.parent->mutex);
   160	}
   161	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
