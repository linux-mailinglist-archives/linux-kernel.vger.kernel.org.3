Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB354F925
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382730AbiFQOZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381599AbiFQOZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:25:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F607517F4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:25:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gl15so9114058ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83FZWiL0crF525APjinz8Kw//Gs5G6caFf4d0M9B9Ak=;
        b=GHJIHuMigTU+g9hI8iabwpQIuDSL7XyuMpSYvmlYhgfC1CIFWEIm1BQ+hSd4bjDOG5
         Rskzt+EOb8aIo94mQFzPQAjullV8lRQ1JR2nEa9GsHHd/BrpeGa8jCWJ9d2l0VXwLBgm
         ZSXjCJoEKsrynHrhheJbBED0jjesuT6+bcpTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83FZWiL0crF525APjinz8Kw//Gs5G6caFf4d0M9B9Ak=;
        b=4PwX547r2wT/Xp7zm1DkhigNwJn9VerTxS3/QcIZxWUr/c9Bxtpl+rihIT4EFXJQZ/
         C8eJoMCH02qGxFXtvtmxeDyX0ayTUM6GiO14dvZJU8RL4N3Y6Rql0CkRKtgkADYs92Sm
         bYKiqiuUHPbE3diJknBvDqoaoERBs165Oq4B3Ca23Id6t8hdr6X9gE0dxDJ2YltqjREB
         lzOt2bNf4FC2ydcESeVvE6F5G1ESAlHNi+7u41WDH9+jTxCkpI3NOZ292f6pOpgP83xs
         8LKpg49aYPIn30NYCox47LpFoxGbQ/ZJ+apiXF6BMj9RNiIgSBJx/DY0nU9wFN9jsP9K
         1cGw==
X-Gm-Message-State: AJIora8qb6j6uzIjVdtkbuwCfRBXDXPaLgH13vgDDPD9rtUT4NSyR5O6
        o5HbkOyNGdTqmlqR9GUkz5F1f1k/7lj4EUCM8PFE/g==
X-Google-Smtp-Source: AGRyM1sHQWP15zLPj2yCwvO447y117lYiVJu4mAWBp6EFASZb6mVwG/jc+KGYlyL13Wi6k2yq/6HTYn7xjYL2VjVjco=
X-Received: by 2002:a17:906:ced1:b0:710:f654:87ef with SMTP id
 si17-20020a170906ced100b00710f65487efmr9824783ejb.194.1655475937079; Fri, 17
 Jun 2022 07:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220530113033.124072-1-hsinyi@chromium.org> <20220530113033.124072-2-hsinyi@chromium.org>
 <CAJMQK-jw+sgunEwgEQAw-V8DAbybZ7WVnZJ6vwOdzQ+-SX_bQg@mail.gmail.com> <c3286fc9-06ed-d1e1-a731-94cdefdf7fab@gmail.com>
In-Reply-To: <c3286fc9-06ed-d1e1-a731-94cdefdf7fab@gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 17 Jun 2022 22:25:11 +0800
Message-ID: <CAJMQK-gJ4AoNQtLeKoOO=GLLtjDRhCdVnYuPJSBD4ZnFWJ5qrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mt8183: Add panel rotation
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 10:10 PM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
> Hi Hsin-Yi Wang,
>
> On 06/06/2022 17:29, Hsin-Yi Wang wrote:
> > On Mon, May 30, 2022 at 7:30 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >>
> >> krane, kakadu, and kodama boards have a default panel rotation.
> >>
> >> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >
> > Hi Matthias,
> >
> > The series ("Add a panel API to return panel orientation") might land
> > in drm-misc. With this series applied, we can add this patch to give
> > the correct default orientation for mt8183 kukui devices.
> > I didn't send this patch again with the series, since they might land
> > in different trees.
> >
>
> I had a look on Linux next (next-20220617) and wasn't able to find the mtk_dsi.c
> changes. What is the status of this?
>
The mtk_dsi change got dropped. The latest is this series:
https://lore.kernel.org/lkml/20220609072722.3488207-1-hsinyi@chromium.org/,
still waiting to be picked or others' comments.

If the dts patch is picked without the drm series, there will be a
WARN, but won't affect boot or display up.


> Regards,
> Matthias
>
> > Thanks.
> >
> >>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> >> index 8d5bf73a9099..f0dd5a06629d 100644
> >> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> >> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> >> @@ -276,6 +276,7 @@ panel: panel@0 {
> >>                  avee-supply = <&ppvarp_lcd>;
> >>                  pp1800-supply = <&pp1800_lcd>;
> >>                  backlight = <&backlight_lcd0>;
> >> +               rotation = <270>;
> >>                  port {
> >>                          panel_in: endpoint {
> >>                                  remote-endpoint = <&dsi_out>;
> >> --
> >> 2.36.1.124.g0e6072fb45-goog
> >>
