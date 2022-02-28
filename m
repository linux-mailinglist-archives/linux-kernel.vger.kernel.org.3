Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC24C62C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiB1GH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiB1GHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:07:54 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC25C36B;
        Sun, 27 Feb 2022 22:07:13 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id t28so8091368qtc.7;
        Sun, 27 Feb 2022 22:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dX1IYuv+pKoE5RWQMebZf9zpCqSCm/Io5TiFn1oToxU=;
        b=UJLrcu+KI8inQtMLqAneJSCusa/UZBrkhLT4UfuM574uAB9MAt84mJh8YJmOeo1pH2
         fkeZvXwH8jtTmOzk/IQITotZ0akAy9IiDX/cFqmSi8zlPw8AdfG7hVTJAZG0cGaVnJ0Z
         fDcaGovRGGCqNQcL3V8LQZjLAsWfeOL1Bs6XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dX1IYuv+pKoE5RWQMebZf9zpCqSCm/Io5TiFn1oToxU=;
        b=f8l7G0zN0luwZR+vSYoxMiPRVJHZ07usxupVwNoF405BQizaxgIuTvHOp9/Jsu48m/
         X6vrRWwdswNq3fY4e80Fl94qiVJCXdcSqCy8jF5eRdSCsonDAeL2Hk6bsegaw07WQy/s
         A8A/Grp/HREco8qrMksqEIH9x28lSYNXiwpUzMcOY9i0cQtHAWEt6LuVdFfrXvvMp7bo
         KzmWzGqOB8bjuWLWfmFsCjhuJNvfc166JE9gXzB7VsAAMYWlJgMI0SquElFtbpopke87
         yE2WUZLhIuTgkJiKnRVcVkr+ksPQWPjEEJAWQMU7coSJXHX3PWRt+HeYd//rKurYMW7n
         1tnQ==
X-Gm-Message-State: AOAM532ToqAFcf0P5/gmif3Y8qUsD4yHlku4dodrCur8gm5tNYnebulw
        Z3UbG0SiQMA3i0SiaX6njQT/+A61TPHlhbT52wyRxAAmfSpZCw==
X-Google-Smtp-Source: ABdhPJwx6e/7afLlxfw9imZxLs7kaRmaUVuH7jsAW+iB4UW00tnsvFIFNSUOuVEkA/Ke6pPE4HgOwn0IBfi1momwe5k=
X-Received: by 2002:a05:622a:283:b0:2de:b3a2:b52d with SMTP id
 z3-20020a05622a028300b002deb3a2b52dmr11796494qtw.625.1646028432862; Sun, 27
 Feb 2022 22:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20220214094231.3753686-1-clg@kaod.org> <20220214094231.3753686-2-clg@kaod.org>
 <20220225073155.f2cxfhm7surf34d4@ti.com> <688b7a65-d4b6-682b-494a-1d4178699dba@kaod.org>
In-Reply-To: <688b7a65-d4b6-682b-494a-1d4178699dba@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 28 Feb 2022 06:07:01 +0000
Message-ID: <CACPK8XeCfLmEJSLV6q5BLpCVztzG3dZehCgqrjgrNr7LaOiReQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] mtd: spi-nor: aspeed: Rename Kconfig option
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, 27 Feb 2022 at 18:50, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 2/25/22 08:31, Pratyush Yadav wrote:
> > On 14/02/22 10:42AM, C=C3=A9dric Le Goater wrote:
> >> To prepare transition to the new Aspeed SMC SPI controller driver usin=
g
> >> the spi-mem interface, change the kernel CONFIG option of the current
> >> driver to reflect that the implementation uses the MTD SPI-NOR interfa=
ce.
> >> Once the new driver is sufficiently exposed, we should remove the old =
one.
> >
> > I don't quite understand the reasoning behind this. Why keep the old
> > driver around? Why not directly replace it with the new one? Does the
> > new one have any limitations that this one doesn't?
>
> No. The old one has more limitations than the new one. The old one in
> mainline is half baked since we could never merge the necessary bits
> for training. We have been keeping a full version on the OpenBMC tree.
>
> Joel, could we simply drop the old driver in mainline and keep the old
> one in the OpenBMC tree until we feel comfortable ? I guess we need
> more testing.

I would answer Pratyush's question with: the old one is well tested,
and the new one is not. We would intend to keep the old one around for
a release cycle or two, and once we're confident the new one is stable
we would remove the old.
