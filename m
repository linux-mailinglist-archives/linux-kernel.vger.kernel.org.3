Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228C35A7308
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiHaAxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiHaAxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:53:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7B37644B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661907224; x=1693443224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ru8+fm29fVTZx8A/XKMu5rYXnHE8oVVQQKiLV5djses=;
  b=aadooxyws9I+WOGnUsqpEYTW4QKUwnCQ08wxxnStHrpWJo/LtaYj2D85
   oa5dPkkjtg+RiEJ4cnMnTg4A8r/geq4CQWHdDf5dW6dtWB10p2Yrr2Ffq
   KO8VHQgL5gVNAPsWju9bmNeetQ5h6qjEys2tIeoMbFb5Go0V3yeTGJ8OL
   RgVI/nQZ1z3TV9sJkfc0t7RGgyavOQn26HAERkpBQmDLLjctym36rQunD
   YYM7hqsasmsi+II8PA3m3BgXGr2fMZQCyvWZMICgwFr6DJOPhlFX2T+wq
   jOmgiiRYxh/BwrZnXLoiLwWvpttE0OGG4845Zy/VmDzl+uMF5nWYXzX3+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="295345342"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="295345342"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 17:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="562868039"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 17:53:41 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTBzB-0000oO-0M;
        Wed, 31 Aug 2022 00:53:41 +0000
Date:   Wed, 31 Aug 2022 08:52:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Like Xu <likexu@tencent.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: arch/x86/include/asm/kvm-x86-ops.h:17 kvm_ops_update() warn:
 inconsistent indenting
