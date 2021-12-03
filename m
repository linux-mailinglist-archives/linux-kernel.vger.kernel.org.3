Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ED4466E42
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349679AbhLCAFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:05:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:47927 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242581AbhLCAFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:05:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="234383792"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="234383792"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 16:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="513443553"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2021 16:01:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msw1K-000GrP-At; Fri, 03 Dec 2021 00:01:46 +0000
Date:   Fri, 3 Dec 2021 08:00:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shawn Guo <shawn.guo@linaro.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 3/3] irqchip: Add Qualcomm MPM controller driver
Message-ID: <202112030740.6LvRpZLQ-lkp@intel.com>
References: <20211202122122.23548-4-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202122122.23548-4-shawn.guo@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on linux/master linus/master v5.16-rc3 next-20211202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shawn-Guo/Add-Qualcomm-MPM-irqchip-driver-support/20211202-202327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 4946f15e8c334840bf277a0bf924371eae120fcd
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20211203/202112030740.6LvRpZLQ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d575d38e462a2d09c7e36150fb9a638d591a9c91
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shawn-Guo/Add-Qualcomm-MPM-irqchip-driver-support/20211202-202327
        git checkout d575d38e462a2d09c7e36150fb9a638d591a9c91
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/irqchip/qcom-mpm.c: In function 'qcom_mpm_handler':
>> drivers/irqchip/qcom-mpm.c:284:33: error: implicit declaration of function 'irq_set_irqchip_state'; did you mean 'irq_set_chip_data'? [-Werror=implicit-function-declaration]
     284 |                                 irq_set_irqchip_state(d->irq,
         |                                 ^~~~~~~~~~~~~~~~~~~~~
         |                                 irq_set_chip_data
>> drivers/irqchip/qcom-mpm.c:285:49: error: 'IRQCHIP_STATE_PENDING' undeclared (first use in this function)
     285 |                                                 IRQCHIP_STATE_PENDING, true);
         |                                                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/qcom-mpm.c:285:49: note: each undeclared identifier is reported only once for each function it appears in
   drivers/irqchip/qcom-mpm.c: In function 'qcom_mpm_init':
