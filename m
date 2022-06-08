Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925CF543CF5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiFHTgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiFHTgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:36:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ABE22961E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654717007; x=1686253007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CyjqbUXPkvUjyVdmYcFeE7jxVK8Tapn71woa6bvsIW4=;
  b=IwV6g+dmsAv/yn5zuPwEdcdqRLyw42KzyZu39Y3nvWTj4ZnCHSl9nboP
   1kT1iUUkBFurpCGnhxKAZspqdWroZ5qHHRpu/lQlXzNWDWUI0JwDeHJWq
   H2mEIzu6sQvZNMMtPOXh21MbJJMXaYTb9xQvO06nf1OwjvdSRDEvCFKQn
   myufYdWBnQaMooIC0FvcrSH0WVM273/eL+PEE4L0zcuVCN6Yp8kdUtY9T
   TVjTsdkjlnPc8e/jxnN39oZnIz2/AgoQQ3yHF9mma0GYkwM2CuelZBwFv
   lbTyLlbmonmfd+1fZR/1MVQxsxbEjNsDaYe2qV6CrVi2FfUJ1VQz13fCb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="256846535"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="256846535"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 12:36:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="683521262"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2022 12:36:45 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz1Tx-000Ewj-2m;
        Wed, 08 Jun 2022 19:36:45 +0000
Date:   Thu, 9 Jun 2022 03:36:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chenbo Feng <fengc@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 110/6555]
 net/netfilter/xt_qtaguid.c:1835:27: warning: function
 'prdebug_full_state_locked' might be a candidate for 'gnu_printf' format
 attribute
