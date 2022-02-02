Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CA54A72E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbiBBOVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344862AbiBBOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:21:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967EC061714;
        Wed,  2 Feb 2022 06:21:48 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b13so42606887edn.0;
        Wed, 02 Feb 2022 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uZxG6ejcH+oTnDpDsfC5qB/qJgKr2fa+FUx9iDGet0A=;
        b=bfAELRSTJH5KgdkiGqCQXeFRZeV2LwexqkR0eM0O4Y66Dm8Af6YSMpkfrkeJbbgKrh
         elXrjOvtZSRPwO+6ZwJvl7ETD5q8XR4Q9Ikp+oo/4Y7XNhoCAJe3j1lBV8nMCeQzNr3W
         1pMqoyyGFAOEWVmP2jlXKrnDNw06lPnlUY1rc/CFAK26iAtGMERgbSplC3LsHT5/b8m1
         gfhhM95CP+QrC+deydWKmxp6MbZ0V6IfuKxySoud5sdriBK8c2n6xiD2JYm8CIndQTQa
         SAmMAtwPbbsYhPa4cMxwRUoKSt+98tbMuIfn8+t5dG/rHRaTeCKMBr3+JD5Qvkw5pajX
         3ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uZxG6ejcH+oTnDpDsfC5qB/qJgKr2fa+FUx9iDGet0A=;
        b=M3pZIxNViqkZWUBJ86Pag4Bv243z1uOBGI0VrEyvNptY4wYYKwnUSIC20m5r4ucvWv
         UbB+Je0ojtgSpqMBkfTNweYD9o5iycY+eze+mJtnhTY0CK0afvyG3pffL+gD4uUu31o3
         2EVtsFxqU7qiPrJWZxy/t5xfH1A+fL9pTTeBeoIpclt6211wFnXxdiYNSE5YkmXbl4Au
         UbSRFrvEfhKcB8QGQ39/iRC/ym/nsMMqEVT2nNdWki1B0qxFPJPRYMQXEP/OCuP4CdUN
         9MN8CvzR80RtRTEZgbM92ThaV3C1wwWydsNfs0r55sdUN2ZUDNPjOEj/HRZ6Gtikirwl
         1dKQ==
X-Gm-Message-State: AOAM531+SRAAwGGit+Cfp0CoDm0MHUfyG3zJXD7Qe67y4hQIeS/GVfdb
        8UitufhTLoXv2bQBBtcDuqjl43soluBl67KKOlAmSDlmFzs=
X-Google-Smtp-Source: ABdhPJy/jhevC/1abuSRWlcDmvSsGBSvixZwyaqJd+WaKS3f2CIiGz1EB0Y4pIvXD0WQzU2FZkv2oZRLQkjL09AJ+Zw=
X-Received: by 2002:aa7:dd8f:: with SMTP id g15mr6382743edv.436.1643811706757;
 Wed, 02 Feb 2022 06:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20220202125438.19345-1-j.neuschaefer@gmx.net>
In-Reply-To: <20220202125438.19345-1-j.neuschaefer@gmx.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Feb 2022 16:20:11 +0200
Message-ID: <CAHp75VdtTzkXVY21WZje1EkqixOOxxA3M09NfqQanV0XSRiNjQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fixing the compile-test warnings in pinctrl-npcm7xx
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 2:54 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> My "Nuvoton WPCM450 pinctrl and GPIO driver" patchset brought two
> warnings[1] in the pinctrl-npcm7xx to light. Here's an attempt at fixing
> them.

With added the respective Fixes tag to each of them
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

> [1]: https://lore.kernel.org/lkml/202201292234.NpSNe4TD-lkp@intel.com/
>
> Jonathan Neusch=C3=A4fer (2):
>   pinctrl: nuvoton: npcm7xx: Use %zd printk format for ARRAY_SIZE()
>   pinctrl: nuvoton: npcm7xx: Rename DS() macro to DSTR()
>
>  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 160 +++++++++++-----------
>  1 file changed, 80 insertions(+), 80 deletions(-)
>
> --
> 2.34.1
>


--=20
With Best Regards,
Andy Shevchenko
