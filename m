Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857E94B54B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355772AbiBNPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:23:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240389AbiBNPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:23:56 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169E95F8E8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:23:48 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b38so6979843ljr.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2Wzb73CCNJjymF4wVIRvovDIYwgk4oVDBjnM/KPNjs=;
        b=elp+5cTpAjU+1/ip79o/mzc94QPWcQLdADxYuHtbbb35WzwfcPePrjIkqA6nuvK8xr
         BlOV7/fKbg5q5P9bz1KGyaJV/tyQmgBVmkZV6IF4hLzxK/M/yGuI4KFp45wWoNuOU6i+
         glNkY+TH9jAi2XDKFPtdZNEXktN0yfyVN6LxczV5G2xn4w0voWRmzdUNDm3gYWGNh/po
         qp+PgBVIPqPEVbsxoB4OXVtFlH21t4pxQaCpVbsDuB++qcxTQ9nl8g8Fxy+AiSgYn63p
         agFwAWRXcAeQNjE2W5r47S8l4JFw7/FhVRMzFrFto1pRWpdlWen+Rq8WTSI64k4A6UfU
         MRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2Wzb73CCNJjymF4wVIRvovDIYwgk4oVDBjnM/KPNjs=;
        b=x9rv3FMNTU9ipXZ0lQlpsrIVhNwBwPkuXaUsaWEEqlxPGAWyYoT/mP/l+Kaa/Z1JaG
         OXNwQcib6xPHdyX4pbB2kaw9Aa4evTZnKmTr2y9dipX+YwlfJCmJ3SVJRBLXBkG+a8Br
         ErlT2SuBv1zLaGtqLtaXcbHm/29GtoBwn51Y523savsltxCEMTCR/DokGFiB9kV5Al83
         nt3WSDV5Q3iKNC11IXfxTwWuGnjUytsgukX0QI1cY0cjZZiVq2BSLL2DU2yHVWReRaNO
         ysC6cWf0YipcIcI+OhY1n/rOxDymfBV3O+sj7S7DLr1YcxJPIwHrpEMiEpT/bsJ7xKN+
         uW8A==
X-Gm-Message-State: AOAM532h1a2RUwNl9/XK2Bds4mEDCPwr5Ea0h5dOharX1tZ1sJCiY0fy
        oyFoMU6FdMiC2lOzSzHR0ePDI7uwRQ5RcyzFZX/OeA==
X-Google-Smtp-Source: ABdhPJzfciI7TngcTILpWVQuCNuuqqSMq2cqqqebQNnx9wghhN7LjSSWuFvn2nKCKlLwBdlHEDzZrWnTrQa46CaiDAA=
X-Received: by 2002:a05:651c:179c:: with SMTP id bn28mr188158ljb.4.1644852226434;
 Mon, 14 Feb 2022 07:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20220119103212.13158-1-axe.yang@mediatek.com> <20220119103212.13158-2-axe.yang@mediatek.com>
In-Reply-To: <20220119103212.13158-2-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Feb 2022 16:23:10 +0100
Message-ID: <CAPDyKFr8bV+1uTbuhMObvORLGJHsvZHUONJkdY54MXPPRWL5Qw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: add cap-sdio-async-irq flag
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 11:32, Axe Yang <axe.yang@mediatek.com> wrote:
>
> Asynchronous interrupt is a mechanism that allow SDIO devices alarm
> interrupt when host stop providing clock to card. Add a DT flag to
> enable this feature if it is supported by SDIO card.
>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 513f3c8758aa..16fb06f88471 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -165,6 +165,11 @@ properties:
>      description:
>        eMMC hardware reset is supported
>
> +  cap-sdio-async-irq:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      SDIO async interrupt is supported.

We already have a DT property for this, I believe.

"wakeup-source" is probably what you want, but we have additional
properties that are related to this too. See more below.

> +
>    cap-sdio-irq:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:

The above, "cap-sdio-irq", informs whether the SDIO IRQs can be
supported at all, by the host controller.

The property "keep-power-in-suspend" informs whether we can preserve
the power to the card during a suspend/resume cycle. This should be
needed in your case too, I think.

In other words, you may need to combine "cap-sdio-irq",
"wakeup-source" and "keep-power-in-suspend" to describe your HW.

However, what perhaps is missing, is a common MMC/SDIO binding that
let us describe an optional irq-line, which sometimes is being used
for the wakeup irq. In the sdhci-omap case, we look for an irq mapping
towards "wakeup" if specified in the "interrupt-names" property.

In some case, when the SDIO card supports an out-of-band IRQ line, the
similar should be specified in the child-node corresponding to the
SDIO card.

Kind regards
Uffe
