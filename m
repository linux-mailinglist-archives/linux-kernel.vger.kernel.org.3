Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE74A7E05
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349067AbiBCCkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:40:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:44673 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349057AbiBCCkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643856041; x=1675392041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l45lVgeFoDmyu7LIRd40q5vSoxl1folQLuv3T+fdiL4=;
  b=m/TtNi/RpK3aX6SfPgi1nZgwNjOsSCESSkR+3d0OIWRBtYZ5cBsYLySl
   fHLAxOdJThkW8oPnoKkic9LxFULkAlia6x4IHsmnhFUG5sna4lWWKqGBH
   4Nt7Wxx71ImunC0F0bQ0C50NG8YCkLjMdT8bogh4l2YOkswc/U0bN9HtX
   IAqbbliwu2B3t8I5ebKAtJ0/XgOj/pM8OvQ2C6iUDIBS/tAdExHlEMVeg
   fpWZPdk5K7LMIh2lIT7OBA5YCNIg2WMM0LDbrbvYEnmJlQcZ41/JBYLQH
   Djq7NdVXV7xPORKCGl3IW+XFZ+l0SPh2YWiPt2+nd4yoNqFF3/xLmQ59O
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248281652"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="248281652"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 18:40:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="676642550"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2022 18:40:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFS34-000VRz-BY; Thu, 03 Feb 2022 02:40:38 +0000
Date:   Thu, 3 Feb 2022 10:39:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anjelique Melendez <quic_amelende@quicinc.com>,
        dmitry.torokhov@gmail.com
Cc:     kbuild-all@lists.01.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        collinsd@codeaurora.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, skakit@codeaurora.org,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: Re: [PATCH v3 2/4] input: misc: pm8941-pwrkey: add support for PON
 GEN3 base addresses
Message-ID: <202202031020.M3pmrtmN-lkp@intel.com>
References: <20220203010804.20883-3-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203010804.20883-3-quic_amelende@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anjelique,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on hid/for-next linux/master linus/master v5.17-rc2 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Anjelique-Melendez/input-misc-pm8941-pwrkey-fix-error-message/20220203-091113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220203/202202031020.M3pmrtmN-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/11f3823037831d0412ab1a6895c5bcf204a3c3b1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Anjelique-Melendez/input-misc-pm8941-pwrkey-fix-error-message/20220203-091113
        git checkout 11f3823037831d0412ab1a6895c5bcf204a3c3b1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/input/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/input/misc/pm8941-pwrkey.c: In function 'pm8941_pwrkey_probe':
>> drivers/input/misc/pm8941-pwrkey.c:221:41: warning: passing argument 1 of '__be32_to_cpup' makes pointer from integer without a cast [-Wint-conversion]
     221 |         pwrkey->baseaddr = be32_to_cpup(*addr);
         |                                         ^~~~~
         |                                         |
         |                                         __be32 {aka unsigned int}
   In file included from include/linux/byteorder/big_endian.h:5,
                    from arch/s390/include/uapi/asm/byteorder.h:5,
                    from include/asm-generic/bitops/le.h:7,
                    from arch/s390/include/asm/bitops.h:393,
                    from include/linux/bitops.h:33,
                    from include/linux/thread_info.h:27,
                    from arch/s390/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from arch/s390/include/asm/percpu.h:5,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/delay.h:23,
                    from drivers/input/misc/pm8941-pwrkey.c:7:
   include/uapi/linux/byteorder/big_endian.h:81:59: note: expected 'const __be32 *' {aka 'const unsigned int *'} but argument is of type '__be32' {aka 'unsigned int'}
      81 | static __always_inline __u32 __be32_to_cpup(const __be32 *p)
         |                                             ~~~~~~~~~~~~~~^
   drivers/input/misc/pm8941-pwrkey.c:227:65: warning: passing argument 1 of '__be32_to_cpup' makes pointer from integer without a cast [-Wint-conversion]
     227 |                         pwrkey->pon_pbs_baseaddr = be32_to_cpup(*addr);
         |                                                                 ^~~~~
         |                                                                 |
         |                                                                 __be32 {aka unsigned int}
   In file included from include/linux/byteorder/big_endian.h:5,
                    from arch/s390/include/uapi/asm/byteorder.h:5,
                    from include/asm-generic/bitops/le.h:7,
                    from arch/s390/include/asm/bitops.h:393,
                    from include/linux/bitops.h:33,
                    from include/linux/thread_info.h:27,
                    from arch/s390/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from arch/s390/include/asm/percpu.h:5,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/delay.h:23,
                    from drivers/input/misc/pm8941-pwrkey.c:7:
   include/uapi/linux/byteorder/big_endian.h:81:59: note: expected 'const __be32 *' {aka 'const unsigned int *'} but argument is of type '__be32' {aka 'unsigned int'}
      81 | static __always_inline __u32 __be32_to_cpup(const __be32 *p)
         |                                             ~~~~~~~~~~~~~~^


