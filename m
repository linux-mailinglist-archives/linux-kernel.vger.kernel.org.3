Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA59C5207E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiEIWoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiEIWn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:43:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBC829BC74
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652136002; x=1683672002;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wuTBBIYsJ5dIs2MgEnmtrfjeaQACGfotCUJCHrf/0m4=;
  b=GY92YhemfumfIpHqXmXKgkVpR2Am3NKj4LUDFki3CJnFrc65HyC4zhk+
   pLitQCiNqNKn9z+rSTe7tEci4eogSAaBX8wi3P6DxJ0O5nogTkvykhuy6
   f4YV7OQXrc1nZAOqWmxTky8aeqKensO1/LrNZ1aod4Pz2EVjzHYoBW0zB
   r/1jTWBkz0Qc/7A+q0bZhDzEU7sboK0R0F/ChAHIKmhpv//1euSvkm9cY
   GwLdvvPUgIely7GX27EwrsEh1aKPa/i0E2rRnGLLNAMQnOVXkmqie6AGT
   /UqK0LLiC0FHRyMNCpjzNhC8PaCzOk+SW++3+zFOGXk71RF/vRyu9omSt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268029492"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="268029492"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 15:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="623180007"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 May 2022 15:40:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noC2p-000GyW-O5;
        Mon, 09 May 2022 22:39:59 +0000
Date:   Tue, 10 May 2022 06:39:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Auld <matthew.auld@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: drivers/gpu/drm/i915/gem/i915_gem_create.c:571:37: warning:
 'prelim_create_extensions' defined but not used
