Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934FF57C981
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiGULFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiGULFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:05:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AAE2B61E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:05:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u14so1412973lju.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJ/vHPCzm1f2d//qmF68sXf6yNTReQ0ju6ClzshBRoI=;
        b=WYXA1xzOXuyrZ3dBHDunm5dy+Ue2dNxXFJBMKycIK+S3seEprfABLkefA2RuFkHR/F
         qThOZ+oBVw1Ez2sRJm9WW6pfc8iM0YYJHn+/vYPDZ9ji0Q4DvIir49gCBzBJfhBDQdj/
         JLzjmJIP/mahXqvfp3jgazyX0x5psXSenRy5RlfzLBfg4E0ghufWCysQ2QNb0yJmXR3/
         Bzrxe5cyKTEEwiCHPViQ0ZPffooVyF2wbl+mUs1EGMAtYr8a/Hf/QERvT/1gNrlkKE+Q
         TEEA1OZ7FVM7AFcQjMpaiBwUO2vxQpegPERArDO8LvyYRvHxEzrZYALWyuLPS2wZI4V5
         aGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJ/vHPCzm1f2d//qmF68sXf6yNTReQ0ju6ClzshBRoI=;
        b=bJeESV7hX8qapydUgMyUHykxtSLlasi0Vn4+qTfgI2r0uhVAFytmgTpWqmmifxZ3SP
         PtCp4eS1yUG8KGDphK9jfGuVMLs9G/4R6YnNMqi6Hvh3Eyw2kVTL71SkxTKY+aQ3TTB1
         8VVo2139rVvVJBMC9hbwwwEMgaSFBLsE/lqcS6K2VErnvOuQWuXG1KrrbpqIRgSe+LSa
         /u3AyOb5KOnpZCA39L+RPn9nqV+z7lbJevXax8b9N5Yxj3SbzTO1Ab/Ga2mPQt/HTdFJ
         rDx7ICHgAr4YrkFjvph1UKb6d8Gjtaw6fnxiG8ktquYqzW6McOXdz63mTIMmoZgHUydl
         qaSA==
X-Gm-Message-State: AJIora+uUzNze8xHcmIAwvWuxiLokGxeRghU4y0tL5JaAqXw6WSdr2uK
        rjL6iO1KJ7Xo5od6pY0q/sFU2rCQhCC1GULnrouK2Q==
X-Google-Smtp-Source: AGRyM1vcvJjCP/hw4nnWQPdUZUzdVTMwbnE0GxM/EXfiRGf+G3w+JBmm/xpG4NFQmXvYIMkJMMthdgPcgvTzijzMINU=
X-Received: by 2002:a05:651c:158:b0:25d:d59c:85bd with SMTP id
 c24-20020a05651c015800b0025dd59c85bdmr3473477ljd.463.1658401514066; Thu, 21
 Jul 2022 04:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220721043608.1527686-1-martin.kepplinger@puri.sm> <20220721043608.1527686-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220721043608.1527686-2-martin.kepplinger@puri.sm>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Jul 2022 13:04:37 +0200
Message-ID: <CAPDyKFpTauJeRS0W34Cz7v_HzJzBCsOk-M2PvrWoYR=cth=j5Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] PM: domain: fix indentation and use BIT macro for flags
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     rafael@kernel.org, khilman@kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz,
        kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 at 06:36, Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> Use the BIT macro for flags and simply do 2 tags indentation.
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

I prefer to keep the advantages with doing a git blame on this file,
over this cleanup. Unless you feel strongly about this I would
appreciate it if you can drop $subject patch from the series.

Kind regards
Uffe

> ---
>  include/linux/pm_domain.h | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index ebc351698090..76bc9e3ef5ff 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -8,6 +8,7 @@
>  #ifndef _LINUX_PM_DOMAIN_H
>  #define _LINUX_PM_DOMAIN_H
>
> +#include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
> @@ -61,13 +62,13 @@
>   *                             components' next wakeup when determining the
>   *                             optimal idle state.
>   */
> -#define GENPD_FLAG_PM_CLK       (1U << 0)
> -#define GENPD_FLAG_IRQ_SAFE     (1U << 1)
> -#define GENPD_FLAG_ALWAYS_ON    (1U << 2)
> -#define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
> -#define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
> -#define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
> -#define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
> +#define GENPD_FLAG_PM_CLK              BIT(0)
> +#define GENPD_FLAG_IRQ_SAFE            BIT(1)
> +#define GENPD_FLAG_ALWAYS_ON           BIT(2)
> +#define GENPD_FLAG_ACTIVE_WAKEUP       BIT(3)
> +#define GENPD_FLAG_CPU_DOMAIN          BIT(4)
> +#define GENPD_FLAG_RPM_ALWAYS_ON       BIT(5)
> +#define GENPD_FLAG_MIN_RESIDENCY       BIT(6)
>
>  enum gpd_status {
>         GENPD_STATE_ON = 0,     /* PM domain is on */
> --
> 2.30.2
>
