Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB9B56C5F2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 04:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiGICQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 22:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGICQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 22:16:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95B06C113;
        Fri,  8 Jul 2022 19:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657332979; x=1688868979;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Sc6zczLXkls6PU3MH7wWrl0qoAo4bn1MC33RQ0+2GM0=;
  b=DBRLpsm8ehfwkwIQnbR9wPWfKIKlcoO+fRsxhEwRNVYfPaDbLMxcK0de
   YIfkstSbe1/GXXimI5zVAMJxN2a+6Mxlkx/sgGUUzltNtRVlQ8DegLfST
   SVrcMHtoRNnqUt8e2yrEnQUp+JEO6upsVKVeXXbMcwH5rr72QkU7HuMxx
   EityqYcXXysuwnuiw2e34twYPUUiHlFEa0MRQtepBFn3G345FQy4vBpu6
   7GHcMdYaEFbCk0MBMH2i3Xeu3v6dvtPcCBQ0hvi2GfDcXHluIAyQ4QHWq
   pTvmnra01msoRHN05IZE3nf8z1nLsWgHN1dh3S201S/iNFdEv0fc9pFaF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="284421941"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="284421941"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 19:16:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="661963491"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jul 2022 19:16:17 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA012-000OC0-Uh;
        Sat, 09 Jul 2022 02:16:16 +0000
Date:   Sat, 9 Jul 2022 10:15:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 232/411] htmldocs:
 Documentation/virt/kvm/intel-tdx.rst:181: WARNING: Enumerated list ends
 without a blank line; unexpected unindent.
Message-ID: <202207091001.5NGaL7w8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   36253a6ed7e922a2e6888cde465578b98145404e
commit: 1737432c5b003b60834d57951e77ef3d6236d445 [232/411] Documentation/virtual/kvm: Document on Trust Domain Extensions(TDX)
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/virt/kvm/intel-tdx.rst:181: WARNING: Enumerated list ends without a blank line; unexpected unindent.
>> Documentation/virt/kvm/intel-tdx.rst:219: WARNING: Unexpected indentation.
>> Documentation/virt/kvm/intel-tdx.rst:223: WARNING: Block quote ends without a blank line; unexpected unindent.
>> Documentation/virt/kvm/intel-tdx.rst:239: WARNING: Bullet list ends without a blank line; unexpected unindent.
>> Documentation/virt/kvm/intel-tdx.rst:353: WARNING: Footnote is not referenced.
>> Documentation/virt/kvm/intel-tdx.rst: WARNING: document isn't included in any toctree

