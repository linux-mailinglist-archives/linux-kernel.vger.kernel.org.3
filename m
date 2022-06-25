Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A130355ABE1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 20:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiFYSJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 14:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiFYSJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 14:09:54 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C91408A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 11:09:53 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3178acf2a92so51789447b3.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VaKpVqy51ezhyEqiWnN1EhPkd8AgPGvHiCVI0qsTW9U=;
        b=DXMUKF/LFsjrp1HGM3xK1pDytRU2+NbeWJx74hVFJr+pseb0uenbJST9xc2Aoa3nKP
         NzdJR4xll8W8hEc0J0hYTWRBw/GCsoeBR1teDmqfMDweS1RMqP3rhkIZKQF2PkPqpvUg
         dtUrjzZCWaCj4AhtBjjgCdVckq1k82VERWGI0zzprRSD+CaFdugthSNhLpqjMj+/Qt01
         P8yJ2A/bitADoOcZT6om8gkVU6/EfCw4lThMwACvOOFiiXd7q930kdsowwpHMVlcLcZ1
         rHIEX/o7r0l+KjfzlFKNfSD/APRNJTDJyhYTHy6sUdyMtaTA2qL5PjFKXqEDEL+dYl6C
         yV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaKpVqy51ezhyEqiWnN1EhPkd8AgPGvHiCVI0qsTW9U=;
        b=uQuE7S9x+6k652GuqTrbVsDFMOdfJR8nCr6YCqtzJFCcgCyfg6rT5Yl0773jEEhF5S
         dXAILndHSdz1ZBpvqGCEZIZ5Rn5p4o11G2AHxO+10zw4//EazSh7ksunwBlwj6nyYmKf
         J5qzK9+Y42Kor4xV+Vr4qhcb3d4RXC2j+BJn2Ksz0O5oWWMWwVvA8HduG53msEBwaonD
         KKHn/Hzy2mgdXip6WbaA172XLtgDYr5lzvN4uhVOECn3jP4As6IygG68eYDHj3CB5qYm
         o+eIzzd/FgCfTCMq8TuH3RsIb6P6SfS62IbY6w0NBmYhAH2JYf3tVMmcaAAK7sS9da6k
         3hnA==
X-Gm-Message-State: AJIora8CPMu43A4yn5UkoRvDMNTvdInaQ4tJmWe9e7RNex1h55F4mhl1
        YMr522B/prq5Gh3B/+DFG5JelNDfY01lLk9gWvRN2A==
X-Google-Smtp-Source: AGRyM1tSxzy+2SU7GX1N7kFiZRHGEsPFix8HC0KjDV/Ix0c0NXllmX30WW/q7/UvSFn6yXkmGiME7OXWPONI7GJZqBg=
X-Received: by 2002:a81:6587:0:b0:318:38c2:2fb1 with SMTP id
 z129-20020a816587000000b0031838c22fb1mr5689751ywb.118.1656180592325; Sat, 25
 Jun 2022 11:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
 <CACRpkdaXJh_Qc-DuD7SFsZPM9GBMUgnoufcFKsy3BPUYFHMHWQ@mail.gmail.com> <CAGETcx-io_5tVbRBfuB-qOwm4tV0A5FR82Q21Z1dJcLbAOkd=A@mail.gmail.com>
In-Reply-To: <CAGETcx-io_5tVbRBfuB-qOwm4tV0A5FR82Q21Z1dJcLbAOkd=A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 25 Jun 2022 20:09:39 +0200
Message-ID: <CACRpkdb1-F1CP0AAbS5FHoDRFdX-bS2m0NOfQm9nVcery+cW4Q@mail.gmail.com>
Subject: Re: Default async probing for DT based systems
To:     Saravana Kannan <saravanak@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 8:01 PM Saravana Kannan <saravanak@google.com> wrote:
> On Fri, Jun 17, 2022 at 1:21 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Thu, Jun 16, 2022 at 5:25 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > > Since fw_devlink=on is the default behavior and fw_devlink understands
> > > approximately 24 DT bindings,
> >
> > How can I see which these are, in the kernel tree?
>
> device/of/property.c has an array of these binding handling functions
> in of_supplier_bindings[].
>
> Most of the functions there are created using DEFINE_SIMPLE_PROP() or
> DEFINE_SUFFIX_PROP() that's also in the same file.

Thanks!

We already have some device links in pin control, it's an opt-in for
drivers, used e.g in drivers/pinctrl/stm32/pinctrl-stm32.c
where you see
pctl->pctl_desc.link_consumers = true;
how does that
play with this? Double device links at different levels?

I had a patch to just enforce device links on all pinctrl resources,
but it seemed over the top:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=consumer-link-enforce&id=73441cf773ed91bff0e7f66614d391b2514188bf

Yours,
Linus Walleij
