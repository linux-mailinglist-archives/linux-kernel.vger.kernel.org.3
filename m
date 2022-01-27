Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9522749E4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbiA0Oft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:35:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60928 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiA0Ofs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:35:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D1C3B822B7;
        Thu, 27 Jan 2022 14:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6C5C36AE3;
        Thu, 27 Jan 2022 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643294144;
        bh=PW79X8cPn6ViAnKzMlHMh+jPKdZ8Vtts2c4SdW32Gzo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AUOiVeCeNZFf4AWa8FOVXHRuBed/o2o6B/EcNapzB8ePPOMhpmyKkIqo++Qm62r4J
         vHRhxxSrHzO7jdW8TUe1ZtOCuvacFsfdGkgHKBBeKW0pBsrRodg9PxEWBVjR0JIvfy
         A+1YmBxZKEaWwwYfBzbUYkQeX+89pa7zoeFNoU44h41wVWTBvbnbucJ3VrSqhjLYS/
         xz5mbETro1Rwxjm0MlXTAhBRD6Ge1fmkZYCjP279qf6UAK5y4IPY9/FgtdfVmFUUVg
         whN4SzEt0zXclfVCPhbjJ4WdDWLVEnuoIDJ2yFOQnN4+AC4j7k5ksBOxWpqzPPf8af
         KzvhYU8HVMdQA==
Received: by mail-qk1-f177.google.com with SMTP id g145so2737407qke.3;
        Thu, 27 Jan 2022 06:35:44 -0800 (PST)
X-Gm-Message-State: AOAM531JLKM8MlRY3fXNxRMMM1n8T/miefkvfwP559sQBh/4I4WH8jWk
        rHTpuW8ZkwrXSW3l0jAu2AAtQ68ft6GZUhUpvA==
X-Google-Smtp-Source: ABdhPJx+l2xwFUQU3YA/Xj/VasojClh5ePxxWVUY3Xu0vur1D3RTeupyBC0V/insZdon7g+GJkRzbH8lNDYDwIUaVWs=
X-Received: by 2002:a05:620a:24cd:: with SMTP id m13mr937625qkn.643.1643294143207;
 Thu, 27 Jan 2022 06:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20220126231427.1638089-1-robh@kernel.org> <1jtudp1rc1.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jtudp1rc1.fsf@starbuckisacylon.baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Jan 2022 08:35:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL77E+5ftqgHPdWQzfp98Oh3d=QZRQ8Z6v91OfSeprxig@mail.gmail.com>
Message-ID: <CAL_JsqL77E+5ftqgHPdWQzfp98Oh3d=QZRQ8Z6v91OfSeprxig@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: Centralize the 'sound-dai' definition
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 3:05 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Wed 26 Jan 2022 at 17:14, Rob Herring <robh@kernel.org> wrote:
>
> > 'sound-dai' is a common property, but has duplicate type definitions.
> > Create a new common definition to define the type and then update all
> > the other occurrences to just define how many entries there are just
> > like other phandle+arg properties.
> >
> > The constraints on the number of entries is based on the examples and
> > could be wrong.
> >
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Please ack, this depends on commit abf0fee97313 ("dt-bindings: Improve
> > phandle-array schemas") in my tree.
> > ---
> >  .../bindings/sound/amlogic,gx-sound-card.yaml |  4 ++--
> >  .../bindings/sound/google,sc7180-trogdor.yaml |  6 ++++--
> >  .../bindings/sound/imx-audio-card.yaml        |  7 +++++--
> >  .../bindings/sound/qcom,sm8250.yaml           | 10 +++++++---
> >  .../bindings/sound/samsung,aries-wm8994.yaml  |  5 +----
> >  .../bindings/sound/samsung,midas-audio.yaml   |  2 --
> >  .../bindings/sound/samsung,odroid.yaml        |  9 +++------
> >  .../devicetree/bindings/sound/sound-dai.yaml  | 20 +++++++++++++++++++
> >  8 files changed, 42 insertions(+), 21 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/sound-dai.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
> > index 2e35aeaa8781..8b5be4b92f35 100644
> > --- a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
> > +++ b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
> > @@ -57,7 +57,7 @@ patternProperties:
> >            rate
> >
> >        sound-dai:
> > -        $ref: /schemas/types.yaml#/definitions/phandle-array
> > +        maxItems: 1
> >          description: phandle of the CPU DAI
> >
> >      patternProperties:
> > @@ -71,7 +71,7 @@ patternProperties:
> >
> >          properties:
> >            sound-dai:
> > -            $ref: /schemas/types.yaml#/definitions/phandle-array
> > +            maxItems: 1
>
> No min or max here. Links may have more than one codec.
>
> Ex:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts#n158

What do you mean? Every 'sound-dai' there only has 1 phande+args. Each
codec is a child node.

Rob
