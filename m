Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41852584A01
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiG2DAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiG2DAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:00:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA6178DE8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:59:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so4448292wrc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqOa2ydWKPCFCDt1F37LPTz5eL6WtbCSjhIkDCaOa5c=;
        b=ig1aLUwDBF5K8r2xiXUpGpnlzg85IiadmuaALx5IUb+9Q9EWw/YjeZJS94s5/tuspY
         LmJSFgP5e3p4SYbfBq4TBfoIxrTVAaurJdNnpp4SefZUZw/nM3QjI0k2LK33SJzFkUlD
         xUMLU0Cf0vePKX0nwkOS8+4bbspWWeALobH0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqOa2ydWKPCFCDt1F37LPTz5eL6WtbCSjhIkDCaOa5c=;
        b=0ul+D6YSMkAgGpSRAKyhkXzqzhty3p1eNPClCPVq9lMhQnhvXl50J1rDozEVLOyH6z
         GNOyVMRDr4pp8Z+zp5OEWPXsfMwPWl6+Vyp+CCwQgdxki91/GdJev6/MKoHWJe1sYjxa
         l55PHBFXuF2U9jeik1IHD36wLDi04HNK6k/ZqCQgI459H2wFA2HnhSg3fKmckXVQAR+s
         eX3sTbFrgoAxy00mpZjx+qU9eh9fxvAt/RiWXzTNnJrLQUuxlJK4adwcrBjUB29gYsEK
         BroMCP0eodNGaWQc6Q9WA7HDG7bhqEvv0PwChjrETtmg9hwk8VZKrDbBWW86sUCiCyxq
         RlzA==
X-Gm-Message-State: ACgBeo1qcsBS5cbKMVuTkeFoDC4L5HAg0JcNnQPuX2QPnqWIDZQydZoy
        bf30e8qjaHIUB++0etirT0BEedeSLwPLArG2msydJg==
X-Google-Smtp-Source: AA6agR4toWohZGJKI+9YbnPUu2yUsYg/YV9HP/3UFT4/MV/bpns3J4siYJlYs6COKIg0lrGKxz70EhFqqeOtGJX3zu8=
X-Received: by 2002:a5d:64cc:0:b0:21d:a4bd:fdbe with SMTP id
 f12-20020a5d64cc000000b0021da4bdfdbemr932345wri.580.1659063598082; Thu, 28
 Jul 2022 19:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220727094034.1372745-1-treapking@chromium.org>
 <c455adea-2d18-60af-7175-a4e283e3dcb8@collabora.com> <CAEXTbpc7W40-vYcTVTNo7ikQ-n0O246AsbPntNb4q2nBErYVQw@mail.gmail.com>
 <689b439f-531b-9b3d-2e48-b7b83c50b3dd@collabora.com>
In-Reply-To: <689b439f-531b-9b3d-2e48-b7b83c50b3dd@collabora.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 29 Jul 2022 10:59:47 +0800
Message-ID: <CAEXTbperyGnKZw9y_55yE-T5gzuR8yzpTwfg7dy_bvTUhmrOag@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:51 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 28/07/22 17:39, Pin-yen Lin ha scritto:
> > On Thu, Jul 28, 2022 at 7:21 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 27/07/22 11:40, Pin-yen Lin ha scritto:
> >>> Switch to SMC watchdog because we need direct control of HW watchdog
> >>> registers from kernel. The corresponding firmware was uploaded in
> >>> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.
> >>>
> >>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - Move the modifications to mt8173-elm.dtsi and add some comments.
> >>>
> >>>    arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 12 ++++++++++++
> >>>    1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> >>> index e21feb85d822..b2269770abc3 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> >>> @@ -161,6 +161,18 @@ hdmi_connector_in: endpoint {
> >>>                        };
> >>>                };
> >>>        };
> >>> +
> >>> +     soc {
> >>> +             /*
> >>> +              * Disable the original MMIO watch dog and switch to the SMC watchdog,
> >>> +              * which operates on the same MMIO.
> >>> +              */
> >>> +             /delete-node/ watchdog@10007000;
> >>
> >> Unfortunately, we're not quite there yet.
> >> The comment is fine, but...
> >>
> >> There's no need to /delete-node/: you can just do it like
> >>
> >> /*
> >>    * Disable the original MMIO watch dog and switch to the SMC watchdog,
> >>    * which operates on the same MMIO.
> >>    */
> >> &watchdog {
> >>          status = "disabled";
> >> };
> >>
> >> and...
> >>
> >>> +
> >>> +             watchdog {
> >>
> >> This isn't addressable, hence it belongs to the root node, not to soc.
> >> If you did that because of naming issues, I would propose to call it
> >> smc-watchdog instead of watchdog.
> >>
> >>
> >>> +                     compatible = "arm,smc-wdt";
> >>
> > Thanks for the suggestion. I'll modify it accordingly in v3.
> >
> >> P.S.: No timeout-sec?
> >
> > The example in the binding file has a timeout-sec property, but it is
> > not defined in the binding nor used in the driver...
> > The driver seems to talk with the firmware to get a timeout value[1]
> > instead of reading it from the devicetree.
> >
>
> Oh. I admit I trusted the binding blindly, didn't check the actual driver code.
>
> On a note, we should check why is that binding partially wrong and eventually
> fix it (remove the property), or add the capability to the driver, but feel free
> to ignore that for now, as this is not relevant for the context of this specific
> change that you're trying to do here.

It looks like the timeout-sec property was not defined nor referenced
from the very first commit [2][3]. I'll send out another patch to
remove it.

[2]: dt-bindings:
https://lore.kernel.org/all/20200505131242.v6.1.Id96574f1f52479d7a2f3b866b8a0552ab8c03d7f@changeid/
[3]: watchdog driver:
https://lore.kernel.org/all/20200505131242.v6.2.Ia92bb4d4ce84bcefeba1d00aaa1c1e919b6164ef@changeid/
>
> P.S.: I just noticed that the commit title is also wrong. s/mt8173-oak/mt8173-elm/g

I sent out the v3 before I saw this reply.  I'll send out a v4 for
this and address Krzysztof's comment as well.

>
> Waiting for a v3!
>
>
> > [1]: https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/arm_smc_wdt.c#L138
> >>
> >> Regards,
> >> Angelo
> >>
> >>> +             };
> >>> +     };
> >>>    };
> >>>
> >>>    &mfg_async {
> >>>
> >>
>
