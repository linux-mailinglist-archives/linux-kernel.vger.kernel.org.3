Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A6158269F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiG0Ma7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiG0Mam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:30:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECC8617C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:30:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t1so26851145lft.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ps/+5VPVaYevdh/6gOs5F1hcVnusMTfNaW2Z1T8LP+A=;
        b=aneJs51DgGyKe9+lAleeq51Nfv17XMEKNKoFAMBIFEhU+PzxuRLX7O3yCmBYWHpHGA
         UUtuAYipA+JLfIwHYEYndPbayzRJU037rJv2XVArk57C7iO8aD92FJ1RPFTNvPaQ0WbL
         nTahfc/XfkSTifQIxmxyejZdwUUjONq5RpnZX/w2WeXaV2AbPLFuK58K7Oer3tYocPQC
         9MYWf6/Fe+cCzHpNc3JR6oKbgNgfqhbrPDKnzK+2njD+iRo+IEK1pScOX+9byFS3o31k
         OXS911hCdbaxYyanxSRLF0De0Mwg9dnxElewjqurL8zRgOjTe6nZYnVJd/yQPPSN0Oz/
         zfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ps/+5VPVaYevdh/6gOs5F1hcVnusMTfNaW2Z1T8LP+A=;
        b=cM5pkSZqqqXOsX7Cc/a1Ve3SUM5R49BhhN/4Q7HwP9lon4Ua7Q0c/0AJY/oE0ZrWVk
         Gxuk55lrjl12xJfveqQEjKl//MUudpcvf2tX+6IX6pPCYYmwh/dfn1180alds9YcTDOV
         3K6NSKxgsjdXuBdUVRImrbTSIuA5lE2J4F0ef9pBY9PS8yWba0PtxV7UibXn0HNc4ZBm
         WK/i9cL5WcQyvxmbI4xB3LK/sFCWW8WGgBpydSoH2rmK8rDjv0C/OGfqTXbHrEJLwK++
         gEQvOXSANZR7jOSgeUQoz5GvdEDkWIVFm3B21BDD79lbAoVMVotPHgoHoPbvYH3oiNv0
         6yWw==
X-Gm-Message-State: AJIora9xJH4ajN6U91cFZEGgdGkf9xrvVRv1ZsLVsji4U+BkmgxoTPhP
        yYO25xi9j9cSn/l16p7c09wI1lRiDsRIgvVtFZ+p5Q==
X-Google-Smtp-Source: AGRyM1usi3VvuAE9QHArHqPE+QINC2fW0qFj7SnfxJ0dIbBnMc/9ltEW0eEe8ey9YdP9hysi5LJxlZnjzcb87Fg6NAo=
X-Received: by 2002:ac2:44af:0:b0:48a:9e9f:74e5 with SMTP id
 c15-20020ac244af000000b0048a9e9f74e5mr3058834lfm.100.1658925011234; Wed, 27
 Jul 2022 05:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com> <20220727121838.tpy55twdkuasjab7@bogus>
In-Reply-To: <20220727121838.tpy55twdkuasjab7@bogus>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 27 Jul 2022 17:59:59 +0530
Message-ID: <CAK9=C2UFgZv5T433S6EVVa+4V2Uaffg6Xq1e2zLKbdFVFYhf0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property riscv,timer-can-wake-cpu
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 5:48 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jul 27, 2022 at 05:13:01PM +0530, Anup Patel wrote:
> > We add an optional DT property riscv,timer-can-wake-cpu which if present
> > in CPU DT node then CPU timer is always powered-on and never loses context.
> >
>
> I don't have much idea on idle states on RISC-V but associating this
> property in just CPU node seems like not so good idea.
>
> This will be applicable for all CPU idle states which means you
> can't use this even if one of the deepest idle state switches off
> the timer.
>
> We have local-timer-stop in each idle states node. IIRC RISC-V uses the
> binding which is now not arm specific[0] and IIRC you moved the binding
> yourself. Any reason why not can't be used and any specific reason for
> needing this extra property.

Indeed, the "local-timer-stop" property should be used. I guess,
Allwinner D1 should use this property in idle state and we should
not unconditionally set CLOCK_EVT_FEAT_C3STOP in the timer
driver.

@Samuel Holland Can you confirm that the "local-timer-stop" property
works for Allwinner D1 ? If yes, then please send a patch to remove
CLOCK_EVT_FEAT_C3STOP from timer driver.

Regards,
Anup
