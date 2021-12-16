Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD9B477D84
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbhLPUZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:25:37 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35806 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240687AbhLPUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:25:35 -0500
Received: by mail-oi1-f170.google.com with SMTP id m6so590586oim.2;
        Thu, 16 Dec 2021 12:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o1JFD4cNZTx567owOuKOKb/ZI5BNAf0I4tx7WOMLMP4=;
        b=icWjCeFcNjjKc51imT13BbJ/oBQtYngujEw5D8gYoltdUaq4XerLOpVUM/T1ueStdQ
         +5RYSQeusFYBDjlnF6f5uXwjNVtmhKLpPHqwbyACsL0UMRH6mWcYoNBdH4Apl7oIcVU2
         QH5NUP5wr56eDUzmyCFE/uupMo/vj2UTkG8ym2NMmUdMpsLu+aj0xa7/GO+q9xmRYFk/
         J3pe/pEnVaGz/32Fw3O/hIMGIr1IrCqv6NBiLdjb7gJTiMiz2dt5DERl9G/FXCCelOyg
         pDOOnb6B9Bos7sgSPCYrT2tm4jdi/eo8I/zy9iAjC5RkrvoJI3O7f0qxI+aprXDwpQWU
         +kaQ==
X-Gm-Message-State: AOAM531apWOWbcIRQy+1uz89PxmnJPwpbzNwmp8gcbHbKXi1onQ6am7C
        MndZMvS443nnkyK6Q8W9ig==
X-Google-Smtp-Source: ABdhPJwU+vaHoQ8PTMCCCR5TMFV7Wl/9PlgwfvZBBRErJadoIJmW7E/7xE2eRZKjPhChZ89BBDMcVA==
X-Received: by 2002:a05:6808:4d9:: with SMTP id a25mr5497400oie.52.1639686334775;
        Thu, 16 Dec 2021 12:25:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb8sm1173912oib.9.2021.12.16.12.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:25:34 -0800 (PST)
Received: (nullmailer pid 696786 invoked by uid 1000);
        Thu, 16 Dec 2021 20:25:32 -0000
Date:   Thu, 16 Dec 2021 14:25:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Hao Fang <fanghao11@huawei.com>, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Virag <virag.david003@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Youngmin Nam <youngmin.nam@samsung.com>
Subject: Re: [PATCH 5/7] dt-bindings: pinctrl: samsung: Add pin drive
 definitions for Exynos850
Message-ID: <YbugvLe2Su/LtNyn@robh.at.kernel.org>
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
 <20211215160906.17451-6-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215160906.17451-6-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 18:09:04 +0200, Sam Protsenko wrote:
> All Exynos850 GPIO blocks can use EXYNOS5420_PIN_DRV* definitions,
> except GPIO_HSI block. Add pin drive strength definitions for GPIO_HSI
> block correspondingly.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/dt-bindings/pinctrl/samsung.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
