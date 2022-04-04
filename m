Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7A4F0E28
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 06:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377107AbiDDEew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 00:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiDDEet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:34:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3654433341
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 21:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649046774; x=1680582774;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k61BIiHt47+zoqZe+wvBZ66jiaC5QEQHWCcV0QZl8YU=;
  b=LOhO6YxtGDcDg5yeUjr71xz14hshZUq9oIsZSdB4B7C2wqlp9ANzehOZ
   mvG2x/+tjo5zMvk051PU3NI6oUlhsVWYssguekW1KvwID47OHUm/mgts9
   chLYia+6oQ02uaLnbTBWkPw8oBmnDZN86TZ/vlWO4jsOAs2BvW5PNhBI2
   fBc1k+xdUvJ3YeUKWMp/O4ObdqkZ26C3dDMH8MaYf+4mAYMo6K4s9Ljo/
   M+j9hH2sUhNrcljb8cbLvSq0i+6llJFotsXyus0phhBKA5B0eE6Eoghpl
   s/81u7RlpoVbcdiSachKUr/GrcrX2+NTDOdiwWj8UVr+IVjoYZ74Apz/+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="323610542"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="323610542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 21:32:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="696447451"
Received: from slkortic-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.132.173])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 21:32:44 -0700
Message-ID: <7c507b609a6e742ebdcd61ea204d5f05ee0b3b35.camel@intel.com>
Subject: Re: [PATCHv7 30/30] Documentation/x86: Document TDX kernel
 architecture
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 04 Apr 2022 16:32:42 +1200
In-Reply-To: <20220318153048.51177-31-kirill.shutemov@linux.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
         <20220318153048.51177-31-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-18 at 18:30 +0300, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Document the TDX guest architecture details like #VE support,
> shared memory, etc.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  Documentation/x86/index.rst |   1 +
>  Documentation/x86/tdx.rst   | 214 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 215 insertions(+)
>  create mode 100644 Documentation/x86/tdx.rst
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index f498f1d36cd3..382e53ca850a 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -24,6 +24,7 @@ x86-specific Documentation
>     intel-iommu
>     intel_txt
>     amd-memory-encryption
> +   tdx
>     pti
>     mds
>     microcode
> diff --git a/Documentation/x86/tdx.rst b/Documentation/x86/tdx.rst
> new file mode 100644
> index 000000000000..8ca60256511b
> --- /dev/null
> +++ b/Documentation/x86/tdx.rst
> @@ -0,0 +1,214 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +Intel Trust Domain Extensions (TDX)
> +=====================================
> +
> +Intel's Trust Domain Extensions (TDX) protect confidential guest VMs from
> +the host and physical attacks by isolating the guest register state and by
> +encrypting the guest memory. In TDX, a special TDX module sits between the
> +host and the guest, and runs in a special mode and manages the guest/host
> +separation.
> +
> +Since the host cannot directly access guest registers or memory, much
> +normal functionality of a hypervisor must be moved into the guest. This is
> +implemented using a Virtualization Exception (#VE) that is handled by the
> +guest kernel. Some #VEs are handled entirely inside the guest kernel, but
> +some require the hypervisor to be involved.
> +
> +TDX includes new hypercall-like mechanisms for communicating from the
> +guest to the hypervisor or the TDX module.
> +
> +New TDX Exceptions
> +==================

Hi Kirill, all,

TDX host support also introduces some documentation.  Currently a new
tdx_host.rst is added for that since there are non-trivial lines of materials
there too (subject to change of course).  More information here:

https://lore.kernel.org/lkml/cover.1647167475.git.kai.huang@intel.com/T/#m1f51210c0ed72c6dd05abe90453d50740e97ceed

This is not the best way I believe.  I think we have two options here:
1) Having dedicated tdx_guest.rst and tdx_host.rst
2) Having a single tdx.rst to cover both TDX guest and host materials.

I don't know which way is better, perhaps 2).  

Kirill,

