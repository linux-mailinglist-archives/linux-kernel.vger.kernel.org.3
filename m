Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9974CAAEE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiCBQ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243595AbiCBQ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:58:01 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149AB58380
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:57:17 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id bt3so2223445qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lDgfXVCBj5NCHWxZKv7iGAFS+RAinlgiSzL/8RxMDV4=;
        b=JHWCGfShRd4cr04CNZivUhRUer938+dOv1ZN4WFwnS5tlcSkbUO6s5k1vDPK0R3FK9
         V1iTCygj4AGBEluhHpk1igzQeGCDNPAhbUN1bht92A90hITQFS57pCS/Ca2cM0gLFr+/
         eEqvPyBHjaItOk+8bvw9h4xS69TaeBb1Z+uU2sJOEHM2Os9irdoKpDVq/tTEP0jnRSrG
         xiq8kSXNv+dynzJX7LuPHGQdHqPROkL1dyGwqDPj7KrNLHxUQCPuC1FoEwLqriRkawEN
         EQWesvxuYAoJlInUbr2VOLlzip6MSqkKvXiuOE2zGuf0RBCZOb2lOofwDIL6ou4gw9CE
         m2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lDgfXVCBj5NCHWxZKv7iGAFS+RAinlgiSzL/8RxMDV4=;
        b=hT/MrZuVs+uip4e+JfSdiNW64J6VC/9EpFlLCGKiTBbv1LxnmuTB8imRQRifN0b/on
         FV6NwOw81gg8iFiHSawNDP14d1WrCGjVPXR0zl9PX5RpKO84RaO166Mg7AeyR7NsrDZx
         nOEQVQiQcOsNRGzrxtGJgOnJUA3sqOLVt1Ujhgwe/a2tHl2JIPeKr3zHwxnrpigm4Df3
         6RwbyK+3Dix04HvdiybyIV39DSauh7KuYx/qnPWHNaQLUZuJAUHsm/gDmNyk+Xbakvaw
         1GyoiEBQX/uGnT6f1tkN5/B9bJAPZHE/0x/kxB/6wzRGCfEXCKN20g/aK1GS+3kADUhU
         y78Q==
X-Gm-Message-State: AOAM533f9/jyWzW21g4cXrNLyUUIOMJJMdXZllTO0xRoED8MWtEm5pvK
        vcRQuPVoZnYs5E9M+pG/Ivo5h3FQqKkd53YvqHXF9HbqVhRgOeOL
X-Google-Smtp-Source: ABdhPJyPhJEZN6nVPNhspUEhnNS8/39I1gAsmu4rPS5EjG6zK0cW2r6S1mTeLsjyH2UrsfuMHFG+pxHW0w95ObJzNxo=
X-Received: by 2002:a05:622a:589:b0:2de:9437:a380 with SMTP id
 c9-20020a05622a058900b002de9437a380mr24092117qtb.593.1646240235931; Wed, 02
 Mar 2022 08:57:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <CAHAy0tR-64vxtFo4KXiJP_va2=WF++Q6gDaPksNxiaSB5wWvhA@mail.gmail.com>
 <86495779-a9c5-45d5-0017-c491bf6354ab@intel.com> <CAHAy0tQYBD2b0jdim=6Zv+hwskyd1FhpycyGF+1FBHDih9TP3g@mail.gmail.com>
 <e746026c-33f3-fd15-5303-563b3eb761d3@intel.com>
In-Reply-To: <e746026c-33f3-fd15-5303-563b3eb761d3@intel.com>
From:   Nathaniel McCallum <nathaniel@profian.com>
Date:   Wed, 2 Mar 2022 11:57:05 -0500
Message-ID: <CAHAy0tRXxDQSuBVoEW9jzpFaWns4DzWqmFASFNGgGb5vjnYuPw@mail.gmail.com>
Subject: Re: [PATCH V2 00/32] x86/sgx and selftests/sgx: Support SGX2
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, Jarkko Sakkinen <jarkko@kernel.org>,
        tglx@linutronix.de, bp@alien8.de,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinette,

