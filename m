Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB7A5779DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 06:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiGREHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 00:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiGREHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 00:07:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5C511C3A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 21:07:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e15so10002211wro.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 21:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUmxFHl7udbaeL8gObJYf8R+qnUxXk7ZcjzIWaqyHiU=;
        b=UnUh04t/rSmvdG08Yrty3ldek6Nnv0PmCHO9xvpdzMcucRZDVLF0YFkwtiucc8S3fX
         j/B5ft/44yxZfIJFQL6yKpNHrG7qyZ+Gok3CfVxwSw7ylIEw67z9gMmc5MtZNTI7vqdr
         Rov70ZXEYbCXKG5R1RqddA+np6zzsQsbJXgQQ7IvF3A/PI0BDjV1BHef3Wtl31bZ2sIQ
         sWw/4fdTZftmbCX2G/yjlOuHKfkM8/Sn+mbXpiCGLyg7gYh4UG5IfB1M2Kf/1jO7Xdx2
         TRC6b2akSnmDPuZh23RHTJhV/DcO0H+LkFpJIp4QI6NeAVdNd3wK/b8l+5KBsWRtVQ9b
         W8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUmxFHl7udbaeL8gObJYf8R+qnUxXk7ZcjzIWaqyHiU=;
        b=rhePxSLGVMBDEXwQHiU6+eHaJxaAWV/RzoiW6ycMuXhnklGrloRD/E4i9/XxaHSAOu
         qAuD6sJadnu734h/tp40a8RTDySkGzqyjTj9q9lXvRpS1i4jVLZOzkzMVeL0aym9FgGg
         Al8NOwmxnA6+PaBeZQTWut2UNL6rk3WT39wFUb6wkuMVYsnZ3/T1AuyLK3Hb5Jhymfhw
         WWq4M6IfYpE4aGhg9FaZ+1EuLfybsMZ08rgbEJt2sb8/MxeuxDvFGkxLB2QlcnD9WJQl
         bFqtK2KPOK3fKreXOBhbPBrE0NSn22qHhqDM2AyS7/Yn8nekBLVF9wKEo0COVd8Kj3ai
         eO9w==
X-Gm-Message-State: AJIora9jwJRtpcfemj0XiOkmJATldE8CH8G4nb8VqQ4UqCpZoRtxoelP
        VrTodXmrjmsXclAg+C8iIQbEQK7RFaoYNujM/gR3AA==
X-Google-Smtp-Source: AGRyM1sgRM5bHN+EZTdAYzsYGyGJ6+Pcr+8r6q8kcbAFBUN7ttVPf5ETNbVQta4uZJMVcFWrjH/y9SjWZJu38BqE6jQ=
X-Received: by 2002:a5d:53c9:0:b0:21d:62f8:f99f with SMTP id
 a9-20020a5d53c9000000b0021d62f8f99fmr21308980wrw.214.1658117237264; Sun, 17
 Jul 2022 21:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220707145248.458771-1-apatel@ventanamicro.com>
 <20220707145248.458771-5-apatel@ventanamicro.com> <CAOnJCUKjFMMsrNWR=hzB+qbw4SECWS3+DOJDun90emnM-Vkpiw@mail.gmail.com>
In-Reply-To: <CAOnJCUKjFMMsrNWR=hzB+qbw4SECWS3+DOJDun90emnM-Vkpiw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 18 Jul 2022 09:37:05 +0530
Message-ID: <CAAhSdy2WZ9Gq9n53u+0FY2SAsXrmgDGdsHjbTJDYRNG+yNw3bw@mail.gmail.com>
Subject: Re: [PATCH 4/5] RISC-V: KVM: Use PAGE_KERNEL_IO in kvm_riscv_gstage_ioremap()
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" 
        <kvm-riscv@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 6:53 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Thu, Jul 7, 2022 at 7:53 AM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > When the host has Svpbmt extension, we should use page based memory
> > type 2 (i.e. IO) for IO mappings in the G-stage page table.
> >
> > To achieve this, we replace use of PAGE_KERNEL with PAGE_KERNEL_IO
> > in the kvm_riscv_gstage_ioremap().
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/kvm/mmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> > index f7862ca4c4c6..bc545aef6034 100644
> > --- a/arch/riscv/kvm/mmu.c
> > +++ b/arch/riscv/kvm/mmu.c
> > @@ -361,7 +361,7 @@ int kvm_riscv_gstage_ioremap(struct kvm *kvm, gpa_t gpa,
> >         pfn = __phys_to_pfn(hpa);
> >
> >         for (addr = gpa; addr < end; addr += PAGE_SIZE) {
> > -               pte = pfn_pte(pfn, PAGE_KERNEL);
> > +               pte = pfn_pte(pfn, PAGE_KERNEL_IO);
> >
> >                 if (!writable)
> >                         pte = pte_wrprotect(pte);
> > --
> > 2.34.1
> >
>
> LGTM.
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Queued this patch for 5.20.

Thanks,
Anup
