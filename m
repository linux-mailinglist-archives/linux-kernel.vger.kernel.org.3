Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB0496786
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiAUVoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiAUVoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:44:17 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4B7C061748
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:44:16 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d14so8763061ila.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gv9X5jp66iJ/t0mGKimaLSIUwkCQNXJG8eeLFnptbT0=;
        b=LaN+63bTy7CQXXuyOL3OBBRlDenJk5sISEyr9WtKJOm8CX5UizxlEHflnYvYrwMEjB
         LQ78iZMXt/8uioM4twI4R3Adp1dkLcGiX4QxoStNqbWZ9Rts0TfFyo5audcd7zHaivWL
         xtzxXLoT62NwoUjQnG9yqJTH/Vsnhf+SM/3Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gv9X5jp66iJ/t0mGKimaLSIUwkCQNXJG8eeLFnptbT0=;
        b=JZBKlB82CDb7ZoozEhHdO4K0sscAJuoHN2ChE9Oc9EMhYmgDq/6mbDmbIMVSk6uK/O
         6Fdqxc91se7nKXQmFjitgExWtoaVWuo8ediA+kx1R8TX/29bLQJLAOA2DT6X6GhyDpTH
         57jSJeqApC5hPH1TiWc128cBfjLzfHOsKEAuy2/FZ7Kwq+npcyPeVL8iayglvtP+a3vL
         ULfysRqKLYadHmdEmjYoM4lm+osI59BWW/bzllpLB6i2lg1CnPO7ugvI/O9NiZeJ3Xoz
         5YjdDhLH3GTiHzLKo/LFFAMaZR1r/FI1vKv80Y03XXpna8TIyy90mafBRbsocBpJZHfC
         Q4rQ==
X-Gm-Message-State: AOAM533z1iYMqRxOg9vxplQgAeO6UiaxxKSxx3yHJJP9JSkERhd3WIhL
        IGGsqJJ7gee04EhREuZCYy1Ft23ngccZ2g==
X-Google-Smtp-Source: ABdhPJzbirHfk9z7GS6UKr5duUxhm6We+ystbFaiTbqB/ylfnHbUbH6DExj6fIP3IW7XRmw+LkwTwQ==
X-Received: by 2002:a92:c267:: with SMTP id h7mr2111239ild.272.1642801455899;
        Fri, 21 Jan 2022 13:44:15 -0800 (PST)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id i15sm1993165iog.14.2022.01.21.13.44.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 13:44:15 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id i1so2728165ils.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:44:15 -0800 (PST)
X-Received: by 2002:a05:6e02:198b:: with SMTP id g11mr3333960ilf.27.1642801454526;
 Fri, 21 Jan 2022 13:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20220114004303.905808-1-dianders@chromium.org>
 <20220113164233.4.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid> <ab57f88c-8473-2499-afa6-86bcf639ca32@somainline.org>
In-Reply-To: <ab57f88c-8473-2499-afa6-86bcf639ca32@somainline.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Jan 2022 13:44:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WaSmUX41vGVy84BrtELParzAtMycecjScCBEp4KFBgMw@mail.gmail.com>
Message-ID: <CAD=FV=WaSmUX41vGVy84BrtELParzAtMycecjScCBEp4KFBgMw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc7280: Add herobrine-r1
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        quic_rjendra@quicinc.com, Sibi Sankar <sibis@codeaurora.org>,
        kgodara1@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 21, 2022 at 10:00 AM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
> Hi!
>
>
> Your DTs look good, but incorporate some weird style decisions..

Funny. I've been working on a DT style guidelines doc. I guess I need
to prioritize it...