Perhaps it would be better for us to have a shared understanding on
how the patches as posted are supposed to work in the most common
cases? I'm thinking here of projects such as Enarx, Gramine and
Occulum, which all have a similar process. Namely they execute an
executable (called exec in the below chart) which has things like
syscalls handled by a shim. These two components (shim and exec) are
supported by a non-enclave userspace runtime. Given this common
architectural pattern, this is how I understand adding pages via an
exec call to mmap() to work.

https://mermaid.live/edit#pako:eNp1k81qwzAQhF9F6NRCAu1Vh0BIRemhoeSHBuIettYm=
FpElVZZLQ8i7144sJ8aOT2bmY3d2vT7R1AikjBb4U6JO8UXC3kGeaFI9FpyXqbSgPTmg06j6uiu=
1lzn2jSKTA2XwD9NEB31uPBLzi-6iMpLnYB8Wn4-kOBYpKBW52iXj8WQSmzEy5Zvt01ewG5HUQN=
2UEc7nK77YPjdALd64GWih8NpkALGwR_JtzOGAaKXexyTKGEt2pgoMaXahgj5Qgk9nM_6xGvDDJ=
psmOyiVv0LB62B8un4dBDrLiLPeWciCL9fvvKVQizhSG6stFz9Df7sxUpcYitR-SodFO2A_Vw-7=
l4nzzduqjX9bKJxOHDDeBB3RHF0OUlS3faq1hPoMqzulrHoVGPZOE32u0NIK8MiF9MZRtgNV4Ih=
C6c3yqFPKvCsxQs3_0VDnfzf-CPg

This only covers adding RW pages. I haven't even tackled permission
changes yet. Is that understanding correct? If not, please provide an
alternative sequence diagram to explain how you expect this to be
used.

