Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF8579514
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiGSIQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGSIQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:16:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D0212615
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658218602; x=1689754602;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QbAr/SFwirFHw4azDiTl0P7N/aavr2qqMXYY3TPkjqI=;
  b=GaWsPb8SkJZ+9Ursg1NUkBEAeqQodNjWQbDozji9jrfOvBbMdJxnSl9f
   n63n316wGhNaw9sT8wW3+ts2BeHZwmvSqpcrKGp+S6xHMKWXbuAMua9YX
   XZLLSBpNMIo2H9eQkgU+fCp4R9aNLKNS1eNVnse+yjD3MJApUbtrAvB7f
   /SImPmaL4qLJt2M1G6x9+iR2bL0SVVwgcagmxFAPUbElNb4CEMdswMLN4
   GPgSFooUg4qYNjFcACWtnfx6ji9ex+VEfO+YRjRUNYOdYTJhCR4kOwb0E
   /9Gyejvq/ieGv8elr8CZ4UXBoVi4E/DDBA5yrUbVgZweGOCGZJH/KHKOl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="372733866"
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="372733866"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 01:16:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="724174977"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Jul 2022 01:16:40 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDiPH-0005QQ-Tl;
        Tue, 19 Jul 2022 08:16:39 +0000
Date:   Tue, 19 Jul 2022 16:16:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: include/kvm_util_base.h:247:35: warning: 'struct kvm_nested_state'
 declared inside parameter list will not be visible outside of this
 definition or declaration
Message-ID: <202207191649.MYYZt4sP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca85855bdcae8f84f1512e88b4c75009ea17ea2f
commit: 7d9a662ed9f0403e7b94940dceb81552b8edb931 kvm: selftests: move base kvm_util.h declarations to kvm_util_base.h
date:   6 months ago
reproduce: make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/kvm_util.h:10,
                    from lib/elf.c:13:
>> include/kvm_util_base.h:247:35: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
     247 |                            struct kvm_nested_state *state);
         |                                   ^~~~~~~~~~~~~~~~
   include/kvm_util_base.h:249:34: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
     249 |                           struct kvm_nested_state *state, bool ignore_error);
         |                                  ^~~~~~~~~~~~~~~~
--
   In file included from include/kvm_util.h:10,
                    from lib/kvm_util.c:10:
