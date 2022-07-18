Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368B45787D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiGRQyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGRQx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:53:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FD962E5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:53:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p4so7517874wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFgEFsfl8rKJs7ra2dHHZoS/sWYcHlxBizMiDuSMBHs=;
        b=mKTwFX9DcjFSbsWZCVza9QbOzZMgaViFHpyhezP8skfw9OhFHOtxe7Coa9eHKiupWf
         GVN5yHFqjF5RvR4cUnCT5TeYNNGH16qQTQo1324kdB32i+xK1jhd92eVU0UxcAZ1VJl+
         YCFlHbbXFyJy8vOlddVjkGKOTQ/m/QSiyBzHwmTC5yTtRUwcf7Uvc6jPR9g4q/bJhb7J
         0l7QCOPJacqQKytb6294d+jLYTpGkqKCr9Rhiqu6KsMCbZfa8rkADp06Jt0BTjfPbpq6
         bKh2lRVqkB/XiLnFVspPNZtdu2+PyjKIBF3giMevCtYzSqa8goeqyMShrFPusWEqeYPO
         hhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFgEFsfl8rKJs7ra2dHHZoS/sWYcHlxBizMiDuSMBHs=;
        b=r5DO5rY3M42o4VJChkspK/9MNBcDr3HuJqne1ekhKHWWQIrdymtc2nH4Z+dJS+HbKg
         cMhrUNS1Vz8CGgvkM3C+BXbc0FIzt3WJurryZdvYMUhGChzh29gUX0lNg2Q3ejOQDPD6
         z6r3JOnndcTKkXkEXoSepHYKhTzgdbT3SDooAjFDfVLmU047PfHSkRAOUkKes/L4+fQ6
         S13aKjGv4fr3KXU5kGZ/40Q/3NU6IxtaNk8EtXkuCZHgk3/e67LVbXnURHeUHwo7R+wD
         tOAZ7j7TEKNNGStYKLMy+DbJrCFVzUh/GA8pcQheYEPS+knBqZzZs1uw2+wcT7iYwc+S
         Qhuw==
X-Gm-Message-State: AJIora/OJRyG96b1hj00zwBZrOlxnmvyFeJoiF3g/NWY/xlxewX6WZpP
        NNZTX+FHFQ1KdBaaiY2ArS9a21zdvF4/Ta/g+EMmlg==
X-Google-Smtp-Source: AGRyM1vVZb4Aon6v5ILgG/Iyd1Sfx4G+07cbbi2sRUeRYV96oOPEBR88UX4fRnJ/EZaOzI28tw0KmqafYPKa3sfBzio=
X-Received: by 2002:a05:600c:a146:b0:3a3:1e79:4446 with SMTP id
 ib6-20020a05600ca14600b003a31e794446mr3231430wmb.158.1658163235828; Mon, 18
 Jul 2022 09:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-7-kaleshsingh@google.com> <87k08c3vtw.wl-maz@kernel.org>
In-Reply-To: <87k08c3vtw.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Jul 2022 09:53:44 -0700
Message-ID: <CAC_TJvcxPCWXq_dViN09c5eyd0N_TdfOmOgExaiO+ugfeTuN6g@mail.gmail.com>
Subject: Re: [PATCH v4 06/18] arm64: stacktrace: Add description of stacktrace/common.h
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>, android-mm@google.com,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 2:58 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 15 Jul 2022 07:10:15 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Add brief description on how to use stacktrace/common.h to implement
> > a stack unwinder.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/include/asm/stacktrace/common.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> > index f86efe71479d..b362086f4c70 100644
> > --- a/arch/arm64/include/asm/stacktrace/common.h
> > +++ b/arch/arm64/include/asm/stacktrace/common.h
> > @@ -2,6 +2,14 @@
> >  /*
> >   * Common arm64 stack unwinder code.
> >   *
> > + * To implement a new arm64 stack unwinder:
> > + *     1) Include this header
> > + *
> > + *     2) Provide implementations for the following functions:
> > + *            - on_overflow_stack()
> > + *            - on_accessible_stack()
> > + *            - unwind_next()
>
> A short description of what these helpers are supposed to do would
> also be helpful.

Thanks Fuad, Marc. I'll add descriptions in the next version.

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