On Wed, Feb 23, 2022 at 1:25 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Nathaniel,
>
> On 2/23/2022 5:24 AM, Nathaniel McCallum wrote:
> > On Tue, Feb 22, 2022 at 5:39 PM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >>
> >> Hi Nathaniel,
> >>
> >> On 2/22/2022 12:27 PM, Nathaniel McCallum wrote:
> >>> 1. This interface looks very odd to me. mmap() is the kernel interfac=
e
> >>> for changing user space memory maps. Why are we introducing a new
> >>> interface for this?
> >>
> >> mmap() is the kernel interface used to create new mappings in the
> >> virtual address space of the calling process. This is different from
> >> the permissions and properties of the underlying file/memory being map=
ped.
> >>
> >> A new interface is introduced because changes need to be made to the
> >> permissions and properties of the underlying enclave. A new virtual
> >> address space is not needed nor should existing VMAs be impacted.
> >>
> >> This is similar to how mmap() is not used to change file permissions.
> >>
> >> VMA permissions are separate from enclave page permissions as found in
> >> the EPCM (Enclave Page Cache Map). The current implementation (SGX1) a=
lready
> >> distinguishes between the VMA and EPCM permissions - for example, it i=
s
> >> already possible to create a read-only VMA from enclave pages that hav=
e
> >> RW EPCM permissions. mmap() of a portion of EPC memory with a particul=
ar
> >> permission does not imply that the underlying EPCM permissions (should=
)have
> >> that permission.
> >
> > Yes. BUT... unlike the file permissions, this leaks an implementation d=
etail.
>
> Not really - just like a RW file can be mapped read-only or RW, RW enclav=
e
> memory can be mapped read-only or RW.
>
> >
> > The user process is governed by VMA permissions. And during enclave
> > creation, it had to mmap() all the enclave regions to their final VMA
> > permissions. So during enclave creation you have to use mmap() but
> > after enclave creation you use custom APIs? That's inconsistent at
> > best.
>
> No. ioctl()s are consistently used to manage enclave memory.
>
> The existing ioctls() SGX_IOC_ENCLAVE_CREATE, SGX_IOC_ENCLAVE_ADD_PAGES,
> and SGX_IOC_ENCLAVE_INIT are used to set up to initialize the enclave mem=
ory.
>
> The new ioctls() are used to manage enclave memory after enclave initiali=
zation.
>
> The enclave memory is thus managed with a consistent interface.
>
> mmap() is required before SGX_IOC_ENCLAVE_CREATE to obtain a base address
> for the enclave that is required by the ioctl(). The rest of the ioctl()s=
,
> existing and new, are consistent in interface by not requiring a memory
> mapping but instead work from an offset from the base address.
>
> > Forcing userspace to worry about the (mostly undocumented!)
> > interactions between EPC, PTE and VMA permissions makes these APIs
> > hard to use and difficult to reason about.
>
> This is not new. The current SGX1 user space is already prevented from
> creating a mapping of enclave memory that is more relaxed than the enclav=
e
> memory. For example, if the enclave memory has RW EPCM permissions then i=
t
> is not possible to mmap() that memory as RWX.
>
> >
> > When I call SGX_IOC_ENCLAVE_RELAX_PERMISSIONS, do I also have to call
> > mmap() to update the VMA permissions to match? It isn't clear. Nor is
>
> mprotect() may be the better call to use.
>
> > it really clear why I'm calling completely separate APIs.
> >
> >>> You can just simply add a new mmap flag (i.e.
> >>> MAP_SGX_TCS*) and then figure out which SGX instructions to execute
> >>> based on the desired state of the memory maps. If you do this, none o=
f
> >>> the following ioctls are needed:
> >>>
> >>> * SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
> >>> * SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
> >>> * SGX_IOC_ENCLAVE_REMOVE_PAGES
> >>> * SGX_IOC_ENCLAVE_MODIFY_TYPE
> >>>
> >>> It also means that languages don't have to grow support for all these
> >>> ioctls. Instead, they can just reuse the existing mmap() bindings wit=
h
> >>> the new flag. Also, multiple operations can be combined into a single
> >>> mmap() call, amortizing the changes over a single context switch.
> >>>
> >>> 2. Automatically adding pages with hard-coded permissions in a fault
> >>> handler seems like a really bad idea.
> >>
> >> Could you please elaborate why this is a bad idea?
> >
> > Because implementations that miss this subtlety suddenly have pages
> > with magic permissions. Magic is bad. Explicit is good.
> >
>
> There is no magic. Any new pages have to be accepted by the enclave.
> The enclave will not be able to access these pages unless explicitly
> accepted, ENCLU[EACCEPT], from within the enclave.
>
> >>> How do you distinguish between
> >>> accesses which should result in an updated mapping and accesses that
> >>> should result in a fault?
> >>
> >> Accesses that should result in an updated mapping have two requirement=
s:
> >> (a) address accessed belongs to the enclave based on the address
> >>     range specified during enclave create
> >> (b) there is no backing enclave page for the address
> >
> > What happens if the enclave is buggy? Or has been compromised. In both
> > of those cases, there should be a userspace visible fault and pages
> > should not be added.
>
> If user space accesses a memory address with a regular read/write that
> results in a new page added then there is indeed a user space visible
> fault. You can see this flow in action in the "augment" test case in
> https://lore.kernel.org/linux-sgx/32c1116934a588bd3e6c174684e3e36a05c0a4d=
4.1644274683.git.reinette.chatre@intel.com/
>
> If user space indeed wants the page after encountering such a fault then
> it needs to enter the enclave again, from a different entry point, to
> run ENCLU[EACCEPT], before it can return to the original entry point to
> continue execution from the instruction that triggered the original read/=
write.
>
> The only flow where a page is added without a user space visible fault
> is when user space explicitly runs the ENCLU[EACCEPT] to do so.
>
> >
> >>> IMHO, all unmapped page accesses should
> >>> result in a page fault. mmap() should be called first to identify the
> >>> correct permissions for these pages.
> >>> Then the page handler should be
> >>> updated to use the permissions from the mapping when backfilling
> >>> physical pages. If I understand correctly, this should also obviate
> >>
> >> Regular enclave pages can _only_ be dynamically added with RW permissi=
on.
> >>
> >> SGX2's support for adding regular pages to an enclave via the EAUG
> >> instruction is architecturally set at RW. The OS cannot change those p=
ermissions
> >> via the EAUG instruction nor can the OS do so with a different/additio=
nal
> >> instruction because:
> >> * the OS is not able to relax permissions since that can only be done =
from
> >> within the enclave with ENCLU[EMODPE], thus it is not possible for the=
 OS to
