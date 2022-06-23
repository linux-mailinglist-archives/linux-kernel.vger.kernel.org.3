Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03356558A17
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiFWUbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiFWUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:31:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1404B54F8F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:31:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c13so566637eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCZ2XHP05VxtgmiRgjao5k7aHC4OaYSNudzicymZ1wE=;
        b=uc+YKK94fwq49iJwxmPKhkTK5XKnBnI3YX1oXB7Uab4wZ4j4ijggEB5oFUzmh5/ZL7
         on8ZDQKvzKUtGtu20Lovz1pnEF7/nkJjj9ka0EltvWLUqV+A7zub4NqsaOtzpOv1Tjd1
         Y8qUfy8N9qWXVUIQ8fChJbLklf9LDYzggpdEG2hgJy85Q4zdWkCsEu3+ofnhUIt6wA4q
         xIr87s6HZ908VQPulOWVQRqoHjFILXnfOdH8U0gI/VUIiqUxa0VqR4KlJ+OG1axauAD3
         mhGNvIwonaCnRuapqLk1JMisHn3EWKIpv8B6f8QNQ50VQrdSCrwUIrFMWQQrcBmkuy9y
         bjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCZ2XHP05VxtgmiRgjao5k7aHC4OaYSNudzicymZ1wE=;
        b=B+N1syAReRHtGC+MtOAbmY0hKIG+iA74KIb+bQNS5Jeo3llhRiHurYk0ubSHYoE1kb
         TMMkcqutIlbt51ePIE9/9nSwFtl0hnFwzFikBug5IZyHwDv4LFBFaLlgSDTz9nkiaxZv
         rkwAcxHHgoEJI8D0/YGVH8JldCQA+WbOcdFnTI6GJeM7s7tBBgjyCvx3lnIURYYLhATE
         Ykzfcd7UX4RzJQ4hR87g5PGBJJwY01QKtYlKK9dF56O7uCg7XLhfpmU2/EIpStnpfrcu
         wPt6/N74xY9yNVNajIxYsVworFXbeBCPsONbPwOV2HcYeDKWtSFY2+79STDSua40KSPL
         PZXw==
X-Gm-Message-State: AJIora9OujtuhNEsmTpsikAvjygYG1TeOYBOTWTCUyryVo5GA9Q9CtMK
        RVsSvWr16YctfNeGRZABwZDSyE9MzdpRdfs/7Hx07g==
X-Google-Smtp-Source: AGRyM1tjnPoft26dvpdnhsTXSuT/m8XtJUqLXM8cpMSUyP8oXrtinFxbOkfMh4vIcxru71+K01j/EQxCoO5fZJLOxhw=
X-Received: by 2002:a05:6402:2786:b0:435:da07:14cb with SMTP id
 b6-20020a056402278600b00435da0714cbmr4670783ede.408.1656016289692; Thu, 23
 Jun 2022 13:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220601050200.22213-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220601050200.22213-1-lukas.bulwahn@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 23 Jun 2022 22:31:19 +0200
Message-ID: <CAMRc=McvogqVVvBoTCVqSPHyD0YLXGZ9d1j+e1SsNicA7+QSyw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust ARM/INTEL IXP4XX ARM ARCHITECTURE to
 ixp4xx clean-up
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 7:02 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit c83227a5d05e ("irq/gpio: ixp4xx: Drop boardfile probe path") and
> commit 155e4306107f ("clocksource/drivers/ixp4xx: Drop boardfile probe
> path") remove files include/linux/irqchip/irq-ixp4xx.h and
> include/linux/platform_data/timer-ixp4xx.h, but miss to adjust MAINTAINERS.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
> broken references.
>
> Remove file entries for those files in ARM/INTEL IXP4XX ARM ARCHITECTURE.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Linus, please pick this minor non-urgent clean-up patch for ixp4xx arm.
>
>  MAINTAINERS | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 58e751b9346e..e0f5895feb6b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2196,8 +2196,6 @@ F:        drivers/clocksource/timer-ixp4xx.c
>  F:     drivers/crypto/ixp4xx_crypto.c
>  F:     drivers/gpio/gpio-ixp4xx.c
>  F:     drivers/irqchip/irq-ixp4xx.c
> -F:     include/linux/irqchip/irq-ixp4xx.h
> -F:     include/linux/platform_data/timer-ixp4xx.h
>
>  ARM/INTEL KEEMBAY ARCHITECTURE
>  M:     Paul J. Murphy <paul.j.murphy@intel.com>
> --
> 2.17.1
>

Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
