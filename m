Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB549E536
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbiA0Oxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiA0Oxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:53:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB13C061714;
        Thu, 27 Jan 2022 06:53:45 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so3209889pjb.1;
        Thu, 27 Jan 2022 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+UlMpr+x/00nAZmm+usrq4TzMquXi1OLfmluG293i0c=;
        b=q5j6Tn6rmBCkDC8N+sqAa8+jOiF5qIusZbX/nfXnYut83R2UZQQgLKHIHzfuYYaBH8
         pa4n8robOaT87VJr1nt8265/IvV1M1bm+TU1qNt3ku4b3ivRqyXIh/TgRAynAytpTSUA
         fN6EJsoIuvAUs+T7I4SfT/JH6wt8++vembIX7nVslnpoGb/CaDdPIKoymZ5ccoSPWZ1g
         kZEwSPeRmw2ow1iX3z+3zSO6BwlGT5/xG4YK66H4mopcJA31oIlnAcJqLnjOVNx58dba
         ee1oYHVnBgw++IPc5irH1hMyVPt3SWzfIAZUWsn9PFHBJ9AkmznSTXOkhRUmrLWr7iQw
         X2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+UlMpr+x/00nAZmm+usrq4TzMquXi1OLfmluG293i0c=;
        b=aKn1Ult/5tUapEu8bUHseFWOCXO8ySIKAw52aRKBEk7xGEHm0kFxd/HhIiRDJGu7uu
         bn7rJ5BGDWBdOGubHBlo4D4T77v20eAF2rmjzNhZ7RlGeA5FrTOlSkf84tWd5DZB0XNT
         Cl66Yy3/Pwa7iS4jiehZG7W9rEc7e/MXM8wHGh64O/T9Uuc3BJQd9KpMjvf1qKD92SHG
         OrfqoJ22BRR8cee3H51Ul8CIMctnRX2YYsUF38ZqDtH8eTI+Mc5r6ZFxP1KyniQ2uqjm
         m/LcYSSAaBRj8cTCUvUDaRqtGC99VaqAborsydwSXUCdUqaFNNkwTY3ZE+N2cAIHlPVe
         QLWw==
X-Gm-Message-State: AOAM5330IQ8vLAint4vHDJ792UPfCjyle7q0zHXat81MZ6JUTbeaYkgs
        kN8ISAqMXsAJ1I7rfBbixDE=
X-Google-Smtp-Source: ABdhPJzrC3NO4OBGtr5IwrF6ZXhjL7MqS+ZnIiSHtgMfbwYivamVnYOWYKOOwsJmX1LZoEsvQ8UgEw==
X-Received: by 2002:a17:90b:3447:: with SMTP id lj7mr4544092pjb.39.1643295224502;
        Thu, 27 Jan 2022 06:53:44 -0800 (PST)
Received: from paju ([116.124.119.85])
        by smtp.gmail.com with ESMTPSA id y42sm5225308pfw.157.2022.01.27.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 06:53:44 -0800 (PST)
Date:   Thu, 27 Jan 2022 23:53:38 +0900
From:   Dongjin Kim <tobetter@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-sm1: fix wrong GPIO domain for GPIOE_2
Message-ID: <20220127145338.GB2417963@paju>
References: <YfKPSvnFKOaLr74+@anyang>
 <dcb67b4e-6a46-86a6-b21f-99263cc9ff05@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcb67b4e-6a46-86a6-b21f-99263cc9ff05@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:00:11PM +0100, Neil Armstrong wrote:
> Hi,
> 
> On 27/01/2022 13:25, Dongjin Kim wrote:
> > GPIOE_2 is in AO domain and "<&gpio GPIOE_2 ...>" changes the state of
> > GPIOZ_14 connected to INTR of 'RTL8211F' on ODROID-HC and TF_PWR_EN of
> > 'FC8731' on BPI-M5
> > 
> > Fixes: 1f80a5cf74a6 ("arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator")
> > Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")
> > 
> > Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
> >  arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> > index 212c6aa5a3b8..5751c48620ed 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> > @@ -123,7 +123,7 @@ vddio_c: regulator-vddio_c {
> >  		regulator-min-microvolt = <1800000>;
> >  		regulator-max-microvolt = <3300000>;
> >  
> > -		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
> > +		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
> >  		enable-active-high;
> >  		regulator-always-on;
> >  
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> > index bf29afac645f..d4349b355e4a 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> > @@ -52,7 +52,7 @@ tf_io: gpio-regulator-tf_io {
> >  		regulator-max-microvolt = <3300000>;
> >  		vin-supply = <&vcc_5v>;
> >  
> > -		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
> > +		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
> >  		enable-active-high;
> >  		regulator-always-on;
> >  
> > 
> Thanks for the fixes,
> can you send 2 patches fixing each files instead ?
> 
> Thanks,
> Neil

Sure.
By the way, I would drop a fix for 'meson-sm1-odroid.dtsi' since I found a
patch just now.
https://patchwork.kernel.org/project/linux-amlogic/patch/20220127130537.GA187347@odroid-VirtualBox/

Thanks,
Dongjin.
