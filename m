Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27E750FCCD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349977AbiDZMVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349972AbiDZMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:21:15 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF51A2C12F;
        Tue, 26 Apr 2022 05:16:51 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y76so3334127ybe.1;
        Tue, 26 Apr 2022 05:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6HlTgV16C1nbm2ubpZ78NSDfxY1Gonbs5NFJi8ajY8=;
        b=RuO8KOEN2G0gLHKrOGmsrR11cQcoY4EMsIY2bcK7T7ocA8XPc3VQ0ZI8QOqsNbGx9a
         hEfVUV5f23FIvJEcgPKImqoVqML9X9/osKNScBQSfEy0iWJmHfC66EgKepFwaSbWHcBq
         7vz6TChuhQO/kTEK2QyFfpz2V/PQB6JJ3BvTpwHz4GLTtjJ97DJoKdJlyy13Wv8R/ufk
         KutoOj0oASZ93F9k83PghB733e2iASfiZQFX+Gp5oKtLtoPrs772wQrB6Rv+6wvavE8a
         YkNh1M+wU0xSguCpmQoJbkExOFWxmi/IfvLPAAHGn6mFORKDazLBhq9g3sd9dQR3CSTL
         oXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6HlTgV16C1nbm2ubpZ78NSDfxY1Gonbs5NFJi8ajY8=;
        b=Hj5asFRA2mjb1ERVeKITNTxZZyeUwPMcGZ9HPX+p4OLx+CZMqfxlhElS1QfnlIF0Eh
         44/nvj/Gio4H2V/+i7a1RloUFRXr6q73O+TMhOXuDgcTFDgt38Z/XxANcZHaV5WHsVKt
         +VULdu4A9zX0o6vCZn6gwWgJUJjzFjUc6X+HZ48EvefkcrY2DDNx1ATRqt8oxOADnLEz
         fH0gUD72bAaAS/6G5iljJ8AFRgAZEc9k0e4qhenuRAS+ANLppxmorS2BD/VqitRI2y0U
         LQisaENiE1Lj5OHrg7+v1FZ6fYYVvQmS6rooOatglfiPPN3rMfS4MPim4/akE/pJpFru
         8N+g==
X-Gm-Message-State: AOAM5329phmEUc1N0BADo17B3zxcwKd1JYPiXRhAZlpXesKwU0F1QQ4A
        MU4CNCJfROLcy1++YI3jId3fcwCPZwtEyKNnMa4=
X-Google-Smtp-Source: ABdhPJy3MdS60/zbT88VhTjyyBnS4sNLV84Xuc1mQp9wK35oHluvxYo31IjHCQ1gtBVhkgAjoqgWbSeYRYxZ89JNSx4=
X-Received: by 2002:a05:6902:cf:b0:641:32bb:53fc with SMTP id
 i15-20020a05690200cf00b0064132bb53fcmr20857198ybs.232.1650975410652; Tue, 26
 Apr 2022 05:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220425171344.1924057-1-pgwipeout@gmail.com> <20220425171344.1924057-2-pgwipeout@gmail.com>
 <60db784a-df7c-af2c-5602-bab8462b0223@linaro.org>
In-Reply-To: <60db784a-df7c-af2c-5602-bab8462b0223@linaro.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 26 Apr 2022 08:16:38 -0400
Message-ID: <CAMdYzYpFB0yKnuuuWjpOiUmMqaSMs1fxeXDVEGOM47JCzZTwBA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: arm: rockchip: Add Pine64 Quartz64
 Model B
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Apr 25, 2022 at 2:00 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/04/2022 19:13, Peter Geis wrote:
> > The Quartz64 Model B is a compact single board computer from Pine64
> > based on the rk3566 SoC. It outputs on uart2 for the debug console.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > index eece92f83a2d..d6650a366753 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -507,6 +507,11 @@ properties:
> >            - const: pine64,quartz64-a
> >            - const: rockchip,rk3566
> >
> > +      - description: Pine64 Quartz64 Model B
> > +        items:
> > +          - const: pine64,quartz64-b
>
> Since it is a single board, not a SoM, this should be rather part of
> enum of Model A block.
>
> See also Radxa ROCK Pi entry.
>
> Keeping such approach - each single board in one item of oneOf - makes
> the file very, very long...

Thanks for pointing this out, I will go this route.

>
> Best regards,
> Krzysztof