> >> dynamically add pages via EAUG as RW and then relax permissions to RWX=
.
> >> * the OS is not able to EAUG a page and immediately attempt an EMODPR =
either
> >> as Jarkko also recently inquired about:
> >> https://lore.kernel.org/linux-sgx/80f3d7b9-e3d5-b2c0-7707-710bf6f5081e=
@intel.com/
> >
> > This design looks... unfinished. EAUG takes a PAGEINFO in RBX, but
> > PAGEINFO.SECINFO must be zeroed and EAUG instead sets magic hard-coded
> > permissions. Why doesn't EAUG just respect the permissions in
> > PAGEINFO.SECINFO? We aren't told.
>
> This design is finished and respects the hardware specification. You can =
find
> the details in the SDM's documentation of the EAUG function.
>
> If the SECINFO field has a value then the hardware requires it to indicat=
e
> that it is a new shadow stack page being added, not a regular page. Suppo=
rt for
> shadow stack pages is not in scope for this work. Attempting to dynamical=
ly
> add a regular page with explicit permissions will result in a #GP(0).
>
> The only way to add a regular enclave page is to make the SECINFO field e=
mpty
> and doing so forces the page type to be a regular page and the permission=
s to
> be RW.
>
> >
> > Further, if the enclave can do EMODPE, why does
> > SGX_IOC_ENCLAVE_RELAX_PERMISSIONS even exist? None of the
> > documentation explains what this ioctl even does. Does it update PTE
> > permissions? VMA permissions? Nobody knows without reading the source
> > code.
>
> Build the documentation (after applying this series) and it should
> contain all the information you are searching for. As is the current cust=
om
> in the SGX documentation the built documentation pulls its content from
> the kernel doc of the functions that implement the core of the
> user space interactions.
>
> >
> > Userspace should not be bothered with the subtle details of the
> > interaction between EPC, PTE and VMA permissions. But this API does
> > everything it can do to expose all these details to userspace. And it
> > doesn't bother to document them (probably because it is hard). It
> > would be much better to avoid exposing these details to userspace.
> >
> > IMHO, there should be a simple flow like this (if EAUG respects
> > PAGEINFO.SECINFO):
>
> EAUG does not respect PAGEINFO.SECINFO for regular pages.
>
> >
> > 1. Non-enclave calls mmap()/munmap().
> > 2. Enclave issues EACCEPT, if necessary.
> > 3. Enclave issues EMODPE, if necessary.
> >
> > Notice that in the second step above, during the mmap() call, the
> > kernel ensures that EPC, PTE and VMA are in sync and fails if they
> > cannot be made to be compatible. Also note that in the above flow EAUG
> > instructions can be efficiently batched.
> >
> > Given the current poor state of the EAUG instruction, we might need to
> > do this flow instead:
> >
> > 1. Enclave issues EACCEPT, if necessary. (Add RW pages...)
> > 2. Non-enclave calls mmap()/munmap().
> > 3. Enclave issues EACCEPT, if necessary.
> > 4. Enclave issues EMODPE, if necessary.
> >
> > However, doing EAUG only via the page access handler means that there
> > is no way to batch EAUG instructions and this forces a context switch
> > for every page you want to add. This has to be terrible for
> > performance. Note specifically that the SDM calls out batching, which
> > is currently impossible under this patch set. 35.5.7 - "Page
> > allocation operations may be batched to improve efficiency."
>
> These page functions are all per-page so it is not possible to add multip=
le
> pages with a single instruction. It is indeed possible to pre-fault pages=
.
>
> > As it stands today, if I want to add 256MiB of pages to an enclave,
> > I'll have to do 2^16 context switches. That doesn't seem scalable.
>
> No. Running ENCLU[EACCEPT] on each of the pages within that range should =
not
> need any explicit context switch out of the enclave. See the "augment_via=
_eaccept"
> test case in:
> https://lore.kernel.org/linux-sgx/32c1116934a588bd3e6c174684e3e36a05c0a4d=
4.1644274683.git.reinette.chatre@intel.com/
>
>
> >>> the need for the weird userspace callback to allow for execute
> >>> permissions.
> >>
> >> User policy integration would always be required to allow execute
> >> permissions on a writable page. This is not expected to be a userspace
> >> callback but instead integration with existing user policy subsystem(s=
).
> >
> > Why? This isn't documented.
>
> This is similar to the existing policies involved in managing the permiss=
ions
> of mapped memory. When user space calls mprotect() to change permissions
> of a mapped region then the kernel will not blindly allow the permissions=
 but
