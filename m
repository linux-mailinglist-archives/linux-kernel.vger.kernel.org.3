Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367A14750FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbhLOCcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbhLOCcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:32:19 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5FDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 18:32:19 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p65so27735154iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 18:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jpvnm8xrS7mJi4uohYfZ6gGBOMTRK7pEN/RZMd2r9BA=;
        b=nYLVk80zmuDjBLea1wTs7WDWZplmleOmVzVVJSXUM2ketavDF8bariAJfY76AqwiMZ
         UcUPw+rj59vKv1BTlf1BQ5YwlStebaztWOMwFmA/Lsw2cxkridHz/PRfxPPaVfYb9Flh
         UTC4JGEteCHa0tkr2dnacaSRITJOiGbGRs8VQyYDoJ6uLJMsSDaaC20YHl6EtCi3YTTo
         uXvdfveGpYkg2vGgjKhvjidjJjSHGy+F4kyFDDrpCm0lnw5jfnk2s1digA/cC3pWL9RC
         F5FB6DN95sCevFr1OEsd86+ilso0T+7YFgXJCJzXPWOJBvobpsuCNWdzjoNl27npSQ67
         g4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jpvnm8xrS7mJi4uohYfZ6gGBOMTRK7pEN/RZMd2r9BA=;
        b=vv3IhN0jWxjOIsYtYQlmsMbdTiiOzSCeaBwM7bNp9uSYyFW11C1XllffDmw5jAZzJg
         GLrSDSOjdeOTqZcdlexqU+zIKD6xYmg8iLhoEKKqwN31w+N03/WzlDqVJed8UEo6/s20
         L4avp9TwZyJxZcWbiPfKaV6QfHM7M9DV9IAwpF+yIn59W/30jX0cdHTxOtlpbu4SVzt8
         PkhZFPPS5TmheSBWR36xeznn4NDqU71WcDZk0aEl/YYVx5EBqlSDsaRgFBPery6dUmep
         2M6cDXHiLeKbs1YaDFBTakJlDzLrY7tWp+5TMXlsKLRhD9CzXtPnjYTtg277+rUApRSm
         evCg==
X-Gm-Message-State: AOAM53243QPoZ0qa7wi3tj+EghWylnXpystD8Njuwkmot55YctoamQOh
        Lf6ZEtCG9RaK5xjZxS36Y8AuYOTyA63Mi+eqbFk=
X-Google-Smtp-Source: ABdhPJxcTwr1jahw3/8a2lwQZ6PkEiDsiXBRxFiGjlJHZALLMtviR6hcQ5nUPnxvW2eZDGCa360+AtEqGXkRZtcwIeg=
X-Received: by 2002:a05:6638:258a:: with SMTP id s10mr4655531jat.381.1639535538588;
 Tue, 14 Dec 2021 18:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20210811050941.398360-1-art@khadas.com> <64a6a9e1-64de-4b31-9413-cdfd981862de@baylibre.com>
 <1jlf4ayrv1.fsf@starbuckisacylon.baylibre.com> <CAKaHn9JOtmYoJsmZed4hLYAbtdyyMkhaM1iVThs0=2SV6y5ojQ@mail.gmail.com>
 <1jtuhwvqxa.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jtuhwvqxa.fsf@starbuckisacylon.baylibre.com>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Wed, 15 Dec 2021 10:32:07 +0800
