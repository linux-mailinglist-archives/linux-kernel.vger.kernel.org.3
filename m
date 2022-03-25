Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3228F4E714C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358887AbiCYKen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbiCYKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:34:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59AF25C9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648204385; x=1679740385;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=03GuHuDYmUOwRAcBXg/OzuVMC0Q/utiDbIdSZ3HNkLc=;
  b=gQ54x9IqAYMl95ahnipvUNYGj+/FYI60n0GAUr867UjFn8oE2QQ1cSIs
   /ELNe6qxjHMsPNbszv7Z1EFjsbKqamD01i09aUzT7f6WmAIFGTHKBMPvI
   ELZidqdawMEEiPTd+C1iWJUukkDTlAzURx6drZFW9ufYmVgZg4HQMpA4u
   hQGbso/55VO0pYIcf7cbMJfAz9Hn2d+Ap0bhFVpS7tVrkeYzeD2SXy7+E
   AIXD6WOAA0LmIfS46Qx0gZr4ADoElqSaAcE35gPExz5BB1/ZlzmR2pIMs
   3cc8pzFshylL5I/jIk7+nJ95Q28G0tQ96Xpm+k6xABpnMTS7YHMBc0zOH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="246083676"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="246083676"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 03:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="718169814"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Mar 2022 03:33:03 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXhFe-000M5K-Ox; Fri, 25 Mar 2022 10:33:02 +0000
Date:   Fri, 25 Mar 2022 18:32:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: arch/x86/kernel/fpu/core.o: warning: objtool: can't decode
 instruction at .text:0x44e8
