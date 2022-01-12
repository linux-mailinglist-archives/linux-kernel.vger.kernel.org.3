Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953D248CD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357739AbiALUrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357724AbiALUrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:47:16 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A24AC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:47:16 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id s8-20020a0568301e0800b00590a1c8cc08so3927146otr.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=0uCoA9gtquAQnLHyAGMH5yVKo8Duifh87vN3LET60pI=;
        b=SnD1JKebqAjYC5/mV/x2NVj0fqVqMvELGDmhlzsqOrnOKrDhwpPSGP84I9xaHm2Rbq
         iGwHRKPGD+nQIsMfjP4tWbcBNbjEBV8aJhdGEWDHUfP0C+m2H19S1ux3ku8quhLV09vz
         5DPxadd9dgWkIVpLgZ1tlCNyvk7npsNGMXYpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=0uCoA9gtquAQnLHyAGMH5yVKo8Duifh87vN3LET60pI=;
        b=76eI0GoRyNO9CFtK/ztBIYzWKLLP0nwrFCxvKFazGkxmgmH2wkybDk2MIttA7kKuMi
         FZZdNcJ/CcZcWdg8uC83iqBsnlje8t2UvCjNp9a4m6gXR8+D/+dQrkRz7NCl4Y6QDvus
         jP2eTOH/FkeXJ5eA7MjcBF7IG41SBWEnw24A98z7g1MX23EMYD86dCZSIm7GE8bGjYGi
         WAgwwK3ED4P8a5l+uLflt1ey+bo/nA0exUE1tcp4jzqv7UNXos/pU8XNikfQLcs4x84J
         wTP3XPzhhjk8MPUwjHrn4LbOmtoX9xs5elJgGFuSVzcRoPufMWHs7KHcrWEk3qQAlGAF
         qw2Q==
X-Gm-Message-State: AOAM530XWboVKRnkp673Ci8BAUSgcNE7movjtixGdmLViP4dzcLiwnev
        DpNPQnft4OnvStBzbtkJBUDQ1x6BD0T9hu8o1tj7BQ==
X-Google-Smtp-Source: ABdhPJy9DmFUV/f3PVpJF83pL5khFYgu6zkYLCna4fPGNS9nED/DGpoKwj7OQP4IEupq54UmgFfYL6V0X/WXPaWBUDU=
X-Received: by 2002:a9d:7451:: with SMTP id p17mr1054973otk.159.1642020435932;
 Wed, 12 Jan 2022 12:47:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Jan 2022 12:47:15 -0800
MIME-Version: 1.0
In-Reply-To: <20220112111028.v19.5.Ie0d2c1214b767bb5551dd4cad38398bd40e4466f@changeid>
References: <20220112191048.837236-1-mka@chromium.org> <20220112111028.v19.5.Ie0d2c1214b767bb5551dd4cad38398bd40e4466f@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 12 Jan 2022 12:47:15 -0800
Message-ID: <CAE-0n51VZobLjRGZFYquEMgDutfmsAC0j8mj6cM7fvK7Myeczw@mail.gmail.com>
Subject: Re: [PATCH v19 5/5] arm64: dts: qcom: sc7180-trogdor: Add nodes for
 onboard USB hub
To:     Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-01-12 11:10:48)
> Add nodes for the onboard USB hub on trogdor devices. Remove the
> 'always-on' property from the hub regulator, since the regulator
> is now managed by the onboard_usb_hub driver.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

One question below

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>
>  .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 19 ++++++++-----------
>  .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 12 +++++-------
>  .../dts/qcom/sc7180-trogdor-pompom-r1.dts     | 11 ++++-------
>  .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts | 19 ++++++++-----------
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 19 ++++++++++++++++++-
>  5 files changed, 43 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index d4f4441179fc..cd31460b3bd6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -202,7 +202,6 @@ pp3300_hub: pp3300-hub {
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&en_pp3300_hub>;
>
> -               regulator-always-on;
>                 regulator-boot-on;

Is regulator-boot-on necessary?

>
>                 vin-supply = <&pp3300_a>;
