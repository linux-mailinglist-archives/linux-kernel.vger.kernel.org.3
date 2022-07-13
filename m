Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E8D573780
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiGMNfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbiGMNfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:35:00 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF75DF35;
        Wed, 13 Jul 2022 06:34:58 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o26so8577774qkl.6;
        Wed, 13 Jul 2022 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zNovvnxCNltl7nyjpskv1bB6kdfvO0KEYNKQKCXFpg=;
        b=BRJedK9Dm0ysBh2ysd8qA02jK/r4tE7oohouS0ATC1cZ54BWUlj7IbOtdUBSyUKhRZ
         ZP3a0P3VMwNVCkuRG+sSNo012rQndOMPw79APKXM+aKY9XEOs3tdwis3lB8p9gELuC2N
         J90a51xczKganDu0vuoADeholu7dvtPR9VxvRqQEcuDQLu58WyS1sGvb4DBRn25xJDmp
         GU+/jBq5/F7bJVhTZa6oPew3PaK2mfX7Lmx5EUYI1jVFjh4PwPFMnUHO3ptKLpC/Kwve
         gNxGOZLMROO4iHGx1117HIvj53pycNxnXy/wm3rR2T95kcYKhf7hq468QoGFeZL8eZ+k
         eCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zNovvnxCNltl7nyjpskv1bB6kdfvO0KEYNKQKCXFpg=;
        b=wqgICEEyH2iROvmWUhVlLCynPucFPrqlP46v2T7mbZ/OFaGUghTSW04FH/0puZOIbL
         Ew7VJ2YZZFRRI6oFhSrnZ+HNu79AjYqC9Qb2dJ5Kqw9yXHd8Kb93lAFH9uWzwEUl5+O8
         UFanr/1W8IdIdB7HnsGUUArSo1C40AzBJRQVrjCzMxWAInGaVj+12U0jKgf3aox/6Jgn
         Ll/DWzSyJWJ7i4aXZdMwZXb8nDtDrcveoLa+gs6r0j9vDYarz+A3uf9MFBfxZxuWBwCt
         7UdTKDXHU+gp6T7aWONjHEZ/PUAZ/39VRBL4a6qs2AVpgpsRAT5BwgsjsEFx001vih6a
         j+Rg==
X-Gm-Message-State: AJIora9aP7Ggy3lyH8F3jdDvuIIE7BgM9g4XusblzO2zIqMYgD06PL2d
        0e4doLqrkUEChOdPm6L7NljVWDAvNgU2T/5eHoZAkxAvfQ2zwA==
X-Google-Smtp-Source: AGRyM1v4o77MegwM8Z9AGbWOV3bLqRh6kQdITYwW4l4rpbhrZdNBHCS2h7p+Jxbq3BicOS5iwaZfxDSTxZNHQIBTcy0=
X-Received: by 2002:a05:620a:1a2a:b0:6b5:93bd:b662 with SMTP id
 bk42-20020a05620a1a2a00b006b593bdb662mr2364604qkb.522.1657719297138; Wed, 13
 Jul 2022 06:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220624195112.894916-1-robimarko@gmail.com> <87edyq1ujr.wl-maz@kernel.org>
 <20220712124445.GC21746@workstation> <87czea1i2f.wl-maz@kernel.org>
 <CAOX2RU5RX+H=omuKGye2fBy9dOFmfC9HC_3pekeGMxDJuReCUw@mail.gmail.com>
 <d8912a0d811b5eb924b8c4136b099f72@kernel.org> <CAOX2RU4MpyEQ0RtcrZ07VXRbB+SWWU=1zWfYUXhQFtvh=MCiDw@mail.gmail.com>
 <874jzl17lc.wl-maz@kernel.org>
In-Reply-To: <874jzl17lc.wl-maz@kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 13 Jul 2022 15:34:46 +0200
Message-ID: <CAOX2RU5k0UJiJ7o3ULjLVLUO=cchT_Azdvzs5FKdjXLX1_muOQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: make the irqchip immutable
To:     Marc Zyngier <maz@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, 13 Jul 2022 at 15:10, Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 13 Jul 2022 13:33:32 +0100,
> Robert Marko <robimarko@gmail.com> wrote:
> >
> > On Wed, 13 Jul 2022 at 13:47, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On 2022-07-13 12:08, Robert Marko wrote:
> > > > I will look at IRQ GPIO docs, but in this case, then we have more
> > > > conversions that
> > > > are not correct.
> > >
> > > Then please point them out.
> >
> > Oh, now I get the issue, I was misunderstanding it completely.
> > gpiochip_enable_irq and gpiochip_disable_irq are not being called
> > at all.
> >
> > However, I dont see them being called before the conversion as well.
> > I am not really familiar with the PMIC IRQ-s, looked like an easy conversion
> > to get rid of the warning.
>
> They definitely were. Look at how gpiochip_add_data() eventually ends
> up calling gpiochip_set_irq_hooks((), which hijacks the irq_chip
> function pointers to insert the calls to these helpers.

Well, that is the thing, since irqchip->irq_enable and
irqchip->irq_disable were never
populated in the SPMI GPIO driver, gpiochip_set_irq_hooks then does
not insert them.
During runtime, gpiochip_irq_enable and gpiochip_irq_disable are never
used even before
the conversion, that is what I am trying to convey.

>
> This is what this conversion process is all about, and you absolutely
> need to understand that code before blindly changing drivers to squash
> a run-time warning.

Yeah, I agree, hopefully, I am not annoying.

Regards,
Robert
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
