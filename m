Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA89048DDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbiAMSyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiAMSyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:54:08 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF54C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:54:07 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id c5so652109pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tb5858QqXIcL5etsmWCS0ZKhHGEgdWFwctSsz78MvDI=;
        b=UK7Pq02IigfJ4UwrZ8hJfii4Xs3neqjQIZcCnn8iEJ2HaSzAsOFfNWUOvyqHby6xZ3
         RPlt+Q9ETiZ57YNEA2lks/Dmj+Yk5qVw6hReh/CyXQxkUhA9iluXR8+lFYLBQ6QHkhM/
         n2ilJTcMm9FfoIvY9Pc/SVqd5ihJfZNoRu56K6O5UOOWWjHBbiczhjlaF92FQkLDeZZm
         Na/p4eIaTEnhyy5sMOVTJTMbbIUFAHYkfchs8yApFNnFluEjW71UU0DvNSBgg1u1x70O
         rdrXoDDPa4vNGbC08xoLC6Fkxa2SJR0HokkgcJz1d/qarYXgH+CmInrAtTcqudfn2bNH
         TnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tb5858QqXIcL5etsmWCS0ZKhHGEgdWFwctSsz78MvDI=;
        b=iQR3bIdTHw8/sRJapyvhOXqq0GcuIZ5NMKKBkZURAPQEJ+W0VDPbTt45YqDVj6+XCm
         HclOXLJrMY1w6WrQlDqpZyiKuz1p4MeWhFeYEtDD/gM6O1DyQNYOzctv8rtl4BiN9PBv
         R+FNlzBsROsecjEUJWTldihOGHtg0z/5dIlvqGZ2eyR1v8bI5RJQgPfDvNFVfmLFiOMh
         vN3p+67tTsrKLkhvnbGVGVOFKANwG8G2crN9SO7iPUJfabX/77EuKtTPjgWK4Pv76Tvm
         AJEa/X0auFsr9EBNh7Etse+cTdACNTW80pWac7cWYFL8vRf1uCdB1P0xXQJ2n52q6Srr
         pgsg==
X-Gm-Message-State: AOAM533veibBmfTvZnylIoYbsJgn75bYs3taF3bDfOk2I+W5zmWwOSCS
        RxCmUucqqNXlMNzgEi1yxbjKNOxQrS9Mk/VjJyilNA==
X-Google-Smtp-Source: ABdhPJzXlahtnsFy6IBae/4XXtwKfp3ieNHsHEWW/ixmJdS+WTYxk6qaqsRZoeKRiQr50fLtEznw6+6eMB/iQsmKuX4=
X-Received: by 2002:a05:6a00:16c7:b0:4a5:d9c1:89da with SMTP id
 l7-20020a056a0016c700b004a5d9c189damr5491085pfc.34.1642100047311; Thu, 13 Jan
 2022 10:54:07 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220113122302epcas5p1d45c0714fe286f8f91d0f28c3fad86e4@epcas5p1.samsung.com>
 <20220113121143.22280-1-alim.akhtar@samsung.com> <d1a852e1-c4c2-b7c4-ddeb-7fbcfd9b4e58@canonical.com>
In-Reply-To: <d1a852e1-c4c2-b7c4-ddeb-7fbcfd9b4e58@canonical.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 13 Jan 2022 10:53:55 -0800
Message-ID: <CAOesGMjZ8X3r2KvPLWWwJj1ckTruiGOjx9wLyu8YbCxW+OaZgQ@mail.gmail.com>
Subject: Re: [PATCH 00/23] Add support for Tesla Full Self-Driving (FSD) SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 4:32 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 13/01/2022 13:11, Alim Akhtar wrote:
> > This patch set adds basic support for the Tesla Full Self-Driving (FSD)
> > SoC. This SoC contains three clusters of four Cortex-A72 CPUs,
> > as well as several IPs.
> >
> > Patches 1 to 8 provide support for the clock controller
> > (which is designed similarly to Exynos SoCs).
> >
> > The remaining changes provide pinmux support, initial device tree support,
> > and SPI, ADC, and MCT IP functionality.
>
> Does FSD have some version number? The FDS, especially in compatibles,
> looks quite generic, so what will happen if a newer SoC comes later? You
> would have:
>  - tesla,fsd-pinctrl
>  - tesla,fsd-xxxx-pinctrl (where xxxx could be some new version)
>
> This will be extra confusing, because fsd-pinctrl looks like the generic
> one, while it is specific...

The public sources from Tesla on github uses "turbo,trav" here, but
that's also not a versioned name. The platform itself (hw3/hw31 -- 3.1
I presume?) has numbering, but that's system and not SoC:
https://github.com/teslamotors/linux/tree/tesla-4.14-hw3/arch/arm64/boot/dts/turbo

It would be easy to do "fsd2" for naming/numbering if needed for
future versions, for example. I'm not so worried about this,
especially if there's no corresponding internal version numbering that
this would map naturally to.


-Olof
