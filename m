Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E025AE916
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbiIFNIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbiIFNIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:08:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D38742ACA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:08:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w2so15148442edc.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pmIp3UU7gjm3NZJhc2Tia9NiJ9p2MvdeXl6JkzY1omI=;
        b=cYalGkxwT9oVIPq949EPepQxvuKKZ4255Ukt4GTPcTVRMNtf81SXeSOV8lBdM9V5TZ
         4kyqsu9OpGyoGFFjH6CoB5XJsVNMa72I09YAEg4vmHSccD66gFMa/EV2EhsL325AhxFO
         MPxZgcwIs+5VTcmXZvNJMeBfiaxRJ99QvaRnpm75XFy5yx/ddSPuvhYgUlcan53fDeC7
         NBFA/IqTWWSy+AjILXG4bL+3y4L0WeSznMqy2RnaHd0Gh9AMoNcje+SdLjONGB3ODcCs
         t6ivHwiPWn3bJkob3F/72s4WYAnxtsM1XudLwcQRTtpx2O45W1CZ/zLXpGlxcmFIV2+5
         go2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pmIp3UU7gjm3NZJhc2Tia9NiJ9p2MvdeXl6JkzY1omI=;
        b=T7pvOuYC9uBv9xMHx5KkA/DkJdeNFLFPvOjL/REZZ//eQnAwf6kefuMgqBA8RF0wMu
         NpBjVFL2mMwCS0k4/KHT224bADFx9/DBN+zSVSuncVD5odZwxwin53M8a6DfYPjbrJci
         GwmsG5akQ+Y+wMBdJNetGb+I1vd7iutufl0sd3XJEEfpS+/VvZE0h9+IP4PGuu4IowuJ
         EzHcz0H3sUrsNss73xP9Qo1eIyfzYhl1xc4qBSJUd1HprsV+I17YGDwwW6cIndznTke/
         6uZsqZ4v71Nd/plmijv38D3qLMwdnvukHF3egUTef+uUyU4pSrGfOKfdpV7TMETA/3Yc
         C2kg==
X-Gm-Message-State: ACgBeo2z3hko6xzpvaxGGth0jh2Xh+qSnLke6Jc6/tgdKwhReKg78RQv
        pdOs3fpAbVtcAkNrBMK5+vm4G7YVs+ir9BKGvIcZ+g==
X-Google-Smtp-Source: AA6agR4W5ASdL40tjGKHYVNHqZ4SrzWB68wk56ZFao/XcWslDGqmL4caxI+vRCacz+8k50G5zb+kQJQWODULR428hEA=
X-Received: by 2002:a05:6402:2691:b0:43d:ba10:854b with SMTP id
 w17-20020a056402269100b0043dba10854bmr45661307edd.158.1662469691869; Tue, 06
 Sep 2022 06:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
 <20220906082820.4030401-2-martyn.welch@collabora.co.uk> <Yxc6zptiJEf2TzP5@smile.fi.intel.com>
In-Reply-To: <Yxc6zptiJEf2TzP5@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Sep 2022 15:08:00 +0200
Message-ID: <CACRpkdZHKEW+WJAdCCf2DN7gN+ZM7pFpeSXfccB508N4=-LkoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: gpio: pca95xx: add entry for pcal6534
 and PI4IOE5V6534Q
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Martyn Welch <martyn.welch@collabora.co.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 2:19 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Tue, Sep 06, 2022 at 09:28:16AM +0100, Martyn Welch wrote:
> > From: Martyn Welch <martyn.welch@collabora.com>
> >
> > The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the PCAL6524. The
> > Diodes PI4IOE5V6534Q is a functionally identical chip provided by Diodes
> > Inc.
>
> ...
>
> > +    oneOf:
> > +      - items:
> > +        - const: diodes,pi4ioe5v6534q
> > +        - const: nxp,pcal6534
>
> ^^^
>
> > +      - items:
> > +        - enum:
>
> > +          - nxp,pcal6534
>
> ^^^
>
> Not sure why is this dup?

No that is how DT compatibles work. One version of the component,
bought from NXP will look like this:

compatible = "nxp,pcal6534";

Another version bought from diodes will look like this:

compatible = "diodes,pi4ioe5v6534q", "nxp,pcal6534";

Then the drivers are probed matching from left to right,
with the "most compatible" matching first.

This also answers your question on the implementation.

Yours,
Linus Walleij
