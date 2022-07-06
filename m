Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9EF56876E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiGFLz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiGFLzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:55:55 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546B528735
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:55:54 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z13so17798165qts.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 04:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xPPvWkX/4qbcpxkLhSz37/dg2kQ2TdyfBGP0fDH2yg=;
        b=cUsjsTcPftdO60OMEiKQ4hv8X2Er3f5roF3uW5EmdRGuZxAt/jWMXPjAFX7itH5ZFK
         vUSSJa1ffxzdS1t6yW4ILO0SO/fDZPzYPyH4Nt7i1uHMmC3hY0YSLaeS3011WTAs4uWR
         bds1oCBPN1inb2QCOT8bOgd94l08GVVEAmsNXaO+wyOWil6Iwlc8uKbI4k0uaAI3hEc9
         N4VQ2NN1Xs6DUhn8t2R3MD3pnuVo6r5iApPFC98RxCk9bZE+XG2wOXUXHWgQ584D+med
         rNquHLcX0owEgVrBbSfHJ4SCfHaUWCGTwwwcYTnergywH4lO9IpTV+DUUQRw20149ZSK
         BI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xPPvWkX/4qbcpxkLhSz37/dg2kQ2TdyfBGP0fDH2yg=;
        b=SBdbu6wAYTOBxPxn9M8e9S95B0ZYGhv/NYFQTxg4r2hircGCKcjatrUquODqTCfXGh
         z68YqbfGwOyjfzupDZ7ZSJXBwZX7pK2rJ8bKyU2YaGhFHWK2EAvgd29u8EP06pRbFdXn
         umf4EGF9dO/woiHjGI83+dY3GApYLn792RWU9f3DUDtsBc9XKj8lqQutQgSZCYp/kL8e
         NOcA+tpyJ9hDk6jZelrqBvQfUpGUk0v9M3vGCpDL9IHoCCmMdF1vJZY/TXUQYu++eAti
         jwbM4qf/txZKfISV8IPEqW41GioaowHPVV2kFGHfnXL1Jqe0TBWj0qSD+2mtg7RTc8t/
         gexw==
X-Gm-Message-State: AJIora+jYiF2fYJkS2S+p3umE9AFz5LGus2D7Ta5bBnjNuYnFqpps+hN
        PwfY77/hPueLSZdmh6HNJoV0f5Ta+L0LxcxsOqOU6Q==
X-Google-Smtp-Source: AGRyM1txd771wD0DyBtRq3n3JR0SKeoIUILx/nX4kQwQ9L56f1AyAZjwRJ1FoLu0egJmYMS134eL+7pj4xks9LiP5WA=
X-Received: by 2002:a0c:f501:0:b0:472:f72c:7947 with SMTP id
 j1-20020a0cf501000000b00472f72c7947mr11667047qvm.119.1657108553408; Wed, 06
 Jul 2022 04:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220705133917.8405-1-ansuelsmth@gmail.com> <20220705133917.8405-4-ansuelsmth@gmail.com>
 <e81344f6-7da5-a209-2785-d540e41f3958@linaro.org> <62c56348.1c69fb81.d2cad.2584@mx.google.com>
In-Reply-To: <62c56348.1c69fb81.d2cad.2584@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Jul 2022 14:55:41 +0300
Message-ID: <CAA8EJprzV_MFa8gS4=vR_mz3RvLAdHYrvH2=D9P5FWGTaviSyQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: dts: qcom: add missing rpm regulators and
 cells for ipq8064
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022 at 13:26, Christian Marangi <ansuelsmth@gmail.com> wrote:
> On Wed, Jul 06, 2022 at 10:34:16AM +0200, Krzysztof Kozlowski wrote:
> > On 05/07/2022 15:39, Christian Marangi wrote:
> > > Add cells definition for rpm node and add missing regulators for the 4
> > > regulator present on ipq8064. There regulators are controlled by rpm and
> > > to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
> > > reject any regulator change request.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > Tested-by: Jonathan McDowell <noodles@earth.li>

[...]

>
> > > +
> > >                     rpmcc: clock-controller {
> > >                             compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
> > >                             #clock-cells = <1>;
> > >                     };
> > > +
> > > +                   smb208_regulators: regulators {
> > > +                           compatible = "qcom,rpm-smb208-regulators";
> > > +                           status = "okay";
> >
> > Was the node disabled?
> >
>
> smb208 is the normal and advised way to handle regulators on this
> platform. Some device may want to not follow that and implement their
> own regulator bypassing rpm so we add a status and on the current device
> present upstream we set it disabled as it does use different regulators
> implementation.

Yep, this is correct. But you don't have to define status = 'okay'. It
is the default.

There are two typical patterns:
1) Disable by default
foo.dtsi:
    abc: def {
        status = "disabled";
    };
foo-bar.dtsi:
    &abc { status = "okay"; }

2) Enable by default
foo.dtsi:
    abc: def {
        /* usual properties */
    };
foo-bar.dtsi:
    &abc { status = "disabled"; }


-- 
With best wishes
Dmitry