Message-ID: <202203251819.OW1ZXvz6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34af78c4e616c359ed428d79fe4758a35d2c5473
commit: c597bfddc9e9e8a63817252b67c3ca0e544ace26 sched: Provide Kconfig support for default dynamic preempt mode
date:   6 months ago
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220325/202203251819.OW1ZXvz6-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c597bfddc9e9e8a63817252b67c3ca0e544ace26
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c597bfddc9e9e8a63817252b67c3ca0e544ace26
        # save the config file to linux build tree
        make W=1 ARCH=x86_64 SHELL=/bin/bash tools/all

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/power/hibernate.c:189:5: warning: no previous prototype for 'arch_resume_nosmt' [-Wmissing-prototypes]
     189 | int arch_resume_nosmt(void)
         |     ^~~~~~~~~~~~~~~~~
   arch/x86/power/hibernate.c:47: warning: Function parameter or member 'pfn' not described in 'pfn_is_nosave'
   arch/x86/power/hibernate.c:92: warning: Function parameter or member 'max_size' not described in 'arch_hibernation_header_save'
   arch/x86/kernel/i8259.c:234: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ
   fs/ioctl.c:112: warning: expecting prototype for fiemap_fill_next_extent(). Prototype was for SET_UNKNOWN_FLAGS() instead
   fs/ioctl.c:906: warning: Function parameter or member 'file' not described in 'compat_ptr_ioctl'
   fs/ioctl.c:906: warning: Function parameter or member 'cmd' not described in 'compat_ptr_ioctl'
   fs/ioctl.c:906: warning: Function parameter or member 'arg' not described in 'compat_ptr_ioctl'
   lib/argv_split.c:36: warning: Function parameter or member 'argv' not described in 'argv_free'
   fs/namei.c:647: warning: Function parameter or member 'mnt' not described in 'path_connected'
   fs/namei.c:647: warning: Function parameter or member 'dentry' not described in 'path_connected'
   fs/namei.c:1094: warning: Function parameter or member 'inode' not described in 'may_follow_link'
   security/keys/trusted-keys/trusted_tpm2.c:203: warning: expecting prototype for tpm_buf_append_auth(). Prototype was for tpm2_buf_append_auth() instead
   drivers/idle/intel_idle.c:178: warning: Function parameter or member 'index' not described in 'intel_idle_tile'
   lib/cpumask.c:114: warning: Function parameter or member 'node' not described in 'alloc_cpumask_var_node'
   lib/cpumask.c:239: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Returns an arbitrary cpu within srcp1 & srcp2.
   arch/x86/mm/pat/memtype.c:749: warning: Function parameter or member 'pfn' not described in 'pat_pfn_immune_to_uc_mtrr'
   drivers/acpi/osl.c: In function 'acpi_os_vprintf':
   drivers/acpi/osl.c:157:2: warning: function 'acpi_os_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     157 |  vsprintf(buffer, fmt, args);
         |  ^~~~~~~~
   drivers/clk/clkdev.c: In function 'vclkdev_alloc':
   drivers/clk/clkdev.c:173:3: warning: function 'vclkdev_alloc' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     173 |   vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
         |   ^~~~~~~~~~
   lib/decompress_inflate.c:42:17: warning: no previous prototype for '__gunzip' [-Wmissing-prototypes]
      42 | STATIC int INIT __gunzip(unsigned char *buf, long len,
         |                 ^~~~~~~~
   lib/decompress_unxz.c:251:17: warning: no previous prototype for 'unxz' [-Wmissing-prototypes]
     251 | STATIC int INIT unxz(unsigned char *in, long in_size,
         |                 ^~~~
   lib/decompress_unzstd.c:331:17: warning: no previous prototype for 'unzstd' [-Wmissing-prototypes]
     331 | STATIC int INIT unzstd(unsigned char *buf, long len,
         |                 ^~~~~~
   drivers/char/ipmi/ipmi_msghandler.c:600: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * The driver model view of the IPMI messaging driver.
   kernel/pid.c:629: warning: expecting prototype for pidfd_open(). Prototype was for sys_pidfd_open() instead
   security/yama/yama_lsm.c:116: warning: Function parameter or member 'work' not described in 'yama_relation_cleanup'
   security/device_cgroup.c:810: warning: Excess function parameter 'dev_cgroup' description in 'devcgroup_legacy_check_permission'
   security/lsm_audit.c:210: warning: Function parameter or member 'ab' not described in 'dump_common_audit_data'
   fs/file.c:655: warning: Function parameter or member 'fdt' not described in 'last_fd'
   fs/file.c:655: warning: Excess function parameter 'cur_fds' description in 'last_fd'
   fs/file.c:703: warning: Function parameter or member 'flags' not described in '__close_range'
   kernel/task_work.c:76: warning: Function parameter or member 'data' not described in 'task_work_cancel_match'
   drivers/video/fbdev/core/fbmon.c:1073: warning: expecting prototype for fb_get_hblank_by_freq(). Prototype was for fb_get_hblank_by_hfreq() instead
   drivers/acpi/sleep.c:495: warning: Function parameter or member 'acpi_state' not described in 'acpi_pm_start'
   drivers/acpi/sleep.c:535: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin'
   drivers/acpi/sleep.c:660: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin_old'
   drivers/acpi/sleep.c:955: warning: Function parameter or member 'stage' not described in 'acpi_hibernation_begin_old'
   drivers/acpi/device_pm.c:1198:5: warning: no previous prototype for 'acpi_subsys_restore_early' [-Wmissing-prototypes]
    1198 | int acpi_subsys_restore_early(struct device *dev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/lib/cmdline.c:204:5: warning: no previous prototype for 'cmdline_find_option_bool' [-Wmissing-prototypes]
     204 | int cmdline_find_option_bool(const char *cmdline, const char *option)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/lib/cmdline.c:209:5: warning: no previous prototype for 'cmdline_find_option' [-Wmissing-prototypes]
     209 | int cmdline_find_option(const char *cmdline, const char *option, char *buffer,
         |     ^~~~~~~~~~~~~~~~~~~
   arch/x86/lib/cmdline.c:17: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Find a boolean option (like quiet,noapic,nosmp....)
   arch/x86/kernel/tsc.c:1297: warning: Function parameter or member 'system_counter' not described in 'convert_tsc_to_art'
   arch/x86/kernel/tsc.c:1297: warning: Function parameter or member 'art' not described in 'convert_tsc_to_art'
   arch/x86/kernel/tsc.c:1486: warning: Excess function parameter 'cycles' description in 'convert_art_ns_to_tsc'
   arch/x86/kernel/tsc.c:1486: warning: Excess function parameter 'cs' description in 'convert_art_ns_to_tsc'
   arch/x86/kernel/tsc.c:1520: warning: Function parameter or member 'work' not described in 'tsc_refine_calibration_work'
   arch/x86/lib/copy_mc.c:26:1: warning: no previous prototype for 'copy_mc_fragile_handle_tail' [-Wmissing-prototypes]
      26 | copy_mc_fragile_handle_tail(char *to, char *from, unsigned len)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/bus.c:428: warning: Function parameter or member 'handle' not described in 'acpi_bus_notify'
   drivers/acpi/bus.c:428: warning: Function parameter or member 'type' not described in 'acpi_bus_notify'
   drivers/acpi/bus.c:428: warning: Function parameter or member 'data' not described in 'acpi_bus_notify'
   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_init':
   drivers/video/fbdev/core/fbcon.c:1028:6: warning: variable 'cap' set but not used [-Wunused-but-set-variable]
    1028 |  int cap, ret;
         |      ^~~
   lib/radix-tree.c:288:6: warning: no previous prototype for 'radix_tree_node_rcu_free' [-Wmissing-prototypes]
     288 | void radix_tree_node_rcu_free(struct rcu_head *head)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/lib/csum-wrappers_64.c:25: warning: Excess function parameter 'isum' description in 'csum_and_copy_from_user'
   arch/x86/lib/csum-wrappers_64.c:25: warning: Excess function parameter 'errp' description in 'csum_and_copy_from_user'
   arch/x86/lib/csum-wrappers_64.c:50: warning: Excess function parameter 'isum' description in 'csum_and_copy_to_user'
   arch/x86/lib/csum-wrappers_64.c:50: warning: Excess function parameter 'errp' description in 'csum_and_copy_to_user'
   arch/x86/lib/csum-wrappers_64.c:73: warning: Excess function parameter 'sum' description in 'csum_partial_copy_nocheck'
   drivers/char/random.c:2199:6: warning: no previous prototype for 'add_hwgenerator_randomness' [-Wmissing-prototypes]
    2199 | void add_hwgenerator_randomness(const char *buffer, size_t count,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/notifier.c:68: warning: Excess function parameter 'returns' description in 'notifier_call_chain'
   kernel/notifier.c:116: warning: Function parameter or member 'v' not described in 'notifier_call_chain_robust'
   arch/x86/lib/insn-eval.c:1151: warning: Function parameter or member 'base_offset' not described in 'get_eff_addr_sib'
   arch/x86/lib/insn-eval.c:1151: warning: Excess function parameter 'regoff' description in 'get_eff_addr_sib'
   arch/x86/kernel/process.c:421: warning: expecting prototype for tss_update_io_bitmap(). Prototype was for native_tss_update_io_bitmap() instead
   kernel/reboot.c:216: warning: Function parameter or member 'cmd' not described in 'do_kernel_restart'
   kernel/reboot.c:559: warning: Function parameter or member 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'
   arch/x86/lib/misc.c:7:5: warning: no previous prototype for 'num_digits' [-Wmissing-prototypes]
       7 | int num_digits(int val)
         |     ^~~~~~~~~~
>> arch/x86/kernel/fpu/core.o: warning: objtool: can't decode instruction at .text:0x44e8
   arch/x86/lib/usercopy_64.c:79:6: warning: no previous prototype for 'arch_wb_cache_pmem' [-Wmissing-prototypes]
      79 | void arch_wb_cache_pmem(void *addr, size_t size)
         |      ^~~~~~~~~~~~~~~~~~
   arch/x86/lib/usercopy_64.c:68: warning: Function parameter or member 'addr' not described in 'clean_cache_range'
   arch/x86/lib/usercopy_64.c:68: warning: Excess function parameter 'vaddr' description in 'clean_cache_range'
   arch/x86/lib/msr.c:30: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Read an MSR with error handling
   arch/x86/lib/msr.c:52: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Write an MSR with error handling
   arch/x86/lib/msr.c:91: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Set @bit in a MSR @msr.
   arch/x86/lib/msr.c:104: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Clear @bit in a MSR @msr.
   security/integrity/ima/ima_main.c:432: warning: Function parameter or member 'vma' not described in 'ima_file_mprotect'
   security/integrity/ima/ima_main.c:622: warning: Function parameter or member 'inode' not described in 'ima_post_create_tmpfile'
   security/integrity/ima/ima_main.c:622: warning: Excess function parameter 'file' description in 'ima_post_create_tmpfile'
   security/integrity/ima/ima_main.c:829: warning: Function parameter or member 'load_id' not described in 'ima_post_load_data'
   security/integrity/ima/ima_main.c:829: warning: Excess function parameter 'id' description in 'ima_post_load_data'
   drivers/gpu/drm/drm_nomodeset.c:8:6: warning: no previous prototype for 'drm_firmware_drivers_only' [-Wmissing-prototypes]
       8 | bool drm_firmware_drivers_only(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/dock.c:388: warning: Function parameter or member 'ds' not described in 'handle_eject_request'
   drivers/acpi/dock.c:388: warning: Function parameter or member 'event' not described in 'handle_eject_request'
   kernel/sched/core.c:3453:6: warning: no previous prototype for 'sched_set_stop_task' [-Wmissing-prototypes]
    3453 | void sched_set_stop_task(int cpu, struct task_struct *stop)
         |      ^~~~~~~~~~~~~~~~~~~
   drivers/virtio/virtio_dma_buf.c:42: warning: Function parameter or member 'dma_buf' not described in 'virtio_dma_buf_attach'
   drivers/virtio/virtio_dma_buf.c:42: warning: Function parameter or member 'attach' not described in 'virtio_dma_buf_attach'
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1684:2: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1684 |  buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |  ^~~
   lib/win_minmax.c:31: warning: Function parameter or member 'm' not described in 'minmax_subwin_update'
   lib/win_minmax.c:31: warning: Function parameter or member 'win' not described in 'minmax_subwin_update'
   lib/win_minmax.c:31: warning: Function parameter or member 'val' not described in 'minmax_subwin_update'
   lib/win_minmax.c:31: warning: expecting prototype for lib/minmax.c(). Prototype was for minmax_subwin_update() instead
   security/integrity/ima/ima_policy.c:696: warning: Function parameter or member 'flags' not described in 'ima_match_policy'
   security/integrity/ima/ima_policy.c:1814: warning: Function parameter or member 'rule' not described in 'ima_parse_add_rule'
   security/integrity/ima/ima_policy.c:1858: warning: expecting prototype for ima_delete_rules() called to cleanup invalid in(). Prototype was for ima_delete_rules() instead
   net/netfilter/ipvs/ip_vs_core.c: In function 'ip_vs_in_icmp':
   net/netfilter/ipvs/ip_vs_core.c:1596:8: warning: variable 'outer_proto' set but not used [-Wunused-but-set-variable]
    1596 |  char *outer_proto = "IPIP";
         |        ^~~~~~~~~~~
   fs/d_path.c:318:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
     318 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
         |       ^~~~~~~~~~~~
   drivers/connector/cn_proc.c:348: warning: Function parameter or member 'msg' not described in 'cn_proc_mcast_ctl'
   drivers/connector/cn_proc.c:348: warning: Function parameter or member 'nsp' not described in 'cn_proc_mcast_ctl'
   drivers/connector/cn_proc.c:348: warning: Excess function parameter 'data' description in 'cn_proc_mcast_ctl'
   security/integrity/evm/evm_main.c:341: warning: Excess function parameter 'inode' description in 'evm_read_protected_xattrs'
   security/integrity/evm/evm_main.c:413: warning: Function parameter or member 'iint' not described in 'evm_verifyxattr'
   security/integrity/evm/evm_main.c:779: warning: Function parameter or member 'attr' not described in 'evm_inode_setattr'
   block/bfq-cgroup.c:834: warning: Function parameter or member 'ioprio_class' not described in 'bfq_reparent_leaf_entity'
   block/bfq-cgroup.c:864: warning: Function parameter or member 'ioprio_class' not described in 'bfq_reparent_active_queues'
   block/bfq-wf2q.c:1399: warning: Function parameter or member 'in_service' not described in '__bfq_lookup_next_entity'
   security/integrity/evm/evm_crypto.c:53: warning: Function parameter or member 'keylen' not described in 'evm_set_key'
   security/integrity/evm/evm_crypto.c:53: warning: Excess function parameter 'size' description in 'evm_set_key'
   fs/nsfs.c:264: warning: Function parameter or member 'ns' not described in 'ns_match'
   fs/nsfs.c:264: warning: Excess function parameter 'ns_common' description in 'ns_match'
   fs/fs_context.c:168: warning: Function parameter or member 'fc' not described in 'vfs_parse_fs_string'
   fs/fs_context.c:168: warning: Function parameter or member 'key' not described in 'vfs_parse_fs_string'
   fs/fs_context.c:168: warning: Function parameter or member 'value' not described in 'vfs_parse_fs_string'
   fs/fs_context.c:168: warning: Function parameter or member 'v_size' not described in 'vfs_parse_fs_string'
   fs/fs_context.c:202: warning: Function parameter or member 'fc' not described in 'generic_parse_monolithic'
   fs/fs_context.c:202: warning: Excess function parameter 'ctx' description in 'generic_parse_monolithic'
   fs/fs_context.c:340: warning: expecting prototype for vfs_dup_fc_config(). Prototype was for vfs_dup_fs_context() instead
   fs/fs_context.c:386: warning: Function parameter or member 'log' not described in 'logfc'
   fs/fs_context.c:386: warning: Function parameter or member 'prefix' not described in 'logfc'
   fs/fs_context.c:386: warning: Function parameter or member 'level' not described in 'logfc'
   fs/fs_context.c:386: warning: Excess function parameter 'fc' description in 'logfc'
   drivers/acpi/x86/apple.c:27:6: warning: no previous prototype for 'acpi_extract_apple_properties' [-Wmissing-prototypes]
      27 | void acpi_extract_apple_properties(struct acpi_device *adev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/feat_ctl.c:105:6: warning: no previous prototype for 'init_ia32_feat_ctl' [-Wmissing-prototypes]
     105 | void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
         |      ^~~~~~~~~~~~~~~~~~
   fs/kernel_read_file.c:38: warning: Function parameter or member 'file' not described in 'kernel_read_file'
   fs/kernel_read_file.c:38: warning: Function parameter or member 'offset' not described in 'kernel_read_file'
   fs/kernel_read_file.c:38: warning: Function parameter or member 'buf' not described in 'kernel_read_file'
   fs/kernel_read_file.c:38: warning: Function parameter or member 'buf_size' not described in 'kernel_read_file'
   fs/kernel_read_file.c:38: warning: Function parameter or member 'file_size' not described in 'kernel_read_file'
   fs/kernel_read_file.c:38: warning: Function parameter or member 'id' not described in 'kernel_read_file'
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
   drivers/acpi/acpi_lpit.c:148:6: warning: no previous prototype for 'acpi_init_lpit' [-Wmissing-prototypes]
     148 | void acpi_init_lpit(void)
         |      ^~~~~~~~~~~~~~
   drivers/acpi/acpi_watchdog.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Returns true if this system should prefer ACPI based watchdog instead of
   lib/scatterlist.c:286: warning: Function parameter or member 'first_chunk' not described in '__sg_alloc_table'
   lib/scatterlist.c:788: warning: Function parameter or member 'flags' not described in 'sg_miter_start'
   drivers/tty/n_hdlc.c:145: warning: Function parameter or member 'write_work' not described in 'n_hdlc'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