Message-ID: <CAKaHn9LPYVZkXsDb-aAcHfDc1dX6tMd2cYpjrqysL62JCu3EYg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 9:51 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 06 Sep 2021 at 19:56, Art Nikpal <email2tema@gmail.com> wrote:
>
> >> It would be nice to indicate how it was tested ?
> >
> > https://github.com/khadas/khadas-linux-kernel/blob/master/patches/linux-5.14-rc5.sound/0001-arm64-dts-meson-khadas-vim3-remake-simple-sound-for-.patch
> >
> > i have test it
> >
> > i2s  and spdif output from gpio headers - works well
>
> You have tested spdifout_a then.
>
> Nothing says spdifin (which was only tested on the axg series so far) or
> spdifout_b would actually work if enabled at a later point.
>
> I would prefer if things could at least be tested once before being
> added DT.
>
> >
> > On Mon, Sep 6, 2021 at 5:29 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> >>
> >>
> >> On Thu 02 Sep 2021 at 15:31, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> > Hi,
> >> >
> >> > On 11/08/2021 07:09, Artem Lapkin wrote:
> >> >> Add spdifin spdifout spdifout_b nodes for Amlogic SM1 SoCs.
> >> >>
> >> >> Signed-off-by: Artem Lapkin <art@khadas.com>
> >> >> ---
> >> >>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 40 ++++++++++++++++++++++
> >> >>  1 file changed, 40 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> >> >> index 3d8b1f4f2..1efdbb61e 100644
> >> >> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> >> >> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> >> >> @@ -356,6 +356,33 @@ tdmin_lb: audio-controller@3c0 {
> >> >>                      status = "disabled";
> >> >>              };
> >> >>
> >> >> +            spdifin: audio-controller@400 {
> >> >> +                    compatible = "amlogic,g12a-spdifin",
> >> >> +                    "amlogic,axg-spdifin";
> >> >> +                    reg = <0x0 0x400 0x0 0x30>;
> >> >> +                    #sound-dai-cells = <0>;
> >> >> +                    sound-name-prefix = "SPDIFIN";
> >> >> +                    interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
> >> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
> >> >> +                    <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
> >> >> +                    clock-names = "pclk", "refclk";
> >> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFIN>;
> >> >> +                    status = "disabled";
> >> >> +            };
> >> >> +
> >> >> +            spdifout: audio-controller@480 {
> >> >> +                    compatible = "amlogic,g12a-spdifout",
> >> >> +                    "amlogic,axg-spdifout";
> >> >> +                    reg = <0x0 0x480 0x0 0x50>;
> >> >> +                    #sound-dai-cells = <0>;
> >> >> +                    sound-name-prefix = "SPDIFOUT";
> >> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
> >> >> +                    <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
> >> >> +                    clock-names = "pclk", "mclk";
> >> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
> >> >> +                    status = "disabled";
> >> >> +            };
> >> >> +
> >> >>              tdmout_a: audio-controller@500 {
> >> >>                      compatible = "amlogic,sm1-tdmout";
> >> >>                      reg = <0x0 0x500 0x0 0x40>;
> >> >> @@ -401,6 +428,19 @@ tdmout_c: audio-controller@580 {
> >> >>                      status = "disabled";
> >> >>              };
> >> >>
> >> >> +            spdifout_b: audio-controller@680 {
> >> >> +                    compatible = "amlogic,g12a-spdifout",
> >> >> +                    "amlogic,axg-spdifout";
> >> >> +                    reg = <0x0 0x680 0x0 0x50>;
> >> >> +                    #sound-dai-cells = <0>;
> >> >> +                    sound-name-prefix = "SPDIFOUT_B";
> >> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
> >> >> +                    <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
> >> >> +                    clock-names = "pclk", "mclk";
> >> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
> >> >> +                    status = "disabled";
> >> >> +            };
> >> >> +
> >> >>              toacodec: audio-controller@740 {
> >> >>                      compatible = "amlogic,sm1-toacodec",
> >> >>                                   "amlogic,g12a-toacodec";
> >> >>
> >> >
> >> > Jerome could you quickly review this ?
> >> >
> >>
> >> Just this, without the related card change is not usefull as it won't be
> >> part of the card.

Current sound card dt configuration not configured for it, but we can
apply dt overlays anytime.

IMHO: current sound configuration is not ideal and for some tasks
better to use custom configuration.
but anyway i think meson-sm1.dtsi must be completed by missed spdif in/out nodes

> >>
> >> It would be nice to indicate how it was tested ?

> >>
> >> AFAIK:
> >> - spdifout b can only be routed to hdmi and dw-hdmi driver does not
> >>   support that yet

Ok! But why not accept it at this moment - next time will be easy to
improve dw-hdmi driver
+like options i can submit new patch without spdifout_b node

> >> - the VIM3 does not have connectors for the spdif (in or out). If it

we have test SPDIF in and SPDIF OUT both works fine on VIM3L meson-sm1

> >>   requires some extension card, it should be noted somewhere, at least

SPDIF in and SPDIF OUT both pins available via GPIO header ( SPDIF_OUT
PIN 13 and SPDIF_IN PIN 35 - same PWM_F )

> >>
> >>
> >> > Thanks,
> >> > Neil
> >>
>
