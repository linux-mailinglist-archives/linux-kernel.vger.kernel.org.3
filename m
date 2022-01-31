Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42D64A465C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344156AbiAaLzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378084AbiAaLuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:50:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4906C09426A;
        Mon, 31 Jan 2022 03:36:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d10so42135428eje.10;
        Mon, 31 Jan 2022 03:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m7A4pVSNJzjFxlNDUBif0ZSjzzxnHlIlhqH9+88MCVE=;
        b=nLY0dw1UbRO4nmzzwMHn2iPJSCTIQbwe0J1U5nCM53blsnqZM3dTetobnp/HM/KOIP
         WWnAAVCjZNvGMTy2kKFM0xg4+rZXzlZ2c5GSdvnS9L27TCy23ROd3dO/4xJPPAQGJ5EF
         uwr7alA8vx5rkSNppkJx/7LoGyNHO4/sMY596xAjHmJOEPJtm9bSLh31koHzzAnamm/D
         F/PWxFJyDAzdCww/4fXc1BoKmN36S/xxiclOylv8kKakNrw1Er8+zHVg/P3TkY2RpbSj
         2AFGfKb/00Y5X53/MMTRCiw80oxYzAXB2Rdezy1o1AqgltWEaQPVpOU8I1AEPkxod69A
         ho5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m7A4pVSNJzjFxlNDUBif0ZSjzzxnHlIlhqH9+88MCVE=;
        b=xqERVj+X+E/Nhr+jEZbhvCnhb15/XxY2nhwRKpX1bqmFqcosVVZTBtmKkHD1s6E44Y
         BniWLVyXAVirfRuMCH1bnIjpt+ooep27n0z15GNQOX/j0sT9EnIhOn6mpmNo8ubfbwk0
         8ldB1m83RNNIvAJd6GkCX49Eaa8PgJ0fRlCd3qNgAhm31aUwl93lVgTDE6HqNm7UxVjU
         U9VkUlGLa8Rgpge69l49d97AOcdpmoIkKueLrTXzIJXjyZxq5QDRtYqEOiXRTOxT601Y
         qaoLsyBn0MzegwbrQHn4svE1qp8emIJwbZ7fcdV4bREm6dMaD04MQV80x/wTM3Bmw4QF
         0fUw==
X-Gm-Message-State: AOAM531C70MFgvJgg6w19+r0hDLPIMNPJAo+VGEr10YwQeH4kAcThZjO
        prE0jK8hCsW5+YY2OID8vdwuMRfL/80KHA==
X-Google-Smtp-Source: ABdhPJzNa2PvryNQRXW9SMrFZ8YqhBpr8tgJS1NdRci1rCS3yirNO2SWtbmF4gBWcUsjX5C7xw2BoA==
X-Received: by 2002:a17:907:6eaa:: with SMTP id sh42mr16701737ejc.388.1643628978367;
        Mon, 31 Jan 2022 03:36:18 -0800 (PST)
Received: from adroid (027-177-184-091.ip-addr.vsenet.de. [91.184.177.27])
        by smtp.gmail.com with ESMTPSA id d2sm13343309ejw.70.2022.01.31.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 03:36:17 -0800 (PST)
Date:   Mon, 31 Jan 2022 12:36:15 +0100
From:   Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
Subject: Re: [PATCH] ARM: dts: add 533 MHz step to p4note GPU opp table
Message-ID: <20220131113615.GA4916@adroid>
References: <20220129221452.GA36524@adroid>
 <131c9bd9-b035-8a75-ca27-f9c2b3993566@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <131c9bd9-b035-8a75-ca27-f9c2b3993566@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 09:54:00AM +0100, Krzysztof Kozlowski wrote:
> On 29/01/2022 23:14, Martin Jücker wrote:
> > The p4note devices support 533 MHz GPU speed, so let's make use of it.
> > 
> 
> If there is going to be resend, please add prefix "exynos:" in subject.
> Just like other commits (git log --oneline arch/arm/boot/dts/exynos*).
> 

Okay.

> > Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
> > ---
> >  arch/arm/boot/dts/exynos4412-p4note.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
> > index 4ae6eb3091c4..d277b2337ae0 100644
> > --- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
> > @@ -355,6 +355,13 @@ &gpu {
> >  	status = "okay";
> >  };
> >  
> > +&gpu_opp_table {
> > +	opp-533000000 {
> > +		opp-hz = /bits/ 64 <533000000>;
> > +		opp-microvolt = <1075000>;
> > +	};
> > +};
> 
> This looks like Exynos4412 Prime. Please check also CPU frequencies and
> if they match, just include exynos4412-prime.dtsi (like Odroid U3).
> 

I thought so as well, but unfortunately it's not. The chip id is
0xe4412211 and according to the vendor kernel, the prime version would
need to have the last two digits being 0x20 or higher. See:

https://github.com/Viciouss/samsung_p4note_kernel_backup/blob/da306e1846bb4b9682f46be1b23b05d6fbebffba/arch/arm/mach-exynos/cpufreq-4x12.c#L619

On the other hand, this kernel has the 533 MHz step unlocked for all
versions:

https://github.com/Viciouss/samsung_p4note_kernel_backup/blob/da306e1846bb4b9682f46be1b23b05d6fbebffba/drivers/gpu/mali400/r3p2/mali/platform/pegasus-m400/exynos4_pmm.c#L88

> > +
> >  &hsotg {
> >  	vusb_a-supply = <&ldo12_reg>;
> >  	dr_mode = "peripheral";
> 
> 
> Best regards,
> Krzysztof

Kind Regards
Martin
