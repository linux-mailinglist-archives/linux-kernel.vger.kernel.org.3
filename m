Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1537D4EFA89
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350242AbiDATqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiDATqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:46:36 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A34FC6F;
        Fri,  1 Apr 2022 12:44:46 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-d6ca46da48so3780904fac.12;
        Fri, 01 Apr 2022 12:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ztZBk/eU8LaN1fXC3KyDZOqNvLzUtsYgJ6oZQG5mmFI=;
        b=sN8xTee22fbVvOtK7lEjyVy1PHqQeH3bdgodpuv+u7Qr5Z3E35Z+/G5uY4Yu7PfmM7
         oNdHLHSNpB4esLSVJF6e8SG0SHoaeE/15aPDT7pNH0JnIrF1Ml8L/+R5XzGrV/YhA0y4
         ernuTFJrn5dNFdU1LkJScgQgKg+CHMp2u42cCap5F12+Qe4ZUyxT9IcP8CJqq2Mgoftj
         Z0BFf7VzYYZ3KYeOUK6VfSNyepmidW+ekm2GsqbXtvXCGGwFGFBkNn2ZLIh1cBEjLI53
         wRMCdn9l9+fqIYEiL4MeGKNG6rfooNnJVjOR+Z8QVWKUQlyVy+r9OYyP2WU5tGXSVCj5
         ucWg==
X-Gm-Message-State: AOAM532drjFbhAV1M7EEWALlubjvpwNbAYMNrAGclOoMwqerRuGh71i6
        UQYfRGr9Q8YSoXa6s7jbSg==
X-Google-Smtp-Source: ABdhPJzdmQjYZBwZW5tuRrD8OuSn87Ui3Lr0GIVODBhuMTGrfej2KLdiOAICQpEL3bnUDb49IBPtDg==
X-Received: by 2002:a05:6870:c142:b0:dd:d5a3:767c with SMTP id g2-20020a056870c14200b000ddd5a3767cmr5662758oad.291.1648842285676;
        Fri, 01 Apr 2022 12:44:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 24-20020a056870139800b000dea48c55d1sm1384878oas.39.2022.04.01.12.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:44:44 -0700 (PDT)
Received: (nullmailer pid 3467869 invoked by uid 1000);
        Fri, 01 Apr 2022 19:44:43 -0000
Date:   Fri, 1 Apr 2022 14:44:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3] dt-bindings: gpio: add common consumer GPIO lines
Message-ID: <YkdWKzjZSzjai9Fj@robh.at.kernel.org>
References: <20220401072714.106403-1-krzysztof.kozlowski@linaro.org>
 <1648818806.914066.2864970.nullmailer@robh.at.kernel.org>
 <2d124d53-1f36-5315-3877-af8f8ad5f824@linaro.org>
 <CAL_JsqJxZZVpregyGK93oKd6KMfhGXVjNYWYhoUZiPJXjELTxQ@mail.gmail.com>
 <b035194e-c27f-ca23-cdb9-8d0dc38f6e5e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b035194e-c27f-ca23-cdb9-8d0dc38f6e5e@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 05:11:57PM +0200, Krzysztof Kozlowski wrote:
> On 01/04/2022 17:01, Rob Herring wrote:
> > On Fri, Apr 1, 2022 at 8:27 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 01/04/2022 15:13, Rob Herring wrote:
> >>> On Fri, 01 Apr 2022 09:27:14 +0200, Krzysztof Kozlowski wrote:
> >>>> Typical GPIO lines like enable, powerdown, reset or wakeup are not
> >>>> documented as common, which leads to new variations of these (e.g.
> >>>> pwdn-gpios).  Add a common schema which serves also as a documentation
> >>>> for preferred naming.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>
> >>>> ---
> >>>>
> >>>> Changes since v2:
> >>>> 1. Correct email.
> >>>>
> >>>> Changes since v1:
> >>>> 1. Select-true, add maxItems and description for each entry (Rob).
> >>>> 2. Mention ACTIVE_LOW in bindings description (Linus).
> >>>> 3. Add allOf for pwrseq reset-gpios case.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>> ---
> >>>>  .../bindings/gpio/gpio-consumer-common.yaml   | 64 +++++++++++++++++++
> >>>>  1 file changed, 64 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
> >>>>
> >>>
> >>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> >>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >>>
> >>> yamllint warnings/errors:
> >>>
> >>> dtschema/dtc warnings/errors:
> >>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.example.dt.yaml: rt4801@73: enable-gpios: [[4294967295, 2, 0], [4294967295, 3, 0]] is too long
> >>>       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
> >>>
> >>
> >> Hi Rob,
> >>
> >> With v1, you proposed to use maxItems for all these standard gpios, but
> >> as we see here there are two exceptions:
> >> 1. pwrseq might have up to 32 reset-gpios,
> >> 2. richtek,rt4801 uses up to 2 enable-gpios.
> > 
> > There's always an outlier...
> > 
> >> One way is to add exceptions in gpio-consumer-common.yaml, like I did
> >> for reset-gpios and pwrseq. However this scales poor if more of such
> >> usages appear.
> > 
> > I'd reject any new cases, but even just 2 I don't really like.
> 
> The richtek,rt4801 enable-gpios are for controlling two separate
> regulators, so it should have been under regulator subnodes/children.
> Some other regulators follow this pattern, so only this one is done that
> way.
> 
> That driver could be converted to enable-gpios per regulator, so if you
> are sure about rejection of new cases, how about keeping current
> exceptions in allOf:if?

Okay.

Rob
