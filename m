Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFA655729B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiFWFhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFWFhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:37:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F7C3A18E;
        Wed, 22 Jun 2022 22:37:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o16so26298010wra.4;
        Wed, 22 Jun 2022 22:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGXOI1F+46h8g4CYNp3aLfgU6JLkNEaQBiU6ibgVVCA=;
        b=HM5idz5iSxToDddeGwp7+NN6Al4VcX+R7jrtS/k2TsBRWhI/QGJtgwP3onufqCCc3z
         +GcrPimFXvXtyXANf9Lw3XZQRt0ZX6p7MAQVn7u4LCbF8eeX34rVz5Lr4uwPjo0FGVmV
         +Pla3kF2YJWL9MdBWcbvFCwJV+EDL5FhwWick=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGXOI1F+46h8g4CYNp3aLfgU6JLkNEaQBiU6ibgVVCA=;
        b=3HWlFalGo+IEnPaD5qV6E8Xz8LnmH4fcuA5XiaV8cIHvBevvwxk/etzRDoNUDVMGSy
         qbdQVz2FlnlyLFvhCoxfzB7PQnsd4xCu5LV7Ff1C1J1CeMADURV9H47ZPZphn1cbEftw
         O0Vj+prgmLYI1UKI8Njc0SrPBS5/LS3L5HSAe/gynIPG6feMc8i652h73hmNWuj2ju+9
         PI4f+xlIdmH/kIPO7nFkPT1eSsA7aeWm7kVu+/bic3AzGCB6lLBf9HMtxQLhW9S/KttM
         Kahk+uHDxZ29uvVnmX1NlX+OYhkD/rCzPxgSLVjzqkghdaeFem7HCgA5WmiX38t6uU9y
         tjZw==
X-Gm-Message-State: AJIora+UVvooORjJPEklgnfSUr+FcRAv3NCLKLpinw6kkHBx3sPPQdHb
        jgKp67HGDztuju+mcd8l1IpRD9Yaa65FzUbvPZ7YqU3tovA=
X-Google-Smtp-Source: AGRyM1sxEHbUFDJd4uwqidyTn0y1zcbD7hXpM+WdCWUtTWrFlvDF18O6m2kSbaO+FuzsJc1bY0QH35P06L8HfegXYfw=
X-Received: by 2002:adf:e502:0:b0:21b:8de6:7f14 with SMTP id
 j2-20020adfe502000000b0021b8de67f14mr6224129wrm.3.1655962630277; Wed, 22 Jun
 2022 22:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-2-krzysztof.kozlowski@linaro.org> <0207c2fe-7c01-7852-3cd1-74297cd4857d@linaro.org>
In-Reply-To: <0207c2fe-7c01-7852-3cd1-74297cd4857d@linaro.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 23 Jun 2022 05:36:58 +0000
Message-ID: <CACPK8Xc=dmaJtLXGsQa8bBdWDnSbwyW3f_yaQr4HqT0WvyScRg@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: arm: aspeed: document board compatibles
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        David Wang <David_Wang6097@jabil.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Steven Lee <steven_lee@aspeedtech.com>,
        Ken Chen <chen.kenyy@inventec.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 at 11:06, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/05/2022 12:49, Krzysztof Kozlowski wrote:
> > Document all compatibles used in existing upstreamed Aspeed AST2400,
> > AST2500 and AST2600 based boards.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../bindings/arm/aspeed/aspeed.yaml           | 83 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 84 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>
> Joel, Andrew,
>
> Any comments on the series? Rob applied only patch 1, so the rest is
> supposed through Aspeed tree. Shall I pick them up and send to arm-soc?

I will take a look at them when it's time to send patches for the next
kernel release.

They should go through the aspeed tree like the rest of the aspeed
device tree patches.

Thanks,

Joel

>
> Best regards,
> Krzysztof
