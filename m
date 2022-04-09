Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9444FA153
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiDIB3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiDIB32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C4FCBD8;
        Fri,  8 Apr 2022 18:27:21 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FVB1LETnjNR4gtqeowC74IUaDck0DNbiePLa3VpGnw=;
        b=rWWskkjrjLqkzAqEJlm06UE7OkQOKn0a7y9nwj7B4HN57xfdLoAwoTZEVxc9XOecmMP4pw
        IayImmYdJnAf+y+nI6+giHxAJkcVmOz4iwsUz+0LQm93JED9wmaZYrLK5XVQuAqoVZozvW
        ckrrlNASHyaM+kB4iSKE5yaEXxUlObfAl3EFvrDVNqLfVQVIXgdk+y8BOC8t6d+ABMEKYO
        suc98g/OTyp/NQ1CH6piOpMVzPTBPm+GLFnUXDFDkXC934M/cqUsHt4O10aUpWzdj0dKJH
        mnHDZZkdPpLiqi9TiJhu/fPqXfha9RhkuGNXZkgtfm4iKRnnCirnK0KWHSgd4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FVB1LETnjNR4gtqeowC74IUaDck0DNbiePLa3VpGnw=;
        b=uw+AcCp+N9APBVQyfPn+g+cBcDDG5IEoob7STdLdP6hfvsPVhMdFFexN74XQpNKuoXgEWr
        5NFgDJyqDzqkrCCQ==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] Documentation/x86: Document TDX kernel architecture
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-31-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-31-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946763801.4207.7868825860070055827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     b9c7ba58777acfd0892b808aea25074d46e0618f
Gitweb:        https://git.kernel.org/tip/b9c7ba58777acfd0892b808aea25074d46e0618f
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:39 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Apr 2022 06:57:09 -07:00

Documentation/x86: Document TDX kernel architecture

Document the TDX guest architecture details like #VE support,
shared memory, etc.

[ dhansen: made some wording changes, including removing
	   all the plural "#VE's" and "#VEs". ]

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220405232939.73860-31-kirill.shutemov@linux.intel.com
---
 Documentation/x86/index.rst |   1 +-
 Documentation/x86/tdx.rst   | 218 +++++++++++++++++++++++++++++++++++-
 2 files changed, 219 insertions(+)
 create mode 100644 Documentation/x86/tdx.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 91b2fa4..51982de 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -26,6 +26,7 @@ x86-specific Documentation
    intel_txt
    amd-memory-encryption
    amd_hsmp
+   tdx
    pti
    mds
    microcode
