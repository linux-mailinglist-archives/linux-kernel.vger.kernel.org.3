Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0EC564A75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiGCXL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGCXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:11:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09FD2BCB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:11:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f190so4420734wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEvIt0W4jMtK0kOUq02n7cnRwL93Xyq1bjqkbvvw32k=;
        b=CiVuKlquo+4o/OdgU9j/J7SlhK5NNg9ng3XiM6R33Wpz8A0EthSdvb+5XdYtOgNvXw
         Fcp5vU/Qz8d0IloOisuZKpr20agYbvpa1ULksUY/MVfeZz2zzGtqLRvpRqRbLLIOasXn
         HjHT4bQ+heaVzhdmhyI8BOg4UgZlmVUb10kCbKeHDsQW6o+dX+BvHeeS6DKhJDx5v59p
         ffoQ+ciCarbX0nVB+G10lnWd8qDquSood14rlUxNo5mXaOFcmDjPByr5DgsSLw2mQvsp
         NYRGciH+asxSIDil2X8Pst5+/DMOVr6fTM127Qyl+6WxMAo5JTTwZYyENOPEBwJqMdlD
         vPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEvIt0W4jMtK0kOUq02n7cnRwL93Xyq1bjqkbvvw32k=;
        b=Gaqz5cT7BQxcBnuWcqTphjHgQKfEhwW/Gzz2C7lhk6/NnSQOwbPQWvFXf0sjDFCQOj
         kTEjuZ+X4SnnDJmAHh6Dx7eJ/8duKAhNy44twaCZlgwvttxAextuOo35/Ef9HqjBCFIc
         MqJnK3qYA2aBxicuUAmUzL2TpyHV5U68ivFRm5uNsDDaCYTHPqA3w+/OrqRgqyyfAWuV
         TWs+L+h/ixPUkqpM+OtwrxmLyy5PFvBb8ANiaqi+FF8YDvyw8UKXlQsucbb7I2LPL5kO
         v/CRnSDeAXSzgzXcacb6+L2mBCHakoxhg3fOwMqwR2BnixjGiZ91TUA/dPF3NfC4wj4T
         EUUg==
X-Gm-Message-State: AJIora+UCbnYWkVLwHgAHKcyRbqe2UiI8ZcfPO9x8venj5k4ro6mhbre
        iZE7e/+zf4THcrDWfRBHHwxavSdVJHtxpnY34IR2Dw==
X-Google-Smtp-Source: AGRyM1v5SLIg8WZnDQdxcL0e+L2xOqK4GaB+5QbY5FlNGlEGYkSCm/VCy7BumOq8xzX0Maqdck28Oe3SLtxW20TxHWg=
X-Received: by 2002:a05:600c:4f42:b0:3a0:57ed:93a9 with SMTP id
 m2-20020a05600c4f4200b003a057ed93a9mr27714140wmq.143.1656889913254; Sun, 03
 Jul 2022 16:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-3-brad@pensando.io>
 <c3785da1-0142-5c4c-4f46-c569c8c06efa@linaro.org>
In-Reply-To: <c3785da1-0142-5c4c-4f46-c569c8c06efa@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:11:42 -0700
Message-ID: <CAK9rFnydaXSjDsZf1Bnv90tBVHpZ4rr+Zufd6Cr4rJjDeB=-jg@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Jun 20, 2022 at 5:50 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/06/2022 21:56, Brad Larson wrote:
> ...
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -13,10 +13,24 @@ maintainers:
> >  allOf:
> >    - $ref: mmc-controller.yaml
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - amd,pensando-elba-sd4hc
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: Cadence host controller registers
> > +            - description: Byte-lane control register
> > +          minItems: 2
> > +
>
> Except Rob's comment, the entire section now should be moved to bottom -
> just before unevaluated/additionalProperties:false

Yes, moved it to just before unevaluatedProperties

Regards,
Brad
