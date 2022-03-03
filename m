Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7506D4CB440
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiCCBO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCCBOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:14:53 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0CC28980
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:14:07 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d84so2816311qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wi6L8alYy4V4SsfLlVtyi/z2L0oc5Zl5QzoxxcNQf/I=;
        b=vo9Yjirf0Zq3WgOxoTSy4UnGcRGG9B7+HsAJscLXwWmP9qV1b/MahfajWNyyE8Sbi3
         LoS/+1v4TlWzgY4VkHPbYp8oExikdPztGL8i3ud5cvw2zdWx1oXnuAtpeVjtQXMVtRA9
         VI4JMQTQ13rs34E1Bd99Nxl3Ar2WLW2ajs5hgAfHzS6cUXbG2+/uzWMRKsD+DtnEpw+G
         OSdi06S3b4+/sr+jth4ZhmKCXdqgqIG/gMtTCfedCadCDxqNizpmlnUTHSod80P2xB14
         W/c9uhvH5EBBB0BH6MBn/mBMF8uxmZU/90h+UXXL5cyzBZvyKmWPkEUen6AynlIvDpKV
         TQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wi6L8alYy4V4SsfLlVtyi/z2L0oc5Zl5QzoxxcNQf/I=;
        b=6KqT2655QxzHevR8Oii8dHPizxZVM77kAMUVpYR77w1BTVzAjzKubNTR/eBJgcSvM+
         bhMQkjLd9fbtkUpDUxrOM4311bftCm5LG2mD9VNPBpt+3aKg7RMzKtusfu9rfkDRDTi2
         3Fsm29SyShjaxfwK1DxjA1Hf5/A8jGFxVCdec7dkERMR5Vdp3K2FOZ4k7CuYZHPHp2QX
         5h9BnTvWJ4OjaNOLLNciJsLB+NWiNNNBdGlrnSsE8i6dQlLBxwW7MFDdLWqHizAdRizL
         FN668DVNMbJFmAc31pL8eNj/K1+cquRVMj+gmZ1sxp/vCQP4bDlK7+dVuwk9+D1sB5DW
         8VPA==
X-Gm-Message-State: AOAM532VasPyxAhUnRwFXwZNqWV4C/ImaLC8mcnACq5Cux9MWWausm5e
        IdlAT7i0jpYKOXBVNhL5zU8iphm3Ce0DIcxdF7EgjQ==
X-Google-Smtp-Source: ABdhPJy9iknoyuZ0ItWdiDqHtIn9q0sub8CXf8vcFX5YBLNwfzRFvmxFbQAWud9UXKfFN7tKSPUrUqM/GN6B4w6HLHg=
X-Received: by 2002:a05:620a:1981:b0:477:6e45:3e7d with SMTP id
 bm1-20020a05620a198100b004776e453e7dmr17386067qkb.407.1646270046597; Wed, 02
 Mar 2022 17:14:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <CAHAy0tR-64vxtFo4KXiJP_va2=WF++Q6gDaPksNxiaSB5wWvhA@mail.gmail.com>
 <86495779-a9c5-45d5-0017-c491bf6354ab@intel.com> <CAHAy0tQYBD2b0jdim=6Zv+hwskyd1FhpycyGF+1FBHDih9TP3g@mail.gmail.com>
 <e746026c-33f3-fd15-5303-563b3eb761d3@intel.com> <CAHAy0tRXxDQSuBVoEW9jzpFaWns4DzWqmFASFNGgGb5vjnYuPw@mail.gmail.com>
 <b2733dba-278a-4574-f7ab-f035e97f762e@intel.com>
In-Reply-To: <b2733dba-278a-4574-f7ab-f035e97f762e@intel.com>
From:   Nathaniel McCallum <nathaniel@profian.com>
Date:   Wed, 2 Mar 2022 20:13:55 -0500
Message-ID: <CAHAy0tRoy=qpn-OqKmEHaWSngO+_Ko+YYd3Aq7WGk+1=n8=2mA@mail.gmail.com>
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

