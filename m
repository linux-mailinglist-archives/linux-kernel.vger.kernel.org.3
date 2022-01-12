Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B383A48BEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351079AbiALHC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiALHCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:02:24 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF532C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 23:02:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id e3so2012572lfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 23:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPlvZ7SgaEi0S0R2Ekpno8fmedH18d4jSr4icAzwWOE=;
        b=TdR+xGF+2F0wNO02bRUsRfwz/8CbD6jzJ4E9pT7NuZrDanOybqP6w47UXHAfz0mldv
         DJdsVkYfNjB+vP+swMqx0mViYs76MGXFC9VbWbnzG6BpTXEftkZp1rIhnSsw7LTMM85V
         YXOnBqnIVvIKLjqrJ7vMq6UiXZxw9GaIwvo7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPlvZ7SgaEi0S0R2Ekpno8fmedH18d4jSr4icAzwWOE=;
        b=cV1Bn0nVdjEa/3f+1qNX6EHkm9qTGRsHaRq1/kL8Q0Gbs8pjHNOk4XTbyhjVZWWbyN
         zfkF4HhUc4dg7oa6rK+PbLS65i87gd5A0E88W7R6aEDKofqA17qHGM6tNIbGYcO0M3h/
         AJMzR06VtKYu5m218g3rUre6Fk9izUCFzOpko9pYHpTMKb+Bou2cQGqHbmY4gIuEyd5s
         s/DW1yCPaDoCg6FMdTfrE8wEnT8Ph3OSiz9MyyD5NOQJny9dxJa0wIiLdKM/GKbGMCF1
         AIi1RoRIJ+PuZ7aDwVBo+6/bvbuVWS2oEjnGgxj6VaBEIvdcr/zdAjCz36V/QgCAHVOa
         JsMg==
X-Gm-Message-State: AOAM533OoFAIr8P7IbVnfn/z2qTxBYTHqOYP8LY/nqDcdBcbWlder17F
        Ym83LRrv6cCst1MPP04xu3L2VXylSx9LJQs+9MFbig==
X-Google-Smtp-Source: ABdhPJxXvYqx3G6aIa/2DKUhp3bz33YZPpV3/zrmpMFnHua1Juqcg44GELc9DoNFmlb2euiiasfXIykUXtIFH0KZolk=
X-Received: by 2002:a05:6512:3093:: with SMTP id z19mr5945256lfd.670.1641970941956;
 Tue, 11 Jan 2022 23:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20220111112244.1483783-1-wenst@chromium.org> <20220111112244.1483783-2-wenst@chromium.org>
 <2dc957b1-300f-161c-edb6-efacf11942e0@collabora.com>
In-Reply-To: <2dc957b1-300f-161c-edb6-efacf11942e0@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 12 Jan 2022 15:02:10 +0800
Message-ID: <CAGXv+5HV+Ca74paF-L54owyCBtBwTNU0r2aT7drjmBxo2dV=uA@mail.gmail.com>
Subject: Re: [PATCH 1/7] pinctrl: pinconf-generic: Print arguments for bias-pull-*
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 11/01/22 12:22, Chen-Yu Tsai ha scritto:
> > The bias-pull-* properties, or PIN_CONFIG_BIAS_PULL_* pin config
> > parameters, accept optional arguments in ohms denoting the strength of
> > the pin bias.
> >
> > Print these values out in debugfs as well.
> >
> > Fixes: eec450713e5c ("pinctrl: pinconf-generic: Add flag to print arguments")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Tested on qcom-SC7180 Trogdor, mtk-MT8173 Elm, and others;

Cool! I'll take that as a Tested-by tag.

> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
