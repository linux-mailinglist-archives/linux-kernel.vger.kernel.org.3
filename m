Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D5655CE19
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbiF1DEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243334AbiF1DEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:04:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA212D1D;
        Mon, 27 Jun 2022 20:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2ED6B81C0C;
        Tue, 28 Jun 2022 03:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71DCC341CE;
        Tue, 28 Jun 2022 03:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656385474;
        bh=Dr3/Y/ZEFbz5YUD1O4lFuoAblnOIw2GNM9YjX37GVH8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R0ErmPALbkmJwBeVFyS4uRUSDdonftuKGiu/OsMcHbWNRZtqKfZ9pK7eRL8ew+ih9
         nfc0yHRKBRZdGGxXs8V3gfI7Qjt0wvSahFOx+O0msj5o5L+N+1m/hLOzIlRh+AjRtB
         nP2Rkx9roqAvNn6R13svRPBDYcSKA2FzvKiHGg99GRehV2MhiZeCjJTIR0cG3nXD4U
         tgki4uId0RC74c201aGQOQD8diLMtA+XggQVwAttyqEfCsW3OS4R1VIWRNDgysC8DU
         YlXRbC8Sw5dnMVZ8jxhGVzUmp/75Nsb2dWJ4yBzp0YcAn40RjEZ22wLcCMYlo1HQhy
         6qVEQIKZKbTKQ==
Received: by mail-vs1-f46.google.com with SMTP id j1so10743441vsj.12;
        Mon, 27 Jun 2022 20:04:34 -0700 (PDT)
X-Gm-Message-State: AJIora97pSiN518gmVzc9550m4iRrnoHIzDNCeq1wLm31MLFyr8CPxdO
        0qe5ApA4Hr9d9le3/ykrC7pE89IFFEbAmN5ICto=
X-Google-Smtp-Source: AGRyM1sASgqSd1n8b23qRP+ZhK+QUT6xztdltgnao0HzRVoKiGz7MfrQ2B57jUIY44E4lHuWRgyB3F8u57cQJWE342A=
X-Received: by 2002:a05:6102:366f:b0:356:352f:9de2 with SMTP id
 bg15-20020a056102366f00b00356352f9de2mr959975vsb.2.1656385473552; Mon, 27 Jun
 2022 20:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220627051257.38543-1-samuel@sholland.org> <20220627051257.38543-2-samuel@sholland.org>
 <CAJF2gTSq1NsBWRCg+kpTbJRwSeE30P9NVB5di6vzi7m2CFRzHw@mail.gmail.com> <ab5b4722-8219-ab1c-e9d8-2c00e52040da@sholland.org>
In-Reply-To: <ab5b4722-8219-ab1c-e9d8-2c00e52040da@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 28 Jun 2022 11:04:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR5Zb4TZbomVLbJdHG=JYrM9UkS4hxGeShXu0eu+SqpjQ@mail.gmail.com>
Message-ID: <CAJF2gTR5Zb4TZbomVLbJdHG=JYrM9UkS4hxGeShXu0eu+SqpjQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: interrupt-controller: Require trigger
 type for T-HEAD PLIC
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:14 PM Samuel Holland <samuel@sholland.org> wrote=
:
>
> On 6/27/22 2:40 AM, Guo Ren wrote:
> > On Mon, Jun 27, 2022 at 1:13 PM Samuel Holland <samuel@sholland.org> wr=
ote:
> >>
> >> The RISC-V PLIC specification unfortunately allows PLIC implementation=
s
> >> to ignore edges seen while an edge-triggered interrupt is being handle=
d:
> >>
> >>   Depending on the design of the device and the interrupt handler,
> >>   in between sending an interrupt request and receiving notice of its
> >>   handler=E2=80=99s completion, the gateway might either ignore additi=
onal
> >>   matching edges or increment a counter of pending interrupts.
> >>
> >> For PLICs with that misfeature, software needs to know the trigger typ=
e
> >> of each interrupt. This allows it to work around the issue by completi=
ng
> >> edge-triggered interrupts before handling them. Such a workaround is
> >> required to avoid missing any edges.
> >>
> >> The T-HEAD C9xx PLIC is an example of a PLIC with this behavior.
> > Actually, C9xx support pulse signals which configed by
> > pad_plic_int_cfg_x for SoC vendor:
> >
> > https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_=
rtl/plic/rtl/plic_int_kid.v
> > 104: assign int_new_pending =3D pad_plic_int_cfg_x ? int_pulse
> > 105:
> >         : level_int_pending;
> >
> > They could put pad_plic_int_cfg_x into the SoC software config
> > registers region or bind them to constant values.
>
> The issue here is the "!int_active" condition for int_new_set_pending,
> regardless of that configuration input.
>
> For interrupt sources that send pulses, those pulses will be lost if they=
 are
> received while int_active is true. So the driver has to make sure int_act=
ive is
> false _before_ servicing an interrupt, or it may miss the next one. This =
means
> the driver needs to know which interrupt _sources_ send pulses and which =
ones
> assert levels.
You are right, in plus mode, we can't receive any interrupt between
claim & complete, then the irq could be lost.

I think the design follows the sentence written by PLIC spec:
https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc

If the global interrupt source was edge-triggered, the gateway will
convert the =EF=AC=81rst matching signal edge into an interrupt request.
Depending on the design of the device and the interrupt handler, in
between sending an interrupt request and receiving notice of its
handler=E2=80=99s completion, the gateway might either **ignore additional
matching edges** or increment a counter of pending interrupts.

Also, the hardware could easily support the feature, but the engineer
follows the first choice and disable the useful function. -_*!

>
> For level interrupts, pad_plic_int_cfg_x had better be 0, but that is a
> hardware/firmware configuration concern. The driver should not have to ca=
re
> about that.
>
> (On the Allwinner D1, those inputs are memory mapped, which was the reaso=
n for
> the stacked interrupt controller mentioned in my other reply. But while
> pad_plic_int_cfg_x =3D=3D 1 only works with edge interrupts, the pad_plic=
_int_cfg_x
> =3D=3D 0 choice works with either kind of interrupt source, so the stacke=
d driver is
> not really needed.)
>
> Regards,
> Samuel
--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