Message-ID: <202208310821.chccoSYt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
commit: fdc298da866165ec0288fe227982f1aa0467bf5c KVM: x86: Move kvm_ops_static_call_update() to x86.c
date:   5 months ago
config: x86_64-randconfig-m001-20220829 (https://download.01.org/0day-ci/archive/20220831/202208310821.chccoSYt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
arch/x86/include/asm/kvm-x86-ops.h:17 kvm_ops_update() warn: inconsistent indenting

Old smatch warnings:
arch/x86/kvm/x86.c:5174 kvm_arch_tsc_set_attr() warn: check for integer overflow 'offset'
arch/x86/kvm/x86.c:5215 kvm_vcpu_ioctl_device_attr() error: uninitialized symbol 'r'.

vim +17 arch/x86/include/asm/kvm-x86-ops.h

9af5471bdbb2a2 Jason Baron         2021-01-14    5  
9af5471bdbb2a2 Jason Baron         2021-01-14    6  /*
e4fc23bad81359 Paolo Bonzini       2021-12-09    7   * KVM_X86_OP() and KVM_X86_OP_OPTIONAL() are used to help generate
e4fc23bad81359 Paolo Bonzini       2021-12-09    8   * both DECLARE/DEFINE_STATIC_CALL() invocations and
e4fc23bad81359 Paolo Bonzini       2021-12-09    9   * "static_call_update()" calls.
e4fc23bad81359 Paolo Bonzini       2021-12-09   10   *
e4fc23bad81359 Paolo Bonzini       2021-12-09   11   * KVM_X86_OP_OPTIONAL() can be used for those functions that can have
e4fc23bad81359 Paolo Bonzini       2021-12-09   12   * a NULL definition, for example if "static_call_cond()" will be used
5be2226f417d5b Paolo Bonzini       2022-02-15   13   * at the call sites.  KVM_X86_OP_OPTIONAL_RET0() can be used likewise
5be2226f417d5b Paolo Bonzini       2022-02-15   14   * to make a definition optional, but in this case the default will
5be2226f417d5b Paolo Bonzini       2022-02-15   15   * be __static_call_return0.
9af5471bdbb2a2 Jason Baron         2021-01-14   16   */
e4fc23bad81359 Paolo Bonzini       2021-12-09  @17  KVM_X86_OP(hardware_enable)
e4fc23bad81359 Paolo Bonzini       2021-12-09   18  KVM_X86_OP(hardware_disable)
e4fc23bad81359 Paolo Bonzini       2021-12-09   19  KVM_X86_OP(hardware_unsetup)
9af5471bdbb2a2 Jason Baron         2021-01-14   20  KVM_X86_OP(has_emulated_msr)
9af5471bdbb2a2 Jason Baron         2021-01-14   21  KVM_X86_OP(vcpu_after_set_cpuid)
9af5471bdbb2a2 Jason Baron         2021-01-14   22  KVM_X86_OP(vm_init)
e4fc23bad81359 Paolo Bonzini       2021-12-09   23  KVM_X86_OP_OPTIONAL(vm_destroy)
9af5471bdbb2a2 Jason Baron         2021-01-14   24  KVM_X86_OP(vcpu_create)
9af5471bdbb2a2 Jason Baron         2021-01-14   25  KVM_X86_OP(vcpu_free)
9af5471bdbb2a2 Jason Baron         2021-01-14   26  KVM_X86_OP(vcpu_reset)
e27bc0440ebd14 Sean Christopherson 2022-01-28   27  KVM_X86_OP(prepare_switch_to_guest)
9af5471bdbb2a2 Jason Baron         2021-01-14   28  KVM_X86_OP(vcpu_load)
9af5471bdbb2a2 Jason Baron         2021-01-14   29  KVM_X86_OP(vcpu_put)
9af5471bdbb2a2 Jason Baron         2021-01-14   30  KVM_X86_OP(update_exception_bitmap)
9af5471bdbb2a2 Jason Baron         2021-01-14   31  KVM_X86_OP(get_msr)
9af5471bdbb2a2 Jason Baron         2021-01-14   32  KVM_X86_OP(set_msr)
9af5471bdbb2a2 Jason Baron         2021-01-14   33  KVM_X86_OP(get_segment_base)
9af5471bdbb2a2 Jason Baron         2021-01-14   34  KVM_X86_OP(get_segment)
9af5471bdbb2a2 Jason Baron         2021-01-14   35  KVM_X86_OP(get_cpl)
9af5471bdbb2a2 Jason Baron         2021-01-14   36  KVM_X86_OP(set_segment)
e4fc23bad81359 Paolo Bonzini       2021-12-09   37  KVM_X86_OP(get_cs_db_l_bits)
9af5471bdbb2a2 Jason Baron         2021-01-14   38  KVM_X86_OP(set_cr0)
e4fc23bad81359 Paolo Bonzini       2021-12-09   39  KVM_X86_OP_OPTIONAL(post_set_cr3)
9af5471bdbb2a2 Jason Baron         2021-01-14   40  KVM_X86_OP(is_valid_cr4)
9af5471bdbb2a2 Jason Baron         2021-01-14   41  KVM_X86_OP(set_cr4)
9af5471bdbb2a2 Jason Baron         2021-01-14   42  KVM_X86_OP(set_efer)
9af5471bdbb2a2 Jason Baron         2021-01-14   43  KVM_X86_OP(get_idt)
9af5471bdbb2a2 Jason Baron         2021-01-14   44  KVM_X86_OP(set_idt)
9af5471bdbb2a2 Jason Baron         2021-01-14   45  KVM_X86_OP(get_gdt)
9af5471bdbb2a2 Jason Baron         2021-01-14   46  KVM_X86_OP(set_gdt)
9af5471bdbb2a2 Jason Baron         2021-01-14   47  KVM_X86_OP(sync_dirty_debug_regs)
9af5471bdbb2a2 Jason Baron         2021-01-14   48  KVM_X86_OP(set_dr7)
9af5471bdbb2a2 Jason Baron         2021-01-14   49  KVM_X86_OP(cache_reg)
9af5471bdbb2a2 Jason Baron         2021-01-14   50  KVM_X86_OP(get_rflags)
9af5471bdbb2a2 Jason Baron         2021-01-14   51  KVM_X86_OP(set_rflags)
c5063551bfcae4 Marc Orr            2021-12-09   52  KVM_X86_OP(get_if_flag)
e27bc0440ebd14 Sean Christopherson 2022-01-28   53  KVM_X86_OP(flush_tlb_all)
e27bc0440ebd14 Sean Christopherson 2022-01-28   54  KVM_X86_OP(flush_tlb_current)
e4fc23bad81359 Paolo Bonzini       2021-12-09   55  KVM_X86_OP_OPTIONAL(tlb_remote_flush)
e4fc23bad81359 Paolo Bonzini       2021-12-09   56  KVM_X86_OP_OPTIONAL(tlb_remote_flush_with_range)
e27bc0440ebd14 Sean Christopherson 2022-01-28   57  KVM_X86_OP(flush_tlb_gva)
e27bc0440ebd14 Sean Christopherson 2022-01-28   58  KVM_X86_OP(flush_tlb_guest)
fc4fad79fc3d88 Sean Christopherson 2021-12-28   59  KVM_X86_OP(vcpu_pre_run)
e27bc0440ebd14 Sean Christopherson 2022-01-28   60  KVM_X86_OP(vcpu_run)
e4fc23bad81359 Paolo Bonzini       2021-12-09   61  KVM_X86_OP(handle_exit)
e4fc23bad81359 Paolo Bonzini       2021-12-09   62  KVM_X86_OP(skip_emulated_instruction)
e4fc23bad81359 Paolo Bonzini       2021-12-09   63  KVM_X86_OP_OPTIONAL(update_emulated_instruction)
9af5471bdbb2a2 Jason Baron         2021-01-14   64  KVM_X86_OP(set_interrupt_shadow)
9af5471bdbb2a2 Jason Baron         2021-01-14   65  KVM_X86_OP(get_interrupt_shadow)
9af5471bdbb2a2 Jason Baron         2021-01-14   66  KVM_X86_OP(patch_hypercall)
e27bc0440ebd14 Sean Christopherson 2022-01-28   67  KVM_X86_OP(inject_irq)
e27bc0440ebd14 Sean Christopherson 2022-01-28   68  KVM_X86_OP(inject_nmi)
9af5471bdbb2a2 Jason Baron         2021-01-14   69  KVM_X86_OP(queue_exception)
9af5471bdbb2a2 Jason Baron         2021-01-14   70  KVM_X86_OP(cancel_injection)
9af5471bdbb2a2 Jason Baron         2021-01-14   71  KVM_X86_OP(interrupt_allowed)
9af5471bdbb2a2 Jason Baron         2021-01-14   72  KVM_X86_OP(nmi_allowed)
9af5471bdbb2a2 Jason Baron         2021-01-14   73  KVM_X86_OP(get_nmi_mask)
9af5471bdbb2a2 Jason Baron         2021-01-14   74  KVM_X86_OP(set_nmi_mask)
9af5471bdbb2a2 Jason Baron         2021-01-14   75  KVM_X86_OP(enable_nmi_window)
9af5471bdbb2a2 Jason Baron         2021-01-14   76  KVM_X86_OP(enable_irq_window)
e4fc23bad81359 Paolo Bonzini       2021-12-09   77  KVM_X86_OP_OPTIONAL(update_cr8_intercept)
9af5471bdbb2a2 Jason Baron         2021-01-14   78  KVM_X86_OP(check_apicv_inhibit_reasons)
9af5471bdbb2a2 Jason Baron         2021-01-14   79  KVM_X86_OP(refresh_apicv_exec_ctrl)
abb6d479e22642 Paolo Bonzini       2022-02-08   80  KVM_X86_OP_OPTIONAL(hwapic_irr_update)
abb6d479e22642 Paolo Bonzini       2022-02-08   81  KVM_X86_OP_OPTIONAL(hwapic_isr_update)
5be2226f417d5b Paolo Bonzini       2022-02-15   82  KVM_X86_OP_OPTIONAL_RET0(guest_apic_has_interrupt)
abb6d479e22642 Paolo Bonzini       2022-02-08   83  KVM_X86_OP_OPTIONAL(load_eoi_exitmap)
abb6d479e22642 Paolo Bonzini       2022-02-08   84  KVM_X86_OP_OPTIONAL(set_virtual_apic_mode)
e4fc23bad81359 Paolo Bonzini       2021-12-09   85  KVM_X86_OP_OPTIONAL(set_apic_access_page_addr)
57dfd7b53dec74 Sean Christopherson 2022-01-28   86  KVM_X86_OP(deliver_interrupt)
e4fc23bad81359 Paolo Bonzini       2021-12-09   87  KVM_X86_OP_OPTIONAL(sync_pir_to_irr)
5be2226f417d5b Paolo Bonzini       2022-02-15   88  KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
5be2226f417d5b Paolo Bonzini       2022-02-15   89  KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
bf07be36cd881b Maxim Levitsky      2022-03-18   90  KVM_X86_OP(get_mt_mask)
9af5471bdbb2a2 Jason Baron         2021-01-14   91  KVM_X86_OP(load_mmu_pgd)
e4fc23bad81359 Paolo Bonzini       2021-12-09   92  KVM_X86_OP(has_wbinvd_exit)
307a94c721fed1 Ilias Stamatis      2021-05-26   93  KVM_X86_OP(get_l2_tsc_offset)
307a94c721fed1 Ilias Stamatis      2021-05-26   94  KVM_X86_OP(get_l2_tsc_multiplier)
edcfe54058114c Ilias Stamatis      2021-05-26   95  KVM_X86_OP(write_tsc_offset)
1ab9287add5e26 Ilias Stamatis      2021-06-07   96  KVM_X86_OP(write_tsc_multiplier)
9af5471bdbb2a2 Jason Baron         2021-01-14   97  KVM_X86_OP(get_exit_info)
9af5471bdbb2a2 Jason Baron         2021-01-14   98  KVM_X86_OP(check_intercept)
9af5471bdbb2a2 Jason Baron         2021-01-14   99  KVM_X86_OP(handle_exit_irqoff)
e4fc23bad81359 Paolo Bonzini       2021-12-09  100  KVM_X86_OP(request_immediate_exit)
9af5471bdbb2a2 Jason Baron         2021-01-14  101  KVM_X86_OP(sched_in)
e4fc23bad81359 Paolo Bonzini       2021-12-09  102  KVM_X86_OP_OPTIONAL(update_cpu_dirty_logging)
e4fc23bad81359 Paolo Bonzini       2021-12-09  103  KVM_X86_OP_OPTIONAL(vcpu_blocking)
e4fc23bad81359 Paolo Bonzini       2021-12-09  104  KVM_X86_OP_OPTIONAL(vcpu_unblocking)
e4fc23bad81359 Paolo Bonzini       2021-12-09  105  KVM_X86_OP_OPTIONAL(pi_update_irte)
e4fc23bad81359 Paolo Bonzini       2021-12-09  106  KVM_X86_OP_OPTIONAL(pi_start_assignment)
abb6d479e22642 Paolo Bonzini       2022-02-08  107  KVM_X86_OP_OPTIONAL(apicv_post_state_restore)
5be2226f417d5b Paolo Bonzini       2022-02-15  108  KVM_X86_OP_OPTIONAL_RET0(dy_apicv_has_pending_interrupt)
e4fc23bad81359 Paolo Bonzini       2021-12-09  109  KVM_X86_OP_OPTIONAL(set_hv_timer)
e4fc23bad81359 Paolo Bonzini       2021-12-09  110  KVM_X86_OP_OPTIONAL(cancel_hv_timer)
9af5471bdbb2a2 Jason Baron         2021-01-14  111  KVM_X86_OP(setup_mce)
9af5471bdbb2a2 Jason Baron         2021-01-14  112  KVM_X86_OP(smi_allowed)
ecc513e5bb7ed5 Sean Christopherson 2021-06-09  113  KVM_X86_OP(enter_smm)
ecc513e5bb7ed5 Sean Christopherson 2021-06-09  114  KVM_X86_OP(leave_smm)
9af5471bdbb2a2 Jason Baron         2021-01-14  115  KVM_X86_OP(enable_smi_window)
e4fc23bad81359 Paolo Bonzini       2021-12-09  116  KVM_X86_OP_OPTIONAL(mem_enc_ioctl)
e4fc23bad81359 Paolo Bonzini       2021-12-09  117  KVM_X86_OP_OPTIONAL(mem_enc_register_region)
e4fc23bad81359 Paolo Bonzini       2021-12-09  118  KVM_X86_OP_OPTIONAL(mem_enc_unregister_region)
e4fc23bad81359 Paolo Bonzini       2021-12-09  119  KVM_X86_OP_OPTIONAL(vm_copy_enc_context_from)
e4fc23bad81359 Paolo Bonzini       2021-12-09  120  KVM_X86_OP_OPTIONAL(vm_move_enc_context_from)
9af5471bdbb2a2 Jason Baron         2021-01-14  121  KVM_X86_OP(get_msr_feature)
9af5471bdbb2a2 Jason Baron         2021-01-14  122  KVM_X86_OP(can_emulate_instruction)
9af5471bdbb2a2 Jason Baron         2021-01-14  123  KVM_X86_OP(apic_init_signal_blocked)
e4fc23bad81359 Paolo Bonzini       2021-12-09  124  KVM_X86_OP_OPTIONAL(enable_direct_tlbflush)
e4fc23bad81359 Paolo Bonzini       2021-12-09  125  KVM_X86_OP_OPTIONAL(migrate_timers)
9af5471bdbb2a2 Jason Baron         2021-01-14  126  KVM_X86_OP(msr_filter_changed)
e4fc23bad81359 Paolo Bonzini       2021-12-09  127  KVM_X86_OP(complete_emulated_msr)
a0941a64a97d50 Sean Christopherson 2022-01-28  128  KVM_X86_OP(vcpu_deliver_sipi_vector)
d5fa597ed87047 Maxim Levitsky      2022-03-22  129  KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
9af5471bdbb2a2 Jason Baron         2021-01-14  130  

:::::: The code at line 17 was first introduced by commit
:::::: e4fc23bad813591417f466beb7e833cdd2089cf6 KVM: x86: remove KVM_X86_OP_NULL and mark optional kvm_x86_ops

:::::: TO: Paolo Bonzini <pbonzini@redhat.com>
:::::: CC: Paolo Bonzini <pbonzini@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
