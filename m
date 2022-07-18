Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1451578804
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiGRRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiGRRDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:03:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB82C102
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:03:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bu1so17970405wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptpv3NcLhPJ5VpMsedGx3eHo8WBrGWeiJ8cSXNWgb/4=;
        b=Y27goTNXBKsu4vXtC3nlibmjnNVCjFjxgrfZOUL3Ap/c/Z9hKcBh9MXJapW2dE/VGL
         zGB+Km7EbYr2JLZ/Umr+CyDsylc+Ozgpz8HXgQVktSWZBG+ePuMVsRSambf7XYAkLr2q
         G8uYaCvUMOUFNw3/CxkfVF9vhXvy3F5YH6Pc72LoEJY/ARsAHUDLO5VUbZIHkc7q/GPe
         NHEa9wQ91BDV7GXM8x6IJoWwH7AJMFgu3X5WLZfHe54yqwpjdzLS43rClGvkl65FIzUe
         ObeGb/YOiGjljF3iTaqMM9VkqWsl2svmq8XWIhAiIZkrrh/cA87qbXoooknYGFCg3QD1
         28oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptpv3NcLhPJ5VpMsedGx3eHo8WBrGWeiJ8cSXNWgb/4=;
        b=s25HRxgT6N4Geuf3FJYphjB5ikbv49D1C3FS9WGA51upYaeyIr0frhimPiyeXRCDR0
         waeDtLAKZzut6uxDFr9yyyyn3S6fWe58W3fx1bzPaDNoGYh3qU61QnilEsv7FED/w8/T
         zbbP3N15pr/sd8SEm5gptKDHk9QTaucaUHBaZGIr9giMK1ibGcDTIBBJKqTIIh8B0dPL
         jIQCzPZ2athqui5FoUKtKDdT903ccjPVpD33Mp02e2H8uBB93Ha0hk0gXVVYWitgD+Gt
         Nb6bz0D7Z9jJa8eV94kOXCoSsbbC6vWoaTQ7kFkq9PkD2rLA8DvOngtLk1HsPqh7jG6+
         RaTQ==
X-Gm-Message-State: AJIora+TXZHjdkBlbl3CfOtubRyvkai/6QKkbqGooNNnBFwO7CD8EqkW
        +MU0/yIHy995w95jsLrBv0M9NLE2s6Tuc2hXjOqFow==
X-Google-Smtp-Source: AGRyM1tO6ZIAXpTKNUvMA5ZeA43y9QffvRUOq+TtCJgH/I6iDOQtfKW5JykSasnWKD0SGHfcPw9GImSjVDEvNipho2s=
X-Received: by 2002:a05:6000:508:b0:21d:4105:caf9 with SMTP id
 a8-20020a056000050800b0021d4105caf9mr24289854wrf.699.1658163820965; Mon, 18
 Jul 2022 10:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-9-kaleshsingh@google.com> <87cze252q7.wl-maz@kernel.org>
In-Reply-To: <87cze252q7.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Jul 2022 10:03:30 -0700
Message-ID: <CAC_TJvcyb6xQhvuoSHpC6+LmeSAqbDk9Fnb=x-bB7UxxMek3EA@mail.gmail.com>
Subject: Re: [PATCH v4 08/18] KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
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
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
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

On Sun, Jul 17, 2022 at 11:56 PM Marc Zyngier <maz@kernel.org> wrote:
>
> [- Drew and android-mm, as both addresses bounce]
>
> On Fri, 15 Jul 2022 07:10:17 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > This can be used to disable stacktrace for the protected KVM
> > nVHE hypervisor, in order to save on the associated memory usage.
> >
> > This option is disabled by default, since protected KVM is not widely
> > used on platforms other than Android currently.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/kvm/Kconfig | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > index 8a5fbbf084df..1edab6f8a3b8 100644
> > --- a/arch/arm64/kvm/Kconfig
> > +++ b/arch/arm64/kvm/Kconfig
> > @@ -46,6 +46,21 @@ menuconfig KVM
> >
> >         If unsure, say N.
> >
> > +config PROTECTED_NVHE_STACKTRACE
> > +     bool "Protected KVM hypervisor stacktraces"
> > +     depends on KVM
> > +     default n
> > +     help
> > +       Say Y here to enable pKVM hypervisor stacktraces on hyp_panic()
> > +
> > +       If you are not using protected nVHE (pKVM), say N.
> > +
> > +       If using protected nVHE mode, but cannot afford the associated
> > +       memory cost (less than 0.75 page per CPU) of pKVM stacktraces,
> > +       say N.
> > +
> > +       If unsure, say N.
> > +
>
> Can we make this depend on NVHE_EL2_DEBUG instead? I'd like to keep
> the disclosing of EL2 information in protected mode a strict debug
> feature.

Hi Marc,

An earlier version was similar to what you propose. The unwinding
depended on NVHE_EL2_DEBUG and all unwinding was done from EL1 with
host stage 2 being disabled. The reason the design was changed is
because Android expressed the need for pKVM hyp stacktraces in
production environments. [1]

[1] https://lore.kernel.org/all/CAC_TJveNRaDFcQGo9-eqKa3=1DnuVDs4U+ye795VcJ1ozVkMyg@mail.gmail.com/

--Kalesh

>
> >  config NVHE_EL2_DEBUG
> >       bool "Debug mode for non-VHE EL2 object"
> >       depends on KVM
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
