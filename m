Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621135123F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiD0Ue4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbiD0Uer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:34:47 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13901B42F4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:31:32 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id a10so3238052oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=BTjDu2WbVSkM+THogaOPND5vYJC+rnL9QDTnicnezHw=;
        b=iedhSo398MjiEuM4wYL0tNDNEjO1emHPQEG0jx4oFdbHMSN0Tbr73uPmbWBHNoClx2
         gf/Xnyj9fe+RYgCwlA8jRXCNu3ZdfMq5WKktloMpp8SeucsFMyn/KzuTGz76BGy5vUAX
         HkUD96ZEQ3hhmhG56vDqh8Kj45d2jczHNXwQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=BTjDu2WbVSkM+THogaOPND5vYJC+rnL9QDTnicnezHw=;
        b=hZwCw+7en2DGnjAlLXkdJq6LGMZomKbdiUfrkPJiTcGkocmXs5wT200qLggByXpIig
         EpfMp4IkB912bvyGwy9K0NglTmTeDHbp0eR36wvGdfdL+CQa5ND/Wz8oKFh90Y0jBf00
         thQLxVFNkfbWg7Ihvi6tgm9atngr8oHI8HMkdlqk/360Z2+s9T6jH2HziAstQqlaXtGY
         8y8y9gSCPzRqjK0f6G/aMzDxrn/8/yGGmd4wW14O8Km8CdlL5LTcrWnU8hD2XLjk8/RF
         oz9ZPLJd2hrIUgIR3lRZcppw0OxAbhsP4GdTOhkkVJ0TY5jOJppKj24H0ox3YaFzkE1i
         td0w==
X-Gm-Message-State: AOAM531Fvfm3JAglFbVSmIV/rOcVFOVK6/CPWPY4wml/Dy8QJWOGBcPG
        5JEOn/ZF08Z4YW3YeXPbJL3d2EwZRuFJ1E6W4aZ//w==
X-Google-Smtp-Source: ABdhPJxs40QvWqeyF3wGk8ZFJb/2UJkHTTGaB8uPg3ULNPuOuUNEUYmGXTbvA8Z4QNZzDDPKDXVVt3/sEqPIqJjowlU=
X-Received: by 2002:a05:6808:1296:b0:325:8fb:68f3 with SMTP id
 a22-20020a056808129600b0032508fb68f3mr10065713oiw.193.1651091491393; Wed, 27
 Apr 2022 13:31:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Apr 2022 13:31:30 -0700
MIME-Version: 1.0
In-Reply-To: <CAE-0n53sfUMiCzEgRwVRuxwnf_BLJi+cL-PoZ_ha_3EfEW1X_A@mail.gmail.com>
References: <20220426225748.324759-1-swboyd@chromium.org> <CAD=FV=WMf0Jc9oD7CGoLthguzt2aV31sZmFoenbjn72MfwFYEA@mail.gmail.com>
 <CAD=FV=Wey2P_=3Lp6M8GEaoyCn1XcYFhfJwfx43a5f_8H0obwg@mail.gmail.com> <CAE-0n53sfUMiCzEgRwVRuxwnf_BLJi+cL-PoZ_ha_3EfEW1X_A@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 27 Apr 2022 13:31:30 -0700
Message-ID: <CAE-0n52vH91zgK0iHiyG5EZtS1KbddUjHgOj2Du43vvnWNJDzg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Remove cros-ec keyboard
 from detachables
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-04-27 11:49:25)
>
> Yes, if the driver patch isn't applied then we'll skip registering
> switches when these properties are removed. I suppose a better way to
> gracefully migrate the logic here would be to add another compatible
> string. Then we could make the compatible be
>
>         compatible = "google,cros-ec-keyb-switches", "google,cros-ec-keyb";
>
> on detachables and the driver can skip registering the keyboard if the more
> specific "google,cros-ec-keyb-switches" compatible is present. The
> driver will continue to probe and we don't have to remove any
> properties.
>

I implemented this at
https://lore.kernel.org/r/20220427203026.828183-1-swboyd@chromium.org
