Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC32758438F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiG1Puc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiG1PuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:50:23 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C185D2F38B;
        Thu, 28 Jul 2022 08:50:22 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-32194238c77so24014817b3.4;
        Thu, 28 Jul 2022 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36Hwq/qRh8es4w9GNvXSHTYjfUFBDsjRYb3TlEw3sq4=;
        b=ZyvciRQzuZ/9hIqed2BbMuHs1hzBRUKrIBDWJxHTuQ6IoAwV92sl34ptvlovkyMG7H
         D+L4GeAu+b+e5E0bO8OSbgoa1xgDWknpiBF/oKNF1kG7nEbQuxBLmvOu+JmzW3WlPBrp
         1sJFaxmDc57DVhK0dRne0McvWNBVqRdTAYNR5+1le1pm1TWFLXYL54vtBX/i8Ggf7uSD
         +8o2vGJDXZSGtCnEdTWpfTRyXcAW/0iXYRIUhIsjVsdU1zu4SABYlFX9KsYKTmnhDo/Q
         AIAOvX3LkvxYnKNh5fFmK+Tie06dMmClDDaDMYE1e4Qh7KKdsxbqGXwWxKMQQImAF891
         ksoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36Hwq/qRh8es4w9GNvXSHTYjfUFBDsjRYb3TlEw3sq4=;
        b=xJ63/GdDxwjxu6LcniptGkka+5ttQng4zUrv9oKSE9JeBVyj0Ly/DuicrhPZRAPXXs
         OTdzvRtJlMGjXtoljPyOuqw/cOOQNaQ6zP5xoseRPOzZtti+IuZA6a0Trwi8maVRF/qH
         DoNbPkMqLvnwr1ejdysRF76SBKCc/BfRiAZ2gQjwsoD4fad8sAvFXmRuaIg7PtY+iUfW
         lyh62J939VBFeTQo9LH0VmkKZ9q/abI1z0srficVb8dCfDIOkYaPs5n63IBvKf6jU/TJ
         7uRdBCFABHnzoaOatC3zvHrRvwtAoN8GNznFcn89rbCMQ3v1EfnbONkFkBgYRUWYN72Z
         Pg5g==
X-Gm-Message-State: AJIora9g5htS1OVILkiiWw/u6BHS6LijHbnHMmGAf8DIcKQhEzWuS4Fy
        osL+bGkuZfnsyrGtWkC0f4ssiSCzx3yh/9PDObE=
X-Google-Smtp-Source: AGRyM1u//aTCa0acrH/zETJEn1/xi//6B9XOsR1Vh4eitow4Zipho038DMVJtbm8PRn+kbrW3v/a7g+FgP76xWRfkBI=
X-Received: by 2002:a81:a149:0:b0:31f:fded:b121 with SMTP id
 y70-20020a81a149000000b0031ffdedb121mr6161578ywg.122.1659023421655; Thu, 28
 Jul 2022 08:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220702190705.5319-1-olek2@wp.pl> <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
 <87fsjen2kl.wl-maz@kernel.org> <20220706081901.GA10797@alpha.franken.de>
 <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
 <20220707100630.GC9894@alpha.franken.de> <CAFBinCBn3+MbKFE84Y0KjW4qG_88+HuBTzRhPQSDqzqGhyhhZw@mail.gmail.com>
 <20220707143930.GA14693@alpha.franken.de>
In-Reply-To: <20220707143930.GA14693@alpha.franken.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 28 Jul 2022 17:50:10 +0200
Message-ID: <CAFBinCBq3ydoxtj1VG=kjqbq5NjP1ZnQe_dOAS2Gjm2fNkK9Yg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second VPE
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Marc Zyngier <maz@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Aleksander Jan Bajkowski <olek2@wp.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>, git@birger-koblitz.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Jul 7, 2022 at 4:40 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
[...]
> > Or can you point me to the code in
> > drivers/irqchip/irq-mips-cpu.c that's responsible for enabling the
> > interrupts on VPE 1 (is it simply unmask_mips_irq)?
>
> IMHO there is the problem, irq-mips-cpu.c can only do CPU irq operations
> on the same CPU. I've checked MIPS MT specs and it's possible do
> modify CP0 registers between VPEs. Using that needs changes in
> irq-mips-cpu.c. But mabye that's not woth the effort as probably
> all SMP cabable platforms have some multi processort capable
> interrupt controller implemented.
On Lantiq the "multi processor capable interrupt controller" solution
seems not very sophisticated: there's simply two identical copies of
the IRQ controller IP, one connected to CPU0 and the other to CPU1.

> I thought about another way solve the issue. By introducing a
> new function in smp-mt.c which sets the value of the interrupt
> mask for the secondary CPU, which is then used in vsmp_init_secondary().
> Not sure if this is worth the effort compared to a .boot_secondary
> override.
I think for the Realtek SoC's this would be problematic because it's
using MIPS_GENERIC. My understanding is that in an ideal world all
platforms would switch to MIPS_GENERIC.
As an alternative to making irq-mips-cpu capable of changing another
CPU's registers: would you also be happy with a change that implements
the following idea (pseudocode) in vsmp_init_secondary():
    struct device_node *root_node = of_find_node_by_path("/");

    if (mips_gic_present() ||
        of_device_is_compatible(root_node, "lantiq,xrx200") ||
        of_device_is_compatible(root_node, "realtek,some-relevant-soc"))
        change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 |
            STATUSF_IP4 | STATUSF_IP5 |
            STATUSF_IP6 | STATUSF_IP7);
    else
       ...

    of_node_put(root_node);

That way we don't risk enabling interrupt lines which shouldn't be
enabled (on SoCs which we don't know).
And also it would not cause any issues with MIPS_GENERIC support.


Best regards,
Martin
