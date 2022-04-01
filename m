Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7194EF6DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356728AbiDAPqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbiDAPRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:17:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BBC5D192;
        Fri,  1 Apr 2022 08:01:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 230D1616FE;
        Fri,  1 Apr 2022 15:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EABC34111;
        Fri,  1 Apr 2022 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648825309;
        bh=TV1nTOWhjz0M7TNtZfCiAFh7Dw+Lqcv6mb3lgab8xzE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X/4SF9PuEMgGL9lg5lx5a4lERIEuEjIZxVirPLIhc10RimxDaIkNuVZHbxqnkDeC2
         4LcMkt7x29GU1XVmTwDQtF5u8ux1uuB8hl1CfwxtziMy50MNKeP5YWuJBC6UM0bHDG
         3jpBUPBNnnwH6Qspkc/lqdCk+RtixiySLAiFgc7ak7TCxYvCLZ/Z56pIqwgcUKKpjQ
         yBzXP5M2pC6Z/6aTE/tWnnukb5uNEf9pPpGEBmfKmRPKHbKBMvYEAy0cdNCVJi0lmy
         OJyg0Icx3owrJZNuz5NFI63ZRGxnjkFVvX86l+H1ps67qkgj/FjnuqxIfB+hZlyOxd
         yU2KjOLu3K91w==
Received: by mail-il1-f170.google.com with SMTP id 14so2094579ily.11;
        Fri, 01 Apr 2022 08:01:49 -0700 (PDT)
X-Gm-Message-State: AOAM533imstSbuXdkz8doTsxFYFLahJVMQPTbQsCwex47z4MA0rMn7xz
        8IsTKM3e6TCKidTcDA3j93d2PFy4WLoK9UoIqw==
X-Google-Smtp-Source: ABdhPJziMx1caNbv0dMwdal2+j9jq5/3gxBdtJLPaVs7YTYmTW9J1vqHIbPb26v6jwFARvg/Ffqsrr4XoaQ8Z+IZLUo=
X-Received: by 2002:a92:cd8c:0:b0:2c7:e86b:5139 with SMTP id
 r12-20020a92cd8c000000b002c7e86b5139mr118285ilb.144.1648825308615; Fri, 01
 Apr 2022 08:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220401072714.106403-1-krzysztof.kozlowski@linaro.org>
 <1648818806.914066.2864970.nullmailer@robh.at.kernel.org> <2d124d53-1f36-5315-3877-af8f8ad5f824@linaro.org>
In-Reply-To: <2d124d53-1f36-5315-3877-af8f8ad5f824@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 1 Apr 2022 10:01:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJxZZVpregyGK93oKd6KMfhGXVjNYWYhoUZiPJXjELTxQ@mail.gmail.com>
Message-ID: <CAL_JsqJxZZVpregyGK93oKd6KMfhGXVjNYWYhoUZiPJXjELTxQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: gpio: add common consumer GPIO lines
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 8:27 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/04/2022 15:13, Rob Herring wrote:
> > On Fri, 01 Apr 2022 09:27:14 +0200, Krzysztof Kozlowski wrote:
> >> Typical GPIO lines like enable, powerdown, reset or wakeup are not
> >> documented as common, which leads to new variations of these (e.g.
> >> pwdn-gpios).  Add a common schema which serves also as a documentation
> >> for preferred naming.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Changes since v2:
> >> 1. Correct email.
> >>
> >> Changes since v1:
> >> 1. Select-true, add maxItems and description for each entry (Rob).
> >> 2. Mention ACTIVE_LOW in bindings description (Linus).
> >> 3. Add allOf for pwrseq reset-gpios case.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  .../bindings/gpio/gpio-consumer-common.yaml   | 64 +++++++++++++++++++
> >>  1 file changed, 64 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.example.dt.yaml: rt4801@73: enable-gpios: [[4294967295, 2, 0], [4294967295, 3, 0]] is too long
> >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
> >
>
> Hi Rob,
>
> With v1, you proposed to use maxItems for all these standard gpios, but
> as we see here there are two exceptions:
> 1. pwrseq might have up to 32 reset-gpios,
> 2. richtek,rt4801 uses up to 2 enable-gpios.

There's always an outlier...

> One way is to add exceptions in gpio-consumer-common.yaml, like I did
> for reset-gpios and pwrseq. However this scales poor if more of such
> usages appear.

I'd reject any new cases, but even just 2 I don't really like.

> Maybe let's drop the maxItems for all of them?

Let's just drop it at least for now (though it seems we can keep it
for powerdown-gpios).

A possible solution here may be adding 'maxItems: 1' automatically to
schemas if not specified. I've been thinking of doing this on standard
unit properties. That's another case of
99% of cases are a single entry with a few outliers.

Rob
