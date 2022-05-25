Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86905533F39
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbiEYOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiEYOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:30:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3CE12AB9;
        Wed, 25 May 2022 07:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16B24B81DC3;
        Wed, 25 May 2022 14:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8BAC3411B;
        Wed, 25 May 2022 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653489036;
        bh=8HyHVyybo/0tZkV/fgwThFXRZPUG5Hduds4Oad/Ax4E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Seststo4IX6giDvmM3hP0SuPLNctoXJml402CKuZ1HVbxLTBQ1cLdWMJDV290f0/k
         adtTg915kQ+NfThzVKkEC5tuH7O/1bD5UN0TcxMRfSOE455CCDYdKmIv30G3XR2bN9
         sJWKO6NCjeik/v2ULR5a4AXJtUwXSn+YU/hNhc+gun1FZO4pPrJJgEw3P5A0hC3lTb
         ey2nOO6/wgaQvaKb1Fj6Vdg1o8cbyu6TjCL174F7VruyjRT9IvwVyF8A9MKdJCZbSJ
         PiSlXCPs26JARvoSNWRi+2E6BY32JXmMq0vYc/GxuKsti7sxbBZDV2maxADOEZrgpA
         aDu7mGKBDKjXg==
Received: by mail-ej1-f45.google.com with SMTP id f21so28395425ejh.11;
        Wed, 25 May 2022 07:30:36 -0700 (PDT)
X-Gm-Message-State: AOAM5316okwfWnWFLIss9rjqjr9ktar/S0BGiJw5+X3dcLCkPETQwSxJ
        rwWBRnb6dDoKsx6K7G2qxboqdsOxJo+qvtB/Tg==
X-Google-Smtp-Source: ABdhPJxJjLiunW5d2So/1U+3/Kl7ANSlIu+TXdQXon7zGOmAxDWIwpH2r+gIYlFBI5+GwQd36/nrkgYpz7pHo6jUMC4=
X-Received: by 2002:a17:907:2daa:b0:6fe:b449:6a8f with SMTP id
 gt42-20020a1709072daa00b006feb4496a8fmr22130827ejc.318.1653489034973; Wed, 25
 May 2022 07:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <b36280be-9993-9a78-0960-4094efeed1aa@linaro.org>
 <CAMuHMdWL93+r0cofwHKj1k-gUo9nk3OzUf6gtY68sK4JNibyNg@mail.gmail.com> <eb5ab9553c419b8259f5494664865597b6c5d4db.camel@infradead.org>
In-Reply-To: <eb5ab9553c419b8259f5494664865597b6c5d4db.camel@infradead.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 May 2022 09:30:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ49bnBe84PXYY6caN0rxEEgL=mcWqKktzbK94McgYNfw@mail.gmail.com>
Message-ID: <CAL_JsqJ49bnBe84PXYY6caN0rxEEgL=mcWqKktzbK94McgYNfw@mail.gmail.com>
Subject: Re: Getting rid of infradead.org - corrupted subjects
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mark@msapiro.net, workflows@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 4:55 AM David Woodhouse <dwmw2@infradead.org> wrote=
:
>
> On Wed, 2022-05-25 at 10:34 +0200, Geert Uytterhoeven wrote:
> > CC dwmw2
>
> Thanks, Geert.
>
> > On Wed, May 25, 2022 at 10:07 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >
> > > The address list is semi-random as I don't know whom to approach.
> > > Problem: infradead.org corrupts email subjects by changing:
> > > s/,/, /
>
> I found an old thread on mailman-users which appears to be claiming
> that it's just standard folding as described in RFC2822 =C2=A72.2.3.
>
> https://mail.python.org/pipermail/mailman-users/2007-May/057119.html
>
> 2.2.3. Long Header Fields
>
>    Each header field is logically a single line of characters comprising
>    the field name, the colon, and the field body.  For convenience
>    however, and to deal with the 998/78 character limitations per line,
>    the field body portion of a header field can be split into a multiple
>    line representation; this is called "folding".  The general rule is
>    that wherever this standard allows for folding white space (not
>    simply WSP characters), a CRLF may be inserted before any WSP.  For
>    example, the header field:
>
>            Subject: This is a test
>
>    can be represented as:
>
>            Subject: This
>             is a test
>
> But this is folding at a *comma*, not at whitespace. The original
> subject line was (in a single line):
>
> Subject: [PATCH v2] dt-bindings: mtd: jedec,spi-nor: remove unneeded prop=
erties
>
> ... and Mailman 'folded' it in the wrong place to:
>
> Subject: [PATCH v2] dt-bindings: mtd: jedec,
>  spi-nor: remove unneeded properties
>
> That *isn't* proper folding because it didn't happen at a whitespace.
>
> I do need to upgrade to Mailman 3 at some point; I've been
> procrastinating on the basis that it "ain't broke". For the time being
> I've just disabled folding in MM2 with a trivial hack:

Yay!!! I should have asked years ago...

Any chance the appending of footers can be stopped as it causes lore
to report duplicates and b4 dmarc attestation to fail?

Rob
