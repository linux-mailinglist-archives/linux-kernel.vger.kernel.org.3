Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16B95A59C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiH3DNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiH3DMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:12:41 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBEA9C2FE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:12:33 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-334dc616f86so242180907b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0Yo1WivuivvhRmPeZKwYl+1/Tm5Jx2AH00zX2jB5mOc=;
        b=TynbUNWtUYNJa5m9EplRfTPwmEY6uCrrvhvjSX0uX/EBzaal5Mnc77gp8fYK5Abw4s
         ATRMSzNXckcG0a9ZyvZm5/6CKzrQSJIQ+AC+UN6aCBXoazMeFQqfVc8+u9NJpH/LWKaQ
         DKT6zrOfp4cqbyktN+/4o/QWs4uSW2rZPPpE45I1b0UtOtnPOP53DtnJWXHPVQNOw5Kw
         +AppjWNtVCbDfyk5l0jF48f6hPODwHI/afKAwUq6D7bTnCdUf5peAnIWcmEVsvjxL+o6
         Ek1R3yl+3BFFIV5mEpbpdh7PVkQhIcA74t8Jz41NxxgubcZjKfTIbojnOo47YkjzQXmK
         O+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0Yo1WivuivvhRmPeZKwYl+1/Tm5Jx2AH00zX2jB5mOc=;
        b=u4DnQbqkQpwpk54XtdHdt/QxejhWNY6ttUq/UydmyiW9/PQwa1oj+CATNq3aP8uIuZ
         3YDN2v2yh96+NFpVxu6Quf2QtAvjxbseLmEgvNNiF3koKXF2IlSbhm3nvvgBKd4ZaQPI
         +t0KUFqSfXjsHruZ9lncOBwZCieSyWtQYVCWiat/yjiE8frlBW0d4klOYapK/AKlvkGQ
         qLFPb/XxVZQSdT1jkPUcOLT9qZeeufpiKHZDHWEHNUSj+NAOka2FGHxNyCKKPvlhlJc+
         neusoax1YXispNAj7yZnWG8j/Si7ABiQVpAa9MzVS4Auqlp54HWTxkGqrjDz8dXGMGuZ
         Drcw==
X-Gm-Message-State: ACgBeo1rV0zL53eMngBeIE8ZMR9ecwbz5GL8XqD7oFmOu6K4zZqdqzKy
        LUwAnKvdvcSUiaNba1sSIR2bAciaQI8Waqv2oAL0Mw==
X-Google-Smtp-Source: AA6agR5B++glpRuf4xCgZTvJW+5BPMjOrGjXDcd+1m+GQn+5AJNWmVwJf3dqNw1INuB10QqVbkBRP5/QfAw467HPSBM=
X-Received: by 2002:a25:253:0:b0:696:4000:8844 with SMTP id
 80-20020a250253000000b0069640008844mr10778698ybc.619.1661829152701; Mon, 29
 Aug 2022 20:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220819140250.3892995-1-ajones@ventanamicro.com>
 <20220819140250.3892995-4-ajones@ventanamicro.com> <CAAhSdy0d8mjr5-5Um2DpLgnhPb3UnGggXvbu_=oqEHWYzMP1SQ@mail.gmail.com>
 <20220829094739.pn7iltmtimpwpshf@kamzik>
In-Reply-To: <20220829094739.pn7iltmtimpwpshf@kamzik>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Aug 2022 08:42:20 +0530
Message-ID: <CAAhSdy2OwNNq4PzFfHgVFYVGW3UQt3=geZGOGPojcA55c20rcA@mail.gmail.com>
Subject: Re: [PATCH 3/4] riscv: KVM: Apply insn-def to hfence encodings
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mchitale@ventanamicro.com, heiko@sntech.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 3:17 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Mon, Aug 29, 2022 at 02:07:59PM +0530, Anup Patel wrote:
> > On Fri, Aug 19, 2022 at 7:32 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > >
> > > Introduce hfence instruction encodings and apply them to KVM's use.
> > > With the self-documenting nature of the instruction encoding macros,
> > > and a spec always within arm's reach, it's safe to remove the
> > > comments, so we do that too.
> > >
> > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > ---
> > >  arch/riscv/include/asm/insn-def.h |   8 ++
> > >  arch/riscv/kvm/tlb.c              | 117 ++++--------------------------
> > >  2 files changed, 21 insertions(+), 104 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> > > index 4cd0208068dd..cd1c0d365f47 100644
> > > --- a/arch/riscv/include/asm/insn-def.h
> > > +++ b/arch/riscv/include/asm/insn-def.h
> > > @@ -79,4 +79,12 @@
> > >  #define RS1(v)         __REG(v)
> > >  #define RS2(v)         __REG(v)
> > >
> > > +#define OPCODE_SYSTEM  OPCODE(115)
> > > +
> > > +#define HFENCE_VVMA(vaddr, asid)       \
> > > +       INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17), RD(0), vaddr, asid)
> > > +
> > > +#define HFENCE_GVMA(gaddr, vmid)       \
> > > +       INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(49), RD(0), gaddr, vmid)
> > > +
> > >  #endif /* __ASM_INSN_DEF_H */
> > > diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> > > index 1a76d0b1907d..f742a0d888e1 100644
> > > --- a/arch/riscv/kvm/tlb.c
> > > +++ b/arch/riscv/kvm/tlb.c
> > > @@ -12,22 +12,7 @@
> > >  #include <linux/kvm_host.h>
> > >  #include <asm/cacheflush.h>
> > >  #include <asm/csr.h>
> > > -
> > > -/*
> > > - * Instruction encoding of hfence.gvma is:
> > > - * HFENCE.GVMA rs1, rs2
> > > - * HFENCE.GVMA zero, rs2
> > > - * HFENCE.GVMA rs1
> > > - * HFENCE.GVMA
> > > - *
> > > - * rs1!=zero and rs2!=zero ==> HFENCE.GVMA rs1, rs2
> > > - * rs1==zero and rs2!=zero ==> HFENCE.GVMA zero, rs2
> > > - * rs1!=zero and rs2==zero ==> HFENCE.GVMA rs1
> > > - * rs1==zero and rs2==zero ==> HFENCE.GVMA
> > > - *
> > > - * Instruction encoding of HFENCE.GVMA is:
> > > - * 0110001 rs2(5) rs1(5) 000 00000 1110011
> > > - */
> > > +#include <asm/insn-def.h>
> > >
> > >  void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
> > >                                           gpa_t gpa, gpa_t gpsz,
> > > @@ -41,31 +26,14 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
> > >         }
> > >
> > >         for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order)) {
> > > -               /*
> > > -                * rs1 = a0 (GPA >> 2)
> > > -                * rs2 = a1 (VMID)
> > > -                * HFENCE.GVMA a0, a1
> > > -                * 0110001 01011 01010 000 00000 1110011
> > > -                */
> > > -               asm volatile ("srli a0, %0, 2\n"
> > > -                             "add a1, %1, zero\n"
> > > -                             ".word 0x62b50073\n"
> > > -                             :: "r" (pos), "r" (vmid)
> > > -                             : "a0", "a1", "memory");
> > > +               asm volatile (HFENCE_GVMA("%0", "%1")
>
> Thank you for the review, Anup! I'd also like to get opinions on whether
> the caller should quote the register tokens or the call should be made as,
> e.g. HFENCE_GVMA(%0, %1), and then do the quoting inside the macro for
> C callers. I could go either way, but I'm starting to lean towards moving
> the quoting into the macros.

I am fine with the current approach but doing quoting inside macors will
certainly be more user friendly.

Regards,
Anup