If 2) is better, could we add an additional level of menu to represent "TDX
guest support" and make all materials as sub-menu of it, if you need to send out
v8?


> +
> +TDX guests behave differently from bare-metal and traditional VMX guests.
> +In TDX guests, otherwise normal instructions or memory accesses can cause
> +#VE or #GP exceptions.
> +
> +Instructions marked with an '*' conditionally cause exceptions.  The
> +details for these instructions are discussed below.
> +
> +Instruction-based #VE
> +---------------------
> +
> +- Port I/O (INS, OUTS, IN, OUT)
> +- HLT
> +- MONITOR, MWAIT
> +- WBINVD, INVD
> +- VMCALL
> +- RDMSR*,WRMSR*
> +- CPUID*
> +
> +Instruction-based #GP
> +---------------------
> +
> +- All VMX instructions: INVEPT, INVVPID, VMCLEAR, VMFUNC, VMLAUNCH,
> +  VMPTRLD, VMPTRST, VMREAD, VMRESUME, VMWRITE, VMXOFF, VMXON
> +- ENCLS, ENCLU
> +- GETSEC
> +- RSM
> +- ENQCMD
> +- RDMSR*,WRMSR*
> +
> +RDMSR/WRMSR Behavior
> +--------------------
> +
> +MSR access behavior falls into three categories:
> +
> +- #GP generated
> +- #VE generated
> +- "Just works"
> +
> +In general, the #GP MSRs should not be used in guests.  Their use likely
> +indicates a bug in the guest.  The guest may try to handle the #GP with a
> +hypercall but it is unlikely to succeed.
> +
> +The #VE MSRs are typically able to be handled by the hypervisor.  Guests
> +can make a hypercall to the hypervisor to handle the #VE.
> +
> +The "just works" MSRs do not need any special guest handling.  They might
> +be implemented by directly passing through the MSR to the hardware or by
> +trapping and handling in the TDX module.  Other than possibly being slow,
> +these MSRs appear to function just as they would on bare metal.
> +
> +CPUID Behavior
> +--------------
> +
> +For some CPUID leaves and sub-leaves, the virtualized bit fields of CPUID
> +return values (in guest EAX/EBX/ECX/EDX) are configurable by the
> +hypervisor. For such cases, the Intel TDX module architecture defines two
> +virtualization types:
> +
> +- Bit fields for which the hypervisor configures the value seen by the
> +  guest TD.
> +
> +- Bit fields for which the hypervisor configures the value such that the
> +  guest TD either sees their native value or a value of 0
> +
> +#VE generated for CPUID leaves and sub-leaves that TDX module doesn't know
> +how to handle. The guest kernel may ask the hypervisor for the value with
> +a hypercall.
> +
> +#VE on Memory Accesses
> +======================
> +
> +There are essentially two classes of TDX memory: private and shared.
> +Private memory receives full TDX protections.  Its content is protected
> +against access from the hypervisor.  Shared memory is expected to be
> +shared between guest and hypervisor.
> +
> +A TD guest is in control of whether its memory accesses are treated as
> +private or shared.  It selects the behavior with a bit in its page table
> +entries.  This helps ensure that a guest does not place sensitive
> +information in shared memory, exposing it to the untrusted hypervisor.
> +
> +#VE on Shared Memory
> +--------------------
> +
> +Access to shared mappings can cause a #VE.  The hypervisor ultimately
> +controls whether a shared memory access causes a #VE, so the guest must be
> +careful to only reference shared pages it can safely handle a #VE.  For
> +instance, the guest should be careful not to access shared memory in the
> +#VE handler before it reads the #VE info structure (TDG.VP.VEINFO.GET).
> +
> +Shared mapping content is entirely controlled by the hypervisor. Shared
> +mappings must never be used for sensitive memory content like stacks or
> +kernel text, only for I/O buffers and MMIO regions.  A good rule of thumb
> +is that hypervisor-shared memory should be treated the same as memory
> +mapped to userspace.  Both the hypervisor and userspace are completely
> +untrusted.
> +
> +MMIO for virtual devices is implemented as shared memory.  The guest must
> +be careful not to access device MMIO regions unless it is also prepared to
> +handle a #VE.
> +
> +#VE on Private Pages
> +--------------------
> +
> +Accesses to private mappings can also cause #VEs.  Since all kernel memory
> +is also private memory, the kernel might theoretically need to handle a
> +#VE on arbitrary kernel memory accesses.  This is not feasible, so TDX
> +guests ensure that all guest memory has been "accepted" before memory is
> +used by the kernel.
> +
> +A modest amount of memory (typically 512M) is pre-accepted by the firmware
> +before the kernel runs to ensure that the kernel can start up without
> +being subjected to #VE's.
> +
> +The hypervisor is permitted to unilaterally move accepted pages to a
> +"blocked" state. However, if it does this, page access will not generate a
> +#VE.  It will, instead, cause a "TD Exit" where the hypervisor is required
> +to handle the exception.
> +
> +Linux #VE handler
> +=================
> +
> +Just like page faults or #GP's, #VE exceptions can be either handled or be
> +fatal.  Typically, unhandled userspace #VE's result in a SIGSEGV.
> +Unhandled kernel #VE's result in an oops.
> +
> +Handling nested exceptions on x86 is typically nasty business.  A #VE
> +could be interrupted by an NMI which triggers another #VE and hilarity
> +ensues.  TDX #VE's have a novel solution to make it slightly less nasty.
> +
> +During #VE handling, the TDX module ensures that all interrupts (including
> +NMIs) are blocked.  The block remains in place until the guest makes a
> +TDG.VP.VEINFO.GET TDCALL.  This allows the guest to choose when interrupts
> +or new #VE's can be delivered.
> +
> +However, the guest kernel must still be careful to avoid potential
> +#VE-triggering actions (discussed above) while this block is in place.
> +While the block is in place, #VE's are elevated to double faults (#DF)
> +which are not recoverable.
> +
> +MMIO handling
> +=============
> +
> +In non-TDX VMs, MMIO is usually implemented by giving a guest access to
> +a mapping which will cause a VMEXIT on access, and then the hypervisor emulates
> +the access.  That is not possible in TDX guests because VMEXIT will expose the
> +register state to the host. TDX guests don't trust the host and can't have
> +their state exposed to the host.
> +
> +In TDX, the MMIO regions typically trigger a #VE exception in the guest.
> +The guest #VE handler then emulates the MMIO instruction inside the guest
> +and converts it into a controlled TDCALL to the host, rather than exposing
> +guest state to the host.
> +
> +MMIO addresses on x86 are just special physical addresses. They can
> +theoretically be accessed with any instruction that accesses memory.
> +However, the kernel instruction decoding method is limited. It is only
> +designed to decode instructions like those generated by io.h macros.
> +
> +MMIO access via other means (like structure overlays) may result in an
> +oops.
> +
> +Shared Memory Conversions
> +=========================
> +
> +All TDX guest memory starts out as private at boot.  This memory can not
> +be accessed by the hypervisor.  However some kernel users like device
> +drivers might have a need to share data with the hypervisor.  To do this,
> +memory must be converted between shared and private.  This can be
> +accomplished using some existing memory encryption helpers:
> +
> +set_memory_decrypted() converts a range of pages to shared.
> +set_memory_encrypted() converts memory back to private.
> +
> +Device drivers are the primary user of shared memory, but there's no need
> +to touch every driver. DMA buffers and ioremap()'ed do the conversions
> +automatically.
> +
> +TDX uses SWIOTLB for most DMA allocations. The SWIOTLB buffer is
> +converted to shared on boot.
> +
> +For coherent DMA allocation, the DMA buffer gets converted on the
> +allocation. Check force_dma_unencrypted() for details.
> +
> +References
> +==========
> +
> +TDX reference material is collected here:
> +
> +https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html