vim +181 Documentation/virt/kvm/intel-tdx.rst

   179	
   180	#. system wide capability check
 > 181	  * KVM_CAP_VM_TYPES: check if VM type is supported and if TDX_VM_TYPE is
   182	    supported.
   183	
   184	#. creating VM
   185	  * KVM_CREATE_VM
   186	  * KVM_TDX_CAPABILITIES: query if TDX is supported on the platform.
   187	  * KVM_TDX_INIT_VM: pass TDX specific VM parameters.
   188	
   189	#. creating VCPU
   190	  * KVM_CREATE_VCPU
   191	  * KVM_TDX_INIT_VCPU: pass TDX specific VCPU parameters.
   192	
   193	#. initializing guest memory
   194	  * allocate guest memory and initialize page same to normal KVM case
   195	    In TDX case, parse and load TDVF into guest memory in addition.
   196	  * KVM_TDX_INIT_MEM_REGION to add and measure guest pages.
   197	    If the pages has contents above, those pages need to be added.
   198	    Otherwise the contents will be lost and guest sees zero pages.
   199	  * KVM_TDX_FINALIAZE_VM: Finalize VM and measurement
   200	    This must be after KVM_TDX_INIT_MEM_REGION.
   201	
   202	#. run vcpu
   203	
   204	Design discussion
   205	=================
   206	
   207	Coexistence of normal(VMX) VM and TD VM
   208	---------------------------------------
   209	It's required to allow both legacy(normal VMX) VMs and new TD VMs to
   210	coexist. Otherwise the benefits of VM flexibility would be eliminated.
   211	The main issue for it is that the logic of kvm_x86_ops callbacks for
   212	TDX is different from VMX. On the other hand, the variable,
   213	kvm_x86_ops, is global single variable. Not per-VM, not per-vcpu.
   214	
   215	Several points to be considered.
   216	  . No or minimal overhead when TDX is disabled(CONFIG_INTEL_TDX_HOST=n).
   217	  . Avoid overhead of indirect call via function pointers.
   218	  . Contain the changes under arch/x86/kvm/vmx directory and share logic
 > 219	    with VMX for maintenance.
   220	    Even though the ways to operation on VM (VMX instruction vs TDX
   221	    SEAM call) is different, the basic idea remains same. So, many
   222	    logic can be shared.
 > 223	  . Future maintenance
   224	    The huge change of kvm_x86_ops in (near) future isn't expected.
   225	    a centralized file is acceptable.
   226	
   227	- Wrapping kvm x86_ops: The current choice
   228	  Introduce dedicated file for arch/x86/kvm/vmx/main.c (the name,
   229	  main.c, is just chosen to show main entry points for callbacks.) and
   230	  wrapper functions around all the callbacks with
   231	  "if (is-tdx) tdx-callback() else vmx-callback()".
   232	
   233	  Pros:
   234	  - No major change in common x86 KVM code. The change is (mostly)
   235	    contained under arch/x86/kvm/vmx/.
   236	  - When TDX is disabled(CONFIG_INTEL_TDX_HOST=n), the overhead is
   237	    optimized out.
   238	  - Micro optimization by avoiding function pointer.
 > 239	  Cons:
   240	  - Many boiler plates in arch/x86/kvm/vmx/main.c.
   241	
   242	Alternative:
   243	- Introduce another callback layer under arch/x86/kvm/vmx.
   244	  Pros:
   245	  - No major change in common x86 KVM code. The change is (mostly)
   246	    contained under arch/x86/kvm/vmx/.
   247	  - clear separation on callbacks.
   248	  Cons:
   249	  - overhead in VMX even when TDX is disabled(CONFIG_INTEL_TDX_HOST=n).
   250	
   251	- Allow per-VM kvm_x86_ops callbacks instead of global kvm_x86_ops
   252	  Pros:
   253	  - clear separation on callbacks.
   254	  Cons:
   255	  - Big change in common x86 code.
   256	  - overhead in common code even when TDX is
   257	    disabled(CONFIG_INTEL_TDX_HOST=n).
   258	
   259	- Introduce new directory arch/x86/kvm/tdx
   260	  Pros:
   261	  - It clarifies that TDX is different from VMX.
   262	  Cons:
   263	  - Given the level of code sharing, it complicates code sharing.
   264	
   265	KVM MMU Changes
   266	---------------
   267	KVM MMU needs to be enhanced to handle Secure/Shared-EPT. The
   268	high-level execution flow is mostly same to normal EPT case.
   269	EPT violation/misconfiguration -> invoke TDP fault handler ->
   270	resolve TDP fault -> resume execution. (or emulate MMIO)
   271	The difference is, that S-EPT is operated(read/write) via TDX SEAM
   272	call which is expensive instead of direct read/write EPT entry.
   273	One bit of GPA (51 or 47 bit) is repurposed so that it means shared
   274	with host(if set to 1) or private to TD(if cleared to 0).
   275	
   276	- The current implementation
   277	  . Reuse the existing MMU code with minimal update.  Because the
   278	    execution flow is mostly same. But additional operation, TDX call
   279	    for S-EPT, is needed. So add hooks for it to kvm_x86_ops.
   280	  . For performance, minimize TDX SEAM call to operate on S-EPT. When
   281	    getting corresponding S-EPT pages/entry from faulting GPA, don't
   282	    use TDX SEAM call to read S-EPT entry. Instead create shadow copy
   283	    in host memory.
   284	    Repurpose the existing kvm_mmu_page as shadow copy of S-EPT and
   285	    associate S-EPT to it.
   286	  . Treats share bit as attributes. mask/unmask the bit where
   287	    necessary to keep the existing traversing code works.
   288	    Introduce kvm.arch.gfn_shared_mask and use "if (gfn_share_mask)"
   289	    for special case.
   290	    = 0 : for non-TDX case
   291	    = 51 or 47 bit set for TDX case.
   292	
   293	  Pros:
   294	  - Large code reuse with minimal new hooks.
   295	  - Execution path is same.
   296	  Cons:
   297	  - Complicates the existing code.
   298	  - Repurpose kvm_mmu_page as shadow of Secure-EPT can be confusing.
   299	
   300	Alternative:
   301	- Replace direct read/write on EPT entry with TDX-SEAM call by
   302	  introducing callbacks on EPT entry.
   303	  Pros:
   304	  - Straightforward.
   305	  Cons:
   306	  - Too many touching point.
   307	  - Too slow due to TDX-SEAM call.
   308	  - Overhead even when TDX is disabled(CONFIG_INTEL_TDX_HOST=n).
   309	
   310	- Sprinkle "if (is-tdx)" for TDX special case
   311	  Pros:
   312	  - Straightforward.
   313	  Cons:
   314	  - The result is non-generic and ugly.
   315	  - Put TDX specific logic into common KVM MMU code.
   316	
   317	New KVM API, ioctl (sub)command, to manage TD VMs
   318	-------------------------------------------------
   319	Additional KVM API are needed to control TD VMs. The operations on TD
   320	VMs are specific to TDX.
   321	
   322	- Piggyback and repurpose KVM_MEMORY_ENCRYPT_OP
   323	  Although not all operation isn't memory encryption, repupose to get
   324	  TDX specific ioctls.
   325	  Pros:
   326	  - No major change in common x86 KVM code.
   327	  Cons:
   328	  - The operations aren't actually memory encryption, but operations
   329	    on TD VMs.
   330	
   331	Alternative:
   332	- Introduce new ioctl for guest protection like
   333	  KVM_GUEST_PROTECTION_OP and introduce subcommand for TDX.
   334	  Pros:
   335	  - Clean name.
   336	  Cons:
   337	  - One more new ioctl for guest protection.
   338	  - Confusion with KVM_MEMORY_ENCRYPT_OP with KVM_GUEST_PROTECTION_OP.
   339	
   340	- Rename KVM_MEMORY_ENCRYPT_OP to KVM_GUEST_PROTECTION_OP and keep
   341	  KVM_MEMORY_ENCRYPT_OP as same value for user API for compatibility.
   342	  "#define KVM_MEMORY_ENCRYPT_OP KVM_GUEST_PROTECTION_OP" for uapi
   343	  compatibility.
   344	  Pros:
   345	  - No new ioctl with more suitable name.
   346	  Cons:
   347	  - May cause confusion to the existing user program.
   348	
   349	
   350	References
   351	==========
   352	
 > 353	.. [1] TDX specification
   354	   https://software.intel.com/content/www/us/en/develop/articles/intel-trust-domain-extensions.html
   355	.. [2] Intel Trust Domain Extensions (Intel TDX)
   356	   https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-whitepaper-final9-17.pdf
   357	.. [3] Intel CPU Architectural Extensions Specification
   358	   https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-cpu-architectural-specification.pdf
   359	.. [4] Intel TDX Module 1.0 EAS
   360	   https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-module-1eas.pdf
   361	.. [5] Intel TDX Loader Interface Specification
   362	   https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-seamldr-interface-specification.pdf
   363	.. [6] Intel TDX Guest-Hypervisor Communication Interface
   364	   https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf
   365	.. [7] Intel TDX Virtual Firmware Design Guide
   366	   https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-virtual-firmware-design-guide-rev-1.
   367	.. [8] intel public github
   368	   kvm TDX branch: https://github.com/intel/tdx/tree/kvm
   369	   TDX guest branch: https://github.com/intel/tdx/tree/guest
   370	.. [9] tdvf
   371	    https://github.com/tianocore/edk2-staging/tree/TDVF
 > 372	.. [10] KVM forum 2020: Intel Virtualization Technology Extensions to

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
