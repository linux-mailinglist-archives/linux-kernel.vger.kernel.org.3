Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B254D53EC9E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbiFFPaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240527AbiFFPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:30:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D1436146
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:30:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q21so29703651ejm.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MEyaqWM6nauSyOE/o6cR6HwD4AGRKj1DKlampNeNe54=;
        b=ebBCl9ALvXs/hDq13HqiEeAtprViCGphd4r907eKS91OqO6wlFsCghYVoFTcBaiLxR
         +BraHJEoPdruKUUlpI1zrcpfQ+slS0OKAYhZShj4ETcGG/dGncD/kvQaDZcLqKtIRpT3
         tEro5Seb389aioq7xC4RNTHYmASlM/jXz40R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEyaqWM6nauSyOE/o6cR6HwD4AGRKj1DKlampNeNe54=;
        b=UnskGSk+65MSLUaH/R+7xwFM+rui3pKECRw2CjekfIGzMxWsXmT3VL6L9BSqdiEufi
         i41Kxs0ayH+nUVob7bWKFhJigP7dBvXMXfTnncL9WOD1pQU6DIrp1YPfyJRkx6cHU7WR
         8Ysu9qeyBZ6EtJAzLymTIA3L4styFex1hTNaKBdyEgpiihCd0AFdrIEpVE92QXCwUzGk
         qKxpAANNEDoD7pXerWiBpGnhr5lIgx4knuLEniYjsotoZe+9Wiv2BP1F6WigRensKGww
         ppi0GdAxIc38Uzr6HvEONiVsO4GCao8yJxzesz6Ce3+OFVePrPwqvGcBFLRbNOQSz23Q
         35fg==
X-Gm-Message-State: AOAM532AMfdxWwSOuAhasFA9yoh9baj9kw9mekH+4bzxHeqFxKuGiWhb
        zgP2SjWsUd1h82/MiASECf98AZkCKKswYQQx0LdhuQ==
X-Google-Smtp-Source: ABdhPJw3lFG2FHh8YBss/swu6q2uufYMGgGFis+oLM6PD4uIZua7oPEouaSwOJQ0zYOIYT0kfRfPo744IaHyEHggWNk=
X-Received: by 2002:a17:906:eb54:b0:708:99d6:83e with SMTP id
 mc20-20020a170906eb5400b0070899d6083emr21650908ejb.745.1654529425433; Mon, 06
 Jun 2022 08:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220530113033.124072-1-hsinyi@chromium.org> <20220530113033.124072-2-hsinyi@chromium.org>
In-Reply-To: <20220530113033.124072-2-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 6 Jun 2022 23:29:59 +0800
Message-ID: <CAJMQK-jw+sgunEwgEQAw-V8DAbybZ7WVnZJ6vwOdzQ+-SX_bQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mt8183: Add panel rotation
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
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
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 7:30 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> krane, kakadu, and kodama boards have a default panel rotation.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Hi Matthias,

The series ("Add a panel API to return panel orientation") might land
in drm-misc. With this series applied, we can add this patch to give
the correct default orientation for mt8183 kukui devices.
I didn't send this patch again with the series, since they might land
in different trees.

Thanks.

>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 8d5bf73a9099..f0dd5a06629d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -276,6 +276,7 @@ panel: panel@0 {
>                 avee-supply = <&ppvarp_lcd>;
>                 pp1800-supply = <&pp1800_lcd>;
>                 backlight = <&backlight_lcd0>;
> +               rotation = <270>;
>                 port {
>                         panel_in: endpoint {
>                                 remote-endpoint = <&dsi_out>;
> --
> 2.36.1.124.g0e6072fb45-goog
>
