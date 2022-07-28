Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B42584338
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiG1Pjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiG1Pjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:39:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7122662A63
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:39:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bn9so2674181wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBcPNZ2+mlbvsLKHm0Kf6uMfdcJuvK0J6XX3HZnb67s=;
        b=dEexRtKhhdGuFxLZw7wIFaLC/s9383EBETm32CK3PLqptTDuxb2jI8IknXdnu4Xbxm
         SzkngLxgNrKxZMR6bIbDH26Zh2qFV7xfC/C7MB54GNXy1EO4moaom+0FEf8jn4sdPtWJ
         5CPCzhn1hE5/SzqLyJk3w4AkftYF7FQBW9Xso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBcPNZ2+mlbvsLKHm0Kf6uMfdcJuvK0J6XX3HZnb67s=;
        b=C2gcF3N9zpQpTbV2XlOabgV9eRJY+tz29qSBuo2N6CsgXA4pDsX82FRh5B50Oq4On+
         Z5LJp+wgaG1az8tatJ7sqehtQdVm2xIQD1WBzVxjPpvyrp8G7BXe0khp1KVhl+bVM+YN
         oBOQ74sM+iQul2sGooLcY+r6z9oAOHiZI2bPL1ORSWS1ht9tCQEgZmv6T2x2hDnsY8W+
         QnEtWg+Vy3dhQz6/mlzz6U6XokHZK7To/MkiFnQVp+xpFMgX6ZnmV0ssZG3hethcc6Vw
         2bYJJ+G7bQpzzT4Hogq3fTJ+Bz5RbReTsi5Kg5Ux6E9jX9H0r+Rx3tPW4HvLB4JUAjbj
         rnbg==
X-Gm-Message-State: AJIora+B9bDTA5eNxZw7SBQkdUqApnQdKnMYjm1kyNxyAa+ieZVSwzZP
        +9Zrl9s42lo7Rqws/cY1E4ZlVrm5oyRHHb+8jLbLvQ==
X-Google-Smtp-Source: AGRyM1uiraKwPpPmXImHqcfLCLjkiLs0EXwTzj4fmDBqlN+to9NWPT1jvCn430UUiC9qi4cBKySudZzFurAn0nLp5Z0=
X-Received: by 2002:a5d:64a4:0:b0:21e:93c4:f8c6 with SMTP id
 m4-20020a5d64a4000000b0021e93c4f8c6mr11535361wrp.246.1659022777735; Thu, 28
 Jul 2022 08:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220727094034.1372745-1-treapking@chromium.org> <c455adea-2d18-60af-7175-a4e283e3dcb8@collabora.com>
In-Reply-To: <c455adea-2d18-60af-7175-a4e283e3dcb8@collabora.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 28 Jul 2022 23:39:26 +0800
Message-ID: <CAEXTbpc7W40-vYcTVTNo7ikQ-n0O246AsbPntNb4q2nBErYVQw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mt8173-oak: Switch to SMC watchdog
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eizan Miyamoto <eizan@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 7:21 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 27/07/22 11:40, Pin-yen Lin ha scritto:
> > Switch to SMC watchdog because we need direct control of HW watchdog
> > registers from kernel. The corresponding firmware was uploaded in
> > https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Move the modifications to mt8173-elm.dtsi and add some comments.
> >
> >   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > index e21feb85d822..b2269770abc3 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > @@ -161,6 +161,18 @@ hdmi_connector_in: endpoint {
> >                       };
> >               };
> >       };
> > +
> > +     soc {
> > +             /*
> > +              * Disable the original MMIO watch dog and switch to the SMC watchdog,
> > +              * which operates on the same MMIO.
> > +              */
> > +             /delete-node/ watchdog@10007000;
>
> Unfortunately, we're not quite there yet.
> The comment is fine, but...
>
> There's no need to /delete-node/: you can just do it like
>
> /*
>   * Disable the original MMIO watch dog and switch to the SMC watchdog,
>   * which operates on the same MMIO.
>   */
> &watchdog {
>         status = "disabled";
> };
>
> and...
>
> > +
> > +             watchdog {
>
> This isn't addressable, hence it belongs to the root node, not to soc.
> If you did that because of naming issues, I would propose to call it
> smc-watchdog instead of watchdog.
>
>
> > +                     compatible = "arm,smc-wdt";
>
Thanks for the suggestion. I'll modify it accordingly in v3.

> P.S.: No timeout-sec?

The example in the binding file has a timeout-sec property, but it is
not defined in the binding nor used in the driver...
The driver seems to talk with the firmware to get a timeout value[1]
instead of reading it from the devicetree.

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/arm_smc_wdt.c#L138
>
> Regards,
> Angelo
>
> > +             };
> > +     };
> >   };
> >
> >   &mfg_async {
> >
>