>> drivers/irqchip/qcom-mpm.c:425:15: error: implicit declaration of function 'devm_request_irq'; did you mean 'can_request_irq'? [-Werror=implicit-function-declaration]
     425 |         ret = devm_request_irq(dev, irq, qcom_mpm_handler,
         |               ^~~~~~~~~~~~~~~~
         |               can_request_irq
>> drivers/irqchip/qcom-mpm.c:426:32: error: 'IRQF_TRIGGER_RISING' undeclared (first use in this function); did you mean 'IRQD_TRIGGER_MASK'?
     426 |                                IRQF_TRIGGER_RISING | IRQF_NO_SUSPEND,
         |                                ^~~~~~~~~~~~~~~~~~~
         |                                IRQD_TRIGGER_MASK
>> drivers/irqchip/qcom-mpm.c:426:54: error: 'IRQF_NO_SUSPEND' undeclared (first use in this function)
     426 |                                IRQF_TRIGGER_RISING | IRQF_NO_SUSPEND,
         |                                                      ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +284 drivers/irqchip/qcom-mpm.c

   264	
   265	/* Triggered by RPM when system resumes from deep sleep */
   266	static irqreturn_t qcom_mpm_handler(int irq, void *dev_id)
   267	{
   268		struct qcom_mpm_priv *priv = dev_id;
   269		unsigned long enable, pending;
   270		int i, j;
   271	
   272		for (i = 0; i < priv->reg_stride; i++) {
   273			enable = qcom_mpm_read(priv, MPM_REG_ENABLE, i);
   274			pending = qcom_mpm_read(priv, MPM_REG_STATUS, i);
   275			pending &= enable;
   276	
   277			for_each_set_bit(j, &pending, 32) {
   278				unsigned int pin = 32 * i + j;
   279				struct irq_desc *desc =
   280						irq_resolve_mapping(priv->domain, pin);
   281				struct irq_data *d = &desc->irq_data;
   282	
   283				if (!irqd_is_level_type(d))
 > 284					irq_set_irqchip_state(d->irq,
 > 285							IRQCHIP_STATE_PENDING, true);
   286	
   287			}
   288		}
   289	
   290		return IRQ_HANDLED;
   291	}
   292	
   293	static int qcom_mpm_enter_sleep(struct qcom_mpm_priv *priv)
   294	{
   295		int i, ret;
   296	
   297		for (i = 0; i < priv->reg_stride; i++)
   298			qcom_mpm_write(priv, MPM_REG_STATUS, i, 0);
   299	
   300		/* Notify RPM to write vMPM into HW */
   301		ret = mbox_send_message(priv->mbox_chan, NULL);
   302		if (ret < 0)
   303			return ret;
   304	
   305		return 0;
   306	}
   307	
   308	static int qcom_mpm_cpu_pm_callback(struct notifier_block *nb,
   309					    unsigned long action, void *data)
   310	{
   311		struct qcom_mpm_priv *priv = container_of(nb, struct qcom_mpm_priv,
   312							  pm_nb);
   313		int ret = NOTIFY_OK;
   314		int cpus_in_pm;
   315	
   316		switch (action) {
   317		case CPU_PM_ENTER:
   318			cpus_in_pm = atomic_inc_return(&priv->cpus_in_pm);
   319			/*
   320			 * NOTE: comments for num_online_cpus() point out that it's
   321			 * only a snapshot so we need to be careful. It should be OK
   322			 * for us to use, though.  It's important for us not to miss
   323			 * if we're the last CPU going down so it would only be a
   324			 * problem if a CPU went offline right after we did the check
   325			 * AND that CPU was not idle AND that CPU was the last non-idle
   326			 * CPU. That can't happen. CPUs would have to come out of idle
   327			 * before the CPU could go offline.
   328			 */
   329			if (cpus_in_pm < num_online_cpus())
   330				return NOTIFY_OK;
   331			break;
   332		case CPU_PM_ENTER_FAILED:
   333		case CPU_PM_EXIT:
   334			atomic_dec(&priv->cpus_in_pm);
   335			return NOTIFY_OK;
   336		default:
   337			return NOTIFY_DONE;
   338		}
   339	
   340		/*
   341		 * It's likely we're on the last CPU. Grab the lock and write MPM for
   342		 * sleep. Grabbing the lock means that if we race with another CPU
   343		 * coming up we are still guaranteed to be safe.
   344		 */
   345		if (raw_spin_trylock(&priv->lock)) {
   346			if (qcom_mpm_enter_sleep(priv))
   347				ret = NOTIFY_BAD;
   348			raw_spin_unlock(&priv->lock);
   349		} else {
   350			/* Another CPU must be up */
   351			return NOTIFY_OK;
   352		}
   353	
   354		if (ret == NOTIFY_BAD) {
   355			/* Double-check if we're here because someone else is up */
   356			if (cpus_in_pm < num_online_cpus())
   357				ret = NOTIFY_OK;
   358			else
   359				/* We won't be called w/ CPU_PM_ENTER_FAILED */
   360				atomic_dec(&priv->cpus_in_pm);
   361		}
   362	
   363		return ret;
   364	}
   365	
   366	static int qcom_mpm_init(struct platform_device *pdev,
   367				 struct device_node *parent,
   368				 const struct mpm_data *data)
   369	{
   370		struct irq_domain *parent_domain;
   371		struct device *dev = &pdev->dev;
   372		struct device_node *np = dev->of_node;
   373		struct qcom_mpm_priv *priv;
   374		unsigned int pin_num;
   375		int irq;
   376		int ret;
   377	
   378		if (!data)
   379			return -ENODEV;
   380	
   381		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
   382		if (!priv)
   383			return -ENOMEM;
   384	
   385		priv->data = data;
   386		pin_num = priv->data->pin_num;
   387		priv->reg_stride = DIV_ROUND_UP(pin_num, 32);
   388	
   389		raw_spin_lock_init(&priv->lock);
   390	
   391		priv->base = devm_platform_ioremap_resource(pdev, 0);
   392		if (!priv->base)
   393			return PTR_ERR(priv->base);
   394	
   395		irq = platform_get_irq(pdev, 0);
   396		if (irq < 0)
   397			return irq;
   398	
   399		priv->mbox_client.dev = dev;
   400		priv->mbox_chan = mbox_request_channel(&priv->mbox_client, 0);
   401		if (IS_ERR(priv->mbox_chan)) {
   402			ret = PTR_ERR(priv->mbox_chan);
   403			dev_err(dev, "failed to acquire IPC channel: %d\n", ret);
   404			return ret;
   405		}
   406	
   407		parent_domain = irq_find_host(parent);
   408		if (!parent_domain) {
   409			dev_err(dev, "failed to find MPM parent domain\n");
   410			ret = -ENXIO;
   411			goto free_mbox;
   412		}
   413	
   414		priv->domain = irq_domain_create_hierarchy(parent_domain,
   415					IRQ_DOMAIN_FLAG_QCOM_MPM_WAKEUP, pin_num,
   416					of_node_to_fwnode(np), &qcom_mpm_ops, priv);
   417		if (!priv->domain) {
   418			dev_err(dev, "failed to create MPM domain\n");
   419			ret = -ENOMEM;
   420			goto free_mbox;
   421		}
   422	
   423		irq_domain_update_bus_token(priv->domain, DOMAIN_BUS_WAKEUP);
   424	
 > 425		ret = devm_request_irq(dev, irq, qcom_mpm_handler,
 > 426				       IRQF_TRIGGER_RISING | IRQF_NO_SUSPEND,
   427				       "qcom_mpm", priv);
   428		if (ret) {
   429			dev_err(dev, "failed to request irq: %d\n", ret);
   430			goto remove_domain;
   431		}
   432	
   433		priv->pm_nb.notifier_call = qcom_mpm_cpu_pm_callback;
   434		cpu_pm_register_notifier(&priv->pm_nb);
   435	
   436		dev_set_drvdata(dev, priv);
   437	
   438		return 0;
   439	
   440	remove_domain:
   441		irq_domain_remove(priv->domain);
   442	free_mbox:
   443		mbox_free_channel(priv->mbox_chan);
   444		return ret;
   445	}
   446	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
