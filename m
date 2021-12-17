Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78AD4787FC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhLQJn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhLQJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:43:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:43:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e5so2915925wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=1qtPajobApofFVdZSOx4QP5IGtLhy9B9FZ44qXwQbeQ=;
        b=QbkwbMWST2Tc4n5emVo9rjXDx7r71Zk7kyElNDeyD7XIHF/vvZmJR0nn4sAlOOpbPG
         vNuxL50TwamelNtotgVwCvL48xBepWVuIcrguiOdIia1A3MUYzIT4/41BWgxuh9JdnWi
         /z1hJv/6i9lHZDizmoSxfNPAch2Oh72oacnKhhVpB0tYE//3bMWyrqpDDPMbpTUB3ypT
         Wo0Qzx8ZblFyRUGzg6YaBJdqHDCnyukLqfrT/KJTM3R0/JBFSR0Y7rm1njH84Bo2qFEa
         OdAPPUDI2s4b+thktJ+AsZMTYl1Q1wCHijPX61PGNaIsVVh8VulrIfkKYEkyu6e43IFf
         DYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=1qtPajobApofFVdZSOx4QP5IGtLhy9B9FZ44qXwQbeQ=;
        b=E5hE+DLLVfLpn2k7d12UXqTs2OFORUFBEOqXrNosr9/hnnDA/+ZwTKUIHsMK7FaThp
         CI19njZxZG9hDlWxojB8HWHo40r+FtRlUROyPvSuwoYahuXXRYcPSo09DRKEx04eAPTZ
         QJn62nZO6boTxnGIisIll11Jb/MwcNcegzcWW1t5qjs2NWHIW25Ga6NrUh03AGcZ604F
         u3BWRLJQC8N0I5IzFBpuOOUWq+Q5fo+8Qb5JZlChe/V9ririOlHpuRMMNumGhJ7tXJ2A
         h+iN0t8stoyAw4MMi27kz/nSm3F+mljYl3ijq5I9sFCqYvpcNdObK6zrOlockXDXRtp/
         r4Wg==
X-Gm-Message-State: AOAM532YYlbmGIx637h3IbuaQIHBaezLG9moXeCMuv2CaM+DmKevOcgq
        GrR2Ktuq4RQLzE1jv6OTSwH3kQ==
X-Google-Smtp-Source: ABdhPJzBP7nsIuuUpr79idFo7tm7YmFNgyv2VOyh0hqoJVzqy1V4gKGIzQaGfi/DjJavTY31bnOSjg==
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr991199wrx.193.1639734204422;
        Fri, 17 Dec 2021 01:43:24 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e11sm8536601wrq.28.2021.12.17.01.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 01:43:24 -0800 (PST)
References: <20210811050941.398360-1-art@khadas.com>
 <64a6a9e1-64de-4b31-9413-cdfd981862de@baylibre.com>
 <1jlf4ayrv1.fsf@starbuckisacylon.baylibre.com>
 <CAKaHn9JOtmYoJsmZed4hLYAbtdyyMkhaM1iVThs0=2SV6y5ojQ@mail.gmail.com>
 <1jtuhwvqxa.fsf@starbuckisacylon.baylibre.com>
 <CAKaHn9LPYVZkXsDb-aAcHfDc1dX6tMd2cYpjrqysL62JCu3EYg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Art Nikpal <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
Subject: Re: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
Date:   Fri, 17 Dec 2021 10:30:30 +0100
In-reply-to: <CAKaHn9LPYVZkXsDb-aAcHfDc1dX6tMd2cYpjrqysL62JCu3EYg@mail.gmail.com>
Message-ID: <1j8rwja7nr.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 15 Dec 2021 at 10:32, Art Nikpal <email2tema@gmail.com> wrote:

