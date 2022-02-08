Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65334ADDE2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352091AbiBHQCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiBHQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:02:46 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904F0C061576;
        Tue,  8 Feb 2022 08:02:45 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y84so21759403iof.0;
        Tue, 08 Feb 2022 08:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9goKUSm5hEh6zlQeP4WV+0zcx7w4KqUffXj4iFvvaS0=;
        b=AVstRejd2OfpszBwtTV2ky988zRsfxnGQUkq0k1RmrQtI25OvWncplA9iicci4eQt0
         Ky8Dr//S3zlXAMo08w4wiRrMYsJfIlpQD4tBONa/Z1Z67PosM+KZkS6sNkwN6TQuMade
         eQEPJ+JF7LCNrncDgF/jgMH+i+crNi3NaodYW/pofD8rxSbjxwgWdL69U457LGXhVNVt
         QFn8p0MWEWr851+fuKWQqVRUyeADhY61Mlnn9dVsZNFUpKROXkjDOX7q3XO36r0S5K+E
         H+CxeZ3OGDoOcO9Ff/kOOq26q3tgMjqZJJoViWfaLOTJ3J8D5kVF0GTg8vqBLelFEIyY
         gZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9goKUSm5hEh6zlQeP4WV+0zcx7w4KqUffXj4iFvvaS0=;
        b=ABZBlPe+y+BBG1yyXqLo6T/iD64HBQ/DyIFYzI/4pxOj7BxyzFBSKFc0khfPYA6g00
         UHSuFxN9JY8Qk+6jHs02IPYrVwKSIfnV419odM/pPhJ+fsaCKWEQqlP5NnK9UKIpTbKV
         q8aWPK/eYvAUEssqpmDrY8LBQmRPxlNN0qiTXm9Pyi/NWsQ7ChkPH4iFCCHp2ny1e6ej
         cHquSS5Jw4HULOnwCCabmN1J9V4KIlGB3C9z501Bp2FPsYHWnzaedH9SyiQqu0UmhsG5
         pv0fPBEdBm3HtSzwz1dIfRwT/p59WsAp8WFl8AinAzfaFg7TCDG6H8S501c7Thse7RWA
         ciUg==
X-Gm-Message-State: AOAM5304boWGHaO4zngbJ9dCGDtqvHwyhXLlDhtI/ySz7ZAJGZ5rpXMU
        W793+bJYCR5+rJUrkrg4qHGnPW6HHOw7vJHQHAk2+FGhqIk=
X-Google-Smtp-Source: ABdhPJxWd9NehdR0IUPTRQ3dI+8R4e08IACkgQZpt3VtxA6mH4xxNRR/QrS3S9EIlkGRDVBZFd0c4npXTVLinIvrVEc=
X-Received: by 2002:a05:6638:1388:: with SMTP id w8mr2464511jad.81.1644336163369;
 Tue, 08 Feb 2022 08:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20220205234554.4403-1-crawford.benjamin15@gmail.com>
 <20220206144343.2194-1-crawford.benjamin15@gmail.com> <42c51f9d-d122-2d09-cdcd-f733cbc60d5b@baylibre.com>
 <65cde84a-8f8b-ac57-9b66-2b8d6378dbfa@arm.com> <CANtEDzSVxnUsC05Vhr5gG3KRBAX_X564ZiY2nBSoBFoy54RQ5w@mail.gmail.com>
 <a7adf12d-f949-9a95-9c6a-b73017107dc7@arm.com>
In-Reply-To: <a7adf12d-f949-9a95-9c6a-b73017107dc7@arm.com>
From:   Benjamin Mordaunt <crawford.benjamin15@gmail.com>
Date:   Tue, 8 Feb 2022 16:02:32 +0000
Message-ID: <CANtEDzQDOiLKWW7c1VwnhjE-kjZ3tWYVKxBA4j1twOOjyEPcwQ@mail.gmail.com>
Subject: Re: [PATCH v2] add pmu to amlogic meson sm1
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay so this does appear to be behaving with some issues (unless I've
just got 2 of the interrupt numbers wrong, but it seems unlikely at
this stage).

CPUs 0 and 1 seem to be behaving somewhat sensibly, while `perf stat`
reports `<not supported>` for caches and branches with CPUs 2 and 3.
Would this suggest this implementation is indeed broken?

Thanks,
Ben


On Mon, Feb 7, 2022 at 1:47 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-02-07 13:33, Benjamin Mordaunt wrote:
> > The S905X3=E2=80=99s (Odroid C4) datasheet appears to report 4 individu=
al PMUIRQs,
> > much in the same way as GX. If that is indeed the case, I think this pa=
tch
> > applies. Otherwise, is the datasheet wrong if Marc=E2=80=99s comments a=
pply?
>
> A fairly solid test would be to run a sampling event (e.g. `perf stat`)
> taskset to a single CPU and observe the corresponding IRQ count increase
> in /proc/interrupts, for each core in turn. If that behaves as expected
> then chances are everything is indeed sane.
>
> Couple of nitpicks for the patch itself - you're almost there, but
> you've got spurious tabs on the blank lines, plus you need a proper
> commit message and your sign-off above the "---" line - anything you add
> below there is treated as additional commentary for reviewers' benefit
> and will be discarded by `git am`.
>
> Cheers,
> Robin.
>
> >
> > / Ben
> >
> > On Mon, 7 Feb 2022 at 13:20, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> >> On 2022-02-07 08:14, Neil Armstrong wrote:
> >>> Hi,
> >>>
> >>> On 06/02/2022 15:43, Benjamin Mordaunt wrote:
> >>>> ---
> >>>> The dts for meson sm1 appears to omit the SoC's PMU,
> >>>> which is essential for accessing perf events regarding
> >>>> e.g. cache on e.g. the Odroid C4 platform. Add it.
> >>>>
> >>>>    arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 13 ++++++++++++-
> >>>>    1 file changed, 12 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> >>>> b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> >>>> index 3d8b1f4f2..4147eecd2 100644
> >>>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> >>>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> >>>> @@ -6,6 +6,8 @@
> >>>>    #include "meson-g12-common.dtsi"
> >>>>    #include <dt-bindings/clock/axg-audio-clkc.h>
> >>>> +#include <dt-bindings/interrupt-controller/irq.h>
> >>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >>>>    #include <dt-bindings/power/meson-sm1-power.h>
> >>>>    #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
> >>>>    #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
> >>>> @@ -90,7 +92,16 @@ l2: l2-cache0 {
> >>>>                compatible =3D "cache";
> >>>>            };
> >>>>        };
> >>>> -
> >>>> +
> >>>> +    arm-pmu {
> >>>> +        compatible =3D "arm,cortex-a55-pmu";
> >>>> +        interrupts =3D <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                 <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                 <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                 <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> >>>> +        interrupt-affinity =3D <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> >>>> +    };
> >>>> +
> >>>>        cpu_opp_table: opp-table {
> >>>>            compatible =3D "operating-points-v2";
> >>>>            opp-shared;
> >>>
> >>> Please see Marc's comments about PMU support:
> >>> http://lore.kernel.org/r/8735pcq63o.wl-maz@kernel.org
> >>
> >> If SM1 actually has distinct per-core interrupts as the patch implies
> >> then it's fine - it's only G12B and anything else that combines multip=
le
> >> PMU IRQs into a single SPI which are unsupportable.
> >>
> >> Robin.
> >>
> >
