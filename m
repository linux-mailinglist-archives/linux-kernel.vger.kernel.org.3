Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADC4DB3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356685AbiCPOtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349582AbiCPOtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:49:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332422BFD;
        Wed, 16 Mar 2022 07:48:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so4719049ejb.4;
        Wed, 16 Mar 2022 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MU28qsctK5PVccJ1WrLZfX9pzKHKxkT7Hh1LuKa2sg8=;
        b=oYGLiy/hunXG2D75J7dgg6ccgKAlxDTBHJWc2w9thvePgZOCpSFQ02J/Z1DDvze70U
         M07qtMz9jgPckpvV4kCgxu1Pgr2Kr/pKLQX/dI9OxNjCHQmJjEEz8BId3TdNe9i1TtvJ
         9vdt0fo77rejZd5la9VGlaGen7BKHyICYk7UbfRUtNySFXp6a+JHq6vpLVrt1wu4svIr
         xVFwCuXCQrn/Kl2CRVAIPpZwa3MouPH1SnRl4Mzshrlk6BiHaGsjWnucQEy9Qixhtsm9
         LDWrJjLvbZ6+OVIi+pU1xIvnO7zi+oAppY1jdkKBRx6Ytt06OM/1O0EF1534lZuc1Le2
         XHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MU28qsctK5PVccJ1WrLZfX9pzKHKxkT7Hh1LuKa2sg8=;
        b=iA+7kS2ysN8+Z128SEVT8UP8sQO682AOIIHHGoC6xTvoRL7x6njIZwc6jOMWG6+zIZ
         24Y8QUBIULuitgQ1wlvWIbhArCbarc+Q1mgl0grJy9lniZi/SyVMIkiWzVaGM+4uptN9
         RkcZZvOUFseS33YTEg7HSQHpCP9yo0NstfXgeIVi0h1LY1kli0Ro6ng5gGNx+w2hhQkv
         XkNixgm+Wmr0inG0J8CkfIbx1z7FqBC4SbkDP5zMlDYPvJ3vHLkyqVO8nMa4mdNstSY0
         s269gE3BzF/SJKhOUB0zudoUALe7YUCDxskEowR8sEWFAI+t6IYcaUlUC2lhLslmxxRV
         yoJQ==
X-Gm-Message-State: AOAM5322pDj1aF/bWo4rMXNDHGxXWQ5iIQQAqUIf0J/16WSagoSE/VKP
        UhBtkqMvl7UgqgpiqWwFy+mgYAt4RWfFkiXUFoc=
X-Google-Smtp-Source: ABdhPJy/Ny8UY3V3+yIJkaQJt94C4ScuZfBq3+cneD49OBa3A7yawWEZCrCxtlo7/0BYgVPT/lQC8V9e77lniQQqEw4=
X-Received: by 2002:a17:907:9703:b0:6da:6412:508a with SMTP id
 jg3-20020a170907970300b006da6412508amr275705ejc.77.1647442117741; Wed, 16 Mar
 2022 07:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220315173922.153389-1-paul@crapouillou.net>
In-Reply-To: <20220315173922.153389-1-paul@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Mar 2022 16:47:24 +0200
Message-ID: <CAHp75Vfas=H7Vb+mJor-LWckUpE8QUdD8Yauq4mdG4OY+7dfMg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ingenic: Garbage-collect code paths for SoCs
 disabled by config
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>, od@opendingux.net,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Mar 16, 2022 at 4:11 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> By being a bit smarter about how the SoC version checks are performed,
> it is possible to have all the code paths that correspond to SoCs
> disabled in the kernel config automatically marked as dead code by the
> compiler, and therefore garbage-collected.
>
> With this patch, when compiling a kernel that only targets the JZ4760
> for instance, the driver is now about 4.5 KiB smaller.

...

> +static const u32 enabled_socs =

If you make it unsigned long, it would be easier to switch to bitmap
APIs if needed in the future.

> +       IS_ENABLED(CONFIG_MACH_JZ4730) << ID_JZ4730 |
> +       IS_ENABLED(CONFIG_MACH_JZ4740) << ID_JZ4740 |
> +       IS_ENABLED(CONFIG_MACH_JZ4725B) << ID_JZ4725B |
> +       IS_ENABLED(CONFIG_MACH_JZ4750) << ID_JZ4750 |
> +       IS_ENABLED(CONFIG_MACH_JZ4755) << ID_JZ4755 |
> +       IS_ENABLED(CONFIG_MACH_JZ4760) << ID_JZ4760 |
> +       IS_ENABLED(CONFIG_MACH_JZ4770) << ID_JZ4770 |
> +       IS_ENABLED(CONFIG_MACH_JZ4775) << ID_JZ4775 |
> +       IS_ENABLED(CONFIG_MACH_JZ4780) << ID_JZ4780 |
> +       IS_ENABLED(CONFIG_MACH_X1000) << ID_X1000 |
> +       IS_ENABLED(CONFIG_MACH_X1500) << ID_X1500 |
> +       IS_ENABLED(CONFIG_MACH_X1830) << ID_X1830 |
> +       IS_ENABLED(CONFIG_MACH_X2000) << ID_X2000 |
> +       IS_ENABLED(CONFIG_MACH_X2100) << ID_X2100;

...

> +is_soc_or_above(const struct ingenic_pinctrl *jzpc, enum jz_version version)
> +{
> +       return (enabled_socs >> version) &&
> +               (!(enabled_socs & GENMASK((unsigned int)version - 1, 0))

Why casting? Why not use BIT()?

But these two lines seem like a very interesting way to reinvent the test_bit().

If I'm mistaken, this all version code needs a good comment.

> +                || jzpc->info->version >= version);
> +}

-- 
With Best Regards,
Andy Shevchenko
