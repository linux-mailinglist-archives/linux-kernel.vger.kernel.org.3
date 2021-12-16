Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49E477AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbhLPRsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:48:36 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33501 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbhLPRsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:48:36 -0500
Received: by mail-oi1-f182.google.com with SMTP id q25so68344oiw.0;
        Thu, 16 Dec 2021 09:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o2JZCbz8Avj0lvEIZyPPiYT7pEQh5cOWFHLlHKH+zGo=;
        b=zVjoExj1874wHfzv0AC/3cVxY2flDY8yCv2pkuN+OXHpjGL+LcrnoWcL+C3iOLCdkt
         wpe8dj4fDnobN2jDHJ+znyCO7j16FvXInBuraGlm1lyM6EsfWulgyEUeIrz0D9TBoeSa
         DNkdbYvlPP21EZ8FWEvB1uLDhP3nRW4S1PgNZetxpe9wJNcmKYFz0YxL8mdo+tDGLDjU
         J/HshgsabnCX8MHzi1cYE07CGB2I7GQ96E31QxfMhJ3Ylet5pFaxXcMFKDyIENFnebHc
         U1w0Y3wAG6dUlMcO197UsmDkzLOS5rIIsPS8PxcH8bj7nMAB7iiaaNJ2OXMx31s0F9Ev
         du6A==
X-Gm-Message-State: AOAM53132fbkJLusdwmcBxIMUBzGqmp8fQmtrHb4m5ga8fWeOqIK4SJO
        kyhHpQUPQyDrZ64ce/nsug==
X-Google-Smtp-Source: ABdhPJzqxF2ClTUqx7Cq8pma6B2pY+ysF0xPZipJknlo450iLFwctAIxCVl4l1Y1qlNu/o6L9npzIQ==
X-Received: by 2002:aca:2319:: with SMTP id e25mr5107591oie.164.1639676915516;
        Thu, 16 Dec 2021 09:48:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b1sm1143229otj.5.2021.12.16.09.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:48:33 -0800 (PST)
Received: (nullmailer pid 462419 invoked by uid 1000);
        Thu, 16 Dec 2021 17:48:32 -0000
Date:   Thu, 16 Dec 2021 11:48:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Virag <virag.david003@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Hao Fang <fanghao11@huawei.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
Message-ID: <Ybt78LP4KDYoQrDy@robh.at.kernel.org>
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
 <20211215160906.17451-2-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215160906.17451-2-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 18:09:00 +0200, Sam Protsenko wrote:
> System Register is used to configure system behavior, like USI protocol,
> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> make it possible to modify SYSREG registers.
> 
> While at it, add also missing PMU and GPIO clocks, which looks necessary
> and might be needed for corresponding Exynos850 features soon.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/dt-bindings/clock/exynos850.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

