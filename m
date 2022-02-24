Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ACD4C21B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiBXCWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiBXCWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:22:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865212C2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645669334; x=1677205334;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q/ad4OHSEt+J9R8R91laI6fqCULJUnXGCWiyyQbN0b4=;
  b=Hh84bXidTZGUhqnapMe3YAZKSI1HKmXQ/VPG0qAPCJckC22u0/We4tJn
   kL+1PncqJ+lrOixaRMS2TEy52KFLArKbpcA/J6ZgKFlFjIY8aZ0Oc4v2+
   jxJoI2UI5iWoKyIg2vCRA8PPmuc7ksp8xrJ4wW80x3OjNyKRPKZV1wRtt
   iy9g2cR0yq+HyeY3kpj3JtmgY36xYA4kiYGiD5xmU+PbxnwpnhC2t/RPV
   JuA27jwiJJNRahLjhISpm+F0LVxilYe4duIgEwJsPhSGjW996ah14tcOO
   yludoK15Bsf/1uQy1DgdZX+FnOkg8r/ix26YY3G6iew6J+uqhp93fvy7z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="250946093"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="250946093"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="543524072"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Feb 2022 16:46:54 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN2HV-00022Z-Qm; Thu, 24 Feb 2022 00:46:53 +0000
Date:   Thu, 24 Feb 2022 08:46:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 55/67] net/tls/tls_main.c:1062:26:
 warning: format '%lu' expects argument of type 'long unsigned int', but
 argument 5 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202202240853.dYMh2vPi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   ac729ea3c52bda460616c71d5f5fc47b2e64da6d
commit: a6fbc57802543bef21b5327858ef990508375b4c [55/67] net/tls: fixup tls identity matching
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220224/202202240853.dYMh2vPi-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=a6fbc57802543bef21b5327858ef990508375b4c
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout a6fbc57802543bef21b5327858ef990508375b4c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash net/tls/

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
   net/tls/tls_main.c: In function 'tls_identity_match':
>> net/tls/tls_main.c:1062:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1062 |                 pr_debug("%s: non-matching src %s len %lu\n",
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
   net/tls/tls_main.c:1062:17: note: in expansion of macro 'pr_debug'
    1062 |                 pr_debug("%s: non-matching src %s len %lu\n",
         |                 ^~~~~~~~
   net/tls/tls_main.c:1062:57: note: format string is defined here
    1062 |                 pr_debug("%s: non-matching src %s len %lu\n",
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
   net/tls/tls_main.c:1076:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1076 |                 pr_debug("%s: non-matching dst %s len %lu\n",
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
   net/tls/tls_main.c:1076:17: note: in expansion of macro 'pr_debug'
    1076 |                 pr_debug("%s: non-matching dst %s len %lu\n",
         |                 ^~~~~~~~
   net/tls/tls_main.c:1076:57: note: format string is defined here
    1076 |                 pr_debug("%s: non-matching dst %s len %lu\n",
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
   net/tls/tls_main.c:1090:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1090 |                 pr_debug("%s: non-matching port %s len %lu\n",
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
   net/tls/tls_main.c:1090:17: note: in expansion of macro 'pr_debug'
    1090 |                 pr_debug("%s: non-matching port %s len %lu\n",
         |                 ^~~~~~~~
   net/tls/tls_main.c:1090:58: note: format string is defined here
    1090 |                 pr_debug("%s: non-matching port %s len %lu\n",
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
   net/tls/tls_main.c:1105:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1105 |         pr_debug("%s: match '%s' '%s' len %lu\n",
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:340:21: note: in definition of macro 'pr_fmt'
     340 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)


vim +1062 net/tls/tls_main.c

  1014	
  1015	static bool tls_identity_match(const struct key *key,
  1016				       const struct key_match_data *match_data)
  1017	{
  1018		const char *src = key->description;
  1019		const char *dst = NULL, *port = NULL, *id = NULL;
  1020		const char *match_src, *match_dst, *match_port, *match_id;
  1021		size_t src_len, dst_len, port_len, id_len;
  1022	
  1023		dst = strchr(src, ';');
  1024		id_len = strlen(src);
  1025		if (dst) {
  1026			src_len = dst - src;
  1027			if (!src_len)
  1028				src = NULL;
  1029			id_len -= src_len + 1;
  1030			dst++;
  1031			port = strchr(dst, ';');
  1032			if (port) {
  1033				dst_len = port - dst;
  1034				if (!dst_len)
  1035					dst = NULL;
  1036				id_len -= dst_len + 1;
  1037				port++;
  1038				id = strchr(port, ';');
  1039				if (id) {
  1040					port_len = id - port;
  1041					if (!port_len)
  1042						port = NULL;
  1043					id_len -= port_len + 1;
  1044					id++;
  1045				}
  1046			}
  1047		}
  1048		pr_debug("%s: src %s dst %s port %s\n", __func__, src, dst, port);
  1049		/* simple string-based IP address matching */
  1050		/* hare: convert to sockaddr matching */
  1051		match_src = match_data->raw_data;
  1052		match_dst = strchr(match_src, ';');
  1053		/* Parsing error */
  1054		if (!match_dst) {
  1055			pr_debug("%s: match dst missing\n", __func__);
  1056			return false;
  1057		}
  1058		match_dst++;
  1059		pr_debug("%s: match src %s\n", __func__, match_src);
  1060		if (src && (match_dst - match_src) > 0 &&
  1061		    memcmp(src, match_src, src_len)) {
> 1062			pr_debug("%s: non-matching src %s len %lu\n",
  1063				 __func__, src, src_len);
  1064				return false;
  1065		}
  1066	
  1067		match_port = strchr(match_dst, ';');
  1068		if (!match_port) {
  1069			pr_debug("%s: match port missing\n", __func__);
  1070			return false;
  1071		}
  1072		match_port++;
  1073		pr_debug("%s: match dst %s\n", __func__, match_dst);
  1074		if (dst && (match_port - match_dst) > 0 &&
  1075		    memcmp(dst, match_dst, dst_len)) {
  1076			pr_debug("%s: non-matching dst %s len %lu\n",
  1077				 __func__, dst, dst_len);
  1078			return false;
  1079		}
  1080	
  1081		match_id = strchr(match_port, ';');
  1082		if (!match_id) {
  1083			pr_debug("%s: match identity missing\n", __func__);
  1084			return false;
  1085		}
  1086		match_id++;
  1087		pr_debug("%s: match port %s\n", __func__, match_port);
  1088		if (port && (match_id - match_port) > 0 &&
  1089		    memcmp(port, match_port, port_len)) {
  1090			pr_debug("%s: non-matching port %s len %lu\n",
  1091				 __func__, port, port_len);
  1092			return false;
  1093		}
  1094	
  1095		/* No match ID specified: match agains all IDs */
  1096		if (!match_id || !strlen(match_id)) {
  1097			pr_debug("%s: match w/ no identity\n", __func__);
  1098			return true;
  1099		}
  1100		/* Match ID specified, but no key ID: no match */
  1101		if (!id) {
  1102			pr_debug("%s: no identity to match\n", __func__);
  1103			return false;
  1104		}
  1105		pr_debug("%s: match '%s' '%s' len %lu\n",
  1106			 __func__, match_id, id, id_len);
  1107		return !memcmp(id, match_id, id_len);
  1108	}
  1109	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
