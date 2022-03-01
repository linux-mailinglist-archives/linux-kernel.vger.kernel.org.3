Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A364C8B49
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiCAMMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiCAMMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:12:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1177F7C7A4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646136688; x=1677672688;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uj5sc++QVz/F+wkCeTHqry3yPvtFGaqcbyp4J5mvpns=;
  b=AHgQZ2r4iQvdMLr0V714iDABZcTKODMlUQ7s+WwIxe862EZPLn0dCWhF
   nQ/GSyhXNg5g6TRIz8jZklWIiGIynAOeK0XWRH6pMJ2Ucz6xMpAViD6mT
   IP9Rcl/99xglvhjVQbdHmC7xWDMsC61OmSu3ITaLjOuoIzSJjJV9P4Bwx
   nh6eVqOJy5+ct3Tvbd9fPuGccwxEr9uUlFqmxNsX9JpYYFrMsc1xpOZ2v
   0kpTlZ+5+uFTJ4CH1PrOIMjLyMoBt0zDiQMUkOpC9DMmHUHr4vq3NUmKB
   f1ffQuakBndd3OQGLrsTNHa1qc1FC7SXGF9uZVN9ugNQuxDGzNP9cRIxE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316331702"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="316331702"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 04:11:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="709032440"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2022 04:11:25 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP1Lh-0000O6-0X; Tue, 01 Mar 2022 12:11:25 +0000
Date:   Tue, 1 Mar 2022 20:11:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 272/379] lib/vsprintf.c:991:13: warning: variable
 'modbuildid' set but not used
Message-ID: <202203012040.uFWGm3My-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   a46912c14343fd3269cc133494988af90b377d9f
commit: b314f622e664eb263ea03ef7f4580e37146f123f [272/379] kallsyms: enhance %pS/s/b printing when KALLSYSMS is disabled
config: arm-eseries_pxa_defconfig (https://download.01.org/0day-ci/archive/20220301/202203012040.uFWGm3My-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/hnaz/linux-mm/commit/b314f622e664eb263ea03ef7f4580e37146f123f
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout b314f622e664eb263ea03ef7f4580e37146f123f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/vsprintf.c: In function 'sprint_module_info':
>> lib/vsprintf.c:991:13: warning: variable 'modbuildid' set but not used [-Wunused-but-set-variable]
     991 |         int modbuildid = 0;
         |             ^~~~~~~~~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1759:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1759 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~


vim +/modbuildid +991 lib/vsprintf.c

   981	
   982	#if !defined(CONFIG_KALLSYMS) && defined(CONFIG_MODULES)
   983	static int sprint_module_info(char *buf, char *end, unsigned long value,
   984				     const char *fmt)
   985	{
   986		struct module *mod;
   987		unsigned long offset = 1;
   988		unsigned long base;
   989		int ret = 0;
   990		const char *modname;
 > 991		int modbuildid = 0;
   992		int len;
   993	#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
   994		const unsigned char *buildid = NULL;
   995	#endif
   996	
   997		if (is_ksym_addr(value))
   998			return 0;
   999	
  1000		if (*fmt == 'B' && fmt[1] == 'b')
  1001			modbuildid = 1;
  1002		else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
  1003			modbuildid = 1;
  1004		else if (*fmt != 's') {
  1005			/*
  1006			 * do nothing.
  1007			 */
  1008		} else
  1009			offset = 0;
  1010	
  1011		preempt_disable();
  1012		mod = __module_address(value);
  1013		if (mod) {
  1014			ret = 1;
  1015			modname = mod->name;
  1016	#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
  1017			if (modbuildid)
  1018				buildid = mod->build_id;
  1019	#endif
  1020			if (offset) {
  1021				base = (unsigned long)mod->core_layout.base;
  1022				offset = value - base;
  1023			}
  1024		}
  1025	
  1026		preempt_enable();
  1027		if (!ret)
  1028			return 0;
  1029	
  1030		/* address belongs to module */
  1031		if (offset)
  1032			len = sprintf(buf, "0x%lx+0x%lx", base, offset);
  1033		else
  1034			len = sprintf(buf, "0x%lx", value);
  1035	
  1036		len += sprintf(buf + len, " [%s", modname);
  1037	#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
  1038		if (modbuildid && buildid) {
  1039			/* build ID should match length of sprintf */
  1040			static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
  1041			len += sprintf(buf + len, " %20phN", buildid);
  1042		}
  1043	#endif
  1044		len += sprintf(buf + len, "]");
  1045	
  1046		return len;
  1047	}
  1048	#else
  1049	static inline int sprint_module_info(char *buf, char *end, unsigned long value,
  1050				     const char *fmt)
  1051	{
  1052		return 0;
  1053	}
  1054	#endif
  1055	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