On Wed, Mar 2, 2022 at 4:20 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Nathaniel,
>
> On 3/2/2022 8:57 AM, Nathaniel McCallum wrote:
> > Perhaps it would be better for us to have a shared understanding on
> > how the patches as posted are supposed to work in the most common
> > cases? I'm thinking here of projects such as Enarx, Gramine and
> > Occulum, which all have a similar process. Namely they execute an
> > executable (called exec in the below chart) which has things like
> > syscalls handled by a shim. These two components (shim and exec) are
> > supported by a non-enclave userspace runtime. Given this common
> > architectural pattern, this is how I understand adding pages via an
> > exec call to mmap() to work.
> >
> > https://mermaid.live/edit#pako:eNp1k81qwzAQhF9F6NRCAu1Vh0BIRemhoeSHBuIe=
ttYmFpElVZZLQ8i7144sJ8aOT2bmY3d2vT7R1AikjBb4U6JO8UXC3kGeaFI9FpyXqbSgPTmg06j=
6uiu1lzn2jSKTA2XwD9NEB31uPBLzi-6iMpLnYB8Wn4-kOBYpKBW52iXj8WQSmzEy5Zvt01ewG5=
HUQN2UEc7nK77YPjdALd64GWih8NpkALGwR_JtzOGAaKXexyTKGEt2pgoMaXahgj5Qgk9nM_6xG=
vDDJpsmOyiVv0LB62B8un4dBDrLiLPeWciCL9fvvKVQizhSG6stFz9Df7sxUpcYitR-SodFO2A_=
Vw-7l4nzzduqjX9bKJxOHDDeBB3RHF0OUlS3faq1hPoMqzulrHoVGPZOE32u0NIK8MiF9MZRtgN=
V4IhC6c3yqFPKvCsxQs3_0VDnfzf-CPg
> >
> > This only covers adding RW pages. I haven't even tackled permission
> > changes yet. Is that understanding correct? If not, please provide an
> > alternative sequence diagram to explain how you expect this to be
> > used.
>
> Please find my attempt linked below:
>
> https://mermaid.live/edit#pako:eNqFUsFqAjEQ_ZWQUwsK7XUPgthQeqiUVang9jAkox=
u6m2yzWVsR_72J2WTbKnSOb97MvPeSI-VaIM1oix8dKo4PEnYG6kIRVw0YK7lsQFlSghGfYPCy8=
45GYXWJm05ZWV8ZaEt55QB-IS9UwOfaItF7NGc0I3UNzU3-ekvaQ8uhqiLPd8l4PJnEYxmZsvXm=
7i20e5B4QlA5rAqMgJJfG9Ixg21X2ctVXn9GGJsvWb65729FSZXWDdlqpxx46Qzu-gB8-cHzhhi=
m2zKdzdjLcuAAt3IPzv6Qkq84EdxGM3492UJS-cdSpLHp6nEgCPz3RjI5NPvAlRisJjspOsbWT8=
sUyc_MwjuynC1Wzyw9EB3RGk0NUrgvePRYQW2J7tNQd5sKDN5ooU6O2jXCiWZCWm1otoWqxRGFz=
urFQXGaWdNhJPXfuGedvgFejOuH
>
> The changes include:
> * Move mmap() to occur before attempting EACCEPT on the addresses. This i=
s
>   required for EACCEPT (as well as any subsequent access from within the =
enclave)
>   to be able to access the pages.
> * Remove AEX[1] to the runtime within the loop. After EAUG returns execut=
ion
>   will return to the instruction pointer that triggered the #PF, EACCEPT,
>   this will cause the EACCEPT to be run again, this time succeeding.
>
> This is based on the implementation within this series. When supporting
> the new ioctl() requested by Jarkko there will be an additional ioctl()
> required before the loop.

https://mermaid.live/edit/#pako:eNp1U9FqgzAU_ZWQpw1a2F6FFaQLYw8ro7asUPeQmWs=
NNYlL4rZS-u-LRmut1ie953jvOecmR5woBjjABr5LkAk8c7rTVMQSuYeWVslSfIH23wXVlie8oN=
KijGr2SzUMkT1oCfmwrktpuRj5wWRcDKvwB0ksfX2hLCD1A7quBkgIWtwtP-6ROZiE5nnLq1A0n=
c5m7bAAhWSzffj0cFNEFaEaGiBCFiuy3D42hKp4gWZUshy6ISOUL6X2e4CCy10rQhUW8dR52QES=
ivGUJ9RyJQ2SAAyYZ_V6ndUSsnldneVca_bJdvY7lkf6vc4haTBlbsdbDmLoaLlSBUqVy5wmWW2=
nw3rq26Pg-oTzOXlf9Xkt7BfTeqjjSWlP2JWTlkrC9cutlmcLlUlxoRBkE3T9Mrq7KArd0UBPqF=
DGTpstI2OphSv-jf1cBukPJlmSaP1GXFs8wQK0oJy523Ws-DG2GTiJOHCvDLx3HMuTo5YFc1MJ4=
1ZpHKQ0NzDB1fWLDjLBgdUltKTmhjas0z-kWy8L

My comments below correspond to the arrow numbers in the diagram.

