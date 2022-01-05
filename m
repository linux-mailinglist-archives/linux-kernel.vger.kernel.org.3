Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FE7485B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244963AbiAEW2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:28:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:51551 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244956AbiAEW2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641421692; x=1672957692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6LIBXyaKFJEHPtRwlnepVZes39DKURgaN+zkOlHhy5M=;
  b=itTYGYP7HGjB6JtNrnbcZrAJvLH/8snqKbnaEObiHh8cFfYA0WsZH96O
   pywFiIRsyuKvgfRROIbpQKiFizNL6wm4PrAW/yupwlAouR/9JVu9rh+tM
   nog4/jPe/et3aYOkE/cotTVa0DQ6YGHZF3+BBfGocA+mxzopkO2UeIIMz
   /N4DhhAFMDjyeZPr0OGd/4yTra0rBLxO7hyZQv06KTetJ/3kcOLyzBvLp
   ZzSJKyZUN9exT8E2bX7d4YtAf8L6kn8bq1EmSOy5SVWMK4tQZvJDyOtxJ
   htd+u6AGUujV19kJ5cj+STtlIih3UPpE/GJ1CqazrAVWBltuJHVhhTJsw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229870981"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="229870981"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 14:27:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="470732360"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2022 14:27:55 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5El8-000H5a-Vi; Wed, 05 Jan 2022 22:27:54 +0000
Date:   Thu, 6 Jan 2022 06:27:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v2 2/2] hwmon: Add "label" attribute
Message-ID: <202201060630.vsp02mfB-lkp@intel.com>
References: <20220105151551.20285-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105151551.20285-3-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I love your patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Paul-Cercueil/hwmon-Add-label-attribute-v2/20220105-231930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: arm64-randconfig-r026-20220105 (https://download.01.org/0day-ci/archive/20220106/202201060630.vsp02mfB-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/57dab49995d01d638d9fa9aaddb5fa48e17b3c48
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Paul-Cercueil/hwmon-Add-label-attribute-v2/20220105-231930
        git checkout 57dab49995d01d638d9fa9aaddb5fa48e17b3c48
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwmon/hwmon.c:777:7: warning: variable 'hdev' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (hwdev->label == NULL) {
                       ^~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/hwmon.c:851:20: note: uninitialized use occurs here
           hwmon_dev_release(hdev);
                             ^~~~
   drivers/hwmon/hwmon.c:777:3: note: remove the 'if' if its condition is always false
                   if (hwdev->label == NULL) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/hwmon.c:773:7: warning: variable 'hdev' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (err < 0)
                       ^~~~~~~
   drivers/hwmon/hwmon.c:851:20: note: uninitialized use occurs here
           hwmon_dev_release(hdev);
                             ^~~~
   drivers/hwmon/hwmon.c:773:3: note: remove the 'if' if its condition is always false
                   if (err < 0)
                   ^~~~~~~~~~~~
   drivers/hwmon/hwmon.c:752:21: note: initialize the variable 'hdev' to silence this warning
           struct device *hdev;
                              ^
                               = NULL
   2 warnings generated.


vim +777 drivers/hwmon/hwmon.c

   744	
   745	static struct device *
   746	__hwmon_device_register(struct device *dev, const char *name, void *drvdata,
   747				const struct hwmon_chip_info *chip,
   748				const struct attribute_group **groups)
   749	{
   750		struct hwmon_device *hwdev;
   751		const char *label;
   752		struct device *hdev;
   753		int i, err, id;
   754	
   755		/* Complain about invalid characters in hwmon name attribute */
   756		if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
   757			dev_warn(dev,
   758				 "hwmon: '%s' is not a valid name attribute, please fix\n",
   759				 name);
   760	
   761		id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
   762		if (id < 0)
   763			return ERR_PTR(id);
   764	
   765		hwdev = kzalloc(sizeof(*hwdev), GFP_KERNEL);
   766		if (hwdev == NULL) {
   767			err = -ENOMEM;
   768			goto ida_remove;
   769		}
   770	
   771		if (device_property_present(dev, "label")) {
   772			err = device_property_read_string(dev, "label", &label);
   773			if (err < 0)
   774				goto free_hwmon;
   775	
   776			hwdev->label = kstrdup(label, GFP_KERNEL);
 > 777			if (hwdev->label == NULL) {
   778				err = -ENOMEM;
   779				goto free_hwmon;
   780			}
   781		}
   782	
   783		hdev = &hwdev->dev;
   784	
   785		if (chip) {
   786			struct attribute **attrs;
   787			int ngroups = 2; /* terminating NULL plus &hwdev->groups */
   788	
   789			if (groups)
   790				for (i = 0; groups[i]; i++)
   791					ngroups++;
   792	
   793			hwdev->groups = kcalloc(ngroups, sizeof(*groups), GFP_KERNEL);
   794			if (!hwdev->groups) {
   795				err = -ENOMEM;
   796				goto free_hwmon;
   797			}
   798	
   799			attrs = __hwmon_create_attrs(drvdata, chip);
   800			if (IS_ERR(attrs)) {
   801				err = PTR_ERR(attrs);
   802				goto free_hwmon;
   803			}
   804	
   805			hwdev->group.attrs = attrs;
   806			ngroups = 0;
   807			hwdev->groups[ngroups++] = &hwdev->group;
   808	
   809			if (groups) {
   810				for (i = 0; groups[i]; i++)
   811					hwdev->groups[ngroups++] = groups[i];
   812			}
   813	
   814			hdev->groups = hwdev->groups;
   815		} else {
   816			hdev->groups = groups;
   817		}
   818	
   819		hwdev->name = name;
   820		hdev->class = &hwmon_class;
   821		hdev->parent = dev;
   822		hdev->of_node = dev ? dev->of_node : NULL;
   823		hwdev->chip = chip;
   824		dev_set_drvdata(hdev, drvdata);
   825		dev_set_name(hdev, HWMON_ID_FORMAT, id);
   826		err = device_register(hdev);
   827		if (err) {
   828			put_device(hdev);
   829			goto ida_remove;
   830		}
   831	
   832		INIT_LIST_HEAD(&hwdev->tzdata);
   833	
   834		if (dev && dev->of_node && chip && chip->ops->read &&
   835		    chip->info[0]->type == hwmon_chip &&
   836		    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
   837			err = hwmon_thermal_register_sensors(hdev);
   838			if (err) {
   839				device_unregister(hdev);
   840				/*
   841				 * Don't worry about hwdev; hwmon_dev_release(), called
   842				 * from device_unregister(), will free it.
   843				 */
   844				goto ida_remove;
   845			}
   846		}
   847	
   848		return hdev;
   849	
   850	free_hwmon:
   851		hwmon_dev_release(hdev);
   852	ida_remove:
   853		ida_simple_remove(&hwmon_ida, id);
   854		return ERR_PTR(err);
   855	}
   856	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
