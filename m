Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0984CD213
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiCDKKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbiCDKKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:10:44 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8CD120E9D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:09:56 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id t22so8515224vsa.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 02:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RSJBHH3RIOxPBOcxPLKpTBjHoXhMbYFt7YY2XmHkL2c=;
        b=LVJRTrUwjgLtiChQ4t98fTwWF5nmzhttA+KFC8QBwhkjXiQ/+93m1cUkxQ9yDGOZh1
         lCm3tbCQ7jq9MRaiDNoxZkviTZvO9CvuVDJ8luzEcK5zpSLqbpXET4v0KeHLRX7aohcN
         nWxHCUhJIPN+/KLh+UK9gAGZdTA0R2eo+I7Mbj0jfvUrn/82uQ4uTmUfwK/nQQW7vgF1
         dpu2+lxPhier/0JMjkml30u0FC3joN1conEQcGRtUxs7DtkPo8Pz7St+8AJ29tPLQTBp
         T9Lyg4OuefdcU54lIjazBZf7jnArGGUH4zGRJXMpALvkRJXNkBQw9FuCELHzDxd4TWNj
         EeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RSJBHH3RIOxPBOcxPLKpTBjHoXhMbYFt7YY2XmHkL2c=;
        b=Moa2KYgy39GJBPA3CcRCqyIpjYACVFP+SMkAGTbtSynkRIl/w8OgG4RtZlajSqEjzU
         OaFAEuMtvRNyIj9/e3+qc/WTJ/pBcnyIDekkEeKbbNY1AVJAwtAN62Sbcz1fjtExEvOF
         l2zbNy/yGYtpVNXWe6pzWLvcaBS0QcKz+KqLLF8Eb4tovJTq9GU/1CYMOUFiWeeWTJLt
         2/DcWAU3H0TCJul8g7nGeJsn38seN/m3I+loGS6OAPfZWOFE3mOcOy3yvGg0d+HFInhc
         /fUFtEJAyUPmPhncR9zLLtyzG7BAiWNrU8m2Ug/krLyzbevY1dHIRzOILZhnu0HEtQnM
         t4gw==
X-Gm-Message-State: AOAM5328QKtx7bvs7/IzlM5TIyjccYMmpaSdHGTJxupRyXO3MZTCJ5P4
        KRgQazIRYCXz/67j3uFF8JfQ68hiMEzMyVCv9N8=
X-Google-Smtp-Source: ABdhPJyHzf5pLWlWedCr7aTKVfPFnb/hWZ5e7AA7syMYGDrCO2/YVX+6c9IVDG8SJGat5AWfIjIaA25sjl2rkTOVnV4=
X-Received: by 2002:a05:6102:3912:b0:320:6bb3:f1fe with SMTP id
 e18-20020a056102391200b003206bb3f1femr2827115vsu.4.1646388595625; Fri, 04 Mar
 2022 02:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20220301104349.3040422-1-daniel@0x0f.com>
In-Reply-To: <20220301104349.3040422-1-daniel@0x0f.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Fri, 4 Mar 2022 11:09:44 +0100
Message-ID: <CABgxDo+32A+akgbcD5Y+oGGJwZ_2G+dqfNTAdHYSD3xVPUnoTQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: mstar: Select HAVE_ARM_ARCH_TIMER
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Interesting, when I wrote the patch for msc313e-timer, I always had
ARCH_ARM_TIMER implicitly built, so I thought that it was implicitly
selected by MULTI_V7...
I agree that we should at least have ARM_ARCH_TIMER enabled, otherwise
we won't being able to boot correctly (no clockevents)

I have also noticed that we missed this commit
https://github.com/linux-chenxing/linux/commit/4cf42fcb4618cd77d80f767d5524=
c32fb40a91c6
 (that selects MSC313E_TIMER), which might explain your initial issue
(not being to boot).

MSC313E_TIMER being optional on ARM (because of ARM_ARCH_TIMER), we
should be sure that arm_timer is enabled and we can keep the mstar
timer optional, imho.

What do you think ?

Romain

Le mar. 1 mars 2022 =C3=A0 11:44, Daniel Palmer <daniel@0x0f.com> a =C3=A9c=
rit :
>
> The mstar SoCs have an arch timer but HAVE_ARM_ARCH_TIMER wasn't
> selected. If MSC313E_TIMER isn't selected then the kernel gets
> stuck at boot because there are no timers available.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>
> I moved one of my CI builds from a 5.16 based tree to a 5.17
> based one and it stopped booting. At some point I had broken my DTB
> so the MStar timer wasn't getting probed anymore and at
> the same time the arch timer driver wasn't getting built in.
> I'm not entirely sure why the arch timer driver was built
> before but isn't now. Anyhow, all of the other ARMv7 machines
> seem to do this so I guess it's right.
>
> Arnd/Olof, please apply directly if acceptable. Maybe this should
> be in 5.17 as a fix?
>
>  arch/arm/mach-mstar/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-mstar/Kconfig b/arch/arm/mach-mstar/Kconfig
> index cd300eeedc20..0bf4d312bcfd 100644
> --- a/arch/arm/mach-mstar/Kconfig
> +++ b/arch/arm/mach-mstar/Kconfig
> @@ -3,6 +3,7 @@ menuconfig ARCH_MSTARV7
>         depends on ARCH_MULTI_V7
>         select ARM_GIC
>         select ARM_HEAVY_MB
> +       select HAVE_ARM_ARCH_TIMER
>         select MST_IRQ
>         select MSTAR_MSC313_MPLL
>         help
> --
> 2.35.1
>
