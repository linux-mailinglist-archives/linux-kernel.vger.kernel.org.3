Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3370487CC5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiAGTEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiAGTEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:04:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3700C061574;
        Fri,  7 Jan 2022 11:04:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B476AB826D7;
        Fri,  7 Jan 2022 19:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B472C36AF7;
        Fri,  7 Jan 2022 19:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641582290;
        bh=nNx8Ez8RuJzMEX0m/nrXYhE49DyWxePNuMQ+s2d9OD0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m5gR7RqmffLGvhknYYWgFF3VAibsPeF8pQrWF6J3+O0Kwz6qm6XXlJkcskjX1N4Q5
         /jKuE1HIfpPOcj538lEcF7XofVhmgV9bZnspFkZYIqt25o+CBtAuYTuwK07E4O4Eao
         IgV8kJKtof1HzpHJ448rDdWmv4pdIolVmAbycc8M+57w03HK8IHG//VGh/BuFQeuW1
         UYeWn8ZQhIBB0Nowg+kYaTHNYL/q61abrwLil2XugJ5CHdaYnlk0M5sBTabv0yV3fb
         wihs/R7/mPeK7wvKs32NSOyaxq+xdF+lXIsK6Ny4Tee9ezGd6ggzhvCI8qQQxa20qw
         Innkz7FsgnU5g==
Received: by mail-ed1-f48.google.com with SMTP id u25so25766680edf.1;
        Fri, 07 Jan 2022 11:04:50 -0800 (PST)
X-Gm-Message-State: AOAM530KrgBE2f92QdT2Ea7Yzt3zwGlt6mj6RrKP18ficABe++9EAWJh
        LidLXd1Brzm5BJ+bFXgB/0k1oCFgh2+7OWOaMQ==
X-Google-Smtp-Source: ABdhPJw+wXf/3puw/6oK452xH+IpOasvCo6eBekERmd/axjyL/WBlDh/+JCf89iqY3bdCvCGkFWJtxidbbj8CqZW4bY=
X-Received: by 2002:aa7:ce88:: with SMTP id y8mr5876517edv.303.1641582288710;
 Fri, 07 Jan 2022 11:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20220107115345.9075-1-tinghan.shen@mediatek.com> <20220107115345.9075-3-tinghan.shen@mediatek.com>
In-Reply-To: <20220107115345.9075-3-tinghan.shen@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 7 Jan 2022 13:04:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKctALMWbNytCP7TGKEcCaoOVpm4eHQ3PUHDy2AKrwfmg@mail.gmail.com>
Message-ID: <CAL_JsqKctALMWbNytCP7TGKEcCaoOVpm4eHQ3PUHDy2AKrwfmg@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] dt-bindings: arm: cpus: Add cortex-a78 compatible
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Ryder Lee <ryder.lee@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 5:54 AM Tinghan Shen <tinghan.shen@mediatek.com> wrote:
>
> Add ARM cpu type cortex-a78.
>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)

I already have a patch for this pending for 5.17.

Rob
