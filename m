Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1B563B3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiGAUsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGAUs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:48:27 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7F51AF33;
        Fri,  1 Jul 2022 13:48:26 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31772f8495fso34652707b3.4;
        Fri, 01 Jul 2022 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCkQguGKE4vw52rjiqjjJsW7E4cSYB+SLLUzIoTk1Ik=;
        b=nhB8IrU8txldVw7LtGSWB2XuMaK41dK1wtjCFUP7hs2b3EfyPt+IK/qd97CWasayUH
         NHtvxCX6iaDovs0Ht/ldQ9nYuWtX5WiPSWMRH5wddBrPfIgkfnm8B5h2MSoQIpIUsObL
         hqv6XVESZyTyy8HferXZt7iyBAQU9BKTTOtJus593aZ7o1aHj/VN2ixvSZ+TutJnzS8Y
         JsOQDoGNQ3+HC7gVixZ2VZWq2ChM+8TqFCY6eRzj+A8B4alnuxSWvk0mnCBBuy9JfZH1
         ikEbbDeMIal5CTyUy+vX9UVmHtNIShnuU5jdE5TT7ZCCMA3YPZGAz6uS0lVeE6CxpTth
         TdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCkQguGKE4vw52rjiqjjJsW7E4cSYB+SLLUzIoTk1Ik=;
        b=uKOJ4/BzmTT+Di0mS/YyJXzC7ZFpToMtLjDtbMyz1+3Ni48gthl7PcvDSe9D5Mu9tM
         OPolfNiwAsQ8DbMFinyJIXizBFYLIfTdGWIKQYp2WsF00ELVnTQAJkbJ+rCtctJxZeYA
         orQzjMjI7HCWmueegATgvdGGV0/1ZMpOMyIe33OzfsVWUem03AEONC28YL1JZTLQWryO
         fjMa6VikQSQFbBmZVW1AXb9HRVeoDyLucA+y8zAiCmmteXD3pMGe0SzkxwvcpvPYIS1P
         y/X2LubDVqLrDAUqVd3FVx46SrhRrAt9xVs4YJEVcydb5orGfgK1Q7bBkcrtbIzPSyoX
         AnRA==
X-Gm-Message-State: AJIora+WSIo0IBFhJRz97R6uCVZO2Za3rzpwXxgyelZFnwIC/jx3tQZd
        yV9SMHMLICnH3pycURT6IN5iison1QTW+0E4wAg=
X-Google-Smtp-Source: AGRyM1vUtG1sprs3WyDHHWQCuxk/Q5yWxq2OoSg0LZhgVVTyot64upYI6tkj6cuRWeOXXNHfAH6Aq1iE1M/M/fjuaZI=
X-Received: by 2002:a81:cd3:0:b0:317:861c:ac07 with SMTP id
 202-20020a810cd3000000b00317861cac07mr19277273ywm.486.1656708505618; Fri, 01
 Jul 2022 13:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220701134415.4017794-1-vincent.knecht@mailoo.org> <20220701134415.4017794-5-vincent.knecht@mailoo.org>
In-Reply-To: <20220701134415.4017794-5-vincent.knecht@mailoo.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Jul 2022 22:47:49 +0200
Message-ID: <CAHp75Vf1nMi6OAbksNMCEkq3snrtDQSwRcSnbkB=gPwS=WWz9A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] leds: is31fl319x: Use non-wildcard names for vars,
 structs and defines
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
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

On Fri, Jul 1, 2022 at 3:45 PM Vincent Knecht <vincent.knecht@mailoo.org> wrote:
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
> Rename variables, stuctures and defines in preparation of the splitting.

structures

> No functional nor behaviour change.

...

> +#define IS31FL3196_CONFIG2_CS_MASK     0x7

GENMASK() ?

...

> +#define IS31FL3196_CURRENT_MIN         ((u32)5000)
> +#define IS31FL3196_CURRENT_MAX         ((u32)40000)
> +#define IS31FL3196_CURRENT_STEP                ((u32)5000)
> +#define IS31FL3196_CURRENT_DEFAULT     ((u32)20000)

> +#define IS31FL3196_AUDIO_GAIN_DB_MAX   ((u32)21)
> +#define IS31FL3196_AUDIO_GAIN_DB_STEP  ((u32)3)

Why do you need all these castings? Wouldn't u/U suffice if you really
want to have them unsigned?

-- 
With Best Regards,
Andy Shevchenko