2. When the runtime receives the AEX, it doesn't have enough knowledge
to know whether or not to ask the kernel for an mmap(). So it has to
reenter the shim.

3. The shim has to handle the syscall instruction routing it to the
enclave's memory management subsystem.

4. The shim has to do bookkeeping and decide if additional pages are
even needed. If pages are already allocated, for example, it can skip
directly to step 13. However, if modifications are needed, it will go
to steps 5-12.

5-12. This is the part that represents new code from the kernel's
perspective for SGX2. It is also in a performance critical path and
should be evaluated with greater scrutiny. The number of context
switches is O(2N + 4) for each new allocated block, where N is the
number of pages: a context switch occurs at step 5, 6, 7,  8, 9/10 and
12. However, this can be reduced to O(4) for each new allocated block
with a simple modification:

https://mermaid.live/edit/#pako:eNqNk11rwyAUhv-KeLVBC9ttYIXQydjFymhaVmh24fS=
kkUbN1Gwrpf99pvlsk8G80nMez3l91SNmmgMOsIXPAhSDR0F3hspYIT9o4bQq5AeYap1T4wQTOV=
UOpdTwb2pgmNmDUZAN46ZQTsiRDTYVchiFH2CxquIL7QDpLzDnaICkpPnN8u0W2YNlNMsarsyi6=
XQ2a5oFKCSb7d17la6DqATKpgEiZLEiy-19DZTBXjalimfQNRlBPrTe7wFyoXaNCJ07JBJ_lh0g=
qblIBKNOaGWRAuDAK-qiVquWkM3zqpVzrblytjt-R2Va5yjR3h_K0nPrLleOaudFERKunzoIVE9=
Xj26VtZYbsEXmxgUOTP2_witfSTifk9fViMDzZPQuoij0V40eUK6tm9a3hqyjDq74P_zuH6V6aG=
RJovUL8WXxBEswkgruf8ux5GPsUvDvGQd-yiGhpS04ViePFjn3XQkXThscJDSzMMHld4oOiuHAm=
QIaqP5xNXX6BeBJIEk

The interesting thing about this pattern is that this can be done for
all page modification types except EMODT. For example, here's the same
process for changing a mapping from RW to RX:

https://mermaid.live/edit/#pako:eNqNk11rwyAUhv-KeLVBC9ttYIVCvdhFu5F0UGh24fS=
kkUbN1Gwrpf995jttMphXes7jOa-vesZMc8ABtvBZgGKwEvRgqIwV8oMWTqtCfoCp1zk1TjCRU-=
VQSg3_pgbGmSMYBdk4bgrlhJzYYFMhx1H4ARarOr7RDpD-AlNFAyQlze_C3T2yJ8tolrVcmUXz-=
WLRNgvQkuz2D-91ugmiEiibBoiQzZaE-8cGKIODbEoVz6BvMoF8aH08AuRCHVoROndIJP4sB0BS=
c5EIRp3QyiIFwIHX1FWtTi0hu-dtJ-dWc-1sf_yeyrTOUaK9P5SlVes-V45651URsn5ZvYY9Bmq=
gbMB32jrTDdgic9MSR7b-X-ONs5U-MqGvmkxeRhQt_V2jJ5Rr6-bNtSHrqIMb_g_DhyepXxoJSf=
S2Jr4snmEJRlLB_Xc5l3yMXQr-QePATzkktHQFx-ri0SLnvivhwmmDg4RmFma4_E_RSTEcOFNAC=
zVfrqEuvytQILY

My point in this thread has always been that it is an anti-feature to
presume that there is a need to treat EPC and VLA permissions
separately. This is a performance sink and it optimizes for a use case
which doesn't exist. Nobody actually wants there to be a mismatch
between EPC and VLA permissions.

So, besides EMODT, the only userspace interface we need is
mmap()/mprotect()/munmap(). The kernel should either succeed the
mmap()/mprotect()/munmap() syscall if the EPC permissions can be made
compatible or should fail otherwise.

Another interesting property arises from this flow. Since the EPC and
VLA permissions are always synchronized from the perspective of
userspace, in cases where the memory state between the kernel and the
exec layer is roughly synchronous, bookkeeping in the shim can be
implemented without any persistent memory between syscall handling
events. So, for example, the shim can implement brk() and
mmap()/munmap()/mprotect() with just two pointers: one to the break
position and one to the lowest mmap().

It is true that this basically commits enclave authors to doing all
EACCEPT calls immediately after modifications. But I suspect everyone
will do this anyway since there is no efficient (read: performant) way
for shims to handle page faults. So trying to do this lazily will just
result in a huge decrease in performance.
