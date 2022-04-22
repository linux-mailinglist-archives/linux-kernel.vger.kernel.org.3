Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070B950C47F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiDVWPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiDVWPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:15:16 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD3323668D;
        Fri, 22 Apr 2022 14:05:18 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id b17so6961114qvp.6;
        Fri, 22 Apr 2022 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpzKp6GQylN2DVn3Q8F44AaoMz54tuxDB2xUboNmmNk=;
        b=pzvr3/UvSftncfosMfmgiWOYhMYbYHuIZTCgY5hDDTvmyy0dEedr9JVfuEeVSTpSm5
         Wod5E9A0cF7e6X5SdVy8UQacTpGtFKdz/js8K/09qJ95ej2UAw2PGlDkrsu+YG2dXUGA
         p/jEJQdqi+LBuQNomKnUI+S9NQyVkZ2ZnEbNnNiPIsX8T4w6VzABtzJx/TXysyHMCVQ+
         ScUWgjAh3cPwFtBgN8jKf/CoS7zoCpT0JVr0YNB0YwEC8YxElSpInoxiPR7dP6Gy9x+x
         Z2XHiikQMiTNKC8bErgRGi2i/cEQhRjtXly2a1DC44EwlTnp4zUihn+XzrUyE57MfFZT
         LYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpzKp6GQylN2DVn3Q8F44AaoMz54tuxDB2xUboNmmNk=;
        b=N+dern6iTZrA/2UvQsr6Y52jn8zymardWbbx95HxpdlyZEHU0GjMAhiSiuBcWU6ygK
         JvfCgYSLuYmROy/fJwQDjacL8Z26faSRt/7q+beB70rfc12J3+jrUYoa3of+uVgVOn8r
         E0I3Cha8DP6onWwoH6uDGhYrXN0tjv0lYjfsOL/h4s6rAHmkmMnRct/kEU5pURDnwn+u
         jLIR9LJuEdROgHTQH9jEsbxMhgu77xSQKO3yBuhhcTCkBSyEq0t6vd7LJxhqOmp1tFVj
         /fsF/Urs+Z1Da7L6xRV5AHESN3hbjFZCoDcZ475N18TUP89AJOhbCYU+21J3cifOSl/X
         tnWQ==
X-Gm-Message-State: AOAM533V03zKTB0KHH5xciSahmWiExG0lVdxqoqtnCrR4CoYYoVLgztQ
        L0rfaX+MxMSzwBqpHdHMyvbxV359xb7uLrvxjhSuX17I
X-Google-Smtp-Source: ABdhPJyDTdfYVPmGi9JCDZSwQ3dGVcvDeC8/OPyjPu7IjhwDECkrHzuq3quIB48TTMhTBLoEclHmpE49GOqp3rGJBbM=
X-Received: by 2002:ad4:5943:0:b0:446:5c3e:2c2a with SMTP id
 eo3-20020ad45943000000b004465c3e2c2amr4554955qvb.75.1650653101635; Fri, 22
 Apr 2022 11:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR20MB24721F9954252BECBEF486ACBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
In-Reply-To: <BYAPR20MB24721F9954252BECBEF486ACBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 22 Apr 2022 11:44:35 -0700
Message-ID: <CA+E=qVfMm=8aQOM_HW_3EeqqLi-Fgn1Ex3h6kor89FQ0KfTvRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: sun8i-thermal: add binding for
 R329 THS
To:     icenowy@outlook.com
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:12 AM <icenowy@outlook.com> wrote:
>
> From: Icenowy Zheng <icenowy@aosc.io>
>
> R329 has a thermal sensor controller that has only one sensor, and the
> structure of it is like the H6 one.
>
> Add device tree binding for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml  | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> index 6e0b110153b0..87b4103e0a5f 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> @@ -20,6 +20,7 @@ properties:
>        - allwinner,sun50i-a100-ths
>        - allwinner,sun50i-h5-ths
>        - allwinner,sun50i-h6-ths
> +      - allwinner,sun50i-r329-ths
>
>    clocks:
>      minItems: 1
> @@ -63,6 +64,7 @@ allOf:
>              enum:
>                - allwinner,sun50i-a100-ths
>                - allwinner,sun50i-h6-ths
> +              - allwinner,sun50i-r329-ths
>
>      then:
>        properties:
> @@ -85,6 +87,7 @@ allOf:
>          compatible:
>            contains:
>              const: allwinner,sun8i-h3-ths
> +            const: allwinner,sun8i-r329-ths
>
>      then:
>        properties:

There's also a check at line #99 that requires clock, clock-names and
resets properties for thermal sensors in other Allwinner SoCs. Are
these not required for r329?

Also are you planning to add a node for thermal sensor to r329 dtsi?


> --
> 2.35.1
>
