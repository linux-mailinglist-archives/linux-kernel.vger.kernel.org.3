Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FD84A2B20
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 02:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352125AbiA2Bxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 20:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344894AbiA2Bxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 20:53:42 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898EAC061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:53:42 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id i10so23645857ybt.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZeBPf4FWmMWEAA75U+2zfHoRz8ztsSomUo5httipXs=;
        b=nqKX4wkSst9GeerM4nOCf/vzcWrSonrEHusl2jkdf6JPbXSJq+BxWymEiL4T3uY8Ik
         4x8dW5ayjyNSQpzHGdBXBwgUR3/i7QbntH1DGpiG1VSo/qONG1dEHjk7eQ7vUZWuTZcB
         sjeGkl7Rxz21f045e0BYhUjLOx+j4CUZqFwX2B6eJp8vesd3WG6mx2xDKwUT/ZySaf4/
         S1/TI9gInNa8Zfx1tUHqgbcs4m8APeF5EQfIi/DnbDv9oVHQSi9bqB1DPhkGLsG0Glc8
         IzQ6dbpda1kxUaMwyRXK27ASejJ7TZq97LYZRHTosEUxPim+HBln40aZzLwhZ55NRmD4
         D9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZeBPf4FWmMWEAA75U+2zfHoRz8ztsSomUo5httipXs=;
        b=jk9JJQU6gTaX7nGgrSvCIg1X6UmDIIIVEae2ZOl4EY5sxKod+70yBnAdqGmH8gCTar
         rTORe4j9ndP/SgHkY32a4nc+jipe1uI1VydwWTfz0q+hRGzN6aj/6mlif8stZfEjyQsG
         AXLbPQa96/fWaIkZ0iEcXggfaDqdDSvi/PkDj/LzInvBIcxy9Pctdw/hPEMy9WxFigRL
         Tk+/uDfWpNNHA8zCkecpKQmzcNO20kGLnYxjZ/nfHn3OUXm4Q3c9XfuVTJlZiC4MwnDk
         BRrZLTzCRpbldhjIY75RMTAE9Xj9nVNrm2P/eoLZcmCXeVpwPEmrBwlWMkRqWUG9GAib
         lh5A==
X-Gm-Message-State: AOAM530eNcmVwLCfg/yXSVbud9jWBnfIWhLGtj6qKcKcm08Aa7odG9Hv
        3fRox0UgmfcRhc6ngdom2crSM2VNecMrxXRtZWn1kw==
X-Google-Smtp-Source: ABdhPJz1SUkhXX0nFJpMY927BG9OfI05xq6GzmRY0qwKjjcY4yGG/+NV86N6iZNmb0K0+pJBgyraSskIt/tK1DfJS44=
X-Received: by 2002:a25:8011:: with SMTP id m17mr16390132ybk.284.1643421221603;
 Fri, 28 Jan 2022 17:53:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643075547.git.benwolsieffer@gmail.com> <9f19df2a0017b71547445ac34df221e827c45bd0.1643075547.git.benwolsieffer@gmail.com>
 <YfDKTGQDh3tDMECz@builder.lan>
In-Reply-To: <YfDKTGQDh3tDMECz@builder.lan>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Jan 2022 02:53:30 +0100
Message-ID: <CACRpkday7mRWPfirjY+VcS-tB8CwqWQCyunkTUh0om9DXF4F3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: qcom: basic HP TouchPad support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ben Wolsieffer <benwolsieffer@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 5:13 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> @Linus, please take a look at the regulator question below.

OK!

> >  arch/arm/boot/dts/qcom-apq8060-tenderloin.dts | 549 ++----------------

Nice to see some use of all the work put into the APQ8060 support!

FYI: if you want graphics, this work may need to get finished:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/log/?h=apq8060-dragonboard-graphics
(mainly the MMCC)

> >               pinctrl@800000 {
> > -                     /* eMMMC pins, all 8 data lines connected */
>
> It would be nice if you could throw a separate patch on the list that
> fixes this spelling mistake in the original as well.

Yes pls.

> >                               l21 {
> > -                                     // 1.1 V according to schematic
> >                                       regulator-min-microvolt = <1200000>;
> >                                       regulator-max-microvolt = <1200000>;
> >                                       bias-pull-down;
> > -                                     regulator-always-on;
> > +                                     /*
> > +                                      * RPM driver can't handle always-on regulators that are
> > +                                      * supplied by regulators initialized after them.
> > +                                      */
>
> That looks like an oversight that should be corrected, perhaps it needs
> similar attention that was given to the smd-rpm driver recently?

Indeed

> But this makes me wonder, how can this work on the other board? Linus?

I suppose these don't supply anything vital?

I know I have seen some regulators switch off and on but I
may have been confused.


> >                               s0 {
> > -                                     // regulator-min-microvolt = <500000>;
> > +                                     // regulator-min-microvolt = <800000>;
> >                                       // regulator-max-microvolt = <1325000>;
>
> This looks like the full range the regulator could do, do you see a
> reason for documenting that here? Unless there's a good reason I think
> you should leave the commented min/max out.

Yours,
Linus Walleij
