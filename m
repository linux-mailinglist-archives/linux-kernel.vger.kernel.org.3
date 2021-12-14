Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B49474751
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhLNQPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbhLNQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:15:46 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A1FC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:15:45 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id t13so35687669uad.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6FJi1chVbjhnnxyU13+cLRUgb7epxkD3A/uWK2BL6E=;
        b=FCrnA9ABISsTiY1lnbiP9+rfCMgW2g08O6yQF8CfKnrrGmEpexA+SIvqrll1A3dPCq
         BKPTXc/7IW1Ef4gZrAasmwlRo59LM5YWGm89jTjRndAUgOSlxjDlEuXLpzbmkGdRopsx
         X2A431io7LiTaagHHLjONVFn7X004XUhAqFBhDUUt8s8ck/oDDC/rhdBs+v5bZvqTfYX
         Cm2mM3+XNemXd4cDvRBBWMxTHQfZeY8Tm4kNjkPAEfrMRuCb+n8AEUtHq9otxZmqrnkj
         3ppIu5zf4M9KYj9gb9sVqG+NRN5SougOKXnUuERI5Hgsuv7nvRKIRgudGZ3xeZ0pOz+T
         9gUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6FJi1chVbjhnnxyU13+cLRUgb7epxkD3A/uWK2BL6E=;
        b=c0GekpAP+xNhTwBjTg0lAsJsezexJFBEUZ0qzmFsy0UezjLYnOx7Y+f+wqifF7YSFu
         9DMQu1wX85ORy04SRLMGWoruVunzMPeb3TeFh61ucEbvt1/Bp9feLNK98ll3hYDRxlax
         ZhwRd9JFD85KJPS18+LJPI0609x+m8anayi9NXBct5ypTZbVcgGPZgTxANiRVE+Y7bHf
         k7oiW9PQ/UdNmWQTzXg9wx7TT8cJDU6mePycAsGC6UejVPjGrwqz3sDqjDpuuLvwWakg
         oLW75kb/scPfrKrroFwg3yqyAtTX9C2B/qi2+l5T4lYoC9G/FLnyU/azFsG4noHI0ZOS
         5U/A==
X-Gm-Message-State: AOAM530amv9DsCLJKiM4kYjicmbGcoGu2eBSpjrm6SByYDFeQz3Y842K
        S3vd+d/l9PutaVpzEXUZtssRhITQ0BimUJ94844UFw==
X-Google-Smtp-Source: ABdhPJzEL887m0Kxg3sI2RmnzaW9Lu/RySFA8VRYAU3p3WJAo5Y3zuyk8/44Zjpq1FkqALrxnuD3wDw/WQyN5lfSdQo=
X-Received: by 2002:ab0:7859:: with SMTP id y25mr2325675uaq.9.1639498543523;
 Tue, 14 Dec 2021 08:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20211126203641.24005-1-semen.protsenko@linaro.org>
 <YagPWOj0CLxE/+ER@robh.at.kernel.org> <CAPLW+4=LTd8i2Tqr7Wa0NDRTJ5mRJXP=EvRCx84WxnwCDQ1eVg@mail.gmail.com>
In-Reply-To: <CAPLW+4=LTd8i2Tqr7Wa0NDRTJ5mRJXP=EvRCx84WxnwCDQ1eVg@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 14 Dec 2021 18:15:31 +0200
Message-ID: <CAPLW+4nk7Y8Psg9ZVacvzJeAV3VAGWfi+9hTPWgTeAWqh67AKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-samsung-soc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        David Virag <virag.david003@gmail.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 at 22:54, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> On Thu, 2 Dec 2021 at 02:12, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, 26 Nov 2021 22:36:40 +0200, Sam Protsenko wrote:
> > > System Register is used to configure system behavior, like USI protocol,
> > > etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> > > make it possible to modify SYSREG registers.
> > >
> > > While at it, add also missing PMU and GPIO clocks, which looks necessary
> > > and might be needed for corresponding Exynos850 features soon.
> > >
> > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > ---
> > >  include/dt-bindings/clock/exynos850.h | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> >
> > Acked-by: Rob Herring <robh@kernel.org>
>
> Hi Sylwester,
>
> Can you please review and apply this series, if it's ok?
>

Hi Krzysztof,

Do you think it's possible to take this series in your tree? Once it's
applied, I can send the board support (dts) series -- this is the only
remaining blocker for that right now.

Thanks!

> Thanks!
