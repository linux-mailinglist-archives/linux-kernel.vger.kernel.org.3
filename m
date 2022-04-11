Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4FC4FBC34
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346142AbiDKMi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346125AbiDKMiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:38:25 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123091AD99;
        Mon, 11 Apr 2022 05:36:11 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id b17so13060462qvf.12;
        Mon, 11 Apr 2022 05:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwALCLphRY0C4UTHiPknn9pMqBg3LkP1UU4uqZKSCNE=;
        b=PNpyaatoefdjsoaMPBBAlGfqIIOu+1zyG8Q2yzsCkxzosDg+1q+2CPUOVZhL4z5yon
         /quA3qTRMjggxrul+tdpLe9axVad1F5gFFhlEa10PQwtjeVguSiLjdKWklQ3IFwKDONL
         w4TM+vhyUWnN3x7zfcM4sajBOMeP+F54dyDlnV7A/fOFHJsfBdXQiFH4QyLcoXAtakxd
         2eeyqIloSIY8DpG3t0CB5vcyL8MAsqA9yy1QK2AA+bCqUrOXJacFsX6MgBQfF5GiOup7
         DtSIadt3Bu0by98YL92GoQh3yyokACFPGfF82vgmOuP0xOCt+5cVb5NEOr3j6pM6LDMT
         SRyw==
X-Gm-Message-State: AOAM533yUszR+ECKXzzxE2coubJb5sIbsg+ThtUxkZVMSRRkXrrDjjdN
        E2Ze5HumcU2ZhDSkoAh46pWzJ51sdSprZg==
X-Google-Smtp-Source: ABdhPJx2BpNj2C+T2b7AbXzgGzOzuchZp0EGVAhwk6oS//FnCZi5lF8FXj72jmKXwQfNW4bYI4I4Ow==
X-Received: by 2002:a05:6214:622:b0:441:2825:c288 with SMTP id a2-20020a056214062200b004412825c288mr26910719qvx.79.1649680569907;
        Mon, 11 Apr 2022 05:36:09 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a22a700b0069c37e2c473sm5978qkh.94.2022.04.11.05.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 05:36:09 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ec05db3dfbso42127267b3.7;
        Mon, 11 Apr 2022 05:36:09 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr25284348ywi.449.1649680568889; Mon, 11
 Apr 2022 05:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-3-singh.kuldeep87k@gmail.com> <558f0c92-c499-daca-e1ad-2b16137f8c06@arm.com>
 <20220317212508.GB99538@9a2d8922b8f1> <Yjd23Gro6B6zWCrO@robh.at.kernel.org>
In-Reply-To: <Yjd23Gro6B6zWCrO@robh.at.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 14:35:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1z3wi-TG7vYFyF=rbYNuV5=wVffAv6a2mzTRMW-1f+A@mail.gmail.com>
Message-ID: <CAMuHMdV1z3wi-TG7vYFyF=rbYNuV5=wVffAv6a2mzTRMW-1f+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: timer: Document arm, cortex-a7-timer
 in arch timer
To:     Rob Herring <robh@kernel.org>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 7:56 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Mar 18, 2022 at 02:55:08AM +0530, Kuldeep Singh wrote:
> > On Thu, Mar 17, 2022 at 08:25:12PM +0000, Robin Murphy wrote:
> > > On 2022-03-17 19:15, Kuldeep Singh wrote:
> > > > Renesas RZ/N1D platform uses compatible "arm,cortex-a7-timer" in
> > > > conjugation with "arm,armv7-timer". Since, initial entry is not
> > > > documented, it start raising dtbs_check warnings.

I hadn't seen this thread, but I had already removed the unneeded
compatible value locally, and was just waiting for the merge window and
holidays to end for sending the patch...

> > > >
> > > > ['arm,cortex-a7-timer', 'arm,armv7-timer'] is too long
> > > > 'arm,cortex-a7-timer' is not one of ['arm,armv7-timer', 'arm,armv8-timer']
> > > > 'arm,cortex-a7-timer' is not one of ['arm,cortex-a15-timer']
> > > >
> > > > Document this compatible to address it. The motivation to add this
> > > > change is taken from an already existing entry "arm,cortex-a15-timer".
> > > > Please note, this will not hurt any arch timer users.
> > >
> > > Eh, if it's never been documented or supported, I say just get rid of it.
> > > The arch timer interface is by definition part of a CPU, and we can tell
> > > what the CPU is by reading its ID registers. Indeed that's how the driver
> > > handles the non-zero number of CPU-specific errata that already exist - we
> > > don't need compatibles for that.
> > >
> > > In some ways it might have been nice to have *SoC-specific* compatibles
> > > given the difficulty some integrators seem to have had in wiring up a stable
> > > count *to* the interface, but it's not like they could be magically added to
> > > already-deployed DTs after a bug is discovered, and nor could we have
> > > mandated them from day 1 just in case and subsequently maintained a binding
> > > that is just an ever-growing list of every SoC. Oh well.
> >
> > Robin, A similar discussion was already done on v1 thread. Please see
> > below for details:
> > https://lore.kernel.org/linux-devicetree/20220317065925.GA9158@9a2d8922b8f1/
> > https://lore.kernel.org/linux-devicetree/726bde76-d792-febf-d364-6eedeb748c3b@canonical.com/
> >
> > And final outcome of discussion turns out to add this compatible string.
>
> I agree with Robin on dropping. More specific here is not useful. If
> we're going to add some cores, then we should add every core
> implementation.

... So consider it gone.

https://lore.kernel.org/r/a8e0cf00a983b4c539cdb1cfad5cc6b10b423c5b.1649680220.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
