Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC575863C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbiHAFfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiHAFfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:35:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A7F658C
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659332118; x=1690868118;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1/iKmCkIFOQ0dYoXXS8AZYAS8nYULrvaRFqzGxjODqM=;
  b=d43ZV4yVlzjWWRdlscqd4tZWKJOzip1OdKn6N3udIfEdVZ4GjUjnKPTW
   hQqMVZJGe3pmrc/8nDXwkvV1MHs8b0nOBRVbJ6XKVqVKH/xP/b4GY+CZs
   cMG0Br55iYNJyVZ/eNvmP6DXxddjsfXVHRlor9aVVPIwBtPoVxz/qqG/d
   0ryzRtiVAQ3yTlNUc4Kytd7YBiqNKSEf9oGZ4DCOUjkmUC+tNhbZjV5dH
   u2NGHiw0h2zgCimCiqP3RVUsNlbliLRjME9Wx0i2ejKv9MPNKmVDyPyqz
   9JQ/Kv9WMxopopxl4H7P45zC7vZw6sjPSvs4jgxc+hN8bUwaRQBXzX9Pr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="375369999"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375369999"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 22:35:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="929423711"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2022 22:35:16 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIO5D-000Eop-2D;
        Mon, 01 Aug 2022 05:35:15 +0000
Date:   Mon, 1 Aug 2022 13:35:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [thermal:thermal/linux-next 68/68]
 drivers/thermal/rcar_thermal.c:532:49: error: passing argument 4 of
 'devm_thermal_of_zone_register' from incompatible pointer type