Message-ID: <202206090347.2RtNCOCc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: fe6bc43a5e8411303b6096e8976d87ae052926fd [110/6555] ANDROID: netfilter: xt_qtaguid: fix the deadlock when enable DDEBUG
config: sh-randconfig-r005-20220608 (https://download.01.org/0day-ci/archive/20220609/202206090347.2RtNCOCc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/fe6bc43a5e8411303b6096e8976d87ae052926fd
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout fe6bc43a5e8411303b6096e8976d87ae052926fd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

    1812 |         MT_DEBUG("qtaguid[%d]: left %d\n", par->hooknum, res);
         |         ^~~~~~~~
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/dynamic_debug.h:126:9: note: in expansion of macro 'if'
     126 |         if (DYNAMIC_DEBUG_BRANCH(descriptor))                   \
         |         ^~
   include/linux/compiler.h:45:26: note: in expansion of macro '__branch_check__'
      45 | #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:115:9: note: in expansion of macro 'likely'
     115 |         likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
         |         ^~~~~~
   include/linux/dynamic_debug.h:126:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     126 |         if (DYNAMIC_DEBUG_BRANCH(descriptor))                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:340:9: note: in expansion of macro 'dynamic_pr_debug'
     340 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   net/netfilter/xt_qtaguid_internal.h:44:25: note: in expansion of macro 'pr_debug'
      44 |                         pr_debug(__VA_ARGS__);              \
         |                         ^~~~~~~~
   net/netfilter/xt_qtaguid_internal.h:52:23: note: in expansion of macro 'MSK_DEBUG'
      52 | #define MT_DEBUG(...) MSK_DEBUG(MDEBUG_MASK, __VA_ARGS__)
         |                       ^~~~~~~~~
   net/netfilter/xt_qtaguid.c:1812:9: note: in expansion of macro 'MT_DEBUG'
    1812 |         MT_DEBUG("qtaguid[%d]: left %d\n", par->hooknum, res);
         |         ^~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/dynamic_debug.h:126:9: note: in expansion of macro 'if'
     126 |         if (DYNAMIC_DEBUG_BRANCH(descriptor))                   \
         |         ^~
   include/linux/printk.h:340:9: note: in expansion of macro 'dynamic_pr_debug'
     340 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   net/netfilter/xt_qtaguid_internal.h:44:25: note: in expansion of macro 'pr_debug'
      44 |                         pr_debug(__VA_ARGS__);              \
         |                         ^~~~~~~~
   net/netfilter/xt_qtaguid_internal.h:52:23: note: in expansion of macro 'MSK_DEBUG'
      52 | #define MT_DEBUG(...) MSK_DEBUG(MDEBUG_MASK, __VA_ARGS__)
         |                       ^~~~~~~~~
   net/netfilter/xt_qtaguid.c:1812:9: note: in expansion of macro 'MT_DEBUG'
    1812 |         MT_DEBUG("qtaguid[%d]: left %d\n", par->hooknum, res);
         |         ^~~~~~~~
   In file included from include/linux/printk.h:336,
                    from include/linux/kernel.h:14,
                    from include/linux/bitmap.h:10,
                    from include/linux/inetdevice.h:7,
                    from net/netfilter/xt_qtaguid.c:18:
   net/netfilter/xt_qtaguid.c:1812:47: error: 'struct xt_action_param' has no member named 'hooknum'
    1812 |         MT_DEBUG("qtaguid[%d]: left %d\n", par->hooknum, res);
         |                                               ^~
   include/linux/dynamic_debug.h:128:38: note: in definition of macro 'dynamic_pr_debug'
     128 |                                    ##__VA_ARGS__);              \
         |                                      ^~~~~~~~~~~
   net/netfilter/xt_qtaguid_internal.h:44:25: note: in expansion of macro 'pr_debug'
      44 |                         pr_debug(__VA_ARGS__);              \
         |                         ^~~~~~~~
   net/netfilter/xt_qtaguid_internal.h:52:23: note: in expansion of macro 'MSK_DEBUG'
      52 | #define MT_DEBUG(...) MSK_DEBUG(MDEBUG_MASK, __VA_ARGS__)
         |                       ^~~~~~~~~
   net/netfilter/xt_qtaguid.c:1812:9: note: in expansion of macro 'MT_DEBUG'
    1812 |         MT_DEBUG("qtaguid[%d]: left %d\n", par->hooknum, res);
         |         ^~~~~~~~
   In file included from include/linux/file.h:9,
                    from net/netfilter/xt_qtaguid.c:17:
   net/netfilter/xt_qtaguid.c: In function 'prdebug_full_state_locked':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   net/netfilter/xt_qtaguid.c:1827:9: note: in expansion of macro 'if'
    1827 |         if (!unlikely(qtaguid_debug_mask & DDEBUG_MASK))
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   net/netfilter/xt_qtaguid.c:1827:14: note: in expansion of macro 'unlikely'
    1827 |         if (!unlikely(qtaguid_debug_mask & DDEBUG_MASK))
         |              ^~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   net/netfilter/xt_qtaguid.c:1827:9: note: in expansion of macro 'if'
    1827 |         if (!unlikely(qtaguid_debug_mask & DDEBUG_MASK))
         |         ^~
>> net/netfilter/xt_qtaguid.c:1835:27: warning: function 'prdebug_full_state_locked' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1835 |                           fmt_buff, args);
         |                           ^~~~~~~~
   In file included from include/linux/file.h:9,
                    from net/netfilter/xt_qtaguid.c:17:
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/dynamic_debug.h:126:9: note: in expansion of macro 'if'
     126 |         if (DYNAMIC_DEBUG_BRANCH(descriptor))                   \
         |         ^~
   include/linux/compiler.h:45:26: note: in expansion of macro '__branch_check__'
      45 | #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:115:9: note: in expansion of macro 'likely'
     115 |         likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
         |         ^~~~~~
   include/linux/dynamic_debug.h:126:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     126 |         if (DYNAMIC_DEBUG_BRANCH(descriptor))                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:340:9: note: in expansion of macro 'dynamic_pr_debug'
     340 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   net/netfilter/xt_qtaguid.c:1837:9: note: in expansion of macro 'pr_debug'
    1837 |         pr_debug("%s", buff);
         |         ^~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/dynamic_debug.h:126:9: note: in expansion of macro 'if'
     126 |         if (DYNAMIC_DEBUG_BRANCH(descriptor))                   \
         |         ^~
   include/linux/printk.h:340:9: note: in expansion of macro 'dynamic_pr_debug'
     340 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   net/netfilter/xt_qtaguid.c:1837:9: note: in expansion of macro 'pr_debug'
    1837 |         pr_debug("%s", buff);
         |         ^~~~~~~~
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/dynamic_debug.h:126:9: note: in expansion of macro 'if'
     126 |         if (DYNAMIC_DEBUG_BRANCH(descriptor))                   \
         |         ^~
   include/linux/compiler.h:45:26: note: in expansion of macro '__branch_check__'
      45 | #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:115:9: note: in expansion of macro 'likely'
     115 |         likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
         |         ^~~~~~
   include/linux/dynamic_debug.h:126:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     126 |         if (DYNAMIC_DEBUG_BRANCH(descriptor))                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:340:9: note: in expansion of macro 'dynamic_pr_debug'
     340 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   net/netfilter/xt_qtaguid.c:1853:9: note: in expansion of macro 'pr_debug'
    1853 |         pr_debug("qtaguid: %s(): }\n", __func__);
         |         ^~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/dynamic_debug.h:126:9: note: in expansion of macro 'if'
     126 |         if (DYNAMIC_DEBUG_BRANCH(descriptor))                   \
         |         ^~
   include/linux/printk.h:340:9: note: in expansion of macro 'dynamic_pr_debug'
     340 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   net/netfilter/xt_qtaguid.c:1853:9: note: in expansion of macro 'pr_debug'
    1853 |         pr_debug("qtaguid: %s(): }\n", __func__);
         |         ^~~~~~~~
   net/netfilter/xt_qtaguid.c: In function 'qtaguid_ctrl_proc_start':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   net/netfilter/xt_qtaguid.c:1895:9: note: in expansion of macro 'if'
    1895 |         if (unlikely(module_passive))
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   net/netfilter/xt_qtaguid.c:1895:13: note: in expansion of macro 'unlikely'
    1895 |         if (unlikely(module_passive))
         |             ^~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \


vim +1835 net/netfilter/xt_qtaguid.c

