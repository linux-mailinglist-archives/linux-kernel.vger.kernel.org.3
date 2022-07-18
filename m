Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B4F578108
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiGRLjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbiGRLjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:39:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2292704;
        Mon, 18 Jul 2022 04:39:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m8so1395959edd.9;
        Mon, 18 Jul 2022 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WM+zWzeYAitwMFZLUVsc8lp6MA3Zpo/kJcizrD/8ssk=;
        b=OvcuKUIjR4uhqpfL8lpsxLQ88mCYxcDOZ5lSaz8YMU5SyNSpWm2LhWIoS9CC+qDuiX
         DI/fnwo811XGeH4U+R290EOyJleoAHOZMLhaBd4hEdDGJHO0ZVerBEE3gVl6te9BpcT4
         KyyXCEIlVZI9vzIm3Fjqb3WD+Kz4vqa72ux+kIiV8AtKAdtI87dFPLp0/j+Mpfxof+su
         lev/A8157qmlXkCgs9+5cRS0ruqiTC3/PHuZcO3JHcb+eMLKX823Z/MyUYWDhywL+lc6
         ZEQD7h68BhRbIcXy5EQnFOo4JXLrkrtrSYjrBnXa5BTwwYZFNpiLwNcI86j6oai3JcHf
         Kb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WM+zWzeYAitwMFZLUVsc8lp6MA3Zpo/kJcizrD/8ssk=;
        b=ZPzABo93bnWSf4CHpIJ+mtevlCaIMyi7sdL5NY4HacH09HwL/vR97GBSlDS+1DG8rV
         erOe41DsfrcUEupmTUtssvzTrh1gKVWrWy0VFcWJvVKMRSfCcEkkBuQAMn44WF313Y9R
         arEIWomj3UU/9Ovtv6mkXJoewEKSYBA4AbafY23LQuwrKOyuemF3J6NIBha+d7+Ld/54
         F6dasTaUobv1LSoXbrt4+9VnLcnQjtNZl3h86Yc3dynIom83ihN96OQTJvXPB/hyXR7c
         QpcNqr2IeD72plYgLjRyitIL06HvknE1D7W8WYrlYG6JuMcD7NNYZPyEBZODQ7ekPGDh
         GdGw==
X-Gm-Message-State: AJIora/VW1UdhFwT2CeR9JblilLwjoIjTf3Bf7NsF//p2OnvnZF/o1EY
        2XgXIlJJtj44+Fcj+HE7hdoVxBc8a4VUQoJ6dcE=
X-Google-Smtp-Source: AGRyM1uLSUr+2lvxiCg3cwvu9VMJCLD+uDi8ZOzhv3dgH0XROSPP5YW44n0Pb3saV+i0UvUB6nImoWisC6NYG7PACSY=
X-Received: by 2002:a05:6402:34c5:b0:43a:8f90:e643 with SMTP id
 w5-20020a05640234c500b0043a8f90e643mr35599070edc.88.1658144351737; Mon, 18
 Jul 2022 04:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220715112607.591-1-peterwu.pub@gmail.com> <20220715112607.591-9-peterwu.pub@gmail.com>
 <CAHp75VdCgdTOu-CdNo9XGY+PrhPh93v_CkAHJC6hkArsKeiXbA@mail.gmail.com> <20220718080831.GA31509@cyhuang-hp-elitebook-840-g3.rt>
In-Reply-To: <20220718080831.GA31509@cyhuang-hp-elitebook-840-g3.rt>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jul 2022 13:38:35 +0200
Message-ID: <CAHp75Ve2_UcS9e3pJC2j4FBc21=S8878tQusyxNV1mXtQG423w@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] usb: typec: tcpci_mt6370: Add MediaTek MT6370
 tcpci driver
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:08 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> On Fri, Jul 15, 2022 at 03:10:42PM +0200, Andy Shevchenko wrote:
> > On Fri, Jul 15, 2022 at 1:28 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:

...

> > > This commit add support for the Type-C & Power Delivery controller in
> >
> > This commit add -> Add
> >
> Upper case? Or rewrite it as 'This commit is to add .....'?

Please, read this documentation [1] for better understanding. It
should clarify this and perhaps other possible questions.

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> > > MediaTek MT6370 IC.

...

> > > +       ret = devm_request_threaded_irq(dev, priv->irq, NULL,
> > > +                                       mt6370_irq_handler, IRQF_ONESHOT,
> > > +                                       dev_name(dev), priv);
> > > +       if (ret) {
> >
> > > +               tcpci_unregister_port(priv->tcpci);
> >
> > This is wrong.
> > You mixed devm_ with non-devm. Either drop devm_ *after* the first
> > non-devm_ call, or convert everything to be managed.
> >
> How about to add 'devm_add_action_or_reset' for tcpci_unregister_port?
> This will convert all as 'devm_' version.

I think it would work, that wrapper was designed to cover cases like this.

> > > +               return dev_err_probe(dev, ret, "Failed to allocate irq\n");
> > > +       }

...

> > > +static int mt6370_tcpc_remove(struct platform_device *pdev)
> > > +{
> > > +       struct mt6370_priv *priv = platform_get_drvdata(pdev);
> >
> > > +       disable_irq(priv->irq);
> >
> > Why?
> > An ugly workaround due to ordering issues in ->probe()?
> >
> Yes, due to the ordering in probe.
> 'bus remove' will be called before device resource releases.
>
> Like as you said, another way is to convert all as non-devm
> version after 'tcpci_unregister_port'.
>
> If to keep the original order, 'disable_irq' before
> 'tcpci_unregister_port' can make the flow more safe.
>
> Or you can think one case if irq triggers after
> 'tcpci_unregister_port'. Null pointer occurs.
>
> Anyway, in next revision, I'll convert all to be 'devm_' version.
> For this remove callback, only 'dev_pm_clear_wake_irq' and
> 'device_init_wakeup' will be kept.
>
> Is this better?

Sounds like a plan!

> > > +       tcpci_unregister_port(priv->tcpci);
> > > +       dev_pm_clear_wake_irq(&pdev->dev);
> > > +       device_init_wakeup(&pdev->dev, false);
> > > +
> > > +       return 0;
> > > +}

-- 
With Best Regards,
Andy Shevchenko
