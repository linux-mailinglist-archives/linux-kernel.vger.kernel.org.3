Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709C750EB32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiDYVRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245712AbiDYVRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:17:32 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B74110549
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:14:26 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r8so18595043oib.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=X8qBR4k7N3biK/baIHugbINU/cSkeqhq6SIFIR2b73g=;
        b=BYv54WpQMfcQHf9EDLt0vgrF2mLVZ5MNLfSA6GV7H7W7HA8OQtn7WOTar0ykA6Lj4a
         UpNrT8Qi8xqIO/wlkhnFrZ5jjWJNWcJZpKzS02rhG2lomL9AdL2U+20NFJZVe9+KiWs5
         HjAvLJpl+dL1J7dLUDPXLywfNY6mcNrqC62mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=X8qBR4k7N3biK/baIHugbINU/cSkeqhq6SIFIR2b73g=;
        b=iu+0f72rrVnxHGWdVpL/YAHHET7srWJJKGwNJypRHTQSQYNfSKFgbR9nOKI/L1j+gz
         876tkeRcu70cIvfAYy43eeyhoHPvfGxOXorryJ8XYiczA5etUl60Q0dZXPiXnCSR/W/q
         +goAgPKFhBgcVjonfyCXkoLG7SkzPoAe4TOLxdfrrF5pL2dIq1RDRHx2o7wwoMoQafeP
         84aXDrUcSyOt107QRz4saSDforiIMUhZJmmELZczDto++Cs8mcHCsiC9cDKDErgAqmcu
         kesCVtJaL2y6Yr+u67Iqh/L2wzUzLHOz3siUZO7AUsDFeqLy6A4kp+ahqOsOyO+JLzO1
         pXFQ==
X-Gm-Message-State: AOAM533hDALTb5hZfr9ncR3pf/lCaOgWwOFZhOa0YD6vKMFYazrNIwJO
        S40SdW75gNG2sccQPv/cmmwfgkWdOYFr8ul+Y60gJw==
X-Google-Smtp-Source: ABdhPJztvQbfhKUVNaMO1H0yxKW2QJXWNd3iFmKb0M3Orpq7oisRwtkCiiqoU7PJj6ZXQ7WmO1sLao/x8L0uFXM5LbY=
X-Received: by 2002:a05:6808:1296:b0:325:8fb:68f3 with SMTP id
 a22-20020a056808129600b0032508fb68f3mr5332637oiw.193.1650921265969; Mon, 25
 Apr 2022 14:14:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Apr 2022 14:14:25 -0700
MIME-Version: 1.0
In-Reply-To: <20220425140619.1.Ibfde5a26a7182c4b478d570c23d2649823ac2cce@changeid>
References: <20220425210643.2420919-1-dianders@chromium.org> <20220425140619.1.Ibfde5a26a7182c4b478d570c23d2649823ac2cce@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 25 Apr 2022 14:14:25 -0700
Message-ID: <CAE-0n51eZpAKprRQ0HqjLciF_BVQHBDN8SMFNVmmOd=B9UBEzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: msm/dp: List supplies in the bindings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, quic_kalyant@quicinc.com,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-04-25 14:06:42)
> We're supposed to list the supplies in the dt bindings but there are
> none in the DP controller bindings. Looking at the Linux driver and
> existing device trees, we can see that two supplies are expected:
> - vdda-0p9-supply
> - vdda-1p2-supply
>
> Let's list them both in the bindings. Note that the datasheet for
> sc7280 doesn't describe these supplies very verbosely. For the 0p9
> supply, for instance, it says "Power for eDP 0.9 V circuits". This
> this is obvious from the property name, we don't bother cluttering the
> bindings with a description.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  .../devicetree/bindings/display/msm/dp-controller.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index cd05cfd76536..dba31108db51 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -76,6 +76,9 @@ properties:
>    "#sound-dai-cells":
>      const: 0
>
> +  vdda-0p9-supply: true
> +  vdda-1p2-supply: true
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      properties:
> @@ -137,6 +140,9 @@ examples:
>
>          power-domains = <&rpmhpd SC7180_CX>;
>
> +        vdda-0p9-supply = <&vdda_usb_ss_dp_core>;

Having 'a' in 'vdda' typically means 'analog' for 'analog' circuits, so
I'd expect this to only matter for the phy that contains the analog
circuitry. It would be great to remove the regulator code from
drivers/gpu/drm/msm/dp/dp_power.c and move the regulator_set_load() call
to the phy driver if possible. Hopefully qcom folks can help clarify
here.

> +        vdda-1p2-supply = <&vdda_usb_ss_dp_1p2>;
