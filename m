Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E04467307
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379101AbhLCIFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:05:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:32449 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350557AbhLCIFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:05:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="323187015"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="323187015"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 00:02:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="478241421"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2021 00:02:01 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mt3W4-000HG0-Jg; Fri, 03 Dec 2021 08:02:00 +0000
Date:   Fri, 3 Dec 2021 16:01:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:asahi 17/56] drivers/base/power/domain.c:598:20: error:
 'pm_wq' undeclared
Message-ID: <202112031521.yz9tDRBh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi
head:   69711d887d3f10a4f7dd6fd648bfff63ff66ba18
commit: 88c21c1057ae09aa4e5945ce315ea48c411398eb [17/56] soc: apple: Add driver for Apple PMGR power state controls
config: arc-randconfig-r035-20211203 (https://download.01.org/0day-ci/archive/20211203/202112031521.yz9tDRBh-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/88c21c1057ae09aa4e5945ce315ea48c411398eb
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi
        git checkout 88c21c1057ae09aa4e5945ce315ea48c411398eb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/base/power/domain.c: In function 'genpd_queue_power_off_work':
>> drivers/base/power/domain.c:598:20: error: 'pm_wq' undeclared (first use in this function)
     598 |         queue_work(pm_wq, &genpd->power_off_work);
         |                    ^~~~~
   drivers/base/power/domain.c:598:20: note: each undeclared identifier is reported only once for each function it appears in
   drivers/base/power/domain.c: In function 'genpd_dev_pm_qos_notifier':
>> drivers/base/power/domain.c:789:39: error: 'struct dev_pm_info' has no member named 'ignore_children'
     789 |                 if (!dev || dev->power.ignore_children)
         |                                       ^
   drivers/base/power/domain.c: In function 'rtpm_status_str':
>> drivers/base/power/domain.c:3006:23: error: 'struct dev_pm_info' has no member named 'runtime_error'
    3006 |         if (dev->power.runtime_error)
         |                       ^
>> drivers/base/power/domain.c:3008:28: error: 'struct dev_pm_info' has no member named 'disable_depth'
    3008 |         else if (dev->power.disable_depth)
         |                            ^
>> drivers/base/power/domain.c:3010:28: error: 'struct dev_pm_info' has no member named 'runtime_status'
    3010 |         else if (dev->power.runtime_status < ARRAY_SIZE(status_lookup))
         |                            ^
   drivers/base/power/domain.c:3011:45: error: 'struct dev_pm_info' has no member named 'runtime_status'
    3011 |                 p = status_lookup[dev->power.runtime_status];
         |                                             ^
--
   drivers/base/power/domain_governor.c: In function 'default_suspend_ok':
>> drivers/base/power/domain_governor.c:82:24: error: 'struct dev_pm_info' has no member named 'ignore_children'
      82 |         if (!dev->power.ignore_children)
         |                        ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
   Depends on PM
   Selected by
   - APPLE_PMGR_PWRSTATE && (ARCH_APPLE || COMPILE_TEST


vim +/pm_wq +598 drivers/base/power/domain.c

c8f0ea45169c57 Geert Uytterhoeven 2014-11-10  588  
29e47e2173349e Ulf Hansson        2015-09-02  589  /**
86e12eac1f7f84 Ulf Hansson        2016-12-08  590   * genpd_queue_power_off_work - Queue up the execution of genpd_power_off().
a3d09c73492e57 Moritz Fischer     2016-01-27  591   * @genpd: PM domain to power off.
29e47e2173349e Ulf Hansson        2015-09-02  592   *
86e12eac1f7f84 Ulf Hansson        2016-12-08  593   * Queue up the execution of genpd_power_off() unless it's already been done
29e47e2173349e Ulf Hansson        2015-09-02  594   * before.
29e47e2173349e Ulf Hansson        2015-09-02  595   */
29e47e2173349e Ulf Hansson        2015-09-02  596  static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
29e47e2173349e Ulf Hansson        2015-09-02  597  {
29e47e2173349e Ulf Hansson        2015-09-02 @598  	queue_work(pm_wq, &genpd->power_off_work);
29e47e2173349e Ulf Hansson        2015-09-02  599  }
29e47e2173349e Ulf Hansson        2015-09-02  600  
1f8728b7adc4c2 Ulf Hansson        2017-02-17  601  /**
1f8728b7adc4c2 Ulf Hansson        2017-02-17  602   * genpd_power_off - Remove power from a given PM domain.
1f8728b7adc4c2 Ulf Hansson        2017-02-17  603   * @genpd: PM domain to power down.
3c64649d1cf9f3 Ulf Hansson        2017-02-17  604   * @one_dev_on: If invoked from genpd's ->runtime_suspend|resume() callback, the
3c64649d1cf9f3 Ulf Hansson        2017-02-17  605   * RPM status of the releated device is in an intermediate state, not yet turned
3c64649d1cf9f3 Ulf Hansson        2017-02-17  606   * into RPM_SUSPENDED. This means genpd_power_off() must allow one device to not
3c64649d1cf9f3 Ulf Hansson        2017-02-17  607   * be RPM_SUSPENDED, while it tries to power off the PM domain.
763663c9715f5f Yang Yingliang     2021-05-12  608   * @depth: nesting count for lockdep.
1f8728b7adc4c2 Ulf Hansson        2017-02-17  609   *
1f8728b7adc4c2 Ulf Hansson        2017-02-17  610   * If all of the @genpd's devices have been suspended and all of its subdomains
1f8728b7adc4c2 Ulf Hansson        2017-02-17  611   * have been powered down, remove power from @genpd.
1f8728b7adc4c2 Ulf Hansson        2017-02-17  612   */
2da835452a0875 Ulf Hansson        2017-02-17  613  static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
2da835452a0875 Ulf Hansson        2017-02-17  614  			   unsigned int depth)
1f8728b7adc4c2 Ulf Hansson        2017-02-17  615  {
1f8728b7adc4c2 Ulf Hansson        2017-02-17  616  	struct pm_domain_data *pdd;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  617  	struct gpd_link *link;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  618  	unsigned int not_suspended = 0;
f63816e43d9044 Ulf Hansson        2020-09-24  619  	int ret;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  620  
1f8728b7adc4c2 Ulf Hansson        2017-02-17  621  	/*
1f8728b7adc4c2 Ulf Hansson        2017-02-17  622  	 * Do not try to power off the domain in the following situations:
1f8728b7adc4c2 Ulf Hansson        2017-02-17  623  	 * (1) The domain is already in the "power off" state.
1f8728b7adc4c2 Ulf Hansson        2017-02-17  624  	 * (2) System suspend is in progress.
1f8728b7adc4c2 Ulf Hansson        2017-02-17  625  	 */
41e2c8e0060db2 Ulf Hansson        2017-03-20  626  	if (!genpd_status_on(genpd) || genpd->prepared_count > 0)
1f8728b7adc4c2 Ulf Hansson        2017-02-17  627  		return 0;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  628  
ffaa42e8a40b7f Ulf Hansson        2017-03-20  629  	/*
ffaa42e8a40b7f Ulf Hansson        2017-03-20  630  	 * Abort power off for the PM domain in the following situations:
ffaa42e8a40b7f Ulf Hansson        2017-03-20  631  	 * (1) The domain is configured as always on.
ffaa42e8a40b7f Ulf Hansson        2017-03-20  632  	 * (2) When the domain has a subdomain being powered on.
ffaa42e8a40b7f Ulf Hansson        2017-03-20  633  	 */
ed61e18a4b4e44 Leonard Crestez    2019-04-30  634  	if (genpd_is_always_on(genpd) ||
ed61e18a4b4e44 Leonard Crestez    2019-04-30  635  			genpd_is_rpm_always_on(genpd) ||
ed61e18a4b4e44 Leonard Crestez    2019-04-30  636  			atomic_read(&genpd->sd_count) > 0)
1f8728b7adc4c2 Ulf Hansson        2017-02-17  637  		return -EBUSY;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  638  
1f8728b7adc4c2 Ulf Hansson        2017-02-17  639  	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
1f8728b7adc4c2 Ulf Hansson        2017-02-17  640  		enum pm_qos_flags_status stat;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  641  
20f97caf1120bd Rafael J. Wysocki  2017-10-13  642  		stat = dev_pm_qos_flags(pdd->dev, PM_QOS_FLAG_NO_POWER_OFF);
1f8728b7adc4c2 Ulf Hansson        2017-02-17  643  		if (stat > PM_QOS_FLAGS_NONE)
1f8728b7adc4c2 Ulf Hansson        2017-02-17  644  			return -EBUSY;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  645  
1f8728b7adc4c2 Ulf Hansson        2017-02-17  646  		/*
1f8728b7adc4c2 Ulf Hansson        2017-02-17  647  		 * Do not allow PM domain to be powered off, when an IRQ safe
1f8728b7adc4c2 Ulf Hansson        2017-02-17  648  		 * device is part of a non-IRQ safe domain.
1f8728b7adc4c2 Ulf Hansson        2017-02-17  649  		 */
1f8728b7adc4c2 Ulf Hansson        2017-02-17  650  		if (!pm_runtime_suspended(pdd->dev) ||
1f8728b7adc4c2 Ulf Hansson        2017-02-17  651  			irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd))
1f8728b7adc4c2 Ulf Hansson        2017-02-17  652  			not_suspended++;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  653  	}
1f8728b7adc4c2 Ulf Hansson        2017-02-17  654  
3c64649d1cf9f3 Ulf Hansson        2017-02-17  655  	if (not_suspended > 1 || (not_suspended == 1 && !one_dev_on))
1f8728b7adc4c2 Ulf Hansson        2017-02-17  656  		return -EBUSY;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  657  
1f8728b7adc4c2 Ulf Hansson        2017-02-17  658  	if (genpd->gov && genpd->gov->power_down_ok) {
1f8728b7adc4c2 Ulf Hansson        2017-02-17  659  		if (!genpd->gov->power_down_ok(&genpd->domain))
1f8728b7adc4c2 Ulf Hansson        2017-02-17  660  			return -EAGAIN;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  661  	}
1f8728b7adc4c2 Ulf Hansson        2017-02-17  662  
2c9b7f8772033c Ulf Hansson        2018-10-03  663  	/* Default to shallowest state. */
2c9b7f8772033c Ulf Hansson        2018-10-03  664  	if (!genpd->gov)
2c9b7f8772033c Ulf Hansson        2018-10-03  665  		genpd->state_idx = 0;
2c9b7f8772033c Ulf Hansson        2018-10-03  666  
f63816e43d9044 Ulf Hansson        2020-09-24  667  	/* Don't power off, if a child domain is waiting to power on. */
1f8728b7adc4c2 Ulf Hansson        2017-02-17  668  	if (atomic_read(&genpd->sd_count) > 0)
1f8728b7adc4c2 Ulf Hansson        2017-02-17  669  		return -EBUSY;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  670  
1f8728b7adc4c2 Ulf Hansson        2017-02-17  671  	ret = _genpd_power_off(genpd, true);
c6a113b52302ad Lina Iyer          2020-10-15  672  	if (ret) {
c6a113b52302ad Lina Iyer          2020-10-15  673  		genpd->states[genpd->state_idx].rejected++;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  674  		return ret;
c6a113b52302ad Lina Iyer          2020-10-15  675  	}
1f8728b7adc4c2 Ulf Hansson        2017-02-17  676  
49f618e1b669ef Ulf Hansson        2020-09-24  677  	genpd->status = GENPD_STATE_OFF;
afece3ab9a3640 Thara Gopinath     2017-07-14  678  	genpd_update_accounting(genpd);
c6a113b52302ad Lina Iyer          2020-10-15  679  	genpd->states[genpd->state_idx].usage++;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  680  
8d87ae48ced2df Kees Cook          2020-07-08  681  	list_for_each_entry(link, &genpd->child_links, child_node) {
8d87ae48ced2df Kees Cook          2020-07-08  682  		genpd_sd_counter_dec(link->parent);
8d87ae48ced2df Kees Cook          2020-07-08  683  		genpd_lock_nested(link->parent, depth + 1);
8d87ae48ced2df Kees Cook          2020-07-08  684  		genpd_power_off(link->parent, false, depth + 1);
8d87ae48ced2df Kees Cook          2020-07-08  685  		genpd_unlock(link->parent);
1f8728b7adc4c2 Ulf Hansson        2017-02-17  686  	}
1f8728b7adc4c2 Ulf Hansson        2017-02-17  687  
1f8728b7adc4c2 Ulf Hansson        2017-02-17  688  	return 0;
1f8728b7adc4c2 Ulf Hansson        2017-02-17  689  }
1f8728b7adc4c2 Ulf Hansson        2017-02-17  690  
5248051b9afb66 Rafael J. Wysocki  2011-07-01  691  /**
8d87ae48ced2df Kees Cook          2020-07-08  692   * genpd_power_on - Restore power to a given PM domain and its parents.
5248051b9afb66 Rafael J. Wysocki  2011-07-01  693   * @genpd: PM domain to power up.
0106ef5146f9e8 Marek Szyprowski   2016-01-20  694   * @depth: nesting count for lockdep.
5248051b9afb66 Rafael J. Wysocki  2011-07-01  695   *
8d87ae48ced2df Kees Cook          2020-07-08  696   * Restore power to @genpd and all of its parents so that it is possible to
5248051b9afb66 Rafael J. Wysocki  2011-07-01  697   * resume a device belonging to it.
5248051b9afb66 Rafael J. Wysocki  2011-07-01  698   */
86e12eac1f7f84 Ulf Hansson        2016-12-08  699  static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
5248051b9afb66 Rafael J. Wysocki  2011-07-01  700  {
5063ce1571b738 Rafael J. Wysocki  2011-08-08  701  	struct gpd_link *link;
5248051b9afb66 Rafael J. Wysocki  2011-07-01  702  	int ret = 0;
5248051b9afb66 Rafael J. Wysocki  2011-07-01  703  
41e2c8e0060db2 Ulf Hansson        2017-03-20  704  	if (genpd_status_on(genpd))
3f241775c30365 Rafael J. Wysocki  2011-08-08  705  		return 0;
5248051b9afb66 Rafael J. Wysocki  2011-07-01  706  
5063ce1571b738 Rafael J. Wysocki  2011-08-08  707  	/*
5063ce1571b738 Rafael J. Wysocki  2011-08-08  708  	 * The list is guaranteed not to change while the loop below is being
8d87ae48ced2df Kees Cook          2020-07-08  709  	 * executed, unless one of the parents' .power_on() callbacks fiddles
5063ce1571b738 Rafael J. Wysocki  2011-08-08  710  	 * with it.
5063ce1571b738 Rafael J. Wysocki  2011-08-08  711  	 */
8d87ae48ced2df Kees Cook          2020-07-08  712  	list_for_each_entry(link, &genpd->child_links, child_node) {
8d87ae48ced2df Kees Cook          2020-07-08  713  		struct generic_pm_domain *parent = link->parent;
0106ef5146f9e8 Marek Szyprowski   2016-01-20  714  
8d87ae48ced2df Kees Cook          2020-07-08  715  		genpd_sd_counter_inc(parent);
0106ef5146f9e8 Marek Szyprowski   2016-01-20  716  
8d87ae48ced2df Kees Cook          2020-07-08  717  		genpd_lock_nested(parent, depth + 1);
8d87ae48ced2df Kees Cook          2020-07-08  718  		ret = genpd_power_on(parent, depth + 1);
8d87ae48ced2df Kees Cook          2020-07-08  719  		genpd_unlock(parent);
5248051b9afb66 Rafael J. Wysocki  2011-07-01  720  
5063ce1571b738 Rafael J. Wysocki  2011-08-08  721  		if (ret) {
8d87ae48ced2df Kees Cook          2020-07-08  722  			genpd_sd_counter_dec(parent);
9e08cf42969709 Rafael J. Wysocki  2011-08-08  723  			goto err;
5248051b9afb66 Rafael J. Wysocki  2011-07-01  724  		}
5063ce1571b738 Rafael J. Wysocki  2011-08-08  725  	}
5248051b9afb66 Rafael J. Wysocki  2011-07-01  726  
86e12eac1f7f84 Ulf Hansson        2016-12-08  727  	ret = _genpd_power_on(genpd, true);
9e08cf42969709 Rafael J. Wysocki  2011-08-08  728  	if (ret)
9e08cf42969709 Rafael J. Wysocki  2011-08-08  729  		goto err;
0140d8bd47f798 Rafael J. Wysocki  2011-12-01  730  
49f618e1b669ef Ulf Hansson        2020-09-24  731  	genpd->status = GENPD_STATE_ON;
afece3ab9a3640 Thara Gopinath     2017-07-14  732  	genpd_update_accounting(genpd);
afece3ab9a3640 Thara Gopinath     2017-07-14  733  
3f241775c30365 Rafael J. Wysocki  2011-08-08  734  	return 0;
9e08cf42969709 Rafael J. Wysocki  2011-08-08  735  
9e08cf42969709 Rafael J. Wysocki  2011-08-08  736   err:
29e47e2173349e Ulf Hansson        2015-09-02  737  	list_for_each_entry_continue_reverse(link,
8d87ae48ced2df Kees Cook          2020-07-08  738  					&genpd->child_links,
8d87ae48ced2df Kees Cook          2020-07-08  739  					child_node) {
8d87ae48ced2df Kees Cook          2020-07-08  740  		genpd_sd_counter_dec(link->parent);
8d87ae48ced2df Kees Cook          2020-07-08  741  		genpd_lock_nested(link->parent, depth + 1);
8d87ae48ced2df Kees Cook          2020-07-08  742  		genpd_power_off(link->parent, false, depth + 1);
8d87ae48ced2df Kees Cook          2020-07-08  743  		genpd_unlock(link->parent);
29e47e2173349e Ulf Hansson        2015-09-02  744  	}
9e08cf42969709 Rafael J. Wysocki  2011-08-08  745  
3f241775c30365 Rafael J. Wysocki  2011-08-08  746  	return ret;
3f241775c30365 Rafael J. Wysocki  2011-08-08  747  }
3f241775c30365 Rafael J. Wysocki  2011-08-08  748  
ea71c59669f17d Ulf Hansson        2019-10-16  749  static int genpd_dev_pm_start(struct device *dev)
ea71c59669f17d Ulf Hansson        2019-10-16  750  {
ea71c59669f17d Ulf Hansson        2019-10-16  751  	struct generic_pm_domain *genpd = dev_to_genpd(dev);
ea71c59669f17d Ulf Hansson        2019-10-16  752  
ea71c59669f17d Ulf Hansson        2019-10-16  753  	return genpd_start_dev(genpd, dev);
ea71c59669f17d Ulf Hansson        2019-10-16  754  }
ea71c59669f17d Ulf Hansson        2019-10-16  755  
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  756  static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  757  				     unsigned long val, void *ptr)
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  758  {
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  759  	struct generic_pm_domain_data *gpd_data;
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  760  	struct device *dev;
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  761  
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  762  	gpd_data = container_of(nb, struct generic_pm_domain_data, nb);
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  763  	dev = gpd_data->base.dev;
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  764  
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  765  	for (;;) {
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  766  		struct generic_pm_domain *genpd;
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  767  		struct pm_domain_data *pdd;
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  768  
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  769  		spin_lock_irq(&dev->power.lock);
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  770  
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  771  		pdd = dev->power.subsys_data ?
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  772  				dev->power.subsys_data->domain_data : NULL;
b4883ca449473e Viresh Kumar       2017-05-16  773  		if (pdd) {
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  774  			to_gpd_data(pdd)->td.constraint_changed = true;
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  775  			genpd = dev_to_genpd(dev);
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  776  		} else {
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  777  			genpd = ERR_PTR(-ENODATA);
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  778  		}
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  779  
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  780  		spin_unlock_irq(&dev->power.lock);
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  781  
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  782  		if (!IS_ERR(genpd)) {
35241d12f750d2 Lina Iyer          2016-10-14  783  			genpd_lock(genpd);
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  784  			genpd->max_off_time_changed = true;
35241d12f750d2 Lina Iyer          2016-10-14  785  			genpd_unlock(genpd);
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  786  		}
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  787  
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  788  		dev = dev->parent;
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01 @789  		if (!dev || dev->power.ignore_children)
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  790  			break;
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  791  	}
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  792  
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  793  	return NOTIFY_DONE;
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  794  }
6ff7bb0d02f829 Rafael J. Wysocki  2012-05-01  795  

:::::: The code at line 598 was first introduced by commit
:::::: 29e47e2173349ee06bd339f7753821c720d50923 PM / Domains: Try power off masters in error path of __pm_genpd_poweron()

:::::: TO: Ulf Hansson <ulf.hansson@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
