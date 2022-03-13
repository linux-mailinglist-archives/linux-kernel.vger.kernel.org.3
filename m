Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6B4D7588
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 14:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiCMNpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 09:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiCMNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 09:45:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5481EC6B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647179040; x=1678715040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JvKVg4wcPKmea1ASVxtdL9JeUS9CzbdD+MPD6OtB+z4=;
  b=Dltkmgyfun882SdWh9DaiXUGR3oUmNrIYz+NqSjHI7Exz09WUxb3cEKw
   KgEn3+hdu58GrnmJIev7dlipe4T5bHrjjHIa/2NViTtxtdLlqhtRulaMu
   Fqb+5Ps1g8MACIrbI4zGECY+dS/paBfeVhB9WOY3tDMKVNnkkhLPIyfeJ
   Dk9xA/1zgkk71dy6HCp01P5QPU4H6pDL+7idoX+8jbLNaZ3xTt72EP35X
   Cj8ybpPmMGwmW2dEtncsli7nJvqZsbPncGEES5plH5xHH8yY/+gY4lYDh
   0weiqYEYjugz0G/u/DJIaFdqb1x9MxwiE00IUkpanh1ydfOGirtS9yfGD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="255822355"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="255822355"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 06:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="515104015"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2022 06:43:58 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTOVp-0008zp-Jy; Sun, 13 Mar 2022 13:43:57 +0000
Date:   Sun, 13 Mar 2022 21:43:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 127/156] net/tls/tls_main.c:1061:26:
 warning: format '%lu' expects argument of type 'long unsigned int', but
 argument 5 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202203132154.1wXAIs5b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 97a450fed0d4ce4978d51685dcca85f9e8b71811 [127/156] net/tls: register '.tls' keyring
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220313/202203132154.1wXAIs5b-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=97a450fed0d4ce4978d51685dcca85f9e8b71811
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 97a450fed0d4ce4978d51685dcca85f9e8b71811
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash net/tls/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:20,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from net/tls/tls_main.c:34:
   net/tls/tls_main.c: In function 'tls_psk_identity_match':
