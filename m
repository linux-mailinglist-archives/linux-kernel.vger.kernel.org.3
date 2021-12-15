Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BCD475752
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhLOLEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhLOLEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:04:46 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A75C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 03:04:46 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id l22so42368407lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 03:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Mxq4v2aa07cn7vmDque1vmJSPRI9q1+xfotPBgOEKw=;
        b=YYVSOtge5Ubs9/QdtAuGxXrCKYFLrjlM3KjC61oHbi35tATBP533nULGmmFdbr/Gvy
         4tK5sdKWdmzTQZoFtgo2YBjm2MjEONJK0mYJt6hi3UgQ0iMg88k53RtPGndnLhtVi/2N
         Oge5CcFSb1F6WZhg3zr87NahWwQR586UpuYU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Mxq4v2aa07cn7vmDque1vmJSPRI9q1+xfotPBgOEKw=;
        b=0bjj26XMYLqg2teKdq7GNrRhMDC5kn4MjDZ92PhhF+VHNxdIPDBv7JRS7O2i8Kg8JS
         0HmCOyIwA1Fjl6FE1xybIANrxxS0erPkToZjN56UmRPJ1knCoQ23ZC1Jhc4/reUbypyK
         GJj+D6B7k2gVYsR0+aU5Il2+O/BTfETZm8UsHSyloqnX+IFbx6ayfehLKBAWuFH8SgFO
         GQsa2QKVT6DUGWcyBaIdDB92zgvp/fyb8C98L+Cqg+8wMqaMtITW0oG5bNqMf6de+DNs
         zN8qtWvkuYP8sT+IqfPhh1rcnD9qWd++howpkzVhUwE56/a8tUdKkj5ljevJ1lNsvVsi
         T+VQ==
X-Gm-Message-State: AOAM5307V60XevdxAZRGPv8OzdGtTJDO0uk23yTlWqpFaAcgzgSnAuiS
        G1jKfiCEq71B6fF6iPyO/TVDI5tJwWMNhrX1N30Cew==
X-Google-Smtp-Source: ABdhPJxWhA1IhaY2P5SVuTF/Dv2jmTo+wwNa0EsIvD5ISkU2YTob2I9LJQKrHWvVMA8n4dFomFv8yOt53VdRikP8LXc=
X-Received: by 2002:a05:6512:3f2:: with SMTP id n18mr9409898lfq.646.1639566284404;
 Wed, 15 Dec 2021 03:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20211210145430.3707463-1-gsomlo@gmail.com> <20211210145430.3707463-2-gsomlo@gmail.com>
In-Reply-To: <20211210145430.3707463-2-gsomlo@gmail.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Wed, 15 Dec 2021 12:04:07 +0100
Message-ID: <CAPk366RvYSdn8Y2Vy-qDh3wVsBqZgvJk+fZArze8u0s9oob5_A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] MAINTAINERS: co-maintain LiteX platform
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 3:54 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> Add the litex_mmc (LiteSDCard) and LiteETH drivers to the list of files
> maintained under LiteX.
>
> Add Gabriel Somlo and Joel Stanley as maintainers; Joel authored
> the LiteETH driver, and Gabriel is currently curating the LiteX
> out-of-tree device drivers as they are tested and prepared for
> upstream submission, having also co-authored a number of them.
>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Acked-by: Joel Stanley <joel@jms.id.au>

Acked-by: Mateusz Holenko <mholenko@antmicro.com>

> ---
>
> New in v4:
>   - n/a
>
> > New in v3:
> >   - picked up acked-by Joel
> >   - added listing for liteeth driver
> >   - added Joel as additional co-maintainer (thanks!)
>
>  MAINTAINERS | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8691c531e297..7f59779bb5eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11011,12 +11011,17 @@ F:    lib/list-test.c
>  LITEX PLATFORM
>  M:     Karol Gugala <kgugala@antmicro.com>
>  M:     Mateusz Holenko <mholenko@antmicro.com>
> +M:     Gabriel Somlo <gsomlo@gmail.com>
> +M:     Joel Stanley <joel@jms.id.au>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/*/litex,*.yaml
>  F:     arch/openrisc/boot/dts/or1klitex.dts
> -F:     drivers/soc/litex/litex_soc_ctrl.c
> -F:     drivers/tty/serial/liteuart.c
>  F:     include/linux/litex.h
> +F:     drivers/tty/serial/liteuart.c
> +F:     drivers/soc/litex/*
> +F:     drivers/net/ethernet/litex/*
> +F:     drivers/mmc/host/litex_mmc.c
> +N:     litex
>
>  LIVE PATCHING
>  M:     Josh Poimboeuf <jpoimboe@redhat.com>
> --
> 2.31.1
>


-- 
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