cead6bffca84b2 JP Abgrall  2011-06-20  1815  
cead6bffca84b2 JP Abgrall  2011-06-20  1816  #ifdef DDEBUG
fe6bc43a5e8411 Chenbo Feng 2017-03-23  1817  /*
fe6bc43a5e8411 Chenbo Feng 2017-03-23  1818   * This function is not in xt_qtaguid_print.c because of locks visibility.
fe6bc43a5e8411 Chenbo Feng 2017-03-23  1819   * The lock of sock_tag_list must be aquired before calling this function
fe6bc43a5e8411 Chenbo Feng 2017-03-23  1820   */
fe6bc43a5e8411 Chenbo Feng 2017-03-23  1821  static void prdebug_full_state_locked(int indent_level, const char *fmt, ...)
cead6bffca84b2 JP Abgrall  2011-06-20  1822  {
cead6bffca84b2 JP Abgrall  2011-06-20  1823  	va_list args;
cead6bffca84b2 JP Abgrall  2011-06-20  1824  	char *fmt_buff;
cead6bffca84b2 JP Abgrall  2011-06-20  1825  	char *buff;
cead6bffca84b2 JP Abgrall  2011-06-20  1826  
cead6bffca84b2 JP Abgrall  2011-06-20 @1827  	if (!unlikely(qtaguid_debug_mask & DDEBUG_MASK))
cead6bffca84b2 JP Abgrall  2011-06-20  1828  		return;
cead6bffca84b2 JP Abgrall  2011-06-20  1829  
cead6bffca84b2 JP Abgrall  2011-06-20  1830  	fmt_buff = kasprintf(GFP_ATOMIC,
cead6bffca84b2 JP Abgrall  2011-06-20  1831  			     "qtaguid: %s(): %s {\n", __func__, fmt);
cead6bffca84b2 JP Abgrall  2011-06-20  1832  	BUG_ON(!fmt_buff);
cead6bffca84b2 JP Abgrall  2011-06-20  1833  	va_start(args, fmt);
cead6bffca84b2 JP Abgrall  2011-06-20  1834  	buff = kvasprintf(GFP_ATOMIC,
cead6bffca84b2 JP Abgrall  2011-06-20 @1835  			  fmt_buff, args);
cead6bffca84b2 JP Abgrall  2011-06-20  1836  	BUG_ON(!buff);
cead6bffca84b2 JP Abgrall  2011-06-20  1837  	pr_debug("%s", buff);
cead6bffca84b2 JP Abgrall  2011-06-20  1838  	kfree(fmt_buff);
cead6bffca84b2 JP Abgrall  2011-06-20  1839  	kfree(buff);
cead6bffca84b2 JP Abgrall  2011-06-20  1840  	va_end(args);
cead6bffca84b2 JP Abgrall  2011-06-20  1841  
cead6bffca84b2 JP Abgrall  2011-06-20  1842  	prdebug_sock_tag_tree(indent_level, &sock_tag_tree);
cead6bffca84b2 JP Abgrall  2011-06-20  1843  
cead6bffca84b2 JP Abgrall  2011-06-20  1844  	spin_lock_bh(&uid_tag_data_tree_lock);
cead6bffca84b2 JP Abgrall  2011-06-20  1845  	prdebug_uid_tag_data_tree(indent_level, &uid_tag_data_tree);
cead6bffca84b2 JP Abgrall  2011-06-20  1846  	prdebug_proc_qtu_data_tree(indent_level, &proc_qtu_data_tree);
cead6bffca84b2 JP Abgrall  2011-06-20  1847  	spin_unlock_bh(&uid_tag_data_tree_lock);
cead6bffca84b2 JP Abgrall  2011-06-20  1848  
cead6bffca84b2 JP Abgrall  2011-06-20  1849  	spin_lock_bh(&iface_stat_list_lock);
cead6bffca84b2 JP Abgrall  2011-06-20  1850  	prdebug_iface_stat_list(indent_level, &iface_stat_list);
cead6bffca84b2 JP Abgrall  2011-06-20  1851  	spin_unlock_bh(&iface_stat_list_lock);
cead6bffca84b2 JP Abgrall  2011-06-20  1852  
cead6bffca84b2 JP Abgrall  2011-06-20  1853  	pr_debug("qtaguid: %s(): }\n", __func__);
cead6bffca84b2 JP Abgrall  2011-06-20  1854  }
cead6bffca84b2 JP Abgrall  2011-06-20  1855  #else
fe6bc43a5e8411 Chenbo Feng 2017-03-23  1856  static void prdebug_full_state_locked(int indent_level, const char *fmt, ...) {}
cead6bffca84b2 JP Abgrall  2011-06-20  1857  #endif
cead6bffca84b2 JP Abgrall  2011-06-20  1858  

:::::: The code at line 1835 was first introduced by commit
:::::: cead6bffca84b298691c58da076022a82af7e6be ANDROID: netfilter: xt_qtaguid: add qtaguid matching module

:::::: TO: JP Abgrall <jpa@google.com>
:::::: CC: Guenter Roeck <groeck@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
