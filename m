Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528125329CF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiEXL5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiEXL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:57:35 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6025A62BD8;
        Tue, 24 May 2022 04:57:34 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b4so3394953iog.11;
        Tue, 24 May 2022 04:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIAXXXRwo1YYdT9BrP9x6eL1UouOtf5nysexYYh5ocs=;
        b=RZi92208R6ZRLaqgjJ35GcMxLld23k/r9kHNFWbPbdA6ButLl2XPyd9axlRNARHviQ
         SXBtr2LoqecHLoFxKSOzat2OmCJuPwf245P8WAx8fhG13Y2b6kkIBFu11X/QWQVvHblb
         bgkQ4C5Sl3rb9K/2X1wsR7+yuxnztqQFxJZYrZbzKCR6XDMGj21cuEmYA6/GJ5nWWRPP
         rp7Xgr+GSuPbGkB81uJqSkXVJa4xgBl8G3Lp2zHdNya6S0MYS3+0fP7wrfVqAxoK76Zt
         Oi64nxv+CcS/JlJt9PsSdqgiuk2xkbJQHqU8agqzacivXOS4nofqzU0mTkqDnvDZ9hGd
         pT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIAXXXRwo1YYdT9BrP9x6eL1UouOtf5nysexYYh5ocs=;
        b=uwrerqdnvJjzuN80DeWJNPBsOjoTwEbYNHXsuxOdal3pWakSduNGbIKpung41OjYTP
         G07rJi29DBSC2KShCBuhsUWrqpbI/5rZrBZ6/vuYD6LFcW8QvQc2IYGXitFI8r6Qnc0G
         nVfYTbAee7L4v7nm6rOynKQptTYUK/hUbMyIMhdj8i8slMi/PIzj35qWa4Gcc0p+my83
         wUt8zIHMCVk+t8qBoit9INgrkjGZ1cZgYfCuA4RaqWP7eZzeelwCn+8mn+iR6v8iuMhB
         v/FX4AkYhQ1e02I5d1ud1h+yl5y6EMVHQFpoavrUHVQExjJJxuuhhYHT/ZtwW2R2Z5Lz
         5LnA==
X-Gm-Message-State: AOAM533HscE5njfNiwvR0Y9iTjbOK/4oKeL/yfRs8aVqtwCzfWZSR+ov
        nVTtJyCBv7kaeK/5rhOupSBPiRZfhEdgWBjfzY0=
X-Google-Smtp-Source: ABdhPJwgkWUFiDvAjFIEaXbe+SSxraGzllK9weXeN8GA2IY0gLlrSCYsidO8nXwFSbttdncy3ecz91vvYjUQD3KE63A=
X-Received: by 2002:a05:6638:498e:b0:32e:be76:f908 with SMTP id
 cv14-20020a056638498e00b0032ebe76f908mr5837862jab.66.1653393453532; Tue, 24
 May 2022 04:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220323120021.361137-1-alistair@alistair23.me> <CAKmqyKP5CRDx4acc6yg9SwADaGTNqKmDUrBs2ODXR30OZuunoA@mail.gmail.com>
In-Reply-To: <CAKmqyKP5CRDx4acc6yg9SwADaGTNqKmDUrBs2ODXR30OZuunoA@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 24 May 2022 21:57:07 +1000
Message-ID: <CAKmqyKOijPJVcRZ93r+Nx_YvoZup4omi7MtKog_Jxg2yuQJPSA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Add support for the Cypress cyttsp5
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:25 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, Mar 23, 2022 at 10:00 PM Alistair Francis
> <alistair@alistair23.me> wrote:
> >
> > This patch series builds on top of [1] and adds support for the cyttsp5
> > touchscreen controller for the reMarkable 2.
> >
> > I first tried to add an I2C HID device. Although the cyttsp5 has some HID
> > looking aspects it is not HID compatible. Just in trying to probe the device
> > I found:
> >  - The HID descriptor has extra padding
> >  - The HID descriptor sets the high bytes of the descriptor length
> >  - The HID descriptor has extra unrecognised tags
> >  - The HID reset command doesn't appear to work
> >
> > I don't think there is a way to use the I2C HID framework with the cyttsp5.
> > For anyone interested you can see the work here [2]. In that branch though I
> > can only obtain a HID descriptor, nothing else works without more core
> > changes.
> >
> > So instead I rebased the series from [1]. Converted to the new yaml DTS
> > documentation, added regulator support and fixed a x/y miscalculation bug.
>
> The DT bindings have been reviewed, any comments on the driver
> implementation? It has been tested on a few different devices

Any comments? It would be great to try and get this in 5.19

Alistair

>
> Alistair
>
> >
> > 1: https://lwn.net/ml/linux-kernel/20180703094309.18514-1-mylene.josserand@bootlin.com/
> > 2: https://github.com/alistair23/linux/commits/rM2-mainline-cyttsp5-hid
> >
> > v7:
> >  - Fix device tree warnings
> > v6:
> >  - Use reg for the button properties
> > v5:
> >  - Address review comments from v4
> >
> > Alistair Francis (4):
> >   Input: Add driver for Cypress Generation 5 touchscreen
> >   dt-bindings: input: Add Cypress TT2100 touchscreen controller
> >   ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
> >   ARM: dts: imx7d-remarkable2: Enable the cyttsp5
> >
> >  .../input/touchscreen/cypress,tt21000.yaml    | 101 ++
> >  arch/arm/boot/dts/imx7d-remarkable2.dts       | 100 ++
> >  arch/arm/configs/imx_v6_v7_defconfig          |   1 +
> >  drivers/input/touchscreen/Kconfig             |  16 +
> >  drivers/input/touchscreen/Makefile            |   1 +
> >  drivers/input/touchscreen/cyttsp5.c           | 902 ++++++++++++++++++
> >  6 files changed, 1121 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> >  create mode 100644 drivers/input/touchscreen/cyttsp5.c
> >
> > --
> > 2.35.1
> >