diff --git a/Documentation/x86/tdx.rst b/Documentation/x86/tdx.rst
new file mode 100644
index 0000000..b8fa432
--- /dev/null
+++ b/Documentation/x86/tdx.rst
@@ -0,0 +1,218 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Intel Trust Domain Extensions (TDX)
+=====================================
+
+Intel's Trust Domain Extensions (TDX) protect confidential guest VMs from
+the host and physical attacks by isolating the guest register state and by
+encrypting the guest memory. In TDX, a special module running in a special
+mode sits between the host and the guest and manages the guest/host
+separation.
+
+Since the host cannot directly access guest registers or memory, much
+normal functionality of a hypervisor must be moved into the guest. This is
+implemented using a Virtualization Exception (#VE) that is handled by the
+guest kernel. A #VE is handled entirely inside the guest kernel, but some
+require the hypervisor to be consulted.
+
+TDX includes new hypercall-like mechanisms for communicating from the
+guest to the hypervisor or the TDX module.
+
+New TDX Exceptions
+==================
+
+TDX guests behave differently from bare-metal and traditional VMX guests.
+In TDX guests, otherwise normal instructions or memory accesses can cause
+#VE or #GP exceptions.
+
+Instructions marked with an '*' conditionally cause exceptions.  The
+details for these instructions are discussed below.
+
+Instruction-based #VE
+---------------------
+
+- Port I/O (INS, OUTS, IN, OUT)
+- HLT
+- MONITOR, MWAIT
+- WBINVD, INVD
+- VMCALL
+- RDMSR*,WRMSR*
+- CPUID*
+
+Instruction-based #GP
+---------------------
+
+- All VMX instructions: INVEPT, INVVPID, VMCLEAR, VMFUNC, VMLAUNCH,
+  VMPTRLD, VMPTRST, VMREAD, VMRESUME, VMWRITE, VMXOFF, VMXON
+- ENCLS, ENCLU
+- GETSEC
+- RSM
+- ENQCMD
+- RDMSR*,WRMSR*
+
+RDMSR/WRMSR Behavior
+--------------------
+
+MSR access behavior falls into three categories:
+
+- #GP generated
+- #VE generated
+- "Just works"
+
+In general, the #GP MSRs should not be used in guests.  Their use likely
+indicates a bug in the guest.  The guest may try to handle the #GP with a
+hypercall but it is unlikely to succeed.
+
+The #VE MSRs are typically able to be handled by the hypervisor.  Guests
+can make a hypercall to the hypervisor to handle the #VE.
+
+The "just works" MSRs do not need any special guest handling.  They might
+be implemented by directly passing through the MSR to the hardware or by
+trapping and handling in the TDX module.  Other than possibly being slow,
+these MSRs appear to function just as they would on bare metal.
+
+CPUID Behavior
+--------------
+
+For some CPUID leaves and sub-leaves, the virtualized bit fields of CPUID
+return values (in guest EAX/EBX/ECX/EDX) are configurable by the
+hypervisor. For such cases, the Intel TDX module architecture defines two
+virtualization types:
+
+- Bit fields for which the hypervisor controls the value seen by the guest
+  TD.
+
+- Bit fields for which the hypervisor configures the value such that the
+  guest TD either sees their native value or a value of 0.  For these bit
+  fields, the hypervisor can mask off the native values, but it can not
+  turn *on* values.
+
+A #VE is generated for CPUID leaves and sub-leaves that the TDX module does
+not know how to handle. The guest kernel may ask the hypervisor for the
+value with a hypercall.
+
+#VE on Memory Accesses
+======================
+
+There are essentially two classes of TDX memory: private and shared.
+Private memory receives full TDX protections.  Its content is protected
+against access from the hypervisor.  Shared memory is expected to be
+shared between guest and hypervisor and does not receive full TDX
+protections.
+
+A TD guest is in control of whether its memory accesses are treated as
+private or shared.  It selects the behavior with a bit in its page table
+entries.  This helps ensure that a guest does not place sensitive
+information in shared memory, exposing it to the untrusted hypervisor.
+
+#VE on Shared Memory
+--------------------
+
+Access to shared mappings can cause a #VE.  The hypervisor ultimately
+controls whether a shared memory access causes a #VE, so the guest must be
+careful to only reference shared pages it can safely handle a #VE.  For
+instance, the guest should be careful not to access shared memory in the
+#VE handler before it reads the #VE info structure (TDG.VP.VEINFO.GET).
+
+Shared mapping content is entirely controlled by the hypervisor. The guest
+should only use shared mappings for communicating with the hypervisor.
+Shared mappings must never be used for sensitive memory content like kernel
+stacks.  A good rule of thumb is that hypervisor-shared memory should be
+treated the same as memory mapped to userspace.  Both the hypervisor and
+userspace are completely untrusted.
+
+MMIO for virtual devices is implemented as shared memory.  The guest must
+be careful not to access device MMIO regions unless it is also prepared to
+handle a #VE.
+
+#VE on Private Pages
+--------------------
+
+An access to private mappings can also cause a #VE.  Since all kernel
+memory is also private memory, the kernel might theoretically need to
+handle a #VE on arbitrary kernel memory accesses.  This is not feasible, so
+TDX guests ensure that all guest memory has been "accepted" before memory
+is used by the kernel.
+
+A modest amount of memory (typically 512M) is pre-accepted by the firmware
+before the kernel runs to ensure that the kernel can start up without
+being subjected to a #VE.
+
+The hypervisor is permitted to unilaterally move accepted pages to a
+"blocked" state. However, if it does this, page access will not generate a
+#VE.  It will, instead, cause a "TD Exit" where the hypervisor is required
+to handle the exception.
+
+Linux #VE handler
+=================
+
+Just like page faults or #GP's, #VE exceptions can be either handled or be
+fatal.  Typically, an unhandled userspace #VE results in a SIGSEGV.
+An unhandled kernel #VE results in an oops.
+
+Handling nested exceptions on x86 is typically nasty business.  A #VE
+could be interrupted by an NMI which triggers another #VE and hilarity
+ensues.  The TDX #VE architecture anticipated this scenario and includes a
+feature to make it slightly less nasty.
+
+During #VE handling, the TDX module ensures that all interrupts (including
+NMIs) are blocked.  The block remains in place until the guest makes a
+TDG.VP.VEINFO.GET TDCALL.  This allows the guest to control when interrupts
+or a new #VE can be delivered.
+
+However, the guest kernel must still be careful to avoid potential
+#VE-triggering actions (discussed above) while this block is in place.
+While the block is in place, any #VE is elevated to a double fault (#DF)
+which is not recoverable.
+
+MMIO handling
+=============
+
+In non-TDX VMs, MMIO is usually implemented by giving a guest access to a
+mapping which will cause a VMEXIT on access, and then the hypervisor
+emulates the access.  That is not possible in TDX guests because VMEXIT
+will expose the register state to the host. TDX guests don't trust the host
+and can't have their state exposed to the host.
+
+In TDX, MMIO regions typically trigger a #VE exception in the guest.  The
+guest #VE handler then emulates the MMIO instruction inside the guest and
+converts it into a controlled TDCALL to the host, rather than exposing
+guest state to the host.
+
+MMIO addresses on x86 are just special physical addresses. They can
+theoretically be accessed with any instruction that accesses memory.
+However, the kernel instruction decoding method is limited. It is only
+designed to decode instructions like those generated by io.h macros.
+
+MMIO access via other means (like structure overlays) may result in an
+oops.
+
+Shared Memory Conversions
+=========================
+
+All TDX guest memory starts out as private at boot.  This memory can not
+be accessed by the hypervisor.  However, some kernel users like device
+drivers might have a need to share data with the hypervisor.  To do this,
+memory must be converted between shared and private.  This can be
+accomplished using some existing memory encryption helpers:
+
+ * set_memory_decrypted() converts a range of pages to shared.
+ * set_memory_encrypted() converts memory back to private.
+
+Device drivers are the primary user of shared memory, but there's no need
+to touch every driver. DMA buffers and ioremap() do the conversions
+automatically.
+
+TDX uses SWIOTLB for most DMA allocations. The SWIOTLB buffer is
+converted to shared on boot.
+
+For coherent DMA allocation, the DMA buffer gets converted on the
+allocation. Check force_dma_unencrypted() for details.
+
+References
+==========
+
+TDX reference material is collected here:
+
+https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