> > --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
> > @@ -26,7 +26,7 @@
> >
> >  / {
> >       model = "Google Herobrine (rev0)";
> > -     compatible = "google,herobrine",
> > +     compatible = "google,herobrine-rev0",
> >                    "qcom,sc7280";
> Why break the line here?

True, this can go on one line. One argument about having the SoC on a
separate line is to make it consistent for boards that have more revs
listed. That's not new for this patch, though. I could go either way,
honestly.

I'll spin for this unless someone wants to defend it being on more
than one line.


> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > new file mode 100644
> > index 000000000000..c57bd689df23
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > @@ -0,0 +1,314 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Google Herobrine board device tree source
> > + *
> > + * Copyright 2022 Google LLC.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sc7280-herobrine.dtsi"
> > +
> > +/ {
> > +     model = "Google Herobrine (rev1+)";
> Are you sure there won't be any changes significant enough in the future
> that will make rev2 or rev7 or rev8192 incompatible with the rev1+ DT?

Definitely not. If there are significant changes, though, then we'll
need a new dts. ...but right now, as coded, this will _match_ against
anything rev1 or newer. This all has to do with now the bootloader
does matching and also about the standard practices we use. Let me try
to explain.

So you can see down below that we list the compatible as
"google,herobrine" and _not_ "google,herobrine-rev1"? This is on
purpose. The bootloader will read the board rev/sku strappings and
then will search for device trees with this priority order (for rev1,
sku0):

1. google,herobrine-rev1-sku0
2. google,herobrine-rev1
3. google,herobrine-sku0
4. google,herobrine

The general rule of thumb is that the newest board for any given
device should _not_ list a revision or a SKU in its compatible but
instead should just advertise itself as the default device tree for a
given board. Basically that means that the current device tree, as
coded, will match everything that's -rev1 or newer (because there is a
more specific dts for -rev0).

Why do we do this? If the board manufacturer makes a new spin of the
board and changes components around or changes routing or whatever, we
want them to populate a new board ID even if the differences are
_supposed_ to be invisible to software. This means that if the issues
turn out _not_ to be invisible to software that we can later work
around them. Usually when the board manufacturer spins the board like
this the want the old software to "just work", so we want the default
to automatically pick things up.

Even when changes _are_ visible to software, it's likely that a new
rev of a board will most closely match the previous version. Thus, if
we don't have a better board to match against, it's better to pick the
newest revision and have some chance to boot than to crash or pick
some other completely random dts file.


> > +     compatible = "google,herobrine",
> > +                  "qcom,sc7280";
> Why break the line here?

See above.


> > +};
> > +
> > +/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
> This is superfluous at best.

So in general I try to use titles like this to indicate a change in
the sort ordering. In different sections different sort ordering is
used.

I'll plan to keep these line headings as they are in my next spin
unless someone else wants to tie-break and tells me to get rid of
them.


