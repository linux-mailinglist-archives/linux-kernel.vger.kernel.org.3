Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C0D4D0FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbiCHGFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiCHGFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:05:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9E833A16
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:04:25 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so778635wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 22:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gypJnXKyk9NshERI4nfF8ZEDV8trASXrbOi5IrTSOLA=;
        b=pqDG1nxeUutTXZzudpqy83iLiRKTNr6xpPWrPhs5WHeW2PDOZ7vKRnES02adLmi6PO
         fe409jwV8BB7VDLICnY7+iW9sBsgeWxNu6Wi75vvlmyC72ovzWbTlV3nHwRR+4Yk7GFk
         /tom3ibJsgbmfcvqcAKomiSXgi83HvcOsLgobDjAI8UU2Adg0vN7bTZVOE9oMdZG5RmM
         0luSDnIsCEOgUDAd72wLxkvxLUdWG8wjws9RlE4KrSHIiH9V5GV3TQTWkUFupWaFmPgX
         Tpr/PnSZ4GJZe1ib+94H+W6LNY08/zfReJwqTNomZrfenJAoyK/0J1ciVBtPxSr3Zctu
         yGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gypJnXKyk9NshERI4nfF8ZEDV8trASXrbOi5IrTSOLA=;
        b=GuXTQtJg5NSgjT3WY26XASV3KzWw8MptjtlRXxL1jM0MTXaUubQMnx8dYthijI51Qp
         A+YEzpRM7ZhlY9EBm4lQw9mWnOr315YdOdbfsCMwXg+ChCMWXVojO3HzYBhmEU+zabN1
         j3KJDDntzdhgk+2r6jy8gDoPfTIuUXKYABwpHkSzMjq0ZbB9WYPx6+4GgpM+shWWTUPl
         cfUGZaWCbDFD21VP5dKBa1PZCwoBHfeasU+eK7usmD8cq20qSEG+518qcVDWJD0sofWj
         Afezywx0we0lSzbxBZghPMOmC7oXFRJ7+4qpdgQE8V2L1bSOXxK5fpkRT2L8xXOCnGHj
         hLOw==
X-Gm-Message-State: AOAM533yHljT+/Dnb9ZNpslqHpKDMsf9V6ql53zh/E+6xYPW20TsRrNz
        fHXqT0pK5QmK4zlL4n3sGdPlNpvcCwRLBA9IddkoXw==
X-Google-Smtp-Source: ABdhPJzRz4DwgVkyJporm08OweviRnbnm0JVnkNLjzWdJzrtBWUuvyqaFt6iT1WmV1eDrhikQfJCtxoah1070AlbFes=
X-Received: by 2002:a7b:cc0d:0:b0:381:220e:a3a0 with SMTP id
 f13-20020a7bcc0d000000b00381220ea3a0mr2112937wmh.59.1646719464236; Mon, 07
 Mar 2022 22:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20220210054947.170134-1-apatel@ventanamicro.com>
 <20220210054947.170134-5-apatel@ventanamicro.com> <CAAhSdy3jK26WFhG8Q=Up8hhHPpJCCkA09EKOi+B-Kp0U9Rwg7w@mail.gmail.com>
