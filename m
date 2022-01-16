Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF10F48FD9E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 16:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiAPP2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 10:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiAPP2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 10:28:53 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1323EC061574;
        Sun, 16 Jan 2022 07:28:53 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id h23so18400182iol.11;
        Sun, 16 Jan 2022 07:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jmsYlqW4QRNe24DrELIWT82TCS9+pEr64+w9U2MhfM=;
        b=h/bk12kTrI7HxS2LrgaWH7kBI6wsESqEFWEJaQfylFvi889gK9ditwASwcgxwJ2kSu
         Z14MXMUnwm0vZbGB9uNsYMImPO1TDgxHYUe+DP12O7L2zdC+crtbNAkR/DpJ2Os3iRor
         9oKI9Jt0f0gBZ7n74tbxiaJAh3vt3bT7yP2t3u93REO6PPiIUavdal3TjsW4vPwdInJi
         +L1FqYRzYBSG2DIIFmOD/LisMhHWs6dGlBcUQvguotx8G1H5a9NJqBJYEzqlbr6D8XFd
         Sz980wGrCMvLebdIDtUQQLShMIpIIQ0wVk7Vr+kPcIUls6HqftPH4nEG8alkgXbRtSso
         8wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jmsYlqW4QRNe24DrELIWT82TCS9+pEr64+w9U2MhfM=;
        b=vHC3umwapkMyfmVKWaylgvdRPsuraDGM8gl0MnPj2TE5j8PWAM68DULWwHp3yRf++0
         fUtydZYtCk0zuCFyM6KDsJSi8IJdzVfxyLte62BMOe0HZT8nQa71wMXCNuDXm30nyJo9
         IjhDlAsylu1ootXT2Zc4mBV0a7/BEa0yBKMB3MXDnT//xOHVOmyYyoPZ+WY3A43KSSNU
         o6PjwDVD2Xgh3PTiVIct7MgaqeTMaat3SqnuT42/uKkPUvn4FJFkzxxCAHjBigVVU2Vn
         36xo7zkEt17R3q7b/3Yc4JCmT1HIW+akk+gvbKBYJC9HlFM4D04XXmlKGipqreQmImNc
         RTpw==
X-Gm-Message-State: AOAM532Jd8rrNLnDCvLGbFwNa6EA1tz8jx3XYujtV6Cjct1pjQct5Vag
        bshiHi8vU63i5SYpY4/Aoxt1Pe5He4YzuHDHdGs=
X-Google-Smtp-Source: ABdhPJwR3VVhAB8eTh4ew3S5evJqNXrk2EmciA9Of/1B7oJmbpVTHq2nmI85mlV9VmqsRJNSFoom1AKYvtTcJv5rvIw=
X-Received: by 2002:a5e:9613:: with SMTP id a19mr4313306ioq.159.1642346932307;
 Sun, 16 Jan 2022 07:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com> <20220112100046.68068-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220112100046.68068-2-krzysztof.kozlowski@canonical.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Sun, 16 Jan 2022 20:58:16 +0530
Message-ID: <CAGOxZ521MhOb+rv+NPCOJq60+CrpsmRR6boWUK5tc_H5wXDmFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ARM: dts: exynos: split dmas into array of
 phandles in Exynos5250
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sam Protsenko <semen.protsenko@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 4:19 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> "dmas" property should be rather an array of phandles, as dtschema
> points.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Andi Shyti <andi@etezian.org>
> ---

 Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm/boot/dts/exynos5250.dtsi | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 139778928b93..102bb57bf704 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -496,8 +496,7 @@ spi_0: spi@12d20000 {
>                         status = "disabled";
>                         reg = <0x12d20000 0x100>;
>                         interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> -                       dmas = <&pdma0 5
> -                               &pdma0 4>;
> +                       dmas = <&pdma0 5>, <&pdma0 4>;
>                         dma-names = "tx", "rx";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -512,8 +511,7 @@ spi_1: spi@12d30000 {
>                         status = "disabled";
>                         reg = <0x12d30000 0x100>;
>                         interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> -                       dmas = <&pdma1 5
> -                               &pdma1 4>;
> +                       dmas = <&pdma1 5>, <&pdma1 4>;
>                         dma-names = "tx", "rx";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -528,8 +526,7 @@ spi_2: spi@12d40000 {
>                         status = "disabled";
>                         reg = <0x12d40000 0x100>;
>                         interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> -                       dmas = <&pdma0 7
> -                               &pdma0 6>;
> +                       dmas = <&pdma0 7>, <&pdma0 6>;
>                         dma-names = "tx", "rx";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> --
> 2.32.0
>


-- 
Regards,
Alim