> > +/*
> > + * The touchscreen connector might come off the Qcard, at least in the case of
> > + * eDP. Like the trackpad, we'll put it in the board device tree file since
> > + * different boards have different touchscreens.
> > + */
> > +ts_i2c: &i2c13 {
> Either sort these by their i2c aliases, or by their new ones.. currently it is
> not alphabetically sorted at all..

They are sorted by the name of what they are overriding. ...it can
certainly get a little awkward at times, but so can any rule. In this
case, the sort ordering is:

ap_spi_fp, i2c0, i2c13, pcie1, ...

I think the key here is that "ts_i2c" is a local label being added,
but the sort order is based on the node name being overridden
("i2c13"). The fact that extra local labels are being added can
confuse the issue for sure, but if you sort by local labels then that
can be confusing in different ways. Specifically the local labels are
optional, but if you later decide to add one you wouldn't want to
change the sort order.

I'll plan to keep my sort ordering for the next spin.


> Looks like some nodes below are just thrown at random places too..

I believe everything has a consistent ordering, you just need to know
what it is. At least I don't see anything mis-sorted.


> > +/* For nvme */
> > +&pcie1 {
> > +     status = "okay";
> > +};
> > +
> > +/* For nvme */
> I think this is kind of obvious and there is no need for this to be said twice
> within 10 lines..

I guess? It feels like this is about the scoping of the comment. I
feel like these are comments that apply only to the next block and are
not "section" comments that apply to anything below. Thus while it
might be obvious it's inconsistent to exclude this comment.

Not planning to change this.


> > +/* PINCTRL - BOARD-SPECIFIC */
> This is also kind of obvious, if it wasn't board-specific, it wouldn't be in the
> board DT..

Sure, but it gets into:

1. Section headers indicate a change in sort ordering and explain why
the stuff below isn't sorted inline with the stuff above.

2. In some files there are actually two separate pinctrl sections, one
where we override / fill in details for parent nodes and one where we
have pins that are totally board specific. You can see herobrine.dtsi
where both pinctrl sections are marked.


> > +                       /*
> > +                        * AP_FLASH_WP is crossystem ABI. Schematics
> > +                        * call it BIOS_FLASH_WP_OD.
> > +                        */
> Is there a need to put this comment on 4 lines instead of a single one?

Probably doesn't need 4 more than one line now that people are more OK
w/ longer lines. This makes it to exactly 100 characters wide if on
one line. I guess it's a matter of opinion, but it actually looks
quite a bit uglier to me on one line. All the other lines are short
and this one really long line sticks out like a sore thumb.

I'll also note that the goal isn't to set 100 characters as the magic
limit. As commit bdc48fa11e46 ("checkpatch/coding-style: deprecate
80-column warning") says, "80 columns is certainly still _preferred_"
but that we should allow longer lines if they make things more
readable / prettier. I disagree that it's prettier or more readable to
put this on one line in this case.


> > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > @@ -0,0 +1,781 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Google Herobrine baseboard device tree source
> > + *
> > + * The set of things in this file is a bit loosely defined. It's roughly
> > + * defined as the set of things that the child boards happen to have in
> > + * common. Since all of the child boards started from the same original
> > + * design this is hopefully a large set of things but as more derivatives
> > + * appear things may "bubble down" out of this file. For things that are
> > + * part of the reference design but might not exist on child nodes we will
> > + * follow the lead of the SoC dtsi files and leave their status as "disabled".
> > + *
> > + * Copyright 2022 Google LLC.
> > + */
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> Factoring gpio.h out into the SoC DT is a good idea.

I'm on the fence and I'd love a 2nd opinion. I don't see any usage of
the GPIO_ definitions there. However, I agree that pretty much all
boards should use them, so it probably makes sense...

Unless someone disagrees, I'll spin for this.


> > +     /*
> > +      * FIXED REGULATORS
> > +      *
> > +      * Sort order:
> > +      * 1. parents above children.
> > +      * 2. higher voltage above lower voltage.
> > +      * 3. alphabetically by node name.
> Why not just alphabetically? These regulator-fixed nodes shouldn't
> have issues with probe order and their parent-child relations are
> specified in their properties.

Back in the day this used to reduce the amount of -EPROBE_DEFER that
the system would suffer at bootup. ...but aside from that, I grew to
feel that it made sense. For regulators you're often thinking them as
a power tree. Things closer to "mains" or the battery are at the top
and they feed into things that bring the voltage lower (since dropping
a voltage is usually easier than raising it). Thus this ordering made
a reasonable amount of sense for someone trying to understand the
power tree for a board. Sorting things alphabetically, on the other
hand, doesn't add anything to understanding. ...so why not sort by the
order that helps people understand the board better?


> > +      */
> > +
> > +     /* This is the top level supply and variable voltage */
> Is there a way to read out the voltage somehow, perhaps as a TODO for the future
> if a driver is needed?

I don't believe so. IIRC this is a voltage that can either be provided
by the battery or by "mains". I believe it feeds a bunch of stuff that
can take whatever voltage is thrown at it and then regulate it down to
something sane.


> I think the regulator framework used not to be very happy
> about not specifying a (fixed) voltage range on a fixed regulator, but I may be
> wrong..

It's never been a problem.


> > +
> > +     pwmleds {
> > +             compatible = "pwm-leds";
> > +             status = "disabled";
> If it's disabled and it's not enabled anywhere else, why is it here?
> Is it going to have users in a very near future?

Right, that's the idea. It's actually on the schematics but just not
stuffed for -rev1 boards.


> > +ap_i2c_tpm: &i2c14 {
> > +     status = "okay";
> > +     clock-frequency = <400000>;
> > +
> > +     tpm@50 {
> > +             compatible = "google,cr50";
> > +             reg = <0x50>;
> > +
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&gsc_ap_int_odl>;
> > +
> > +             interrupt-parent = <&tlmm>;
> > +             interrupts = <104 IRQ_TYPE_EDGE_RISING>;
> > +     };
> > +};
> > +
> > +/* For nvme; not all herobrine boards have; boards set status = "okay" */
> "NVMe drive, enabled on a per-board basis"?

I guess. I'm not really convinced your wording is better but I'm fine
with it. I'll change to your wording.



> > +&tlmm {
> > +     /*
> > +      * pinctrl settings for pins that have no real owners.
> > +      */
> You can make it /* one line */

Sure, I can spin for this.


> Also, the following pins seem to be in random order, not sorted by either their
> name nor by their gpio number..

I think only "hub_en" is mis-sorted, right? Then they're sorted by
node name. I'll spin for that.


> > +
> > +&ipa {
> > +     status = "okay";
> > +     modem-init;
> > +};
> > +
> > +/* For nvme; boards set status = "okay" */
> This is kind of obvious, no?

Sure, I can remove this comment.


> > +/* For eMMC; not all Qcards have eMMC stuffed; boards set status = "okay" */
> Same here.

Actually, this provides some pretty useful info IMO. I don't think
it'd be terribly obvious that eMMC is on the Qcard PCB (if stuffed)
but not always stuffed.



> > +mos_bt_uart: &uart7 {
> > +     status = "okay";
> > +
> > +     /delete-property/interrupts;
> I think generally one should put a space after '/'.

OK, I'll spin with this.


> > +/* For mos_bt_uart */
> > +&qup_uart7_cts {
> > +     /*
> > +      * Configure a pull-down on CTS to match the pull of
> > +      * the Bluetooth module.
> My email client doesn't show me the column count, but I think this would
> fit in a single 100 char line..

IMO it doesn't exactly look ugly the way it is, but sure I can make it
one line. Seems to look fine that way too. I'll change it to one line.


> > +     ts_rst_conn: ts-rst-conn {
> > +             pins = "gpio54";
> > +             function = "gpio";
> > +             bias-pull-up;
> > +             drive-strength = <2>;
> Please be consistent in the order in which you add the same properties throughout
> GPIO nodes.

Sure, I'll spin for this.

-Doug
