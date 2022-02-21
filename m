Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AF64BD848
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbiBUIc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:32:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbiBUIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:32:25 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24CD26E2;
        Mon, 21 Feb 2022 00:32:02 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id t21so9334723qkg.6;
        Mon, 21 Feb 2022 00:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fe2hsCdbxN1ij2HP4oggs60CZPKRq8in1lb+QkY/nqo=;
        b=nikTB4nTPSIHaAbZaqKeqIYB7Ip1n/OvgN5AE9hLz08d3EyLVRH+LyoKfDvR26SUeP
         Ggwo7azjtYWZPev4HZPO/g0Ui/r1WmrpyJjFJajqDyxGO69+PUxjfPigsPECfz/c/mKU
         0hH5vzvYZBaxGDXFAyf2FiKGkvc+g3GP53Bz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fe2hsCdbxN1ij2HP4oggs60CZPKRq8in1lb+QkY/nqo=;
        b=JF3WrqTxH3I5FaV41gaEPOe646Uysg4h+GnXjq4drjwWhm33Y/zP+Gfz7OOKfLlG0D
         hjN1NNA977ARYOaeb/Wyc0te+elvjw5G7iIo3xX+PaQZfUr7b8qduRDN59QrJU8FGdWu
         N1BXy/z4lzm49LW5oTDBC1eqjWbtLRC6qgq5YVEXHwJ99MsTckn10j3+nqNv70SWyCJ4
         A6Hqlx1GD/+P2E77Xpwv133nzHtKu1lvreyraD4LyDXhiyNqEhmZ8cXvPB9WncP/s56A
         z3WRXlZUKCQR8buncJSYW7I6iQ464BRwBUsVTzDh1Y41bgk7DEUcaPMSZeH2zvb1mJcQ
         HoeQ==
X-Gm-Message-State: AOAM532Jxfxuk3xaS4bbL1wo26SmDs1UCy7zz+FWlXQ9g1cfhf194r77
        ROaGLqmE9nQ7s+1l97MiS1kkIsqKuUrYg2N4ycqIVPr+6eAx4A==
X-Google-Smtp-Source: ABdhPJybHDR+rwS5BataoX0weUhRuleDucNLDhHs+gIIGUgBpftAAxgiThB8021yyAhm964JoV33b5jxB2TzSNca8W4=
X-Received: by 2002:a05:620a:29ce:b0:648:ad12:789 with SMTP id
 s14-20020a05620a29ce00b00648ad120789mr5644170qkp.347.1645432321827; Mon, 21
 Feb 2022 00:32:01 -0800 (PST)
MIME-Version: 1.0
References: <nick.hawkins@hpe.com> <20220216153632.40981-1-nick.hawkins@hpe.com>
 <CAK8P3a0NmyxrzxgfwfDXuFvhmc3OL_-yBj8PDdEHh-2qm4NVkw@mail.gmail.com>
 <PH0PR84MB17185157544CFEB1D8AE267088359@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1HuTMt5WmOw3aQcLwGZd_WQ5nsKZ2HFDPQ0CHFvKsygA@mail.gmail.com>
In-Reply-To: <CAK8P3a1HuTMt5WmOw3aQcLwGZd_WQ5nsKZ2HFDPQ0CHFvKsygA@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Feb 2022 08:31:49 +0000
Message-ID: <CACPK8XdXV4j=0kYbEJRki9ug6VeeK02ZrXRgqFd9gUu6kSpA=Q@mail.gmail.com>
Subject: Re: [PATCH] [v3] arch: arm: boot: dts: Create HPE GXP Device Tree
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>
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

On Wed, 16 Feb 2022 at 16:51, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 16, 2022 at 5:29 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:

> > > +
> > > +               vrom@58000000 {
> > > +                       compatible = "mtd-ram";
> >
> > Same thing here, "vrom" is clearly not a standard name.
> >
> > NH: VROM is a Virtual ROM device that we use to create a memory mapping of a SPI flash content copy that is served to a host system. How should I rename it?
>
> Not sure, I don't remember seeing this case so far. Adding Joel to Cc,
> maybe he knows of
> another BMC that does the same thing.

We have something similar. The aspeed systems map this over LPC, using
FW cycles (aka memory accesses) over the LPC bus to read from the
BMC's SPI NOR devices, or DRAM.

The device tree bindings we have are in the LPC document:

 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml

It's the aspeed,ast2400-lpc-ctrl specifically. It takes a phandle to a
reserved-memory node.

The kernel driver is at drivers/soc/aspeed/aspeed-lpc-ctrl.c. It
exposes a character device that allows userspace to read and write to
the memory window.

We have this very aspeed specific design because it was the first
implementation in the kernel. Where possible, we should create a new
unified API for doing this type of access, where each BMC can
implement a backend. Now that we have GXP, Nuvoton and ASPEED it
should be easier to pick out common functionality.

Cheers,

Joel
