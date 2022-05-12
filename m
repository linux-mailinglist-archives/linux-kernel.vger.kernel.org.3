Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4628E5253F7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357211AbiELRoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353035AbiELRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:44:05 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FF06E8DD;
        Thu, 12 May 2022 10:44:05 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y76so11170553ybe.1;
        Thu, 12 May 2022 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dV6HUB7SxpjK+7mBEuOiLof9qR8uoa5I2hxfC6B+U0=;
        b=V0BWORNUjzvdj7VCoVnOtF+BzEUkQT/FPg3TIY4oQR/ngKTsDne6/7cO1iY7svOI/c
         J3vw05flqg8wbznzwHXi8paRcDRGowDTt0vkoicwau9AWyFe1p4je/pJyOW8gaDDyl7B
         nbHkFN25tMl0xIij0PQsyFekN/u4+4n4oer8I+2t6TeWF8OGPT8FcV2D7JpQg1iPdC3a
         ihAM/FPGEUlJ6N3Zrl3QGIsOCAfqy2l7ZBIzYAtrOZjf1ZswvQZ/iiRL27rC0XkRP3l1
         6JwoGxlp+ZZ3VwxLdH0PXb05IvXvlRYQCLdJ7vaZvFDKRGjN5rgumo/TqjW1WR2cWAOw
         nAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dV6HUB7SxpjK+7mBEuOiLof9qR8uoa5I2hxfC6B+U0=;
        b=VQ9834yQ3jglJPEpdosW9Xok+O+gRNHz8OBVRHZatB2fiRpanOBh3p8yROWJL8Ui5V
         Bhf1VBxXQGl+ru/oq8SDbyP4HRyXsWA8+IOV5HysADH0OduCTZMHxbYkzG+LASZn178F
         4auwaaJH4wLBHtYtm1JdvEKPd9NIkUyYXmtRYCMgpV39TqXz3Y7Vl3BWyrVDkrVg+M5y
         39jFab5wyiCwEcpKkQPSEuFGQEBoaOYr/G+2nSigKRe7VViEV+KeMw9EI0SHGDD8vKLM
         SH1mRAWw6JP2Z2aWLEghcML8Nyq1SolWyBNSX0y2xHT7GtOFiA3uy2pXOZlS+T8o+SVM
         y6Xg==
X-Gm-Message-State: AOAM533MulTvnb/BPoTJdFfb4OmnhapnL+G2CKcWHUxwZOr/Ln714aLs
        rxzvaQ4YV1T9QIZXGREAJaUw5ny8m9yrB+f1J2I=
X-Google-Smtp-Source: ABdhPJy1WwkC5EbZMV5JPFIASaM/e60AvOA4texGRaJe7EsXmlzHKWzVwopGa+RtsniYx0rlTvcvSI8zzJwoVRF4llo=
X-Received: by 2002:a25:bfce:0:b0:648:963b:1ccb with SMTP id
 q14-20020a25bfce000000b00648963b1ccbmr951675ybm.417.1652377444242; Thu, 12
 May 2022 10:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB59221ADFC86483FE2C8765C486CB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59221ADFC86483FE2C8765C486CB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 12 May 2022 18:43:37 +0100
Message-ID: <CA+V-a8s4RfNSXCHG5xo4LhkHw09aj2wFnH0iCDos_ysunV1+5g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

Thank you for the review.

On Thu, May 12, 2022 at 6:35 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch.
>
> > Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
> > handle GPIO interrupt
> >
> > Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
> >
> > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be used as
> > IRQ lines at given time. Selection of pins as IRQ lines is handled by IA55
> > (which is the IRQC block) which sits in between the GPIO and GIC.
>
> Do we need to update bindings with interrupt-cells on [1] like [2] as it act as parent for GPIO interrupts?
>
Yes interrupt-controller and interrupt-parent needs to be added. I'm
wondering if "interrupt-cells" is not required. If the pin is an
interrupt it will be passed as an GPIO.

@Geert - your thoughts ?

Cheers,
Prabhakar
