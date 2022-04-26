Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DC1510B28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355378AbiDZVXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355369AbiDZVW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:22:57 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F2DC8BCD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:19:47 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id s21-20020a0568301e1500b006054da8e72dso13954936otr.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=MWHv2TFewrJAPnTOlW4qxlIxjpJGKW/g1lpO6FHxMAU=;
        b=mpzPEMETgbUkrlArfjYnb6ZpqroDw1mZAkpGqiBB5PVb8cmmQ01gcb3oyxdNlLfPAK
         nRTKFA5C3mK0kiSXAA6f+Oai3vDQMqoLiwrSZ8SL7jDgzbvo5scQZePIJ+ldIeuGYEst
         pzjRUCWOBhnGjrLKOYtmAvWh95ioiy9ZfJ6Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=MWHv2TFewrJAPnTOlW4qxlIxjpJGKW/g1lpO6FHxMAU=;
        b=KvQCUM+kYV10pEc7eyrLQUKwpzEtqE3R3uzWhNx0xTKngPUgeVXiJwVH7qUmTg4nis
         KAhZrkvgKRcA9Sg5oi8cD1QDnMjsszI1iU5+Aa2cBgvMs+fyIeCehDxdsdOEXe8qRtl2
         DctxtpHVRw9an0NkDyR+UjR4b1bKpO5i3alqzR0ocZC79vlN88YQAV1xuoCD55Is2/LS
         /Gc9pgP6BiQYJcVfmHOoaVncx5+Vjdww7ihwJZ49jbRDp5ONTcnA9EBzW7h1xcMeuAsM
         qPlyq00gEgg5eek0QA9GQ4MZzqThulHbCw0UVHyhW0iRBljOdmGeSPeMLCot0KDlKhDW
         /aWg==
X-Gm-Message-State: AOAM532CDzoLp+vghwR1oLEDrN0ohx9iSB6OxwXPuJMfp3VOjjmaJnpW
        /nGENmP2cCieXwBm9GHrCyO4TWDAVew482NPT4Qdpw==
X-Google-Smtp-Source: ABdhPJyzV9/i01if8INa4Tse6Ei8JcXrrFht2ib4YZe3NjXFYsSVY7NwTbRGnIZk4GbC1jHhniYThM3EsJRShwv8Oas=
X-Received: by 2002:a9d:20a1:0:b0:5e8:d2b6:f63f with SMTP id
 x30-20020a9d20a1000000b005e8d2b6f63fmr8859832ota.159.1651007987265; Tue, 26
 Apr 2022 14:19:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Apr 2022 14:19:46 -0700
MIME-Version: 1.0
In-Reply-To: <20220426124053.v2.1.Iedd71976a78d53c301ce0134832de95a989c9195@changeid>
References: <20220426124053.v2.1.Iedd71976a78d53c301ce0134832de95a989c9195@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 26 Apr 2022 14:19:46 -0700
Message-ID: <CAE-0n53Oc2Ni=dgMPLxDXLUzOPXzAQOFm2fTiimTJA_K84M=5g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: eDP for herobrine boards
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        quic_kalyant@quicinc.com, Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Quoting Douglas Anderson (2022-04-26 12:41:03)
> Add eDP support to herobrine boards, splitting up amongst the
> different files as makes sense. Rationale for the current split of
> things:
> * The eDP connector itself is on qcard. However, not all devices with
>   a qcard will use an eDP panel. Some might use MIPI and, presumably,
>   someone could build a device with qcard that had no display at all.
> * The qcard provides a PWM for backlight that goes to the eDP
>   connector. This PWM is also provided to the board and it's expected
>   that it would be used as the backlight PWM even for herobrine
>   devices with MIPI displays.
> * It's currently assumed that all herobrine boards will have some sort
>   of display, either MIPI or eDP (but not both).
> * We will assume herobrine-rev1 has eDP. The schematics allow for a
>   MIPI panel to be hooked up but, aside from some testing, nobody is
>   doing this and most boards don't have all the parts stuffed for
>   it. The two panels would also share a PWM for backlight, which is
>   weird.
> * herobrine-villager and herobrine-hoglin (crd) also have eDP.
> * herobrine-hoglin (crd) has slightly different regulator setup for
>   the backlight. It's expected that this is unique to this board. See
>   comments in the dts file.
> * There are some regulators that are defined in the qcard schematic
>   but provided by the board like "vreg_edp_bl" and
>   "vreg_edp_3p3". While we could put references to these regulators
>   straight in the qcard.dtsi file, this would force someone using
>   qcard that didn't provide those regulators to provide a dummy or do
>   an ugly /delete-node/. Instead, we'll add references in
>   herobrine.dtsi.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
