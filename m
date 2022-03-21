Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063224E2186
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbiCUHqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344992AbiCUHqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:46:46 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB4C57B05;
        Mon, 21 Mar 2022 00:45:21 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d3so9811601ilr.10;
        Mon, 21 Mar 2022 00:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3CXgUQrDFjyBhF3xGf+VPGqW6vyWt/wdzgEUomBEfM8=;
        b=VhQiC6oqXDI2JPYyP/HiL1T9aohH7SjGGRMN0g1eBIEdtI5cPbw8Do1w8SgoITsroY
         0BT8+UBmO0mWqtSON0ZWDXkgg+eM/bskEzxadexSLP5z3XjNya1RvSbiLizdCjZUPqgH
         9ituta0NQWToQek5RRavQer4iwqyRZw10j9L/7ZwPIUzSTIF1RzkRz8IaGPhG+TFf2iF
         UtuK6x/b7uZR1ScgvzxdcJXr2e+ytY+Nx7CDV82KDfgM/EmyreGk7Vrckn1dAhMVPF6B
         23ZWmOcT3ZmaT+OqPEjiJPApG8M4WXtaMzLwxmgDOrzJu29DZ5QIMbqRK7L9A/t0UbBF
         Gzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3CXgUQrDFjyBhF3xGf+VPGqW6vyWt/wdzgEUomBEfM8=;
        b=xqZUZySmXQOL3DlNTJcmZWFST2OU2ou3VTVhoFQYP1LYcQ+SaOv0wYaHlIm75imgDd
         A50kmZK4ySuiAC8jH7pWq3sIZHOJ4bwDez55qpICphPdvAkkr4u8n0Tu24wz4JDsVzrL
         qfftfdJb/XY5Ux9/bB/PJTW9DiMw6PMo0DPnaZ7GIsYymgQdsx4RGPsgHQsxfCx7hOfj
         K8LVby8yNHT6g1LXRfGQNcC1sURgsucO+Ryq5xIXvio7ZhHj4vvzlpZLlr7b/OS4MDvA
         Jtf1JFCvH+DLjKfcxtoulqylvb4dxDBpq8OCJefKn/E5cEy102EP22UgLcptN8ChGCxn
         pQWA==
X-Gm-Message-State: AOAM531VTypidW8r+aMx418tbnGUM1lvRBF4TUJCJ5lVu/+bgCVHdala
        pJ6AeI1KKOvo/1fw+ZbTaxiNBSiYtFSljZLKysc=
X-Google-Smtp-Source: ABdhPJwaGS+sDRZCG6ImECVKDheTmeON01D/r8EEoupK08iGme6jIPoP0UsVKzUv5Tdf8UQMcEXknPEzSCt+4eJKP6w=
X-Received: by 2002:a92:6012:0:b0:2bd:fb5f:d627 with SMTP id
 u18-20020a926012000000b002bdfb5fd627mr9211249ilb.86.1647848720745; Mon, 21
 Mar 2022 00:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220124121009.108649-1-alistair@alistair23.me>
 <20220124121009.108649-3-alistair@alistair23.me> <CAMuHMdVNgVQzjrdybbnfCEr+G5Q4ztjRCC29RF9HwGnhKkPn3Q@mail.gmail.com>
 <CAKmqyKOnezw8_dDY-c69F77KVxmb-C3t=N3H23GurKbrxWDAgg@mail.gmail.com>
 <CAMuHMdVy4E1pX+VLLq_05FX4pM+BPZycQgn68ArGh2s8qL24=w@mail.gmail.com> <7792b3b6-e196-c3c7-5875-9eb4da488a95@roeck-us.net>
In-Reply-To: <7792b3b6-e196-c3c7-5875-9eb4da488a95@roeck-us.net>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 21 Mar 2022 17:45:00 +1000
Message-ID: <CAKmqyKO2x0V6p8LVsgq54f1KcghVhW2jw6zmUOFxbf6Zh+0BNA@mail.gmail.com>
Subject: Re: [PATCH v18 2/8] mfd: simple-mfd-i2c: Add a Kconfig name
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Alistair Francis <alistair@alistair23.me>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
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

On Sun, Mar 20, 2022 at 12:48 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/19/22 02:28, Geert Uytterhoeven wrote:
> > Hi Alistair,
> >
> > On Sat, Mar 19, 2022 at 3:36 AM Alistair Francis <alistair23@gmail.com> wrote:
> >> On Tue, Mar 8, 2022 at 8:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>> Thanks for your patch, which is now commit bae5a4acef67db88
> >>> ("mfd: simple-mfd-i2c: Add a Kconfig name") in mfd/for-mfd-next.
> >>>
> >>> On Mon, Jan 24, 2022 at 1:24 PM Alistair Francis <alistair@alistair23.me> wrote:
> >>>> Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
> >>>> device so that it can be enabled via menuconfig.
> >>>
> >>> Which still does not explain why this would be needed...
> >>>
> >>>> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> >>>> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> >>>
> >>>> --- a/drivers/mfd/Kconfig
> >>>> +++ b/drivers/mfd/Kconfig
> >>>> @@ -1188,7 +1188,7 @@ config MFD_SI476X_CORE
> >>>>            module will be called si476x-core.
> >>>>
> >>>>   config MFD_SIMPLE_MFD_I2C
> >>>> -       tristate
> >>>> +       tristate "Simple Multi-Functional Device support (I2C)"
> >>>>          depends on I2C
> >>>>          select MFD_CORE
> >>>>          select REGMAP_I2C
> >>>
> >>> The help text states:
> >>>
> >>> | This driver creates a single register map with the intention for it
> >>> | to be shared by all sub-devices.
> >>>
> >>> Yes, that's what MFD does?
> >>>
> >>> | Once the register map has been successfully initialised, any
> >>> | sub-devices represented by child nodes in Device Tree will be
> >>> | subsequently registered.
> >>>
> >>> OK...?
> >>>
> >>> Still, no clue about what this driver really does, and why and when
> >>> it would be needed.
> >>>
> >>> There is one driver symbol that selects MFD_SIMPLE_MFD_I2C.
> >>> There are no driver symbols that depend on this symbol.
> >>>
> >>> If you have a driver in the pipeline that can make use of this,
> >>> can't it just select MFD_SIMPLE_MFD_I2C, so the symbol itself can
> >>> stay invisible?
> >>
> >> My patch "mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a"
> >> allows using this driver for the silergy,sy7636a MFD. So it's nice to
> >> be able to enable and disable it as required.
> >
> > So after that patch, enabling MFD_SIMPLE_MFD_I2C will enable
> > support for an ever-growing random bunch of devices, none of which
> > is described in the help text?
> > To me, ghat doesn't look like the way to go forward...
> >
>
> I am probably missing something. Why not something like the following ?
>
> config MFD_SY7636A
>          tristate "Silergy SY7636A voltage regulator"
>          depends on I2C
>          select MFD_SIMPLE_MFD_I2C
>          help
>            Enable support for Silergy SY7636A voltage regulator.
>
>            To enable support for building sub-devices as modules,
>            choose M here.
>
>
> This would be quite similar to MFD_SL28CPLD which essentially does
> the same (and, unless I am missing something, doesn't have its own
> driver either). Sub-devices would then depend on MFD_SY7636A.

That's fine with me.

As you said this patch is already in the mfd/for-mfd-next tree, should
I resend the series?

Alistair

>
> Guenter
>
> > Gr{oetje,eeting}s,
> >
> >                          Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                  -- Linus Torvalds
>