Message-ID: <202208011342.io34XfQd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git thermal/linux-next
head:   f0105ae57fe7c05fb82b7c0a6416a34051d29a34
commit: f0105ae57fe7c05fb82b7c0a6416a34051d29a34 [68/68] thermal/of: Remove old OF code
config: microblaze-randconfig-s033-20220731 (https://download.01.org/0day-ci/archive/20220801/202208011342.io34XfQd-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?id=f0105ae57fe7c05fb82b7c0a6416a34051d29a34
        git remote add thermal git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
        git fetch --no-tags thermal thermal/linux-next
        git checkout f0105ae57fe7c05fb82b7c0a6416a34051d29a34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/thermal/rcar_thermal.c:20:
   include/linux/thermal.h:319:73: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     319 |                                                      void *data, struct thermal_sensor_ops *ops)
         |                                                                         ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:326:78: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                              ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:335:20: error: redefinition of 'thermal_of_zone_unregister'
     335 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:331:20: note: previous definition of 'thermal_of_zone_unregister' with type 'void(struct thermal_zone_device *)'
     331 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:343:20: error: redefinition of 'devm_thermal_of_zone_unregister'
     343 | static inline void devm_thermal_of_zone_unregister(struct device *dev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:339:20: note: previous definition of 'devm_thermal_of_zone_unregister' with type 'void(struct device *, struct thermal_zone_device *)'
     339 | static inline void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/rcar_thermal.c: In function 'rcar_thermal_probe':
>> drivers/thermal/rcar_thermal.c:532:49: error: passing argument 4 of 'devm_thermal_of_zone_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
     532 |                                                 &rcar_thermal_zone_of_ops);
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                 |
         |                                                 struct thermal_zone_device_ops *
   include/linux/thermal.h:326:98: note: expected 'struct thermal_sensor_ops *' but argument is of type 'struct thermal_zone_device_ops *'
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/thermal/rcar_gen3_thermal.c:18:
   include/linux/thermal.h:319:73: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     319 |                                                      void *data, struct thermal_sensor_ops *ops)
         |                                                                         ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:326:78: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                              ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:335:20: error: redefinition of 'thermal_of_zone_unregister'
     335 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:331:20: note: previous definition of 'thermal_of_zone_unregister' with type 'void(struct thermal_zone_device *)'
     331 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:343:20: error: redefinition of 'devm_thermal_of_zone_unregister'
     343 | static inline void devm_thermal_of_zone_unregister(struct device *dev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:339:20: note: previous definition of 'devm_thermal_of_zone_unregister' with type 'void(struct device *, struct thermal_zone_device *)'
     339 | static inline void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/rcar_gen3_thermal.c: In function 'rcar_gen3_thermal_probe':
>> drivers/thermal/rcar_gen3_thermal.c:508:54: error: passing argument 4 of 'devm_thermal_of_zone_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
     508 |                                                      &rcar_gen3_tz_of_ops);
         |                                                      ^~~~~~~~~~~~~~~~~~~~
         |                                                      |
         |                                                      struct thermal_zone_device_ops *
   include/linux/thermal.h:326:98: note: expected 'struct thermal_sensor_ops *' but argument is of type 'struct thermal_zone_device_ops *'
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/thermal/armada_thermal.c:16:
   include/linux/thermal.h:319:73: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     319 |                                                      void *data, struct thermal_sensor_ops *ops)
         |                                                                         ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:326:78: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                              ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:335:20: error: redefinition of 'thermal_of_zone_unregister'
     335 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:331:20: note: previous definition of 'thermal_of_zone_unregister' with type 'void(struct thermal_zone_device *)'
     331 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:343:20: error: redefinition of 'devm_thermal_of_zone_unregister'
     343 | static inline void devm_thermal_of_zone_unregister(struct device *dev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:339:20: note: previous definition of 'devm_thermal_of_zone_unregister' with type 'void(struct device *, struct thermal_zone_device *)'
     339 | static inline void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/armada_thermal.c: In function 'armada_thermal_probe':
>> drivers/thermal/armada_thermal.c:933:52: error: passing argument 4 of 'devm_thermal_of_zone_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
     933 |                                                    &of_ops);
         |                                                    ^~~~~~~
         |                                                    |
         |                                                    const struct thermal_zone_device_ops *
   include/linux/thermal.h:326:98: note: expected 'struct thermal_sensor_ops *' but argument is of type 'const struct thermal_zone_device_ops *'
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/thermal/max77620_thermal.c:19:
   include/linux/thermal.h:319:73: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     319 |                                                      void *data, struct thermal_sensor_ops *ops)
         |                                                                         ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:326:78: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                              ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:335:20: error: redefinition of 'thermal_of_zone_unregister'
     335 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:331:20: note: previous definition of 'thermal_of_zone_unregister' with type 'void(struct thermal_zone_device *)'
     331 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:343:20: error: redefinition of 'devm_thermal_of_zone_unregister'
     343 | static inline void devm_thermal_of_zone_unregister(struct device *dev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:339:20: note: previous definition of 'devm_thermal_of_zone_unregister' with type 'void(struct device *, struct thermal_zone_device *)'
     339 | static inline void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/max77620_thermal.c: In function 'max77620_thermal_probe':
>> drivers/thermal/max77620_thermal.c:118:41: error: passing argument 4 of 'devm_thermal_of_zone_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
     118 |                                 mtherm, &max77620_thermal_ops);
         |                                         ^~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         const struct thermal_zone_device_ops *
   include/linux/thermal.h:326:98: note: expected 'struct thermal_sensor_ops *' but argument is of type 'const struct thermal_zone_device_ops *'
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/thermal/thermal_core.h:13,
                    from drivers/thermal/hisi_thermal.c:28:
   include/linux/thermal.h:319:73: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     319 |                                                      void *data, struct thermal_sensor_ops *ops)
         |                                                                         ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:326:78: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                              ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:335:20: error: redefinition of 'thermal_of_zone_unregister'
     335 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:331:20: note: previous definition of 'thermal_of_zone_unregister' with type 'void(struct thermal_zone_device *)'
     331 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:343:20: error: redefinition of 'devm_thermal_of_zone_unregister'
     343 | static inline void devm_thermal_of_zone_unregister(struct device *dev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:339:20: note: previous definition of 'devm_thermal_of_zone_unregister' with type 'void(struct device *, struct thermal_zone_device *)'
     339 | static inline void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/hisi_thermal.c: In function 'hisi_thermal_register_sensor':
>> drivers/thermal/hisi_thermal.c:497:53: error: passing argument 4 of 'devm_thermal_of_zone_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
     497 |                                                     &hisi_of_thermal_ops);
         |                                                     ^~~~~~~~~~~~~~~~~~~~
         |                                                     |
         |                                                     const struct thermal_zone_device_ops *
   include/linux/thermal.h:326:98: note: expected 'struct thermal_sensor_ops *' but argument is of type 'const struct thermal_zone_device_ops *'
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/thermal/broadcom/ns-thermal.c:9:
   include/linux/thermal.h:319:73: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     319 |                                                      void *data, struct thermal_sensor_ops *ops)
         |                                                                         ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:326:78: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                              ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:335:20: error: redefinition of 'thermal_of_zone_unregister'
     335 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:331:20: note: previous definition of 'thermal_of_zone_unregister' with type 'void(struct thermal_zone_device *)'
     331 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:343:20: error: redefinition of 'devm_thermal_of_zone_unregister'
     343 | static inline void devm_thermal_of_zone_unregister(struct device *dev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:339:20: note: previous definition of 'devm_thermal_of_zone_unregister' with type 'void(struct device *, struct thermal_zone_device *)'
     339 | static inline void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/broadcom/ns-thermal.c: In function 'ns_thermal_probe':
>> drivers/thermal/broadcom/ns-thermal.c:57:44: error: passing argument 4 of 'devm_thermal_of_zone_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
      57 |                                            &ns_thermal_ops);
         |                                            ^~~~~~~~~~~~~~~
         |                                            |
         |                                            const struct thermal_zone_device_ops *
   include/linux/thermal.h:326:98: note: expected 'struct thermal_sensor_ops *' but argument is of type 'const struct thermal_zone_device_ops *'
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/thermal/broadcom/sr-thermal.c:9:
   include/linux/thermal.h:319:73: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     319 |                                                      void *data, struct thermal_sensor_ops *ops)
         |                                                                         ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:326:78: warning: 'struct thermal_sensor_ops' declared inside parameter list will not be visible outside of this definition or declaration
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                              ^~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:335:20: error: redefinition of 'thermal_of_zone_unregister'
     335 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:331:20: note: previous definition of 'thermal_of_zone_unregister' with type 'void(struct thermal_zone_device *)'
     331 | static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:343:20: error: redefinition of 'devm_thermal_of_zone_unregister'
     343 | static inline void devm_thermal_of_zone_unregister(struct device *dev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thermal.h:339:20: note: previous definition of 'devm_thermal_of_zone_unregister' with type 'void(struct device *, struct thermal_zone_device *)'
     339 | static inline void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/broadcom/sr-thermal.c: In function 'sr_thermal_probe':
>> drivers/thermal/broadcom/sr-thermal.c:88:52: error: passing argument 4 of 'devm_thermal_of_zone_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
      88 |                                                    &sr_tz_ops);
         |                                                    ^~~~~~~~~~
         |                                                    |
         |                                                    const struct thermal_zone_device_ops *
   include/linux/thermal.h:326:98: note: expected 'struct thermal_sensor_ops *' but argument is of type 'const struct thermal_zone_device_ops *'
     326 |                                                           void *data, struct thermal_sensor_ops *ops)
         |                                                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/devm_thermal_of_zone_register +532 drivers/thermal/rcar_thermal.c