> instead ensure that it is allowed based on user policy by calling the LSM
> (Linux Security Module) hooks.
>
> You can learn more about LSM and various security modules at:
> Documentation/security/lsm.rst
> Documentation/admin-guide/LSM/*
>
> You can compare what is needed here to what is currently done when user s=
pace
> attempts to make some memory executable (see:
> mm/mprotect.c:do_mprotect_key()->security_file_mprotect()). User policy n=
eeds
> to help the kernel determine if this is allowed. For example, when SELinu=
x is
> the security module of choice then the process or file (depending on what=
 type
> of memory is being changed) needs to have a special permission (PROCESS__=
EXECHEAP,
> PROCESS__EXECSTACK, or FILE__EXECMOD) assigned by user space to allow thi=
s.
>
> Integration with user space policy is required for RWX of dynamically add=
ed pages
> to be supported. In this series dynamically added pages will not be allow=
ed to
> be made executable, a follow-up series will add support for user policy
> integration to support RWX permissions of dynamically added pages.
>
> >>> 3. Implementing as I've suggested also means that we can lock down an
> >>> enclave, for example - after code has been JITed, by closing the file
> >>> descriptor. Once the file descriptor used to create the enclave is
> >>> closed, no further mmap() can be performed on the enclave. Attempting
> >>> to do EACCEPT on an unmapped page will generate a page fault.
> >>
> >> This is not clear to me. If the file descriptor is closed and no furth=
er
> >> mmap() is allowed then how would a process be able to enter the enclav=
e
> >> to execute code within it?
> >
> > EENTER (or the vdso function) with the address of a TCS page, like
> > normal. In Enarx, we don't retain the enclave fd after the final
> > mmap() following EINIT. Everything works just fine.
>
> The OS fault handler is responsible for managing the PTEs that is require=
d
> for the enclave to be able to access the memory within the enclave.
> The OS fault handler is attached to a VMA that is created with mmap().
>
> >
> >> This series does indeed lock down the address range to ensure that it =
is
> >> not possible to map memory that does not belong to the enclave after t=
he
> >> enclave is created. Please see:
> >> https://lore.kernel.org/linux-sgx/1b833dbce6c937f71523f4aaf4b2181b9673=
519f.1644274683.git.reinette.chatre@intel.com/
> >
> > That's not what I'm talking about. I'm talking about a workflow like th=
is:
> >
> > 1. Enclave initialization: ECREATE ... EINIT
> > 2. EENTER
> > 3. Enclave JITs some code (changes page permissions)
> > 4. EEXIT
> > 5. Close enclave fd.
> > 6. EENTER
> > 7. If an enclave attempts page modifications, a fault occurs.
>
> The original fd that was created to obtain the enclave base address
> may be closed at (5) but the executable and data portions of the enclave
> still needs to be mapped afterwards to be able to have OS support for
> managing the PTEs that the enclave depends on to access those pages.
>
> >
> > Think of this similar to seccomp(). The enclave wants to do some
> > dynamic page table manipulation. But then it wants to lock down page
> > table modification so that, if compromised, attackers have no ability
> > to obtain RWX permissions.
>
> Reinette
