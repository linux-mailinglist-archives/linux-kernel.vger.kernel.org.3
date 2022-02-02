Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EDA4A74ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbiBBPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiBBPtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:49:33 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D12BC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:49:33 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id c19so33574100ybf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 07:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/siAlN12aLkICP6/rrLm39IlMfBgQE7j1j4GTBXCe9o=;
        b=gWjNQ8FVYVcHiCwRtEAS7NrkTAvIjJU/VrqAnes2yv01NsrE4rU3dpRu7fG4gVfjgU
         /ldWfg/vwbb75BTcEVAcLJVjaZfofykrHQyaul9ew9uYl1kou+/3sWInfm6OO633wvB3
         FeIGnPC/6msmeS/tBY0ftUubEMYtZfRzK1E1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/siAlN12aLkICP6/rrLm39IlMfBgQE7j1j4GTBXCe9o=;
        b=mLNotkVthAXO9LPDr87bNVxbaKhZODjsNTJshWieRpnVXAOej1g4GP5JCFqByozSN1
         YjGGWoQzvG6b3oRsF1EYe21lUaUnrg4xxwk24nK9320pJPK+CWH+hrdSLtxKjFMcRqhj
         bD6FyinD3uhRRz/y2dAl8iHWIctVqpbXU/6leRALJcy3DAJC0IrAnoqPnsx1crkW31HN
         4skStLavKi/6aUEkbNwQm6rzJYB/vb+WtIll2uqRFV7+11X0IbpD/y/oViqUYm7FkTGU
         9t+hGBk8QZLm69pBIsiFbhG5W5z2a/OFcu6aC3dnqXP6R0hvDe3pjeKsOhy5ItvG6OhL
         y8fg==
X-Gm-Message-State: AOAM531XZ0ViL2JfZIOBwXIMAkKWnclY5jf/39u6RGb+5IQ59TkjKrwp
        hYy1Qd48L9v71uu2OjNZOWxvLePg877gA++412GV0w==
X-Google-Smtp-Source: ABdhPJzOI+CAspMP7aHP0upHc/wxFpkGCHDf+XfXkFWd8wWK8Qi+Y/Kt+hJfo9SkDJmj5/uVRZvSOUFn0/NVB3IqdOw=
X-Received: by 2002:a25:c709:: with SMTP id w9mr42995658ybe.296.1643816972414;
 Wed, 02 Feb 2022 07:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20220121060120.10683-1-guodong.liu@mediatek.com> <CACRpkdaL_cUj2rbQUSzVj+ViEuNWiQbsakChNkaj6FK+fE76FA@mail.gmail.com>
In-Reply-To: <CACRpkdaL_cUj2rbQUSzVj+ViEuNWiQbsakChNkaj6FK+fE76FA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 2 Feb 2022 23:49:21 +0800
Message-ID: <CAGXv+5E6bq-veUQ6bEPgKwUULpWvZPu9GZ9cGkDS3OKD5Z8KFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: mediatek: Support pinctrl driver on mt8186
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Guodong Liu <guodong.liu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 30, 2022 at 9:43 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Jan 21, 2022 at 7:01 AM Guodong Liu <guodong.liu@mediatek.com> wrote:
>
> > changes since v1:
> > - add default pinctrl config to consistent with other MTK pinctrl drivers
> >
> > Patch 1 add pinctrl file and binding document.
> >
> > Patch 2 add pinctrl chip driver on mt8186.
> >
> > Guodong Liu (2):
> >   dt-bindings: pinctrl: mt8186: add pinctrl file and binding document
> >   pinctrl: add pinctrl driver on mt8186
>
> Looks good to me, just wanna loop this by Chen-Yu Tsai for a check that
> it looks good to him too.

I'm still on vacation, and even after that, I might not have the cycles to
do an in depth review of the hardware bits this month.

Since Angelo already gave an ack (which somehow was not added in v2), and
AFAIK the driver does work downstream in ChromeOS, I wouldn't block it.

However, there's an error in the DT binding that should be fixed sooner
than later.


Thanks
ChenYu
