Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78952550E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357766AbiELSmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351554AbiELSmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:42:12 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC6169702
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:42:11 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id a22-20020a9d3e16000000b00606aeb12ab6so3326242otd.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2ktEM2WdQXhUkI4WC57ZsgNwZP50FQxfG+aaBGhL1/A=;
        b=X84dqLkVxAqkq2YriqsNaydX5HWwTZIJ41RwxOz78cFKaBWcUViPGfxQQnUcKxODJU
         jlRB3Elg852MYIjthVe2hc0onWRbJRVUKA34l44KQTcMpXQgOxe5HdlePDnD7l4gGpmK
         0I71ECIHGd3G/uPaybBW+PILUaRLuQ7hXCD7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2ktEM2WdQXhUkI4WC57ZsgNwZP50FQxfG+aaBGhL1/A=;
        b=N1evFnnOPM4Vp3uNlsnTjPWGT0E4sMLuY0dRuVSS8A3vX7oUJEyK2UVeHBYMMkJAxm
         eq9ayOtCMecIMUliEU3I5xNsYv78MPU2gctsQAU4Utkco53RdvvAiLk+9IgnDPktJOMP
         Uh+QbbrCXVFy5mL4EbZPLubG0OmXBiSNztG2UxBQDjV+zp+bmNnWzOuU1OUVAh2pX23R
         IQbnkq+kSewOKvc02PJ6ZTQtxm1zLcS82mfU7oHMzS/Y5jpF+p7Gt4rMgme9ZPjCaHG7
         nGoDRNYYLfdJRCzPGs4PdsqPtquIcbWaXsXpcZwacLiTKY/gXO+EUlVzay0e5VCDtl8f
         bj6w==
X-Gm-Message-State: AOAM53109OBAHkI3JqPD5RvLqvkYv+TTRXV3MBjQxlvteswx5mODzW82
        50GlL3TvUXcaq5Bo935RCSFizFE0jh30tNbOxkthvw==
X-Google-Smtp-Source: ABdhPJwYZomkma75bHZi41atC+Y+imFA2JK98Jirq9TfqEF/WaUpsCWBVXGwHAmgE8CNURqOJUtqAkCO4SquH4yYBm0=
X-Received: by 2002:a9d:63cd:0:b0:606:9e7f:79f8 with SMTP id
 e13-20020a9d63cd000000b006069e7f79f8mr532146otl.77.1652380930973; Thu, 12 May
 2022 11:42:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 May 2022 11:42:10 -0700
MIME-Version: 1.0
In-Reply-To: <20220512090429.1.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
References: <20220512090429.1.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 12 May 2022 11:42:10 -0700
Message-ID: <CAE-0n51fD6H2+JmFLMWyWuamcXDWzLQaXuWpnanvwO8rDQcuKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: qcom: Add sc7180 Chromebook board bindings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-05-12 09:04:45)
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 5c06d1bfc046..399be67eb5d2 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -214,11 +214,191 @@ properties:
>                - qcom,ipq8074-hk10-c2
>            - const: qcom,ipq8074
>

Side note: The top of this file describes a scheme that is basically not
used by any compatibles in this file. I came up with that scheme many
years ago so that we could upstream DTS files but still be able to
generate the magic numbers that the bootloader picked DTBs by. I hope
nobody assumes that description applies to "google," prefixed
compatibles.

Can the description can be amended to indicate the "google," scheme with
rev and sku details? Or a bindings/arm/chrome.yaml file could be made
and all google prefix chromeos board compatibles could be put in there
regardless of SoC used.

> +      # Qualcomm Technologies, Inc. SC7180 IDP
>        - items:
>            - enum:
>                - qcom,sc7180-idp
>            - const: qcom,sc7180
>
> +      # Google CoachZ (rev1 - 2)

Can we follow the design of rockchip.yaml and also include the marketing
name (if published)? That helps folks match things up quicker.
