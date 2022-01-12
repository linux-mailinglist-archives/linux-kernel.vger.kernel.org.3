Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E4648BE02
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiALFAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiALFAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:00:42 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073A9C061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 21:00:41 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h4so1748167qth.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 21:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaSxb8/3tW75RqpNkToSLtyGS0/ACpk6hM1Y1IVBwz8=;
        b=iUc6xc9cLZAhNuyr74C1urrqVrbmKHode2rHCcMBGdFahBIed/yscTDzmfb7BybmWN
         3M/w693Q1531YGcunSLW6fiYF9SdPYM3GN5A0LR1ufmRApve4tD2+eM842YW/HqhOJs4
         6wQVx516Vp3FcvjIDl63t0/GWt5xBT4AKMsRpwVHjBixMOp2oy276eC+28YFLhQqPFPr
         qXcIR28O7w4vAv7zfxjCo42orTdzI711hOnUmbJLnnNmNKBoPKrjqQdp5kh5DAgQKRoQ
         TNLGN35bVXkeEinrGP0O8aDTEkDBn9+KKiLwnJpO3+wait3cwGBe9ht9R5Ga9Gkh90qn
         1qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaSxb8/3tW75RqpNkToSLtyGS0/ACpk6hM1Y1IVBwz8=;
        b=Zpuv3TVBFYfLdR9gzqqMp4jvxMyoL4yBpOPWOztn6t5X+1Q9rOxM+sXftGkoU96ufM
         jbQMsElsqVv3X65WZR/ri36KfRDnUK3J2v6fg1KmNb1pHY0z6ZQqV+q/14mmNzb97pHX
         mSiXr/4xJy+nIETpVJ1O55hDAZ7149KA0JyLsNogcc9MqW1VETAJqymEjCCrziivR7mo
         mJL11u5rCndUflXY0TQgLdvR91pOArcRyCp1QTuwDytJGi5RiYuzgxQyI5aE+QNleidh
         7PNkrs4DSDGGqpKg6wiL1LKTtKq3DCWiDQNIi1tHD9L+fMd4Fn4AYmsamHgtfLzqKXav
         8KTg==
X-Gm-Message-State: AOAM532TGNBD6rqPe9MPV3OkMFuTfstkyiHK9qbnSc/RAUtJEaDkU3cB
        AgSn7HBsaMzOTK5edPjzQv2Drbqhe+vclp/vj2hhYw==
X-Google-Smtp-Source: ABdhPJw71vvuyjYb0/5S7EXojGfVFgYipbf0DqycEv7zw/Oy1vM7FdEbt27AtkIHB+xYCuZg+Ne3YYQd5XU551OEvpA=
X-Received: by 2002:a05:622a:134c:: with SMTP id w12mr6394524qtk.370.1641963640916;
 Tue, 11 Jan 2022 21:00:40 -0800 (PST)
MIME-Version: 1.0
References: <20220112035556.5108-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20220112035556.5108-1-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 12 Jan 2022 08:00:29 +0300
Message-ID: <CAA8EJpqqEVWS5SuUY6vBWUBnoJdazXqWkMfQbnHRPNL1Fv3XKQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: Fix MSI IRQ for PCIe1 and PCIe2
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 06:56, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Fix the MSI IRQ used for PCIe instances 1 and 2.
>
> Cc: stable@vger.kernel.org
> Fixes: e53bdfc00977 ("arm64: dts: qcom: sm8250: Add PCIe support")
> Reported-by: Jordan Crouse <jordan@cosmicpenguin.net>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 6f6129b39c9c..8a3373c110fc 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -1487,7 +1487,7 @@ pcie1: pci@1c08000 {
>                         ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
>                                  <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
>
> -                       interrupts = <GIC_SPI 306 IRQ_TYPE_EDGE_RISING>;
> +                       interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "msi";
>                         #interrupt-cells = <1>;
>                         interrupt-map-mask = <0 0 0 0x7>;
> @@ -1593,7 +1593,7 @@ pcie2: pci@1c10000 {
>                         ranges = <0x01000000 0x0 0x64200000 0x0 0x64200000 0x0 0x100000>,
>                                  <0x02000000 0x0 0x64300000 0x0 0x64300000 0x0 0x3d00000>;
>
> -                       interrupts = <GIC_SPI 236 IRQ_TYPE_EDGE_RISING>;
> +                       interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "msi";
>                         #interrupt-cells = <1>;
>                         interrupt-map-mask = <0 0 0 0x7>;
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
