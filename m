Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C074972F2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 17:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiAWQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 11:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbiAWQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 11:17:02 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07B7C06173B;
        Sun, 23 Jan 2022 08:17:02 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y84so314471iof.0;
        Sun, 23 Jan 2022 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LAyle5M8Yin1J588XMzvsyR2yrP3PbLy64Gkk1kIsNU=;
        b=BT6HCKGUg1XaJmawU3N80eef4GpsPRceNHPfAiBnNVPss4Wk4Brum6pYMRSAFr4vBX
         wqV9G/5usKDIPlOcR/hNQES/QRa35HWNd6DwLAvXBeUc7CVhZPai7eFzBUYsvJoah5In
         aTSySG60Ptuax9Bh/jwUfvaa4HurmS/e0OrpAbmO3R8Dhxe9jsm7LS7ZoTV9fiTMbBhk
         aSnLNZbMgI8fLrFaILyq2eNLePrZpVkGzEbTnD6ieDXqsIZLqLLj4SX5BkhJ6P1bpR4Y
         zqgdkVmCXQjbs0f2S//pzs/oK9cnGkTEUQrvRdk66GAZlAuhHs8A9SQjC8WTdBlzKD1p
         J8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAyle5M8Yin1J588XMzvsyR2yrP3PbLy64Gkk1kIsNU=;
        b=lLW1HPuno5ZN0FaId3C1AsNvdSMSbphKluY+MF3HP3gprv+gNWI/jhKOGsa4g5Jhvc
         X3zFB7u2+zcDMdgLDPZABQzSbxkwe9fFCaZf3Hral5/MlUjZQOaoJCyN3SuUbvel0EW7
         lliUNnrMZyKOVnmsyzujISPhRsDXQ6TayKTm2hCarbYLJqmeIBqVRiKZBw5VS67naGnj
         pyxh3zVEW1zUYFmo8cNBay+bmNGZLRnyR6e3T6g8/oW9y2s3AUmT49q8Xaj0pSyg/JGh
         DWaGtwdHbSBw7UbILL9OrQDN1tFIsHDpgdnsG8RPMLWNto6fza0rMZH7msTaiMJU9glk
         qd/Q==
X-Gm-Message-State: AOAM531Lw1al9t7UlRid/p0aTFRkl/Xqv58bDJdgCuoRdfYhnTaGiuiW
        NQ1rCE/06LNV96JdONeVqHr6n9CZVlfhl4klmxL2VA0TwQM=
X-Google-Smtp-Source: ABdhPJyXRfHSon1CXbaeMo3p6YKqpoPWYPu2kMaMvmCp9dGwvNgi2GKe58hHXdwt5kM5S6JYuKLpW8Pk81s5WB3f1Eg=
X-Received: by 2002:a02:a485:: with SMTP id d5mr1206959jam.167.1642954621876;
 Sun, 23 Jan 2022 08:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20220122131457.63304-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220122131457.63304-1-krzysztof.kozlowski@canonical.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Sun, 23 Jan 2022 21:46:28 +0530
Message-ID: <CAGOxZ53gMpmxtxjk5K0PsZYUxTC9W9Y1vNOU1aY9WgdG1-c0Hw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: use define for TMU clock on Exynos4412
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On Sun, Jan 23, 2022 at 8:42 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Replace clock hard-coded number with a define from bindings.  No
> functional change.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


>  arch/arm/boot/dts/exynos4412.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index d3802046c8b8..aa0b61b59970 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -813,7 +813,7 @@ &tmu {
>         interrupt-parent = <&combiner>;
>         interrupts = <2 4>;
>         reg = <0x100C0000 0x100>;
> -       clocks = <&clock 383>;
> +       clocks = <&clock CLK_TMU_APBIF>;
>         clock-names = "tmu_apbif";
>         status = "disabled";
>  };
> --
> 2.32.0
>


-- 
Regards,
Alim