> On Mon, Oct 4, 2021 at 9:51 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>>
>> On Mon 06 Sep 2021 at 19:56, Art Nikpal <email2tema@gmail.com> wrote:
>>
>> >> It would be nice to indicate how it was tested ?
>> >
>> > https://github.com/khadas/khadas-linux-kernel/blob/master/patches/linux-5.14-rc5.sound/0001-arm64-dts-meson-khadas-vim3-remake-simple-sound-for-.patch
>> >
>> > i have test it
>> >
>> > i2s  and spdif output from gpio headers - works well
>>
>> You have tested spdifout_a then.
>>
>> Nothing says spdifin (which was only tested on the axg series so far) or
>> spdifout_b would actually work if enabled at a later point.
>>
>> I would prefer if things could at least be tested once before being
>> added DT.
>>
>> >
>> > On Mon, Sep 6, 2021 at 5:29 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>> >>
>> >>
>> >> On Thu 02 Sep 2021 at 15:31, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> >>
>> >> > Hi,
>> >> >
>> >> > On 11/08/2021 07:09, Artem Lapkin wrote:
>> >> >> Add spdifin spdifout spdifout_b nodes for Amlogic SM1 SoCs.
>> >> >>
>> >> >> Signed-off-by: Artem Lapkin <art@khadas.com>
>> >> >> ---
>> >> >>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 40 ++++++++++++++++++++++
>> >> >>  1 file changed, 40 insertions(+)
>> >> >>
>> >> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> >> >> index 3d8b1f4f2..1efdbb61e 100644
>> >> >> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> >> >> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> >> >> @@ -356,6 +356,33 @@ tdmin_lb: audio-controller@3c0 {
>> >> >>                      status = "disabled";
>> >> >>              };
>> >> >>
>> >> >> +            spdifin: audio-controller@400 {
>> >> >> +                    compatible = "amlogic,g12a-spdifin",
>> >> >> +                    "amlogic,axg-spdifin";
>> >> >> +                    reg = <0x0 0x400 0x0 0x30>;
>> >> >> +                    #sound-dai-cells = <0>;
>> >> >> +                    sound-name-prefix = "SPDIFIN";
>> >> >> +                    interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
>> >> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
>> >> >> +                    <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
>> >> >> +                    clock-names = "pclk", "refclk";
>> >> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFIN>;
>> >> >> +                    status = "disabled";
>> >> >> +            };
>> >> >> +
>> >> >> +            spdifout: audio-controller@480 {
>> >> >> +                    compatible = "amlogic,g12a-spdifout",
>> >> >> +                    "amlogic,axg-spdifout";
>> >> >> +                    reg = <0x0 0x480 0x0 0x50>;
>> >> >> +                    #sound-dai-cells = <0>;
>> >> >> +                    sound-name-prefix = "SPDIFOUT";
>> >> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
>> >> >> +                    <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
>> >> >> +                    clock-names = "pclk", "mclk";
>> >> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
>> >> >> +                    status = "disabled";
>> >> >> +            };
>> >> >> +
>> >> >>              tdmout_a: audio-controller@500 {
>> >> >>                      compatible = "amlogic,sm1-tdmout";
>> >> >>                      reg = <0x0 0x500 0x0 0x40>;
>> >> >> @@ -401,6 +428,19 @@ tdmout_c: audio-controller@580 {
>> >> >>                      status = "disabled";
>> >> >>              };
>> >> >>
>> >> >> +            spdifout_b: audio-controller@680 {
>> >> >> +                    compatible = "amlogic,g12a-spdifout",
>> >> >> +                    "amlogic,axg-spdifout";
>> >> >> +                    reg = <0x0 0x680 0x0 0x50>;
>> >> >> +                    #sound-dai-cells = <0>;
>> >> >> +                    sound-name-prefix = "SPDIFOUT_B";
>> >> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
>> >> >> +                    <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
>> >> >> +                    clock-names = "pclk", "mclk";
>> >> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
>> >> >> +                    status = "disabled";
>> >> >> +            };
>> >> >> +
>> >> >>              toacodec: audio-controller@740 {
>> >> >>                      compatible = "amlogic,sm1-toacodec",
>> >> >>                                   "amlogic,g12a-toacodec";
>> >> >>
>> >> >
>> >> > Jerome could you quickly review this ?
>> >> >
>> >>
>> >> Just this, without the related card change is not usefull as it won't be
>> >> part of the card.
>
> Current sound card dt configuration not configured for it, but we can
> apply dt overlays anytime.

Maybe you should do so

>
> IMHO: current sound configuration is not ideal and for some tasks
> better to use custom configuration.
> but anyway i think meson-sm1.dtsi must be completed by missed spdif in/out nodes
>

Tested ones, sure

>> >>
>> >> It would be nice to indicate how it was tested ?
>
>> >>
>> >> AFAIK:
>> >> - spdifout b can only be routed to hdmi and dw-hdmi driver does not
>> >>   support that yet
>
> Ok! But why not accept it at this moment - next time will be easy to
> improve dw-hdmi driver
> +like options i can submit new patch without spdifout_b node

Because as it stands, it is useless. No one tried it. What lands in the
kernel should work, or at least we should do our best to confirm it does.

We should not place code here hoping everything will be fine when someone
finally turns it on.

When dw-hdmi driver support spdif input and you can confirm it works with
your change, you are welcome to submit it again.

>
>> >> - the VIM3 does not have connectors for the spdif (in or out). If it
>
> we have test SPDIF in and SPDIF OUT both works fine on VIM3L meson-sm1

Then adding to spdifin and spdifout_a nodes is fine by me

>
>> >>   requires some extension card, it should be noted somewhere, at least
>
> SPDIF in and SPDIF OUT both pins available via GPIO header ( SPDIF_OUT
> PIN 13 and SPDIF_IN PIN 35 - same PWM_F )
>

Like other thing on those GPIO connectors, we don't enable them by
default.

Now that the kernel accepts overlays, it would be nice to submit one so
other can replicate your test setup, if you wish to.

>> >>
>> >>
>> >> > Thanks,
>> >> > Neil
>> >>
>>