>> include/kvm_util_base.h:247:35: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
     247 |                            struct kvm_nested_state *state);
         |                                   ^~~~~~~~~~~~~~~~
   include/kvm_util_base.h:249:34: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
     249 |                           struct kvm_nested_state *state, bool ignore_error);
         |                                  ^~~~~~~~~~~~~~~~
   lib/kvm_util.c: In function 'vm_enable_dirty_ring':
   lib/kvm_util.c:143:19: error: 'KVM_CAP_DIRTY_LOG_RING' undeclared (first use in this function); did you mean 'KVM_CAP_IRQ_ROUTING'?
     143 |         cap.cap = KVM_CAP_DIRTY_LOG_RING;
         |                   ^~~~~~~~~~~~~~~~~~~~~~
         |                   KVM_CAP_IRQ_ROUTING
   lib/kvm_util.c:143:19: note: each undeclared identifier is reported only once for each function it appears in
   lib/kvm_util.c: In function 'kvm_vm_clear_dirty_log':
   lib/kvm_util.c:468:16: error: variable 'args' has initializer but incomplete type
     468 |         struct kvm_clear_dirty_log args = { .dirty_bitmap = log, .slot = slot,
         |                ^~~~~~~~~~~~~~~~~~~
   lib/kvm_util.c:468:46: error: 'struct kvm_clear_dirty_log' has no member named 'dirty_bitmap'
     468 |         struct kvm_clear_dirty_log args = { .dirty_bitmap = log, .slot = slot,
         |                                              ^~~~~~~~~~~~
   lib/kvm_util.c:468:61: warning: excess elements in struct initializer
     468 |         struct kvm_clear_dirty_log args = { .dirty_bitmap = log, .slot = slot,
         |                                                             ^~~
   lib/kvm_util.c:468:61: note: (near initialization for 'args')
   lib/kvm_util.c:468:67: error: 'struct kvm_clear_dirty_log' has no member named 'slot'
     468 |         struct kvm_clear_dirty_log args = { .dirty_bitmap = log, .slot = slot,
         |                                                                   ^~~~
   lib/kvm_util.c:468:74: warning: excess elements in struct initializer
     468 |         struct kvm_clear_dirty_log args = { .dirty_bitmap = log, .slot = slot,
         |                                                                          ^~~~
   lib/kvm_util.c:468:74: note: (near initialization for 'args')
   lib/kvm_util.c:469:46: error: 'struct kvm_clear_dirty_log' has no member named 'first_page'
     469 |                                             .first_page = first_page,
         |                                              ^~~~~~~~~~
   lib/kvm_util.c:469:59: warning: excess elements in struct initializer
     469 |                                             .first_page = first_page,
         |                                                           ^~~~~~~~~~
   lib/kvm_util.c:469:59: note: (near initialization for 'args')
   lib/kvm_util.c:470:46: error: 'struct kvm_clear_dirty_log' has no member named 'num_pages'
     470 |                                             .num_pages = num_pages };
         |                                              ^~~~~~~~~
   lib/kvm_util.c:470:58: warning: excess elements in struct initializer
     470 |                                             .num_pages = num_pages };
         |                                                          ^~~~~~~~~
   lib/kvm_util.c:470:58: note: (near initialization for 'args')
   lib/kvm_util.c:468:36: error: storage size of 'args' isn't known
     468 |         struct kvm_clear_dirty_log args = { .dirty_bitmap = log, .slot = slot,
         |                                    ^~~~
   lib/kvm_util.c:473:29: error: 'KVM_CLEAR_DIRTY_LOG' undeclared (first use in this function); did you mean 'KVM_GET_DIRTY_LOG'?
     473 |         ret = ioctl(vm->fd, KVM_CLEAR_DIRTY_LOG, &args);
         |                             ^~~~~~~~~~~~~~~~~~~
         |                             KVM_GET_DIRTY_LOG
   lib/kvm_util.c:468:36: warning: unused variable 'args' [-Wunused-variable]
     468 |         struct kvm_clear_dirty_log args = { .dirty_bitmap = log, .slot = slot,
         |                                    ^~~~
   lib/kvm_util.c: In function 'kvm_vm_reset_dirty_ring':
   lib/kvm_util.c:480:30: error: 'KVM_RESET_DIRTY_RINGS' undeclared (first use in this function); did you mean 'KVM_GET_DIRTY_LOG'?
     480 |         return ioctl(vm->fd, KVM_RESET_DIRTY_RINGS);
         |                              ^~~~~~~~~~~~~~~~~~~~~
         |                              KVM_GET_DIRTY_LOG
   lib/kvm_util.c: At top level:
   lib/kvm_util.c:1748:35: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
    1748 |                            struct kvm_nested_state *state)
         |                                   ^~~~~~~~~~~~~~~~
   lib/kvm_util.c:1747:6: error: conflicting types for 'vcpu_nested_state_get'; have 'void(struct kvm_vm *, uint32_t,  struct kvm_nested_state *)' {aka 'void(struct kvm_vm *, unsigned int,  struct kvm_nested_state *)'}
    1747 | void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
         |      ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/kvm_util.h:10,
                    from lib/kvm_util.c:10:
   include/kvm_util_base.h:246:6: note: previous declaration of 'vcpu_nested_state_get' with type 'void(struct kvm_vm *, uint32_t,  struct kvm_nested_state *)' {aka 'void(struct kvm_vm *, unsigned int,  struct kvm_nested_state *)'}
     246 | void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
         |      ^~~~~~~~~~~~~~~~~~~~~
   lib/kvm_util.c: In function 'vcpu_nested_state_get':
   lib/kvm_util.c:1755:31: error: 'KVM_GET_NESTED_STATE' undeclared (first use in this function); did you mean 'KVM_GET_MP_STATE'?
    1755 |         ret = ioctl(vcpu->fd, KVM_GET_NESTED_STATE, state);
         |                               ^~~~~~~~~~~~~~~~~~~~
         |                               KVM_GET_MP_STATE
   lib/kvm_util.c: At top level:
   lib/kvm_util.c:1762:34: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
    1762 |                           struct kvm_nested_state *state, bool ignore_error)
         |                                  ^~~~~~~~~~~~~~~~
   lib/kvm_util.c:1761:5: error: conflicting types for 'vcpu_nested_state_set'; have 'int(struct kvm_vm *, uint32_t,  struct kvm_nested_state *, _Bool)' {aka 'int(struct kvm_vm *, unsigned int,  struct kvm_nested_state *, _Bool)'}
    1761 | int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
         |     ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/kvm_util.h:10,
                    from lib/kvm_util.c:10:
   include/kvm_util_base.h:248:5: note: previous declaration of 'vcpu_nested_state_set' with type 'int(struct kvm_vm *, uint32_t,  struct kvm_nested_state *, _Bool)' {aka 'int(struct kvm_vm *, unsigned int,  struct kvm_nested_state *, _Bool)'}
     248 | int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
         |     ^~~~~~~~~~~~~~~~~~~~~
   lib/kvm_util.c: In function 'vcpu_nested_state_set':
   lib/kvm_util.c:1769:31: error: 'KVM_SET_NESTED_STATE' undeclared (first use in this function); did you mean 'KVM_SET_MP_STATE'?
    1769 |         ret = ioctl(vcpu->fd, KVM_SET_NESTED_STATE, state);
         |                               ^~~~~~~~~~~~~~~~~~~~
         |                               KVM_SET_MP_STATE
   lib/kvm_util.c: In function 'vcpu_map_dirty_ring':
   lib/kvm_util.c:1926:45: error: 'KVM_DIRTY_LOG_PAGE_OFFSET' undeclared (first use in this function); did you mean 'KVM_PIO_PAGE_OFFSET'?
    1926 |                             vm->page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                             KVM_PIO_PAGE_OFFSET
   lib/kvm_util.c:1940:56: error: invalid application of 'sizeof' to incomplete type 'struct kvm_dirty_gfn'
    1940 |                 vcpu->dirty_gfns_count = size / sizeof(struct kvm_dirty_gfn);
         |                                                        ^~~~~~
--
   In file included from include/x86_64/../kvm_util.h:10,
                    from include/x86_64/processor.h:16,
                    from include/x86_64/apic.h:13,
                    from lib/x86_64/apic.c:8:
>> include/x86_64/../kvm_util_base.h:247:35: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
     247 |                            struct kvm_nested_state *state);
         |                                   ^~~~~~~~~~~~~~~~
   include/x86_64/../kvm_util_base.h:249:34: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
     249 |                           struct kvm_nested_state *state, bool ignore_error);
         |                                  ^~~~~~~~~~~~~~~~
--
   In file included from include/kvm_util.h:10,
                    from lib/x86_64/processor.c:9:
>> include/kvm_util_base.h:247:35: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
     247 |                            struct kvm_nested_state *state);
         |                                   ^~~~~~~~~~~~~~~~
   include/kvm_util_base.h:249:34: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
     249 |                           struct kvm_nested_state *state, bool ignore_error);
         |                                  ^~~~~~~~~~~~~~~~
   lib/x86_64/processor.c:1029:41: error: field 'nested' has incomplete type
    1029 |                 struct kvm_nested_state nested;
         |                                         ^~~~~~
   lib/x86_64/processor.c: In function 'vcpu_save_state':
   lib/x86_64/processor.c:1081:45: error: 'KVM_CAP_NESTED_STATE' undeclared (first use in this function); did you mean 'KVM_CAP_PIT_STATE2'?
    1081 |                 nested_size = kvm_check_cap(KVM_CAP_NESTED_STATE);
         |                                             ^~~~~~~~~~~~~~~~~~~~
         |                                             KVM_CAP_PIT_STATE2
   lib/x86_64/processor.c:1081:45: note: each undeclared identifier is reported only once for each function it appears in
   lib/x86_64/processor.c:1131:37: error: 'KVM_GET_NESTED_STATE' undeclared (first use in this function); did you mean 'KVM_GET_MP_STATE'?
    1131 |                 r = ioctl(vcpu->fd, KVM_GET_NESTED_STATE, &state->nested);
         |                                     ^~~~~~~~~~~~~~~~~~~~
         |                                     KVM_GET_MP_STATE
   lib/x86_64/processor.c: In function 'vcpu_load_state':
   lib/x86_64/processor.c:1195:37: error: 'KVM_SET_NESTED_STATE' undeclared (first use in this function); did you mean 'KVM_SET_MP_STATE'?
    1195 |                 r = ioctl(vcpu->fd, KVM_SET_NESTED_STATE, &state->nested);
         |                                     ^~~~~~~~~~~~~~~~~~~~
         |                                     KVM_SET_MP_STATE
   lib/x86_64/processor.c: In function 'kvm_get_supported_hv_cpuid':
   lib/x86_64/processor.c:1381:29: error: 'KVM_GET_SUPPORTED_HV_CPUID' undeclared (first use in this function); did you mean 'KVM_GET_SUPPORTED_CPUID'?
    1381 |         ret = ioctl(kvm_fd, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                             KVM_GET_SUPPORTED_CPUID
   lib/x86_64/processor.c: In function 'vcpu_get_supported_hv_cpuid':
   lib/x86_64/processor.c:1430:32: error: 'KVM_GET_SUPPORTED_HV_CPUID' undeclared (first use in this function); did you mean 'KVM_GET_SUPPORTED_CPUID'?
    1430 |         vcpu_ioctl(vm, vcpuid, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                KVM_GET_SUPPORTED_CPUID
--
   In file included from include/kvm_util.h:10,
                    from lib/x86_64/vmx.c:9:
>> include/kvm_util_base.h:247:35: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
     247 |                            struct kvm_nested_state *state);
         |                                   ^~~~~~~~~~~~~~~~
   include/kvm_util_base.h:249:34: warning: 'struct kvm_nested_state' declared inside parameter list will not be visible outside of this definition or declaration
     249 |                           struct kvm_nested_state *state, bool ignore_error);
         |                                  ^~~~~~~~~~~~~~~~
   lib/x86_64/vmx.c: In function 'vcpu_enable_evmcs':
   lib/x86_64/vmx.c:51:24: error: 'KVM_CAP_HYPERV_ENLIGHTENED_VMCS' undeclared (first use in this function)
      51 |                 .cap = KVM_CAP_HYPERV_ENLIGHTENED_VMCS,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/x86_64/vmx.c:51:24: note: each undeclared identifier is reported only once for each function it appears in

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