84f0e490bee068 Kuninori Morimoto     2015-11-10  435  
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  436  static int rcar_thermal_probe(struct platform_device *pdev)
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  437  {
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  438  	struct rcar_thermal_common *common;
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  439  	struct rcar_thermal_priv *priv;
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  440  	struct device *dev = &pdev->dev;
3277e022a1c31f Lad Prabhakar         2022-01-10  441  	struct resource *res;
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  442  	const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  443  	int mres = 0;
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  444  	int i;
fb84d9907f0ff0 Devendra Naga         2013-03-04  445  	int ret = -ENODEV;
e0a5172e9eec7f Kuninori Morimoto     2013-01-31  446  	int idle = IDLE_INTERVAL;
11313746547015 Yoshihiro Shimoda     2015-01-07  447  	u32 enr_bits = 0;
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  448  
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  449  	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
b0a60d88d60b92 Jingoo Han            2014-05-07  450  	if (!common)
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  451  		return -ENOMEM;
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  452  
84f0e490bee068 Kuninori Morimoto     2015-11-10  453  	platform_set_drvdata(pdev, common);
84f0e490bee068 Kuninori Morimoto     2015-11-10  454  
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  455  	INIT_LIST_HEAD(&common->head);
e0a5172e9eec7f Kuninori Morimoto     2013-01-31  456  	spin_lock_init(&common->lock);
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  457  	common->dev = dev;
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  458  
51d45d25948bdf Kuninori Morimoto     2013-03-26  459  	pm_runtime_enable(dev);
51d45d25948bdf Kuninori Morimoto     2013-03-26  460  	pm_runtime_get_sync(dev);
51d45d25948bdf Kuninori Morimoto     2013-03-26  461  
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  462  	for (i = 0; i < chip->nirqs; i++) {
3277e022a1c31f Lad Prabhakar         2022-01-10  463  		int irq;
3277e022a1c31f Lad Prabhakar         2022-01-10  464  
3277e022a1c31f Lad Prabhakar         2022-01-10  465  		ret = platform_get_irq_optional(pdev, i);
3277e022a1c31f Lad Prabhakar         2022-01-10  466  		if (ret < 0 && ret != -ENXIO)
3277e022a1c31f Lad Prabhakar         2022-01-10  467  			goto error_unregister;
3277e022a1c31f Lad Prabhakar         2022-01-10  468  		if (ret > 0)
3277e022a1c31f Lad Prabhakar         2022-01-10  469  			irq = ret;
3277e022a1c31f Lad Prabhakar         2022-01-10  470  		else
3277e022a1c31f Lad Prabhakar         2022-01-10  471  			break;
3277e022a1c31f Lad Prabhakar         2022-01-10  472  
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  473  		if (!common->base) {
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  474  			/*
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  475  			 * platform has IRQ support.
ee853addd9fedb Geert Uytterhoeven    2015-01-12  476  			 * Then, driver uses common registers
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  477  			 * rcar_has_irq_support() will be enabled
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  478  			 */
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  479  			res = platform_get_resource(pdev, IORESOURCE_MEM,
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  480  						    mres++);
5095526faf3847 Sachin Kamat          2013-03-04  481  			common->base = devm_ioremap_resource(dev, res);
39056e8a989ef5 Niklas Söderlund      2020-03-10  482  			if (IS_ERR(common->base)) {
39056e8a989ef5 Niklas Söderlund      2020-03-10  483  				ret = PTR_ERR(common->base);
39056e8a989ef5 Niklas Söderlund      2020-03-10  484  				goto error_unregister;
39056e8a989ef5 Niklas Söderlund      2020-03-10  485  			}
e0a5172e9eec7f Kuninori Morimoto     2013-01-31  486  
6fe495e0f80ebe Geert Uytterhoeven    2014-01-07  487  			idle = 0; /* polling delay is not needed */
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  488  		}
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  489  
3277e022a1c31f Lad Prabhakar         2022-01-10  490  		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  491  				       IRQF_SHARED, dev_name(dev), common);
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  492  		if (ret) {
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  493  			dev_err(dev, "irq request failed\n ");
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  494  			goto error_unregister;
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  495  		}
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  496  
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  497  		/* update ENR bits */
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  498  		if (chip->irq_per_ch)
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  499  			enr_bits |= 1 << i;
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  500  	}
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  501  
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  502  	for (i = 0;; i++) {
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  503  		res = platform_get_resource(pdev, IORESOURCE_MEM, mres++);
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  504  		if (!res)
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  505  			break;
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  506  
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  507  		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  508  		if (!priv) {
1dc20828e674a7 Kuninori Morimoto     2013-03-26  509  			ret = -ENOMEM;
1dc20828e674a7 Kuninori Morimoto     2013-03-26  510  			goto error_unregister;
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  511  		}
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  512  
5095526faf3847 Sachin Kamat          2013-03-04  513  		priv->base = devm_ioremap_resource(dev, res);
1dc20828e674a7 Kuninori Morimoto     2013-03-26  514  		if (IS_ERR(priv->base)) {
1dc20828e674a7 Kuninori Morimoto     2013-03-26  515  			ret = PTR_ERR(priv->base);
1dc20828e674a7 Kuninori Morimoto     2013-03-26  516  			goto error_unregister;
1dc20828e674a7 Kuninori Morimoto     2013-03-26  517  		}
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  518  
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  519  		priv->common = common;
e0a5172e9eec7f Kuninori Morimoto     2013-01-31  520  		priv->id = i;
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  521  		priv->chip = chip;
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  522  		mutex_init(&priv->lock);
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  523  		INIT_LIST_HEAD(&priv->list);
e0a5172e9eec7f Kuninori Morimoto     2013-01-31  524  		INIT_DELAYED_WORK(&priv->work, rcar_thermal_work);
a1ade5653804b8 Kuninori Morimoto     2015-12-15  525  		ret = rcar_thermal_update_temp(priv);
a1ade5653804b8 Kuninori Morimoto     2015-12-15  526  		if (ret < 0)
a1ade5653804b8 Kuninori Morimoto     2015-12-15  527  			goto error_unregister;
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  528  
392573b73ee337 Geert Uytterhoeven    2020-08-19  529  		if (chip->use_of_thermal) {
b5177e394349c6 Daniel Lezcano        2022-07-27  530  			priv->zone = devm_thermal_of_zone_register(
8b477ea56383dc Kuninori Morimoto     2016-01-28  531  						dev, i, priv,
8b477ea56383dc Kuninori Morimoto     2016-01-28 @532  						&rcar_thermal_zone_of_ops);
392573b73ee337 Geert Uytterhoeven    2020-08-19  533  		} else {
8b477ea56383dc Kuninori Morimoto     2016-01-28  534  			priv->zone = thermal_zone_device_register(
8b477ea56383dc Kuninori Morimoto     2016-01-28  535  						"rcar_thermal",
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  536  						1, 0, priv,
d2a73e225d113f Kuninori Morimoto     2012-12-02  537  						&rcar_thermal_zone_ops, NULL, 0,
e0a5172e9eec7f Kuninori Morimoto     2013-01-31  538  						idle);
bbcf90c0646ac7 Andrzej Pietrasiewicz 2020-06-29  539  
bbcf90c0646ac7 Andrzej Pietrasiewicz 2020-06-29  540  			ret = thermal_zone_device_enable(priv->zone);
bbcf90c0646ac7 Andrzej Pietrasiewicz 2020-06-29  541  			if (ret) {
bbcf90c0646ac7 Andrzej Pietrasiewicz 2020-06-29  542  				thermal_zone_device_unregister(priv->zone);
bbcf90c0646ac7 Andrzej Pietrasiewicz 2020-06-29  543  				priv->zone = ERR_PTR(ret);
bbcf90c0646ac7 Andrzej Pietrasiewicz 2020-06-29  544  			}
bbcf90c0646ac7 Andrzej Pietrasiewicz 2020-06-29  545  		}
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  546  		if (IS_ERR(priv->zone)) {
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  547  			dev_err(dev, "can't register thermal zone\n");
fb84d9907f0ff0 Devendra Naga         2013-03-04  548  			ret = PTR_ERR(priv->zone);
87260d3f7aecba Dirk Behme            2016-04-21  549  			priv->zone = NULL;
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  550  			goto error_unregister;
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  551  		}
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  552  
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  553  		if (chip->use_of_thermal) {
64a411e8042ed0 Kuninori Morimoto     2016-07-19  554  			/*
64a411e8042ed0 Kuninori Morimoto     2016-07-19  555  			 * thermal_zone doesn't enable hwmon as default,
64a411e8042ed0 Kuninori Morimoto     2016-07-19  556  			 * but, enable it here to keep compatible
64a411e8042ed0 Kuninori Morimoto     2016-07-19  557  			 */
64a411e8042ed0 Kuninori Morimoto     2016-07-19  558  			priv->zone->tzp->no_hwmon = false;
64a411e8042ed0 Kuninori Morimoto     2016-07-19  559  			ret = thermal_add_hwmon_sysfs(priv->zone);
64a411e8042ed0 Kuninori Morimoto     2016-07-19  560  			if (ret)
64a411e8042ed0 Kuninori Morimoto     2016-07-19  561  				goto error_unregister;
64a411e8042ed0 Kuninori Morimoto     2016-07-19  562  		}
64a411e8042ed0 Kuninori Morimoto     2016-07-19  563  
e0a5172e9eec7f Kuninori Morimoto     2013-01-31  564  		rcar_thermal_irq_enable(priv);
1dc20828e674a7 Kuninori Morimoto     2013-03-26  565  
1dc20828e674a7 Kuninori Morimoto     2013-03-26  566  		list_move_tail(&priv->list, &common->head);
11313746547015 Yoshihiro Shimoda     2015-01-07  567  
11313746547015 Yoshihiro Shimoda     2015-01-07  568  		/* update ENR bits */
1969d9dc2079e4 Yoshihiro Kaneko      2018-05-20  569  		if (!chip->irq_per_ch)
11313746547015 Yoshihiro Shimoda     2015-01-07  570  			enr_bits |= 3 << (i * 8);
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  571  	}
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  572  
542cdf40680494 Simon Horman          2018-07-24  573  	if (common->base && enr_bits)
11313746547015 Yoshihiro Shimoda     2015-01-07  574  		rcar_thermal_common_write(common, ENR, enr_bits);
11313746547015 Yoshihiro Shimoda     2015-01-07  575  
3db46c939677e3 Laurent Pinchart      2013-05-14  576  	dev_info(dev, "%d sensor probed\n", i);
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  577  
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  578  	return 0;
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  579  
3676d1dd3d3069 Kuninori Morimoto     2013-01-31  580  error_unregister:
84f0e490bee068 Kuninori Morimoto     2015-11-10  581  	rcar_thermal_remove(pdev);
51d45d25948bdf Kuninori Morimoto     2013-03-26  582  
fb84d9907f0ff0 Devendra Naga         2013-03-04  583  	return ret;
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  584  }
1e426ffddf2f15 Kuninori Morimoto     2012-07-21  585  

:::::: The code at line 532 was first introduced by commit
:::::: 8b477ea56383dc8b838f1f8b506e4571c14ceb30 thermal: rcar: enable to use thermal-zone on DT

:::::: TO: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
:::::: CC: Eduardo Valentin <edubezval@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