vim +/__be32_to_cpup +221 drivers/input/misc/pm8941-pwrkey.c

   168	
   169	static SIMPLE_DEV_PM_OPS(pm8941_pwr_key_pm_ops,
   170				 pm8941_pwrkey_suspend, pm8941_pwrkey_resume);
   171	
   172	static int pm8941_pwrkey_probe(struct platform_device *pdev)
   173	{
   174		struct pm8941_pwrkey *pwrkey;
   175		bool pull_up;
   176		struct device *parent;
   177		struct device_node *regmap_node;
   178		const __be32 *addr;
   179		u32 req_delay;
   180		int error;
   181	
   182		if (of_property_read_u32(pdev->dev.of_node, "debounce", &req_delay))
   183			req_delay = 15625;
   184	
   185		if (req_delay > 2000000 || req_delay == 0) {
   186			dev_err(&pdev->dev, "invalid debounce time: %u\n", req_delay);
   187			return -EINVAL;
   188		}
   189	
   190		pull_up = of_property_read_bool(pdev->dev.of_node, "bias-pull-up");
   191	
   192		pwrkey = devm_kzalloc(&pdev->dev, sizeof(*pwrkey), GFP_KERNEL);
   193		if (!pwrkey)
   194			return -ENOMEM;
   195	
   196		pwrkey->dev = &pdev->dev;
   197		pwrkey->data = of_device_get_match_data(&pdev->dev);
   198	
   199		parent = pdev->dev.parent;
   200		regmap_node = pdev->dev.of_node;
   201		pwrkey->regmap = dev_get_regmap(parent, NULL);
   202		if (!pwrkey->regmap) {
   203			regmap_node = parent->of_node;
   204			/*
   205			 * We failed to get regmap for parent. Let's see if we are
   206			 * a child of pon node and read regmap and reg from its
   207			 * parent.
   208			 */
   209			pwrkey->regmap = dev_get_regmap(parent->parent, NULL);
   210			if (!pwrkey->regmap) {
   211				dev_err(&pdev->dev, "failed to locate regmap\n");
   212				return -ENODEV;
   213			}
   214		}
   215	
   216		addr = of_get_address(regmap_node, 0, NULL, NULL);
   217		if (!addr) {
   218			dev_err(&pdev->dev, "reg property missing\n");
   219			return -EINVAL;
   220		}
 > 221		pwrkey->baseaddr = be32_to_cpup(*addr);
   222	
   223		if (pwrkey->data->has_pon_pbs) {
   224			/* PON_PBS base address is optional */
   225			addr = of_get_address(regmap_node, 1, NULL, NULL);
   226			if (addr)
   227				pwrkey->pon_pbs_baseaddr = be32_to_cpup(*addr);
   228		}
   229	
   230		pwrkey->irq = platform_get_irq(pdev, 0);
   231		if (pwrkey->irq < 0)
   232			return pwrkey->irq;
   233	
   234		error = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_REV2,
   235				    &pwrkey->revision);
   236		if (error) {
   237			dev_err(&pdev->dev, "failed to read revision: %d\n", error);
   238			return error;
   239		}
   240	
   241		error = of_property_read_u32(pdev->dev.of_node, "linux,code",
   242					     &pwrkey->code);
   243		if (error) {
   244			dev_dbg(&pdev->dev,
   245				"no linux,code assuming power (%d)\n", error);
   246			pwrkey->code = KEY_POWER;
   247		}
   248	
   249		pwrkey->input = devm_input_allocate_device(&pdev->dev);
   250		if (!pwrkey->input) {
   251			dev_dbg(&pdev->dev, "unable to allocate input device\n");
   252			return -ENOMEM;
   253		}
   254	
   255		input_set_capability(pwrkey->input, EV_KEY, pwrkey->code);
   256	
   257		pwrkey->input->name = pwrkey->data->name;
   258		pwrkey->input->phys = pwrkey->data->phys;
   259	
   260		if (pwrkey->data->supports_debounce_config) {
   261			req_delay = (req_delay << 6) / USEC_PER_SEC;
   262			req_delay = ilog2(req_delay);
   263	
   264			error = regmap_update_bits(pwrkey->regmap,
   265						   pwrkey->baseaddr + PON_DBC_CTL,
   266						   PON_DBC_DELAY_MASK,
   267						   req_delay);
   268			if (error) {
   269				dev_err(&pdev->dev, "failed to set debounce: %d\n",
   270					error);
   271				return error;
   272			}
   273		}
   274	
   275		if (pwrkey->data->pull_up_bit) {
   276			error = regmap_update_bits(pwrkey->regmap,
   277						   pwrkey->baseaddr + PON_PULL_CTL,
   278						   pwrkey->data->pull_up_bit,
   279						   pull_up ? pwrkey->data->pull_up_bit :
   280							     0);
   281			if (error) {
   282				dev_err(&pdev->dev, "failed to set pull: %d\n", error);
   283				return error;
   284			}
   285		}
   286	
   287		error = devm_request_threaded_irq(&pdev->dev, pwrkey->irq,
   288						  NULL, pm8941_pwrkey_irq,
   289						  IRQF_ONESHOT,
   290						  pwrkey->data->name, pwrkey);
   291		if (error) {
   292			dev_err(&pdev->dev, "failed requesting IRQ: %d\n", error);
   293			return error;
   294		}
   295	
   296		error = input_register_device(pwrkey->input);
   297		if (error) {
   298			dev_err(&pdev->dev, "failed to register input device: %d\n",
   299				error);
   300			return error;
   301		}
   302	
   303		if (pwrkey->data->supports_ps_hold_poff_config) {
   304			pwrkey->reboot_notifier.notifier_call = pm8941_reboot_notify;
   305			error = register_reboot_notifier(&pwrkey->reboot_notifier);
   306			if (error) {
   307				dev_err(&pdev->dev, "failed to register reboot notifier: %d\n",
   308					error);
   309				return error;
   310			}
   311		}
   312	
   313		platform_set_drvdata(pdev, pwrkey);
   314		device_init_wakeup(&pdev->dev, 1);
   315	
   316		return 0;
   317	}
   318	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
