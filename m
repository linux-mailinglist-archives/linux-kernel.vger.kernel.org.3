Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DEA5775DF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 13:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiGQLIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 07:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGQLIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 07:08:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD52DE9C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 04:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658056111; x=1689592111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jroVo+XotZoc/9kkawuUXF43NgHfvLRKOsrOQW6CAIw=;
  b=mb1u/hP0XahXXQ0mPT50+AUJDNrDPUMu4X4qs3/ckRQlA6mWmZNUxCvd
   EooXMim0Y73f9L+7zndT/hIddX+kM7NxE6ZuQqvDroUFvmKqseLLtPO6x
   qjDu3Qtx994kCycz8Pe90qZia4BOKv0UDTOZEzxQxXH73MvYyr/GVSlB+
   8yzib2DkStlbwrkBrLO0lWzzX5HP32bToiBHo5nokhX2Wvu8sd3XexMyj
   TbvUhODR4nC8bP/eTV1NEQPsFIMPSoOsCsoRIUA2+5xeSkvuOYfhUHdby
   sRsxP9OlYk0PXnr1Lxhh83+4LgAQu4fbAWWAwwjSaZ/gD2R880d/nyYc5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="287195071"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="287195071"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 04:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="572067027"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Jul 2022 04:08:28 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD28S-0003Ac-B9;
        Sun, 17 Jul 2022 11:08:28 +0000
Date:   Sun, 17 Jul 2022 19:07:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     hmy <huanglin@uniontech.com>, robh+dt@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        hmy <huanglin@uniontech.com>
Subject: Re: [PATCH] FIX CONFIG_CMDLINE is not avail when kernel config line
 in grub ends with --
Message-ID: <202207171910.KLJBcWEv-lkp@intel.com>
References: <20220630043823.19242-1-huanglin@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630043823.19242-1-huanglin@uniontech.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi hmy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v5.19-rc6 next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hmy/FIX-CONFIG_CMDLINE-is-not-avail-when-kernel-config-line-in-grub-ends-with/20220630-124059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: loongarch-randconfig-c041-20220717 (https://download.01.org/0day-ci/archive/20220717/202207171910.KLJBcWEv-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a68da93a13a9544ea17147828f16894ab6cfd204
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review hmy/FIX-CONFIG_CMDLINE-is-not-avail-when-kernel-config-line-in-grub-ends-with/20220630-124059
        git checkout a68da93a13a9544ea17147828f16894ab6cfd204
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/of/fdt.c: In function 'early_init_dt_scan_chosen':
>> drivers/of/fdt.c:1192:20: error: 'data' undeclared (first use in this function); did you mean '_data'?
    1192 |         q = strstr(data, "--");
         |                    ^~~~
         |                    _data
   drivers/of/fdt.c:1192:20: note: each undeclared identifier is reported only once for each function it appears in


vim +1192 drivers/of/fdt.c

  1158	
  1159	int __init early_init_dt_scan_chosen(char *cmdline)
  1160	{
  1161		int l, node;
  1162		const char *p;
  1163		char *q;
  1164		const void *rng_seed;
  1165		const void *fdt = initial_boot_params;
  1166	
  1167		node = fdt_path_offset(fdt, "/chosen");
  1168		if (node < 0)
  1169			node = fdt_path_offset(fdt, "/chosen@0");
  1170		if (node < 0)
  1171			return -ENOENT;
  1172	
  1173		chosen_node_offset = node;
  1174	
  1175		early_init_dt_check_for_initrd(node);
  1176		early_init_dt_check_for_elfcorehdr(node);
  1177	
  1178		/* Retrieve command line */
  1179		p = of_get_flat_dt_prop(node, "bootargs", &l);
  1180		if (p != NULL && l > 0)
  1181			strlcpy(cmdline, p, min(l, COMMAND_LINE_SIZE));
  1182	
  1183		/*
  1184		 * CONFIG_CMDLINE is meant to be a default in case nothing else
  1185		 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
  1186		 * is set in which case we override whatever was found earlier.
  1187		 */
  1188	#ifdef CONFIG_CMDLINE
  1189	#if defined(CONFIG_CMDLINE_EXTEND)
  1190		strlcat(cmdline, " ", COMMAND_LINE_SIZE);
  1191		strlcat(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> 1192		q = strstr(data, "--");
  1193		if (q)
  1194			*q = '\0';
  1195	#elif defined(CONFIG_CMDLINE_FORCE)
  1196		strlcpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
  1197	#else
  1198		/* No arguments from boot loader, use kernel's  cmdl*/
  1199		if (!((char *)cmdline)[0])
  1200			strlcpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
  1201	#endif
  1202	#endif /* CONFIG_CMDLINE */
  1203	
  1204		pr_debug("Command line is: %s\n", (char *)cmdline);
  1205	
  1206		rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
  1207		if (rng_seed && l > 0) {
  1208			add_bootloader_randomness(rng_seed, l);
  1209	
  1210			/* try to clear seed so it won't be found. */
  1211			fdt_nop_property(initial_boot_params, node, "rng-seed");
  1212	
  1213			/* update CRC check value */
  1214			of_fdt_crc32 = crc32_be(~0, initial_boot_params,
  1215					fdt_totalsize(initial_boot_params));
  1216		}
  1217	
  1218		return 0;
  1219	}
  1220	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
