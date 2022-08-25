Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01465A1A27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243707AbiHYUSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiHYUSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:18:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAC0C00F5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:18:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e20so25459702wri.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=5boySqx/QOquxLdl8JfduLgh/CCKYPrGmebEc48BqF0=;
        b=jLv3eDLvx9cgcOp5gVtcmROUr2uL6GYDlm8F4RBQWUGoBZn2VuJHqqH7BCvQLkCifO
         ljH9VuP0Da5A5DQjni+AeAf38v2ml/1zwzOjnYptmctUe7jiHMFLsHoVqZiICXOXNtrf
         UNp8UCcHyj3io+wolu6mPwkxm8ZqYX7u+sc1RY6WlPTQOd1y9aK3r6hwtRSthvXQhVc6
         xWW50IGEq7ybZp8R5H9EcpOq/NgBKaZyTmvtg5rXOIesPVsuuCD8rm6S1/Q+SidPCJM0
         gN0VgnX0bUdIA+RW6Uh+X9EwueDctoU1FcLqMAZCWTt7HVjh7W2mqBAFK1z4fwXj0fIl
         /Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=5boySqx/QOquxLdl8JfduLgh/CCKYPrGmebEc48BqF0=;
        b=k1G/Zu0BIAczzA5hdLyrSg7+tgtM+IPbaNt9hpZfyVV29JNtAYCxSQl+U7J/xBRGa3
         KueyQnwgvR6CE/uH+e70KNvvwLsgNaSaklxVbn/abfOv2Tc6uhpzb+aF+tqnSzQLalwd
         hb/uR8ejIaWMM6XYO1hl7rUqNeDBo50iu1uvmzgT3MPL1q3n+2yzYtH505BJdg7FhUr9
         Yqt1h3aQDwnonEB4nPPA5YSr1BsjvI71fLg859ckQKS462hWCTFUWBba5mKDYljkeQ7P
         RHPeOMJ3owtovapTtyKjB9YptaVGolF7u15BjM3Jrogmo+Xrm1SpHuBewv6i6chZOueI
         AbxA==
X-Gm-Message-State: ACgBeo06U9kGyaglvaS5y8nVn+H9g2Y3F28ynaAsEjRLN11wvnKk7WkU
        OSxX+z6c0QTsPaQ4/hk1pYE=
X-Google-Smtp-Source: AA6agR7qqebJ62S4jnfJLHIVKwuKG1XL7+sEEI5x6RLTUccSKg0PKv9fP153dYaHKowzV88ZPlHI6w==
X-Received: by 2002:a05:6000:2a3:b0:225:7ce8:a318 with SMTP id l3-20020a05600002a300b002257ce8a318mr2611163wry.350.1661458692998;
        Thu, 25 Aug 2022 13:18:12 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id i186-20020a1c3bc3000000b003a601707174sm242129wma.33.2022.08.25.13.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 13:18:12 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        maijianzhang <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH] iio: adc: sun4i-gpadc-iio: adaptation interrupt number
Date:   Thu, 25 Aug 2022 22:18:11 +0200
Message-ID: <5595575.DvuYhMxLoT@kista>
In-Reply-To: <YwdhTlk+7h+FMrwm@scg>
References: <YwdhTlk+7h+FMrwm@scg>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne =C4=8Detrtek, 25. avgust 2022 ob 13:47:26 CEST je fuyao napisal(a):
> __platform_get_irq_byname determinies whether the interrupt
> number is 0 and returns EINVAL.
>=20
> Signed-off-by: fuyao <fuyao1697@cyg.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  include/linux/mfd/sun4i-gpadc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/mfd/sun4i-gpadc.h
> b/include/linux/mfd/sun4i-gpadc.h index ea0ccf33a459..021f820f9d52 100644
> --- a/include/linux/mfd/sun4i-gpadc.h
> +++ b/include/linux/mfd/sun4i-gpadc.h
> @@ -81,8 +81,8 @@
>  #define SUN4I_GPADC_TEMP_DATA				0x20
>  #define SUN4I_GPADC_DATA				0x24
>=20
> -#define SUN4I_GPADC_IRQ_FIFO_DATA			0
> -#define SUN4I_GPADC_IRQ_TEMP_DATA			1
> +#define SUN4I_GPADC_IRQ_FIFO_DATA			1
> +#define SUN4I_GPADC_IRQ_TEMP_DATA			2
>=20
>  /* 10s delay before suspending the IP */
>  #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
> --
> 2.32.0
>=20
>=20
> --
> Technology is exciting


