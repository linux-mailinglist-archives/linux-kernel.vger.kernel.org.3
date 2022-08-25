Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B1B5A0777
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 04:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiHYCwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 22:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiHYCwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 22:52:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C39D105
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 19:52:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m5so15798036lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ky9f3zT08S4ZXNjlyA5qGbsFiUvNGJziEqTyRMY4jSw=;
        b=jo31VNDUXR8dbKvXYPyNa0M/tQAX3KyHNSSjuFpuQh9mB7Xyhvbs0IHAU7OaCjVSmy
         paWWTAVL9yz28LlBaaiv0rcb1ANcvdrTDPc8Gdm9qCupJCdajV6g7LylrLp0zy+TRHXO
         8RCmkbQWnxKFnqzAtL2EMCkPBOFwmxSk8z47W1tAVynQW41vlnUx8XPQuggBgXUa19kr
         bbyNO5C3paJoU0yujCZqslCm3QZ1VHbb9cVm7UjKJn9VZ9V6GX/cnuyOP5cUHDG0Opbk
         UY3qGBaQnJ4e8qBwBGdNaHoMYBLiDKgUA83URBqoVG2xXZQ2mBpo9Od8PptIxB3pafCD
         Kmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ky9f3zT08S4ZXNjlyA5qGbsFiUvNGJziEqTyRMY4jSw=;
        b=IHBLbvd/XWR/pRtbVSHbGJ3WoA/MFTWnwSaqrC2/nhRpke5ecACK8PRhI03bwTAeUX
         Qyf+U+TJyeZkoWeO5XvWHc9jPiGSrLkhSR//2VtClj7h5nJjvzQ5XS3Rexcp2Q5wobrh
         UZAnApyD8KESLZuot9UP77nRDwbCXej+/w71NLf23UTf5VRMlzNgmUALCCzeqCoPf8v+
         PFosLdBkchRlAFjPVdEoloBT8O8Uf61SKtNn3A+Rcdozx9AoaGbdxwmv1pLKiQt2R9rn
         q5RGztSKBf+pe8w5lkIGrshDMgWqgoCxeI2b0CeCIrEgG2TVO57W2DqEF5Q+tstTYS/q
         TeRA==
X-Gm-Message-State: ACgBeo1ooLUIht0fzJgys0gHP5D1H+z8FMkdvw4q7JMchfo9x0g2IQ/F
        MXQ14pDp/pI4S7cv512PHqv9GgTit6yR4PcYzBWEKw==
X-Google-Smtp-Source: AA6agR5adGSfvPjHNArIdRKeBP7Ky4mhYot3mSpYxhseCkqeFsMTRtBGNQP5s8bnvWkGLT62qwXl2P+zEWQfbLRaDug=
X-Received: by 2002:a05:6512:3b0f:b0:492:ef21:33a0 with SMTP id
 f15-20020a0565123b0f00b00492ef2133a0mr462100lfv.419.1661395918227; Wed, 24
 Aug 2022 19:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220817111348.745527-1-heiko@sntech.de> <CAOnJCUJu1fr2qxOkX4Sz-kLhB64xkcjAbBAeTkp214ZHAa0btA@mail.gmail.com>
 <CAK9=C2U3OvUZmYTJ-C0wkSp8ViPA1+Nj2L6pd4CHTCuzaVtDJg@mail.gmail.com> <13084187.uLZWGnKmhe@phil>
In-Reply-To: <13084187.uLZWGnKmhe@phil>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 25 Aug 2022 08:21:46 +0530
Message-ID: <CAK9=C2WhbguLxKuJ6jVZZQUvsv30iuORviDZ4sT9imvwwzNY2w@mail.gmail.com>
Subject: Re: [PATCH] drivers/perf: riscv_pmu_sbi: add support for PMU variant
 on T-Head C9xx cores
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Atish Patra <atishp@atishpatra.org>, anup@brainfault.org,
        will@kernel.org, mark.rutland@arm.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        philipp.tomsich@vrull.eu, cmuellner@linux.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 7:34 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 18. August 2022, 10:24:33 CEST schrieb Anup Patel:
> > On Thu, Aug 18, 2022 at 1:03 AM Atish Patra <atishp@atishpatra.org> wrote:
> > >
> > > On Wed, Aug 17, 2022 at 4:13 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > > >
> > > > With the T-HEAD C9XX cores being designed before or during the ratification
> > > > to the SSCOFPMF extension, they implement functionality very similar but
> > > > not equal to it. So add some adaptions to allow the C9XX to still handle
> > > > its PMU through the regular SBI PMU interface instead of defining new
> > > > interfaces or drivers.
> > > >
> > >
> > > IMO, vendor specific workarounds in the generic implementation is not
> > > a good idea.
> > > If we have to support it, I think we should just put the IRQ number in
> > > the DT and parse from the DT.
> > > The initial sscofpmf series was based on the DT. It was removed later
> > > as there was no need for it at that time.
> > > We can always revive it.
> > >
> > > Regarding the CSR number difference and static key enablement, can we
> > > use code patching techniques here as well ?
> > > At least all the T-HEAD C9XX core erratas are in one place.
> > >
> > > The alternate would be just to say T-HEAD C9XX support SSCOFPMF but
> > > with erratas. I don't prefer this approach
> > > but it keeps the vendor specific checks out of the generic code.
> >
> > Whether to have a DT node (or not) was already discussed and concluded
> > in the past.
> >
> > We don't need a DT node just to get the IRQ number. The T-HEAD custom
> > IRQ number can be derived based on mvendorid.
>
> Yeah, I remember reading that discussion and thus went with the mvendorid
> way in this patch.
>
> > Also, all these T-HEAD specific changes in SBI PMU driver should be
> > implemented as erratas using ALTERNATIVE() macros.
>
> (1) "All these T-HEAD specific changes ..."
> Actually the only T-HEAD-specific change is reading that different CSR
> for the overflow information, the rest only makes the irq-number variable

If it is just overflow CSR then it is simpler to do instruction patching
in drivers/perf/riscv_pmu_sbi.c itself.

>
> (2) ALTERNATIVE macros are working on assembler instructions, so are you
> sugesting to replace the generic csr_read() for the overflow-csr with a
> custom copy like
>
> #define sbi_pmu_read_overflow(void)                                             \
> ({                                                              \
>         register unsigned long __v;                             \
>         ALT_THEAD_PMU_OVERFLOW(__v); \
>         __v;                                                    \
> })
>
> and then in errata_list.h
>
> #define ALT_THEAD_PMU_OVERFLOW(__ovl) \
> __asm__ __volatile__ (alternative(
>         "csrr %0, " __ASM_STR(CSR_SSCOUNTOVF),  \
>         "csrr %0, " __ASM_STR(THEAD_C9XX_CSR_SCOUNTEROF), THEAD_VENDOR_ID, \
>                 ERRATA_THEAD_PMU, CONFIG_ERRATA_THEAD_PMU) \
>                               : "=r" (__ovl) :                  \
>                               : "memory");
>
> I'm not yet seeing what you're gaining by going with this approach:
> - that the overflow-csr is the same bitwise but only at a different
>   address is specific to the c9xx, other deviants might implement things
>   completely different
> - you're not getting rid of the thead mention
> - and we're now duplicating the generic csr-read code
>
> Is this the preferred way or what am I overlooking?

Yes, better to have special sbi_pmu_read_overflow() in
drivers/perf/riscv_pmu_sbi.c itself which is based on ALTERNATIVES.

I am suggesting ALTERNATIVEs only because overflow CSR is
accessed in the interrupt handler which is in hot-path when we run
"perf record".

Regards,
Anup