Message-ID: <202205100605.76EqlXtm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
commit: dcaccaf0e83a97750985bdb866649cc952b127cf drm/i915/gem: split gem_create into own file
date:   1 year, 4 months ago
config: i386-debian-10.3-kselftests (https://download.01.org/0day-ci/archive/20220510/202205100605.76EqlXtm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dcaccaf0e83a97750985bdb866649cc952b127cf
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dcaccaf0e83a97750985bdb866649cc952b127cf
        # save the config file
        make W=1 ARCH=i386 SHELL=/bin/bash tools/all

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

     524 | void __exit acpi_video_detect_exit(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   kernel/latencytop.c:152: warning: Function parameter or member 'tsk' not described in '__account_scheduler_latency'
   kernel/latencytop.c:152: warning: Function parameter or member 'usecs' not described in '__account_scheduler_latency'
   kernel/latencytop.c:152: warning: Function parameter or member 'inter' not described in '__account_scheduler_latency'
   drivers/gpu/drm/i915/display/intel_display_debugfs.c:2404: warning: Function parameter or member 'intel_connector' not described in 'intel_connector_debugfs_add'
   drivers/gpu/drm/i915/display/intel_display_debugfs.c:2404: warning: Excess function parameter 'connector' description in 'intel_connector_debugfs_add'
   lib/argv_split.c:36: warning: Function parameter or member 'argv' not described in 'argv_free'
   lib/cpumask.c:114: warning: Function parameter or member 'node' not described in 'alloc_cpumask_var_node'
   lib/cpumask.c:239: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Returns an arbitrary cpu within srcp1 & srcp2.
   lib/decompress_inflate.c:42:17: warning: no previous prototype for '__gunzip' [-Wmissing-prototypes]
      42 | STATIC int INIT __gunzip(unsigned char *buf, long len,
         |                 ^~~~~~~~
   drivers/gpu/drm/i915/gt/intel_engine_cs.c:1489: warning: expecting prototype for intel_engines_init_common(). Prototype was for engine_init_common() instead
   drivers/gpu/drm/i915/gt/intel_engine_cs.c:1615: warning: expecting prototype for intel_engines_cleanup_common(). Prototype was for intel_engine_cleanup_common() instead
   lib/decompress_unzstd.c:331:17: warning: no previous prototype for 'unzstd' [-Wmissing-prototypes]
     331 | STATIC int INIT unzstd(unsigned char *buf, long len,
         |                 ^~~~~~
   lib/decompress_unxz.c:251:17: warning: no previous prototype for 'unxz' [-Wmissing-prototypes]
     251 | STATIC int INIT unxz(unsigned char *in, long in_size,
         |                 ^~~~
   drivers/watchdog/pretimeout_noop.c:19: warning: Function parameter or member 'wdd' not described in 'pretimeout_noop'
   lib/radix-tree.c:288:6: warning: no previous prototype for 'radix_tree_node_rcu_free' [-Wmissing-prototypes]
     288 | void radix_tree_node_rcu_free(struct rcu_head *head)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/watchdog/pretimeout_panic.c:19: warning: Function parameter or member 'wdd' not described in 'pretimeout_panic'
   drivers/watchdog/it87_wdt.c:222: warning: Function parameter or member 'wdd' not described in 'wdt_set_timeout'
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1694:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1694 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
   lib/win_minmax.c:31: warning: Function parameter or member 'm' not described in 'minmax_subwin_update'
   lib/win_minmax.c:31: warning: Function parameter or member 'win' not described in 'minmax_subwin_update'
   lib/win_minmax.c:31: warning: Function parameter or member 'val' not described in 'minmax_subwin_update'
   lib/win_minmax.c:31: warning: expecting prototype for lib/minmax.c(). Prototype was for minmax_subwin_update() instead
   fs/reiserfs/do_balan.c: In function 'balance_leaf_new_nodes_paste_whole':
   fs/reiserfs/do_balan.c:1147:13: warning: variable 'leaf_mi' set but not used [-Wunused-but-set-variable]
    1147 |         int leaf_mi;
         |             ^~~~~~~
   drivers/edac/i7300_edac.c:1199: warning: expecting prototype for i7300_init(). Prototype was for i7300_exit() instead
   fs/ext4/balloc.c:423: warning: Function parameter or member 'ignore_locked' not described in 'ext4_read_block_bitmap_nowait'
   lib/bitmap.c:498: warning: Function parameter or member 'buf' not described in 'bitmap_print_to_buf'
   lib/bitmap.c:498: warning: Function parameter or member 'maskp' not described in 'bitmap_print_to_buf'
   lib/bitmap.c:498: warning: Function parameter or member 'nmaskbits' not described in 'bitmap_print_to_buf'
   lib/bitmap.c:498: warning: Function parameter or member 'off' not described in 'bitmap_print_to_buf'
   lib/bitmap.c:498: warning: Function parameter or member 'count' not described in 'bitmap_print_to_buf'
   lib/bitmap.c:606: warning: Function parameter or member 'buf' not described in 'bitmap_print_list_to_buf'
   lib/bitmap.c:606: warning: Function parameter or member 'maskp' not described in 'bitmap_print_list_to_buf'
   lib/bitmap.c:606: warning: Function parameter or member 'nmaskbits' not described in 'bitmap_print_list_to_buf'
   lib/bitmap.c:606: warning: Function parameter or member 'off' not described in 'bitmap_print_list_to_buf'
   lib/bitmap.c:606: warning: Function parameter or member 'count' not described in 'bitmap_print_list_to_buf'
   fs/reiserfs/fix_node.c: In function 'dc_check_balance_leaf':
   fs/reiserfs/fix_node.c:1938:13: warning: variable 'maxsize' set but not used [-Wunused-but-set-variable]
    1938 |         int maxsize, ret;
         |             ^~~~~~~
   fs/reiserfs/fix_node.c:1935:13: warning: variable 'levbytes' set but not used [-Wunused-but-set-variable]
    1935 |         int levbytes;
         |             ^~~~~~~~
   fs/reiserfs/prints.c: In function 'prepare_error_buf':
   fs/reiserfs/prints.c:221:17: warning: function 'prepare_error_buf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     221 |                 p += vscnprintf(p, end - p, fmt1, args);
         |                 ^
   fs/reiserfs/prints.c:260:9: warning: function 'prepare_error_buf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     260 |         p += vscnprintf(p, end - p, fmt1, args);
         |         ^
   lib/scatterlist.c:286: warning: Function parameter or member 'first_chunk' not described in '__sg_alloc_table'
   lib/scatterlist.c:788: warning: Function parameter or member 'flags' not described in 'sg_miter_start'
   fs/reiserfs/lbalance.c: In function 'leaf_copy_items':
   fs/reiserfs/lbalance.c:524:29: warning: variable 'dest' set but not used [-Wunused-but-set-variable]
     524 |         struct buffer_head *dest;
         |                             ^~~~
   drivers/cpuidle/governors/ladder.c:54: warning: Function parameter or member 'dev' not described in 'ladder_do_selection'
   drivers/cpufreq/intel_pstate.c:263: warning: Function parameter or member 'epp_cached' not described in 'cpudata'
   fs/jbd2/journal.c:1294: warning: Function parameter or member 'shrink' not described in 'jbd2_journal_shrink_scan'
   fs/jbd2/journal.c:1294: warning: Function parameter or member 'sc' not described in 'jbd2_journal_shrink_scan'
   fs/jbd2/journal.c:1318: warning: Function parameter or member 'shrink' not described in 'jbd2_journal_shrink_count'
   fs/jbd2/journal.c:1318: warning: Function parameter or member 'sc' not described in 'jbd2_journal_shrink_count'
   drivers/cpuidle/sysfs.c:512: warning: expecting prototype for cpuidle_remove_driver_sysfs(). Prototype was for cpuidle_remove_state_sysfs() instead
   drivers/cpufreq/powernow-k6.c:141: warning: Function parameter or member 'policy' not described in 'powernow_k6_target'
   drivers/gpu/drm/i915/gt/intel_rps.c:2508: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Tells the intel_ips driver that the i915 driver is now loaded, if
   drivers/cpufreq/longhaul.c: In function 'do_powersaver':
   drivers/cpufreq/longhaul.c:165:13: warning: variable 't' set but not used [-Wunused-but-set-variable]
     165 |         u32 t;
         |             ^
   drivers/cpufreq/longrun.c:21: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * longrun_{low,high}_freq is needed for the conversion of cpufreq kHz
   drivers/cpufreq/longrun.c:126: warning: expecting prototype for longrun_verify_poliy(). Prototype was for longrun_verify_policy() instead
   drivers/cpufreq/gx-suspmod.c:143: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * we can detect a core multiplier from dir0_lsb
   drivers/cpufreq/gx-suspmod.c:203: warning: Function parameter or member 'cpu' not described in 'gx_get_cpuspeed'
   drivers/cpufreq/gx-suspmod.c:219: warning: Function parameter or member 'khz' not described in 'gx_validate_speed'
   drivers/cpufreq/gx-suspmod.c:219: warning: Function parameter or member 'on_duration' not described in 'gx_validate_speed'
   drivers/cpufreq/gx-suspmod.c:219: warning: Function parameter or member 'off_duration' not described in 'gx_validate_speed'
   drivers/cpufreq/gx-suspmod.c:251: warning: Function parameter or member 'policy' not described in 'gx_set_cpuspeed'
   drivers/cpufreq/gx-suspmod.c:251: warning: Function parameter or member 'khz' not described in 'gx_set_cpuspeed'
   drivers/cpufreq/longhaul.c:247: warning: Function parameter or member 'policy' not described in 'longhaul_setstate'
   drivers/cpufreq/longhaul.c:247: warning: Function parameter or member 'table_index' not described in 'longhaul_setstate'
   drivers/cpufreq/longhaul.c:247: warning: expecting prototype for longhaul_set_cpu_frequency(). Prototype was for longhaul_setstate() instead
>> drivers/gpu/drm/i915/gem/i915_gem_create.c:571:37: warning: 'prelim_create_extensions' defined but not used [-Wunused-const-variable=]
     571 | static const i915_user_extension_fn prelim_create_extensions[] = {
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/ext4/ioctl.c:31: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Swap memory between @a and @b for @len bytes.
   fs/ext4/ioctl.c:52: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Swap i_data and associated attributes between @inode1 and @inode2.
   fs/ext4/ioctl.c:106: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Swap the information from the given @inode and the inode
   drivers/gpu/drm/i915/gem/i915_gem_create.c:578: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Creates a new mm object and returns a handle to it.
   drivers/gpu/drm/i915/gem/i915_gem_create.c:769: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Creates a new mm object and returns a handle to it.
   fs/coda/file.c: In function 'coda_release':
   fs/coda/file.c:241:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
     241 |         int err;
         |             ^~~
   fs/coda/upcall.c: In function 'venus_setattr':
   fs/coda/upcall.c:115:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     115 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_close':
   fs/coda/upcall.c:164:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     164 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_rename':
   fs/coda/upcall.c:238:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     238 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_rmdir':
   fs/coda/upcall.c:306:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     306 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_remove':
   fs/coda/upcall.c:329:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     329 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_link':
   fs/coda/upcall.c:383:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     383 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_symlink':
   fs/coda/upcall.c:410:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     410 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_fsync':
   fs/coda/upcall.c:443:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     443 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_access':
   fs/coda/upcall.c:459:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     459 |         union outputArgs *outp;
         |                           ^~~~
   fs/coda/upcall.c: In function 'venus_access_intent':
   fs/coda/upcall.c:577:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
     577 |         union outputArgs *outp;
         |                           ^~~~
   drivers/gpu/drm/i915/gt/intel_workarounds.c:2027: warning: Function parameter or member 'wal' not described in 'wa_find_addr'
   drivers/gpu/drm/i915/gt/intel_workarounds.c:2027: warning: Function parameter or member 'test_addr' not described in 'wa_find_addr'
   drivers/gpu/drm/i915/gt/intel_workarounds.c:2095: warning: Function parameter or member 'uncore' not described in 'xehpsdv_wa_1607720814'
   drivers/gpu/drm/i915/gt/intel_workarounds.c:2095: warning: Function parameter or member 'wal' not described in 'xehpsdv_wa_1607720814'
   drivers/cpufreq/cpufreq-nforce2.c:135: warning: Function parameter or member 'bootfsb' not described in 'nforce2_fsb_read'
   drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c:62: warning: Function parameter or member 'attrs' not described in 'dmabuf_map_addr'
   drivers/gpu/drm/i915/gem/i915_gem_domain.c:96: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Moves a single object to the WC read, and possibly write domain.
   drivers/gpu/drm/i915/gem/i915_gem_domain.c:157: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Moves a single object to the GTT read, and possibly write domain.
   drivers/gpu/drm/i915/gem/i915_gem_domain.c:244: warning: expecting prototype for Changes the cache(). Prototype was for i915_gem_object_set_cache_level() instead
   drivers/gpu/drm/i915/gem/i915_gem_domain.c:462: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Moves a single object to the CPU read, and possibly write domain.
   drivers/gpu/drm/i915/gem/i915_gem_domain.c:506: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Called when user space prepares to use an object with the CPU, either
   fs/fat/dir.c:282: warning: Function parameter or member 'dir' not described in 'fat_parse_long'
   fs/fat/dir.c:282: warning: Function parameter or member 'pos' not described in 'fat_parse_long'
   fs/fat/dir.c:282: warning: Function parameter or member 'bh' not described in 'fat_parse_long'
   fs/fat/dir.c:282: warning: Function parameter or member 'de' not described in 'fat_parse_long'
   fs/fat/dir.c:282: warning: Function parameter or member 'unicode' not described in 'fat_parse_long'
   fs/fat/dir.c:282: warning: Function parameter or member 'nr_slots' not described in 'fat_parse_long'
   lib/errname.c:16:67: warning: initialized field overwritten [-Woverride-init]
      16 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
         |                                                                   ^~~
   lib/errname.c:173:9: note: in expansion of macro 'E'
     173 |         E(EDEADLK), /* EDEADLOCK */
         |         ^
   lib/errname.c:16:67: note: (near initialization for 'names_0[35]')
      16 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
         |                                                                   ^~~
   lib/errname.c:173:9: note: in expansion of macro 'E'
     173 |         E(EDEADLK), /* EDEADLOCK */
         |         ^
   drivers/gpu/drm/i915/gem/i915_gem_object.c:129: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Mark up the object's coherency levels for a given cache_level
   drivers/gpu/drm/i915/gem/i915_gem_object.c:1073: warning: Function parameter or member 'ww' not described in 'i915_gem_object_migrate_to_smem'
   drivers/firmware/efi/efi.c:166:16: warning: no previous prototype for 'efi_attr_is_visible' [-Wmissing-prototypes]
     166 | umode_t __weak efi_attr_is_visible(struct kobject *kobj, struct attribute *attr,
         |                ^~~~~~~~~~~~~~~~~~~
   lib/nlattr.c:648: warning: Function parameter or member 'p' not described in 'nla_policy_len'
   lib/nlattr.c:648: warning: Excess function parameter 'policy' description in 'nla_policy_len'
   fs/hfsplus/inode.c: In function 'hfsplus_cat_read_inode':
   fs/hfsplus/inode.c:513:37: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     513 |                         /* panic? */;


vim +/prelim_create_extensions +571 drivers/gpu/drm/i915/gem/i915_gem_create.c

dcaccaf0e83a97 Matthew Auld 2021-01-14    1  // SPDX-License-Identifier: MIT
dcaccaf0e83a97 Matthew Auld 2021-01-14    2  /*
dcaccaf0e83a97 Matthew Auld 2021-01-14    3   * Copyright © 2020 Intel Corporation
dcaccaf0e83a97 Matthew Auld 2021-01-14    4   */
dcaccaf0e83a97 Matthew Auld 2021-01-14    5  
dcaccaf0e83a97 Matthew Auld 2021-01-14    6  #include "gem/i915_gem_ioctls.h"
dcaccaf0e83a97 Matthew Auld 2021-01-14    7  #include "gem/i915_gem_region.h"
dcaccaf0e83a97 Matthew Auld 2021-01-14    8  
dcaccaf0e83a97 Matthew Auld 2021-01-14    9  #include "i915_drv.h"
dcaccaf0e83a97 Matthew Auld 2021-01-14   10  
dcaccaf0e83a97 Matthew Auld 2021-01-14   11  static int
dcaccaf0e83a97 Matthew Auld 2021-01-14   12  i915_gem_create(struct drm_file *file,
dcaccaf0e83a97 Matthew Auld 2021-01-14   13  		struct intel_memory_region *mr,
dcaccaf0e83a97 Matthew Auld 2021-01-14   14  		u64 *size_p,
dcaccaf0e83a97 Matthew Auld 2021-01-14   15  		u32 *handle_p)
dcaccaf0e83a97 Matthew Auld 2021-01-14   16  {
dcaccaf0e83a97 Matthew Auld 2021-01-14   17  	struct drm_i915_gem_object *obj;
dcaccaf0e83a97 Matthew Auld 2021-01-14   18  	u32 handle;
dcaccaf0e83a97 Matthew Auld 2021-01-14   19  	u64 size;
dcaccaf0e83a97 Matthew Auld 2021-01-14   20  	int ret;
dcaccaf0e83a97 Matthew Auld 2021-01-14   21  
dcaccaf0e83a97 Matthew Auld 2021-01-14   22  	GEM_BUG_ON(!is_power_of_2(mr->min_page_size));
dcaccaf0e83a97 Matthew Auld 2021-01-14   23  	size = round_up(*size_p, mr->min_page_size);
dcaccaf0e83a97 Matthew Auld 2021-01-14   24  	if (size == 0)
dcaccaf0e83a97 Matthew Auld 2021-01-14   25  		return -EINVAL;
dcaccaf0e83a97 Matthew Auld 2021-01-14   26  
dcaccaf0e83a97 Matthew Auld 2021-01-14   27  	/* For most of the ABI (e.g. mmap) we think in system pages */
dcaccaf0e83a97 Matthew Auld 2021-01-14   28  	GEM_BUG_ON(!IS_ALIGNED(size, PAGE_SIZE));
dcaccaf0e83a97 Matthew Auld 2021-01-14   29  
dcaccaf0e83a97 Matthew Auld 2021-01-14   30  	/* Allocate the new object */
dcaccaf0e83a97 Matthew Auld 2021-01-14   31  	obj = i915_gem_object_create_region(mr, size, 0);
dcaccaf0e83a97 Matthew Auld 2021-01-14   32  	if (IS_ERR(obj))
dcaccaf0e83a97 Matthew Auld 2021-01-14   33  		return PTR_ERR(obj);
dcaccaf0e83a97 Matthew Auld 2021-01-14   34  
dcaccaf0e83a97 Matthew Auld 2021-01-14   35  	ret = drm_gem_handle_create(file, &obj->base, &handle);
dcaccaf0e83a97 Matthew Auld 2021-01-14   36  	/* drop reference from allocate - handle holds it now */
dcaccaf0e83a97 Matthew Auld 2021-01-14   37  	i915_gem_object_put(obj);
dcaccaf0e83a97 Matthew Auld 2021-01-14   38  	if (ret)
dcaccaf0e83a97 Matthew Auld 2021-01-14   39  		return ret;
dcaccaf0e83a97 Matthew Auld 2021-01-14   40  
dcaccaf0e83a97 Matthew Auld 2021-01-14   41  	*handle_p = handle;
dcaccaf0e83a97 Matthew Auld 2021-01-14   42  	*size_p = size;
dcaccaf0e83a97 Matthew Auld 2021-01-14   43  	return 0;
dcaccaf0e83a97 Matthew Auld 2021-01-14   44  }
dcaccaf0e83a97 Matthew Auld 2021-01-14   45  
dcaccaf0e83a97 Matthew Auld 2021-01-14   46  int
dcaccaf0e83a97 Matthew Auld 2021-01-14   47  i915_gem_dumb_create(struct drm_file *file,
dcaccaf0e83a97 Matthew Auld 2021-01-14   48  		     struct drm_device *dev,
dcaccaf0e83a97 Matthew Auld 2021-01-14   49  		     struct drm_mode_create_dumb *args)
dcaccaf0e83a97 Matthew Auld 2021-01-14   50  {
dcaccaf0e83a97 Matthew Auld 2021-01-14   51  	enum intel_memory_type mem_type;
dcaccaf0e83a97 Matthew Auld 2021-01-14   52  	int cpp = DIV_ROUND_UP(args->bpp, 8);
dcaccaf0e83a97 Matthew Auld 2021-01-14   53  	u32 format;
dcaccaf0e83a97 Matthew Auld 2021-01-14   54  
dcaccaf0e83a97 Matthew Auld 2021-01-14   55  	switch (cpp) {
dcaccaf0e83a97 Matthew Auld 2021-01-14   56  	case 1:
dcaccaf0e83a97 Matthew Auld 2021-01-14   57  		format = DRM_FORMAT_C8;
dcaccaf0e83a97 Matthew Auld 2021-01-14   58  		break;
dcaccaf0e83a97 Matthew Auld 2021-01-14   59  	case 2:
dcaccaf0e83a97 Matthew Auld 2021-01-14   60  		format = DRM_FORMAT_RGB565;
dcaccaf0e83a97 Matthew Auld 2021-01-14   61  		break;
dcaccaf0e83a97 Matthew Auld 2021-01-14   62  	case 4:
dcaccaf0e83a97 Matthew Auld 2021-01-14   63  		format = DRM_FORMAT_XRGB8888;
dcaccaf0e83a97 Matthew Auld 2021-01-14   64  		break;
dcaccaf0e83a97 Matthew Auld 2021-01-14   65  	default:
dcaccaf0e83a97 Matthew Auld 2021-01-14   66  		return -EINVAL;
dcaccaf0e83a97 Matthew Auld 2021-01-14   67  	}
dcaccaf0e83a97 Matthew Auld 2021-01-14   68  
dcaccaf0e83a97 Matthew Auld 2021-01-14   69  	/* have to work out size/pitch and return them */
dcaccaf0e83a97 Matthew Auld 2021-01-14   70  	args->pitch = ALIGN(args->width * cpp, 64);
dcaccaf0e83a97 Matthew Auld 2021-01-14   71  
dcaccaf0e83a97 Matthew Auld 2021-01-14   72  	/* align stride to page size so that we can remap */
dcaccaf0e83a97 Matthew Auld 2021-01-14   73  	if (args->pitch > intel_plane_fb_max_stride(to_i915(dev), format,
dcaccaf0e83a97 Matthew Auld 2021-01-14   74  						    DRM_FORMAT_MOD_LINEAR))
dcaccaf0e83a97 Matthew Auld 2021-01-14   75  		args->pitch = ALIGN(args->pitch, 4096);
dcaccaf0e83a97 Matthew Auld 2021-01-14   76  
dcaccaf0e83a97 Matthew Auld 2021-01-14   77  	if (args->pitch < args->width)
dcaccaf0e83a97 Matthew Auld 2021-01-14   78  		return -EINVAL;
dcaccaf0e83a97 Matthew Auld 2021-01-14   79  
dcaccaf0e83a97 Matthew Auld 2021-01-14   80  	args->size = mul_u32_u32(args->pitch, args->height);
dcaccaf0e83a97 Matthew Auld 2021-01-14   81  
dcaccaf0e83a97 Matthew Auld 2021-01-14   82  	mem_type = INTEL_MEMORY_SYSTEM;
dcaccaf0e83a97 Matthew Auld 2021-01-14   83  	if (HAS_LMEM(to_i915(dev)))
dcaccaf0e83a97 Matthew Auld 2021-01-14   84  		mem_type = INTEL_MEMORY_LOCAL;
dcaccaf0e83a97 Matthew Auld 2021-01-14   85  
dcaccaf0e83a97 Matthew Auld 2021-01-14   86  	return i915_gem_create(file,
dcaccaf0e83a97 Matthew Auld 2021-01-14   87  			       intel_memory_region_by_type(to_i915(dev),
dcaccaf0e83a97 Matthew Auld 2021-01-14   88  							   mem_type),
dcaccaf0e83a97 Matthew Auld 2021-01-14   89  			       &args->size, &args->handle);
dcaccaf0e83a97 Matthew Auld 2021-01-14   90  }
dcaccaf0e83a97 Matthew Auld 2021-01-14   91  
dcaccaf0e83a97 Matthew Auld 2021-01-14   92  /**
dcaccaf0e83a97 Matthew Auld 2021-01-14   93   * Creates a new mm object and returns a handle to it.
dcaccaf0e83a97 Matthew Auld 2021-01-14   94   * @dev: drm device pointer
dcaccaf0e83a97 Matthew Auld 2021-01-14   95   * @data: ioctl data blob
dcaccaf0e83a97 Matthew Auld 2021-01-14   96   * @file: drm file pointer
dcaccaf0e83a97 Matthew Auld 2021-01-14   97   */
dcaccaf0e83a97 Matthew Auld 2021-01-14   98  int
dcaccaf0e83a97 Matthew Auld 2021-01-14   99  i915_gem_create_ioctl(struct drm_device *dev, void *data,
dcaccaf0e83a97 Matthew Auld 2021-01-14  100  		      struct drm_file *file)
dcaccaf0e83a97 Matthew Auld 2021-01-14  101  {
dcaccaf0e83a97 Matthew Auld 2021-01-14  102  	struct drm_i915_private *i915 = to_i915(dev);
dcaccaf0e83a97 Matthew Auld 2021-01-14  103  	struct drm_i915_gem_create *args = data;
dcaccaf0e83a97 Matthew Auld 2021-01-14  104  
dcaccaf0e83a97 Matthew Auld 2021-01-14  105  	i915_gem_flush_free_objects(i915);
dcaccaf0e83a97 Matthew Auld 2021-01-14  106  
dcaccaf0e83a97 Matthew Auld 2021-01-14  107  	return i915_gem_create(file,
dcaccaf0e83a97 Matthew Auld 2021-01-14  108  			       intel_memory_region_by_type(i915,
dcaccaf0e83a97 Matthew Auld 2021-01-14  109  							   INTEL_MEMORY_SYSTEM),
dcaccaf0e83a97 Matthew Auld 2021-01-14  110  			       &args->size, &args->handle);
dcaccaf0e83a97 Matthew Auld 2021-01-14  111  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
