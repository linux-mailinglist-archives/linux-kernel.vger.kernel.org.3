Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19C04E3B13
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiCVIrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiCVIrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:47:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4851B4C417;
        Tue, 22 Mar 2022 01:46:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k10so7052814edj.2;
        Tue, 22 Mar 2022 01:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksvGP3yP3QXBfeqcjncUFi6hCmkjvpUrrJVwZ45Fxdg=;
        b=faIWsKv8b9f7l4f8DpWBAEhe/U2Up4aCHJ9PnY4jNXQked+orxeHvIjxr48AHCqhy5
         YdoC/2zYEvKiPv3VxIXgQ2q62qV+M97d2ZnpneG7ASsP493vL8R6BkOzc25MuCpHLKTI
         uNxlsSmBa+mweazHJovFMmJU08DTlGXiAI1iDF6/Rj3gn7bCntI9j8idPuX7RmWauufj
         S+7ABuu23ZCM4F0ziyjA662s7zXCCqt4+XN/vK6sCTUIcwEbEmBRn58p+/dv8sOEP+Ct
         zYd3f9G7C7VM++Ci32HR4J74LYIVCeo2pRWXo3HwtEKNJ5DOyoF2vnYM1c6M0jbsWVYN
         qglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksvGP3yP3QXBfeqcjncUFi6hCmkjvpUrrJVwZ45Fxdg=;
        b=ULuPXKOoVp4Xl3Z9lMgli34VehUwxgmBMEP7E6CpWt3G45y2Ur4SFVx+nUmv6KUXJ9
         lDm/Wcj/PyPWzsWkl7s0rDyFgkmO24j3ItU3n7AmrCX5PEXgTgMnRLHh/SyEEAOix3vM
         mK+/WDcumEe+/7Y0Z5iJdPhVUDBCvkFRrmUvi644rmdZl3krSQygVeWMWKRAXdpYCQZd
         WGYAIwrqCXX8XgUoFEnAYlfcFXIX3SPoIRZoUsHOLdQLvITZ+NN8m72q/PCeh3UGCcY1
         HvmsZJvUUMgFNQD0wLrqWdMr5DIPQQDgN+KxXKq17OMcowBPnz0O0pMLM4y/1enBfxMy
         lQHg==
X-Gm-Message-State: AOAM531RbDllyJxeKp4PkOIBE+k3DezjTAaRHQ2J0rImaEhcSVVOfu/m
        /ISvmw+lBx+c+vieHNGdiIoiFJ50IqZefH2DniI=
X-Google-Smtp-Source: ABdhPJw2/JvIRiFz1odA3bIFiYDfYHfEMmBsLFazrWltix/Y5vNQvG19DXbFZRmg7wGdl1qK5X/BJLSoSux7ERoO4FY=
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id
 c17-20020a05640227d100b004191b024a04mr17403213ede.218.1647938771580; Tue, 22
 Mar 2022 01:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <1647927649-9907-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1647927649-9907-1-git-send-email-haibo.chen@nxp.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Mar 2022 10:45:01 +0200
Message-ID: <CAHp75VdZ9RVuMrgWXOWqCrmvHBtkz+S=dxXhR44Ri3p6Pj5LMA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: Allow setting gpio device id via device tree alias
To:     BOUGH CHEN <haibo.chen@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
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

On Tue, Mar 22, 2022 at 7:52 AM <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> For some SoCs which contain different cores, like few ARM A cores
> and few ARM M cores. Some GPIO controllers like GPIO3/GPIO4/GPIO5
> belong to A core domain, some GPIO controllers like GPIO1/GPIO2
> belong to M core domain. Linux only cover A cores, without gpio
> alias, we can get gpiochip0/gpiochip1/gpiochip2 to map the real
> GPIO3/GPIO4/GPIO5, it's difficult for users to identify this map
> relation, and hardcode the gpio device index. With gpio alias,

With the GPIO

> we can easily make gpiochip3 map to GPIO3, gpiochip4 map to GPIO4.
> For GPIO controllers do not claim the alias, it will get one id

If GPIO

> which larger than all the claimed aliases.

which is

...

I'm not sure I understand the issue. The other GPIO drivers and hence
user space (which is already quite a question why user space needs
this) may distinguish the GPIO chips by labels and device names.
What's wrong with that approach?

-- 
With Best Regards,
Andy Shevchenko