>> net/tls/tls_main.c:1061:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1061 |                 pr_debug("%s: non-matching src %s len %lu\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:340:21: note: in definition of macro 'pr_fmt'
     340 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   net/tls/tls_main.c:1061:17: note: in expansion of macro 'pr_debug'
    1061 |                 pr_debug("%s: non-matching src %s len %lu\n",
         |                 ^~~~~~~~
   net/tls/tls_main.c:1061:57: note: format string is defined here
    1061 |                 pr_debug("%s: non-matching src %s len %lu\n",
         |                                                       ~~^
         |                                                         |
         |                                                         long unsigned int
         |                                                       %u
   In file included from include/linux/kernel.h:20,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from net/tls/tls_main.c:34:
   net/tls/tls_main.c:1075:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1075 |                 pr_debug("%s: non-matching dst %s len %lu\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:340:21: note: in definition of macro 'pr_fmt'
     340 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   net/tls/tls_main.c:1075:17: note: in expansion of macro 'pr_debug'
    1075 |                 pr_debug("%s: non-matching dst %s len %lu\n",
         |                 ^~~~~~~~
   net/tls/tls_main.c:1075:57: note: format string is defined here
    1075 |                 pr_debug("%s: non-matching dst %s len %lu\n",
         |                                                       ~~^
         |                                                         |
         |                                                         long unsigned int
         |                                                       %u
   In file included from include/linux/kernel.h:20,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from net/tls/tls_main.c:34:
   net/tls/tls_main.c:1089:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1089 |                 pr_debug("%s: non-matching port %s len %lu\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:340:21: note: in definition of macro 'pr_fmt'
     340 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   net/tls/tls_main.c:1089:17: note: in expansion of macro 'pr_debug'
    1089 |                 pr_debug("%s: non-matching port %s len %lu\n",
         |                 ^~~~~~~~
   net/tls/tls_main.c:1089:58: note: format string is defined here
    1089 |                 pr_debug("%s: non-matching port %s len %lu\n",
         |                                                        ~~^
         |                                                          |
         |                                                          long unsigned int
         |                                                        %u
   In file included from include/linux/kernel.h:20,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from net/tls/tls_main.c:34:
   net/tls/tls_main.c:1104:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1104 |         pr_debug("%s: match '%s' '%s' len %lu\n",
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:340:21: note: in definition of macro 'pr_fmt'
     340 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)


vim +1061 net/tls/tls_main.c

  1013	
  1014	static bool tls_psk_identity_match(const struct key *key,
  1015					   const struct key_match_data *match_data)
  1016	{
  1017		const char *src = key->description;
  1018		const char *dst = NULL, *port = NULL, *id = NULL;
  1019		const char *match_src, *match_dst, *match_port, *match_id;
  1020		size_t src_len, dst_len, port_len, id_len;
  1021	
  1022		dst = strchr(src, ';');
  1023		id_len = strlen(src);
  1024		if (dst) {
  1025			src_len = dst - src;
  1026			if (!src_len)
  1027				src = NULL;
  1028			id_len -= src_len + 1;
  1029			dst++;
  1030			port = strchr(dst, ';');
  1031			if (port) {
  1032				dst_len = port - dst;
  1033				if (!dst_len)
  1034					dst = NULL;
  1035				id_len -= dst_len + 1;
  1036				port++;
  1037				id = strchr(port, ';');
  1038				if (id) {
  1039					port_len = id - port;
  1040					if (!port_len)
  1041						port = NULL;
  1042					id_len -= port_len + 1;
  1043					id++;
  1044				}
  1045			}
  1046		}
  1047		pr_debug("%s: src %s dst %s port %s\n", __func__, src, dst, port);
  1048		/* simple string-based IP address matching */
  1049		/* hare: convert to sockaddr matching */
  1050		match_src = match_data->raw_data;
  1051		match_dst = strchr(match_src, ';');
  1052		/* Parsing error */
  1053		if (!match_dst) {
  1054			pr_debug("%s: match dst missing\n", __func__);
  1055			return false;
  1056		}
  1057		match_dst++;
  1058		pr_debug("%s: match src %s\n", __func__, match_src);
  1059		if (src && (match_dst - match_src) > 0 &&
  1060		    memcmp(src, match_src, src_len)) {
> 1061			pr_debug("%s: non-matching src %s len %lu\n",
  1062				 __func__, src, src_len);
  1063				return false;
  1064		}
  1065	
  1066		match_port = strchr(match_dst, ';');
  1067		if (!match_port) {
  1068			pr_debug("%s: match port missing\n", __func__);
  1069			return false;
  1070		}
  1071		match_port++;
  1072		pr_debug("%s: match dst %s\n", __func__, match_dst);
  1073		if (dst && (match_port - match_dst) > 0 &&
  1074		    memcmp(dst, match_dst, dst_len)) {
  1075			pr_debug("%s: non-matching dst %s len %lu\n",
  1076				 __func__, dst, dst_len);
  1077			return false;
  1078		}
  1079	
  1080		match_id = strchr(match_port, ';');
  1081		if (!match_id) {
  1082			pr_debug("%s: match identity missing\n", __func__);
  1083			return false;
  1084		}
  1085		match_id++;
  1086		pr_debug("%s: match port %s\n", __func__, match_port);
  1087		if (port && (match_id - match_port) > 0 &&
  1088		    memcmp(port, match_port, port_len)) {
  1089			pr_debug("%s: non-matching port %s len %lu\n",
  1090				 __func__, port, port_len);
  1091			return false;
  1092		}
  1093	
  1094		/* No match ID specified: match agains all IDs */
  1095		if (!match_id || !strlen(match_id)) {
  1096			pr_debug("%s: match w/ no identity\n", __func__);
  1097			return true;
  1098		}
  1099		/* Match ID specified, but no key ID: no match */
  1100		if (!id) {
  1101			pr_debug("%s: no identity to match\n", __func__);
  1102			return false;
  1103		}
  1104		pr_debug("%s: match '%s' '%s' len %lu\n",
  1105			 __func__, match_id, id, id_len);
  1106		return !memcmp(id, match_id, id_len);
  1107	}
  1108	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
