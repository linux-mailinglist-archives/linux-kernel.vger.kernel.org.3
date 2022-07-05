Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D49C5676CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiGESsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiGESrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:47:46 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DB31B788;
        Tue,  5 Jul 2022 11:47:42 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31bf3656517so117869937b3.12;
        Tue, 05 Jul 2022 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUn0Dl36fUybJsR7SVUxdhvipccFobY5Xd3Ct0RmvM0=;
        b=LLsUFpXOv4vADqi/Z+1WbsuyTzVjRaEjfscsAli3kLOpdNNF/fg1rSfF2x19nVWf1g
         wBBZGjk6janX3qenOpHKKrAyuolm9qLk6VYgRlX+X5STjfp1Q6Ljp7l/XcwiqEIj+g4s
         ADTspCsqtE6/53G2ibgsjcKGj3RLC6ZWil3g1UTA2xiEyWYzeBsUu2DzCDC96jhF85mM
         vXI2TZqF2eiCuhNyo2NTHM3Nqx+VPcGF95eGlPB9scw47wikb04gtdJA/WBpXWmMsyHq
         WsWCmpVj3HQEQ9hxPbnK7EGAoSVq43PIbeWe8AjAmstetcCc+Sr2YEyWE0wuqSzHqlu7
         xfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUn0Dl36fUybJsR7SVUxdhvipccFobY5Xd3Ct0RmvM0=;
        b=KU2tzmn7zCGpY32IFrDdTe2Q/81nzgjXvoEkAq6jb5kw6YZdngswgdNQa3LBjmfllG
         PqDeudG4uiZAZ+eVwgOaW9M1l8mbHLO+ndVIF98aO8jeiSsXzuovCwSpKeXDCO+YGMes
         VJhK0SHuk7ZmXplaTUepTUb0tsuO57sPg5c3h+trxLWFdouAdpdmMiSzVybwcH7AYDt7
         tGMVjKoh5m70RWasyrztiVIvzUx8WzrOnEW/BuVndo43/Bk4AToxwaQO8vC1TL9YNwKV
         owwkfhVU3oJafGk9IfQ3FzczbtR2lN9yyy3+FBG+yH19boQkcEnjzy2xBGEiBsIoyB7g
         zgFQ==
X-Gm-Message-State: AJIora+kWtDHboVnorVOmEQMEJw+bpx6iOen2PvjlTgmCGJ0A/wZFKXy
        3fNyFFTbbYcOLXcOJSAhqK2m0mZ+WJ8CgPslmFA=
X-Google-Smtp-Source: AGRyM1s+scTvZUsz+EFhE5GHHFUPVEKSvgjXH4mEu2fWSfrxbb0l4gyvoFkcbtEYwWVD17SjWWeUkoZd6n8XmmBTeso=
X-Received: by 2002:a81:8397:0:b0:31c:8a02:3f6d with SMTP id
 t145-20020a818397000000b0031c8a023f6dmr16817651ywf.486.1657046861338; Tue, 05
 Jul 2022 11:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220705163136.2278662-1-vincent.knecht@mailoo.org> <20220705163136.2278662-5-vincent.knecht@mailoo.org>
In-Reply-To: <20220705163136.2278662-5-vincent.knecht@mailoo.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 20:47:05 +0200
Message-ID: <CAHp75VdHdSkALpgGHGxthq8h1q9Dg3N5jJS6NxTuexvfWJEDjQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] leds: is31fl319x: Use non-wildcard names for vars,
 structs and defines
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 6:32 PM Vincent Knecht <vincent.knecht@mailoo.org> wrote:
>
> In order to add real support for is31fl3190, is31fl3191 and is31fl3193,
> rename variant-dependent elements to not use 319X where needed.
>
> 3190 suffix is used for is31fl3190, is31fl3191 and is31fl3193 circuits.
> 3196 suffix is used for is31fl3196 and is31fl3199.
>
> Those two groups have different register maps, current settings and even
> a different interpretation of the software shutdown bit:
> https://lumissil.com/assets/pdf/core/IS31FL3190_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3191_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3193_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3196_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3199_DS.pdf
>
> Rename variables, structures and defines in preparation of the splitting.
> No functional nor behaviour change.

...

> +static bool is31fl3196_volatile_reg(struct device *dev, unsigned int reg)

>  { /* volatile registers are not cached */

This is a rather non-standard place for comments. Are you going to
address this in the future?

>  }

...

> +static const struct reg_default is31fl3196_reg_defaults[] = {
> +       { IS31FL3196_CONFIG1, 0x00},
> +       { IS31FL3196_CONFIG2, 0x00},
> +       { IS31FL3196_PWM(0), 0x00},
> +       { IS31FL3196_PWM(1), 0x00},
> +       { IS31FL3196_PWM(2), 0x00},
> +       { IS31FL3196_PWM(3), 0x00},
> +       { IS31FL3196_PWM(4), 0x00},
> +       { IS31FL3196_PWM(5), 0x00},
> +       { IS31FL3196_PWM(6), 0x00},
> +       { IS31FL3196_PWM(7), 0x00},
> +       { IS31FL3196_PWM(8), 0x00},

While at it, add a space before }. This seems in many places like
this. Perhaps address the rest in a separate patch?

>  };

-- 
With Best Regards,
Andy Shevchenko
