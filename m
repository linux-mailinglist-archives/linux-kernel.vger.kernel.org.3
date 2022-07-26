Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D847580ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbiGZIYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiGZIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:24:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374962CE3F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:24:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w5so4407898edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2eR2bajGRP/sgNFoTl95SKN8UfWncJyTcpIwCg8mZac=;
        b=oOPs8L9PuW7OKOkDNzZYO1z+kaxW19SG4MupZMavHPwr6wEwC5Pkc+a3zCWnbp37gB
         Q/XMOdE8bkMm20N5pufa1A7ii53GVMD+uoA6jY0MaPs/Mz3pXGymLuyqhabVcfCBVdNG
         FZKT+MEl5xFBxseEjwndE1xYUEu+A4yYJMxdrijrGgYMrqOgTib+1V3AwKxFYa0Q1Yv3
         lsKS/G21RNxtTJ160BPYSlnp7cgPcAMUXrSkZQHkwV5knNUojtbyLS9Lm//Lys8qBwvo
         MvYj4n8+5MWt1T59klH/XTflGtix7ZAMhi5ycY1UPpY2nrYkEFLEkCvdxZrYePspDuGY
         4aDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2eR2bajGRP/sgNFoTl95SKN8UfWncJyTcpIwCg8mZac=;
        b=MJ3uJnNtkxi1p7EteL+vks/yEz3azjsMm+c87wPNJjmCayjppOwCsvQn7wQniQicDc
         xEMOvvmeIw/muNWCFCUnmtsy4oZgfuiK6y8m9cswsC9Lk2k3b4po5rZzLZZwaZvuYzmC
         SHlbb/7MWHb2B6PblhpDDw3rWHXZs2qljLnQpMU+BHPL2AOS/nHQFKaIbZ+poLo+x4fn
         EHtvDodfBWnU5YCLaEbxt/DE0hUhIdKrwwJYLsPtPXsyenxe184eZJl1EZJAl25MZDIE
         78ONLEWGNRE4B04dfvD/1wwcn2iGIqei5LgEndf+0Swb/65b9myBHOk+IFw5vE87ZPqs
         icyw==
X-Gm-Message-State: AJIora/ijKJHM6yrOZkLpQ80cTk5fOp05tuUyBxrRZPrK9n4H6eORzTw
        s6Io9Mavzk/8D+7G8oRrkSKxAUp0i0y/i5hS+nfROw==
X-Google-Smtp-Source: AGRyM1tstrOXHY8xgRH3GyE5OsoHHbrAl6kqR23c9IfUWFc8GJUD8u2uEM2ekizLdZ6HC2sstvliH1Jpc4Nk7Ibfn7A=
X-Received: by 2002:a05:6402:2696:b0:43b:eb8b:d0da with SMTP id
 w22-20020a056402269600b0043beb8bd0damr10851495edd.158.1658823887600; Tue, 26
 Jul 2022 01:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220725110702.11362-1-allen-kh.cheng@mediatek.com> <20220725110702.11362-2-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220725110702.11362-2-allen-kh.cheng@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jul 2022 10:24:36 +0200
Message-ID: <CACRpkdbJai1X1iwY+qEGH_NwwsSWk=Ap6goZEat6o4Wb5E_FXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: mt8186: Add gpio-line-names property
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 1:07 PM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:

> Add the 'gpio-line-names' property to mt8186-pinctrl, as this will be
> used in devicetrees to describe pin names.
>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Patch applied.

Yours,
Linus Walleij
