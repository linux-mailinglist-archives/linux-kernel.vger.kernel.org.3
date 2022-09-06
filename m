Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899B85AEE57
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiIFPHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiIFPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:06:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C936F31EC6;
        Tue,  6 Sep 2022 07:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD3C6153A;
        Tue,  6 Sep 2022 14:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A209C433B5;
        Tue,  6 Sep 2022 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662474005;
        bh=j6JrfRaniZkG8XDwvLbMp+eQR1Ik9H5eUd1vOPVqvsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n62GbgH/vS+CBFhlOCS1m9FvfeO3rcbHG+xSZbe2i/ez3g7jnZx3gsAzFO+CT2DbX
         OGML5PJckxnz526tRsZ8RNEjIW/+3wYN9AqkFFFPWXDytK9KtUGKQQxqR4O2ljp5K8
         /pR7u0cU+QU+1TZumjEmNeUthOXC4rypl+NZgbVYHhjzYK2RKDnDG5GhgxJFgm6bEc
         US0EK6k3Htlfywyu9jMiueyz4JZ9VUcpc4lVhuU1tHWVzKKERHPShey5mL76qhKHS2
         g3+T862C0Oe/k0a1yrSPVfLYnLa4siAFy32Za6KDM/IDkjBQJcaNIOcQQXhA9vlxSW
         Ay8Iu4Kw57+mw==
Received: by mail-vs1-f43.google.com with SMTP id 67so11837625vsv.2;
        Tue, 06 Sep 2022 07:20:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo0NEnNdQF2eey6xYwYCdzF/yJTp3zvX29BYM2/mUcmMoAidrM+e
        YV3FmOb9Vd1B+bgbLD2PCRvGnsMrLR5U7uZ/7g==
X-Google-Smtp-Source: AA6agR5m1ZEcDopFt39ntHgsvsjFoHVh5uUiID70c/HLxGHEvCBETjaPqeniS+moT1V69c8cUOhuGWhzf1sRJrxX2RA=
X-Received: by 2002:a05:6102:3123:b0:390:d9f3:2a9f with SMTP id
 f3-20020a056102312300b00390d9f32a9fmr13533513vsh.6.1662474004545; Tue, 06 Sep
 2022 07:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
 <20220906082820.4030401-2-martyn.welch@collabora.co.uk> <Yxc6zptiJEf2TzP5@smile.fi.intel.com>
 <CACRpkdZHKEW+WJAdCCf2DN7gN+ZM7pFpeSXfccB508N4=-LkoQ@mail.gmail.com>
 <YxdI/TLBrzJP3RKi@smile.fi.intel.com> <CACRpkdaQ+0wbreyCEaoBnjKT0rtgPEnotZQw_Eh=y4xktwrwHQ@mail.gmail.com>
In-Reply-To: <CACRpkdaQ+0wbreyCEaoBnjKT0rtgPEnotZQw_Eh=y4xktwrwHQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Sep 2022 09:19:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJru+ajo4zqsAHeXUsvGDE_S0k3H7q4d3PvCYV4Qexa_w@mail.gmail.com>
Message-ID: <CAL_JsqJru+ajo4zqsAHeXUsvGDE_S0k3H7q4d3PvCYV4Qexa_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: gpio: pca95xx: add entry for pcal6534
 and PI4IOE5V6534Q
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 8:33 AM Linus Walleij <linus.walleij@linaro.org> wro=
te:
>
> On Tue, Sep 6, 2022 at 3:20 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Sep 06, 2022 at 03:08:00PM +0200, Linus Walleij wrote:
> > > On Tue, Sep 6, 2022 at 2:19 PM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Tue, Sep 06, 2022 at 09:28:16AM +0100, Martyn Welch wrote:
> > > > > From: Martyn Welch <martyn.welch@collabora.com>
> > > > >
> > > > > The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the PCAL=
6524. The
> > > > > Diodes PI4IOE5V6534Q is a functionally identical chip provided by=
 Diodes
> > > > > Inc.
> > > >
> > > > ...
> > > >
> > > > > +    oneOf:
> > > > > +      - items:
> > > > > +        - const: diodes,pi4ioe5v6534q
> > > > > +        - const: nxp,pcal6534
> > > >
> > > > ^^^
> > > >
> > > > > +      - items:
> > > > > +        - enum:
> > > >
> > > > > +          - nxp,pcal6534
> > > >
> > > > ^^^
> > > >
> > > > Not sure why is this dup?
> > >
> > > No that is how DT compatibles work. One version of the component,
> > > bought from NXP will look like this:
> > >
> > > compatible =3D "nxp,pcal6534";
> > >
> > > Another version bought from diodes will look like this:
> > >
> > > compatible =3D "diodes,pi4ioe5v6534q", "nxp,pcal6534";
> > >
> > > Then the drivers are probed matching from left to right,
> > > with the "most compatible" matching first.
> > >
> > > This also answers your question on the implementation.
> >
> > Then I don't understand why the const list above is only for new chips
> > and not for the old one where the same can be applied.
>
> That's YAML. It's because the const list is the most compact way
> to express two precise items following after each other, and the enum
> list is an implicit list of single-item const:s, as you cannot enum
> tuples.
>
> > Mysterious ways of DT...
>
> It's not DT, it's YAML that is mysterious. DT itself is a pretty
> straight-forward
> grammar, while YAML is a meta-grammar describing the DT grammar

Not YAML, but json-schema is the grammar. YAML is just the file format
and it's a JSON compatible subset of YAML (no anchors, refs, tags).

> (ML stands for Meta Language).

Huh? yaml.org says: YAML Ain't Markup Language=E2=84=A2

Rob