In-Reply-To: <CAAhSdy3jK26WFhG8Q=Up8hhHPpJCCkA09EKOi+B-Kp0U9Rwg7w@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 8 Mar 2022 11:34:12 +0530
Message-ID: <CAAhSdy3q+NcuVsdGQ+KoY=CTO-zAfprY0XJkUbOTpD6u5VZCTQ@mail.gmail.com>
Subject: Re: [PATCH v11 4/8] RISC-V: Add SBI HSM suspend related defines
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <apatel@ventanamicro.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Wed, Feb 23, 2022 at 12:32 PM Anup Patel <anup@brainfault.org> wrote:
>
> Hi Palmer
>
> On Thu, Feb 10, 2022 at 11:20 AM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > We add defines related to SBI HSM suspend call and also
> > update HSM states naming as-per latest SBI specification.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Guo Ren <guoren@kernel.org>
>
> This patch is shared with "KVM RISC-V SBI v0.3 support".
> (https://lore.kernel.org/all/20220201082227.361967-2-apatel@ventanamicro.com/T/)
>
> How do you want to handle this ?
>
> One option is that I take this patch through the KVM RISC-V tree
> and you can send this series (minus this patch) for 5.18 after the
> KVM RISC-V changes have been merged.

I have queued this patch for 5.18. Let me know if you want to
handle this patch differently.

Thanks,
Anup

>
> Regards,
> Anup
>
> > ---
> >  arch/riscv/include/asm/sbi.h    | 27 ++++++++++++++++++++++-----
> >  arch/riscv/kernel/cpu_ops_sbi.c |  2 +-
> >  arch/riscv/kvm/vcpu_sbi_hsm.c   |  4 ++--
> >  3 files changed, 25 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index d1c37479d828..06133b4f8e20 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -71,15 +71,32 @@ enum sbi_ext_hsm_fid {
> >         SBI_EXT_HSM_HART_START = 0,
> >         SBI_EXT_HSM_HART_STOP,
> >         SBI_EXT_HSM_HART_STATUS,
> > +       SBI_EXT_HSM_HART_SUSPEND,
> >  };
> >
> > -enum sbi_hsm_hart_status {
> > -       SBI_HSM_HART_STATUS_STARTED = 0,
> > -       SBI_HSM_HART_STATUS_STOPPED,
> > -       SBI_HSM_HART_STATUS_START_PENDING,
> > -       SBI_HSM_HART_STATUS_STOP_PENDING,
> > +enum sbi_hsm_hart_state {
> > +       SBI_HSM_STATE_STARTED = 0,
> > +       SBI_HSM_STATE_STOPPED,
> > +       SBI_HSM_STATE_START_PENDING,
> > +       SBI_HSM_STATE_STOP_PENDING,
> > +       SBI_HSM_STATE_SUSPENDED,
> > +       SBI_HSM_STATE_SUSPEND_PENDING,
> > +       SBI_HSM_STATE_RESUME_PENDING,
> >  };
> >
> > +#define SBI_HSM_SUSP_BASE_MASK                 0x7fffffff
> > +#define SBI_HSM_SUSP_NON_RET_BIT               0x80000000
> > +#define SBI_HSM_SUSP_PLAT_BASE                 0x10000000
> > +
> > +#define SBI_HSM_SUSPEND_RET_DEFAULT            0x00000000
> > +#define SBI_HSM_SUSPEND_RET_PLATFORM           SBI_HSM_SUSP_PLAT_BASE
> > +#define SBI_HSM_SUSPEND_RET_LAST               SBI_HSM_SUSP_BASE_MASK
> > +#define SBI_HSM_SUSPEND_NON_RET_DEFAULT                SBI_HSM_SUSP_NON_RET_BIT
> > +#define SBI_HSM_SUSPEND_NON_RET_PLATFORM       (SBI_HSM_SUSP_NON_RET_BIT | \
> > +                                                SBI_HSM_SUSP_PLAT_BASE)
> > +#define SBI_HSM_SUSPEND_NON_RET_LAST           (SBI_HSM_SUSP_NON_RET_BIT | \
> > +                                                SBI_HSM_SUSP_BASE_MASK)
> > +
> >  enum sbi_ext_srst_fid {
> >         SBI_EXT_SRST_RESET = 0,
> >  };
> > diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> > index dae29cbfe550..2e16f6732cdf 100644
> > --- a/arch/riscv/kernel/cpu_ops_sbi.c
> > +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> > @@ -111,7 +111,7 @@ static int sbi_cpu_is_stopped(unsigned int cpuid)
> >
> >         rc = sbi_hsm_hart_get_status(hartid);
> >
> > -       if (rc == SBI_HSM_HART_STATUS_STOPPED)
> > +       if (rc == SBI_HSM_STATE_STOPPED)
> >                 return 0;
> >         return rc;
> >  }
> > diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
> > index 2e383687fa48..1ac4b2e8e4ec 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> > @@ -60,9 +60,9 @@ static int kvm_sbi_hsm_vcpu_get_status(struct kvm_vcpu *vcpu)
> >         if (!target_vcpu)
> >                 return -EINVAL;
> >         if (!target_vcpu->arch.power_off)
> > -               return SBI_HSM_HART_STATUS_STARTED;
> > +               return SBI_HSM_STATE_STARTED;
> >         else
> > -               return SBI_HSM_HART_STATUS_STOPPED;
> > +               return SBI_HSM_STATE_STOPPED;
> >  }
> >
> >  static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
> > --
> > 2.25.1
> >
