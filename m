Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9331457F69F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiGXSzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXSzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:55:32 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9169265C3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:55:31 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id h18so7000007qvr.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BZIDWbd+e5/Q1G0dFyLVjy7eyY4n93CGPNpfz9ufq8k=;
        b=Y/x3X31uJTRvN69iA8JzEhHsItKIPMJZshfa+bd/jj0BgkTh5+YrF4nH/331x6eMQ8
         ZimP5N8WljYAKCHUHQXUPtfODti54bLmHHssHC3psGmOQ1x2wL3vQWNzdKDe5wdqY3Sa
         tEReokYrGMZF6VWR0PXKEKEnxrWKpGqOKOII6pOM7iD6OEh9wHH6gbtJlxOa0w+HDBvK
         9WfCPqQgstBgL0M8Y8v4nLRaNoDtXdvFpPH7qjMoFZtUSAk55b9biOIBVAKndTmQ/5YB
         3f1zBf5/kDr20EFdT3GvoeW7mw+Zi37ltG/fe8mnf4SIy6WKBXP/Shnia+sPWYXMFBKw
         SlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BZIDWbd+e5/Q1G0dFyLVjy7eyY4n93CGPNpfz9ufq8k=;
        b=cERucvWTILGBNBVK7u8msyiT6W6MRVXbtQ7Ze8YDUt3G/5Iyon+R/cY9/cfItHxYya
         h5Arq0TXQapsJ2ugZovzQJh0h6aXSvLIY6i9T8ax2J/kfaSVoNZXWcOa89ONnEKwPsfO
         +SRG9cBiCPCRg6v4LKdPwyAQCHjbz4cb3VwxAfIoMA37usuRPivsC8ubPB4wH8GKpHLC
         oFGlPBqBbP19wg+P5wLCmsSsMIJIpaN1a2R/0KXxxQY40UUthnoEgy+3Nr7QJRFAIT/T
         L5CaSynQlqklgWF+dzoxRMEKFMGbpnX7ydvJWvB29+6xyTpNLZbQQIr2eMiPH/q1iu8/
         tMRA==
X-Gm-Message-State: AJIora9L3hE7vnzO2wJWrBrmtH4jBDfyezz7mkd8Uiow/rw0tqPAJw8o
        Yan0yj2v/tMJaYDeMRttTjin4RHVdkb3IE+7f+hRIA==
X-Google-Smtp-Source: AGRyM1uhtAz31vRN2vTHNL4YCaPo/HzrRPqWvsF7BYkwB/9AbIB+WVtU7Zfj39rHx4IiBz8rcO0fuw5kZtT4pTTl5BA=
X-Received: by 2002:ad4:5761:0:b0:473:7861:69d1 with SMTP id
 r1-20020ad45761000000b00473786169d1mr8093947qvx.73.1658688930682; Sun, 24 Jul
 2022 11:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220724172442.87830-1-matti.lehtimaki@gmail.com> <20220724172442.87830-4-matti.lehtimaki@gmail.com>
In-Reply-To: <20220724172442.87830-4-matti.lehtimaki@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 24 Jul 2022 21:55:19 +0300
Message-ID: <CAA8EJpqUH_v1GXEYF62Z3DBtFu_305_h4D36aCnBr38bo5HoJw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: qcom: Add support for Samsung Galaxy Tab
 4 10.1 (SM-T530)
To:     =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 at 20:25, Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.c=
om> wrote:
>
> Add a device tree for the Samsung Galaxy Tab 4 10.1 (SM-T530) wifi tablet
> based on the apq8026 platform.
>
> Currently supported are accelerometer sensor, hall sensor,
> internal storage, physical buttons (power & volume), screen
> (based on simple-framebuffer set up by the bootloader), sdcard,
> touchscreen and USB.
>
> Signed-off-by: Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com>
> ---
> Changes in v3:
>   - Fix sdhc_2 bus width
>   - Reorder includes
>
> Changes in v2:
>   - Change codename to matisse-wifi
>   - Remove msm-id, not needed when lk2nd is used
>   - Remove unused labels from reserved memory regions
>   - Rename muic node
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 469 ++++++++++++++++++
>  2 files changed, 470 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.d=
ts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5112f493f494..8bac4f4f8656 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1010,6 +1010,7 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
>         qcom-apq8016-sbc.dtb \
>         qcom-apq8026-asus-sparrow.dtb \
>         qcom-apq8026-lg-lenok.dtb \
> +       qcom-apq8026-samsung-matisse-wifi.dtb \
>         qcom-apq8060-dragonboard.dtb \
>         qcom-apq8064-cm-qs600.dtb \
>         qcom-apq8064-ifc6410.dtb \
> diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/ar=
ch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> new file mode 100644
> index 000000000000..78a119107069
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> @@ -0,0 +1,469 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include "qcom-msm8226.dtsi"
> +#include "qcom-pm8226.dtsi"
> +
> +/delete-node/ &smem_region;

Please move this to the /reserved-memory node. having it there would
help understanding that we are just changing the address.

> +
> +/ {
> +       model =3D "Samsung Galaxy Tab 4 10.1";
> +       compatible =3D "samsung,matisse-wifi", "qcom,apq8026";
> +       chassis-type =3D "tablet";
> +

[skipped]

> +       i2c-muic {
> +               compatible =3D "i2c-gpio";

Is there any reason for using i2c-gpio rather than blsp_i2c4?
According to the pinctrl-msm8226, gpio14/15 can be mapped to the blsp.

> +               sda-gpios =3D <&tlmm 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN=
)>;
> +               scl-gpios =3D <&tlmm 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN=
)>;
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&muic_i2c_default_state>;
> +
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               muic: usb-switch@25 {
> +                       compatible =3D "siliconmitus,sm5502-muic";
> +                       reg =3D <0x25>;
> +
> +                       interrupt-parent =3D <&tlmm>;
> +                       interrupts =3D <67 IRQ_TYPE_EDGE_FALLING>;
> +
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&muic_int_default_state>;
> +               };
> +       };

[skipped]


--=20
With best wishes
Dmitry
