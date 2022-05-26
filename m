Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7446C53477C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbiEZA1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbiEZA1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:27:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D051A7E1B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:27:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z17so156360wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOl6uOgkcVMNPECHww0pzlplNgdMl8NRZo39BUzLuoA=;
        b=BHM0auJl9Sd5Dl2qJoFb/qdXLGW8QkdJbZjjrLo1TDFKx5fEHAlXZgFbC0cBhPOdAI
         5xDvn/os9mSk3V1kxQ1KHgGhTHYaQaRkPFLEeXeTroCAeIt70xNw7V/WlqqtbHW/CRjT
         OnzERudLz6vFREv37wQlCLFnApPMsCvjHd54G8eeHnr70Fe/n2vEeoiT2vjnTTOI25Nl
         0EpNn2dzHSOtEIGTKjyJHp0LZB9FmTKk43WKiVV/ApgMW0khwjaWbetLVYfhpG8LfPqF
         hAPRZH+uPbrzgpF/eGmx+c1QbbKX4kIKJoNfJJT7xoVRq4LPhj1f+Y715qT0z3Lh4lzh
         Lbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOl6uOgkcVMNPECHww0pzlplNgdMl8NRZo39BUzLuoA=;
        b=qF4oSvIdnVHRhiK751kB9HoDeRl4OR15dE3BJ60Wsp/DaXUc6AxMa+HQXHej+Djms1
         3sDCnOb1j3mPPnVzf/w3w/tnsQP0YegU3DX2iB0SgTHQqNPpk5uIluNXoHGB1MLnudj4
         vSvTqVIuRkU7uYLkGig4C9kv5tURs0z9KWLtvOULhZ70j034nsh0FA++CinDXyRwyGKg
         FttAlL7s+G9dVen7C56MKjOB/pLiUdGVWUFXS6BDbT/Dx3cKgXcLA5q0YH+qJwyJARF2
         OlNMQQ2yF0KSQwdc4PvCHegE59SD0ppkVp68zcIttNFAniHP4hzxoMKUKbHcTDibKjQf
         WfsA==
X-Gm-Message-State: AOAM530uB+cNGRHvsUVJANu7FDaW9eKOfZCBMJXDNoeEybFRwIbrLJ/a
        ZeJ3IJUhfbfO2OCtR/znCP4osA9j/OIvLtprWXKh6g==
X-Google-Smtp-Source: ABdhPJxVky3rKIS/oU7bSC8zBBvywZPXJjmvHSoT1fVc5JVZhyOfC8jBb/ONCY7sQEBc9th/majjmccCTzSpZD7nxWc=
X-Received: by 2002:a05:600c:4f45:b0:397:710e:4c6e with SMTP id
 m5-20020a05600c4f4500b00397710e4c6emr4117893wmq.143.1653524863660; Wed, 25
 May 2022 17:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-6-brad@pensando.io>
 <6769ea2d-9e6a-03b1-0e05-cb5b7379cb5e@linaro.org>
In-Reply-To: <6769ea2d-9e6a-03b1-0e05-cb5b7379cb5e@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 17:27:32 -0700
Message-ID: <CAK9rFnzmz0cUYe6i8qjXbwsfJgZaSk7DfJuZk5N6YV-Jwu2_kQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] dt-bindings: spi: dw: Add Pensando Elba SoC SPI
 Controller bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

Hi Krzysztof,

On Thu, Apr 7, 2022 at 11:52 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/04/2022 01:36, Brad Larson wrote:
> > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > @@ -37,6 +37,21 @@ allOf:
> >      else:
> >        required:
> >          - interrupts
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - pensando,elba-spi
> > +    then:
> > +      properties:
> > +        pensando,syscon-spics:
> > +          $ref: /schemas/types.yaml#/definitions/phandle
> > +          description:
> > +            Phandle to the system control device node which provides access to
> > +            the spics control register
>
> It looks you only need to poke one register from spics, so it could be
> something like:
>
>     items:
>       - items:
>           - description: Phandle to the system control device node
>           - description: spics control register offset

This looks better, I'll change to this approach for updated patchset.

Regards,
Brad
