Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD315340A0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245287AbiEYPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245265AbiEYPqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:46:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1EDAF315
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:46:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso1368044wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrTCiIB5+imBAeHHe5Yk2P2e1nFNoP+klKZAhqbPDdA=;
        b=MqPIurhFVqpa+pBM1vNQS6bUBZWcTHP2YxERwDnH+bQfrSJK2/72G3Xj7gT+UEioGy
         thWYm7nOuZQUFNxIv2huTTw/x+VekSpTufiYFUFRGkawxOrxefVaDTY1BSz5YzKXNb3N
         N68WwPk1+UqgTIjKN5dveLZ8D1OuV7Beewa2kxUojacU7Bp2iSArTdwBToEwZEZGd4Vj
         mNe2f/owRoeJLfYJRHYnmYyxZRT+hFbQiGMJHYcMVz4o5iqcWa+fTys9HDmTxnnRF79m
         YZdblvApQE3X8Sz+8/wuOXm/kqKvRy3tyjhXPvV2Tr51KqrC0DPWM7HLycywFd//eT++
         8jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrTCiIB5+imBAeHHe5Yk2P2e1nFNoP+klKZAhqbPDdA=;
        b=RtaSfNPEAckr2nv30FiKswa74rnGJ52BcyCxyMW0RDHFi5p2turZcMUjACyFxoMScx
         LPihhUPA5GD5FcfeLFxLeqZ0ZHVuD4WAPmnhpWwoEK9QOnDXw1dtkgixFixDMkzBBwUm
         N3qB31MtcXs3bYS1mfjyYiQbw1+OY/2qCA8vVu/Atj+rebaUJvyhYv/yOX0ceMVjguZn
         pFG87RXQIp0ZwZHHoqgofruzakG8Q2MVWIJWUqI7rfsCbsgMVL7Nz6V2llCXBHN2/Vce
         5v8XIah6DbHXmyun7Os6Sqpe6qJe3qTrM2FpRU2+WOmKCbu7mom1hmz18drYlxhgc/5g
         Yf1Q==
X-Gm-Message-State: AOAM530QOf75rKhExgTb+KXVMKYTEnhzVv65JtAb6jJ/MLv3t3oQLurB
        H4PSONDNpXxwpBfarO9Oihp5bQpB5WtPzMTKF4EOyg==
X-Google-Smtp-Source: ABdhPJwMCeE2M2oBeMoCYDG8p7UZtY8gBrM+hDCF+s5vsXn/s+B7NoTCVj2dK00lSgGxLjxe2HR3aykRV/KV+QWzz/s=
X-Received: by 2002:a1c:e903:0:b0:397:36b8:795a with SMTP id
 q3-20020a1ce903000000b0039736b8795amr9116951wmc.98.1653493586128; Wed, 25 May
 2022 08:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-4-brad@pensando.io>
 <CAK8P3a2wZwza=tUzxpHTHTnahf-bUS2-e80rW-wzN3aWodD1vQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2wZwza=tUzxpHTHTnahf-bUS2-e80rW-wzN3aWodD1vQ@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 08:46:15 -0700
Message-ID: <CAK9rFnwjeaGALTaDx-0k2OEktSv_UmJK9+uGuy=OFP8dnhNeOQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Apr 6, 2022 at 11:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 7, 2022 at 1:36 AM Brad Larson <brad@pensando.io> wrote:
> >
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -19,10 +19,12 @@ properties:
> >        - enum:
> >            - microchip,mpfs-sd4hc
> >            - socionext,uniphier-sd4hc
> > +          - pensando,elba-sd4hc
> >        - const: cdns,sd4hc
> >
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> >
>
> Shouldn't the binding describe what the register areas are? If there
> is only one of them, it is fairly clear, but when you have the choice
> between one and two, it gets ambiguous, and there is a risk that
> another SoC might have a different register area in the second entry,
> making it incompatible.

Thanks for the review.  Changing this to allOf:if:then in updated
patchset.  The second item is particular to Elba SoC.

Regards,
Brad
