Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8204A46B0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359817AbiAaMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbiAaMQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:16:03 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EABAC061714;
        Mon, 31 Jan 2022 04:16:03 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jx6so42830132ejb.0;
        Mon, 31 Jan 2022 04:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wNg7k8KGRXZqz1GErRZAiyrRK14ro0vTHrrnr73crWw=;
        b=mfGPj/eNstpblm1dIutlRbUAmZFkY8qc56QvqOE+UihGt6vnkO2WziLqOTM1Crd3Ne
         lyy3szZFQJfX1dMtnsFr0na+VviKrfs0XYGuzXWnU7ZfODeEcQe1SOfWkRfK8Hk9oATk
         MvMa/s4+u6FWgOf49E9jOTg0lc/zGgf9jzTwbrKsKodb8jZ9XEGJRQvePaNy44CWHlRr
         wQPiaya50xQRj9Eiai+yTeX0xHFdEWU0OPo1IBhpuxB9y/PiTUYvCo7xqzr0koNLS8PY
         NcUIPhZ42hN5GHS/JZjx99zaGdYAdmfEkZMJvPOQ5KtvW6F8YmvROTMJ3XCMSHN22ZsR
         vYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wNg7k8KGRXZqz1GErRZAiyrRK14ro0vTHrrnr73crWw=;
        b=i81CVx9+l7w9A3HDCQ4bFnWJO//ORJZlUmc9kLBWxi0J1jVY7C9cohh1r+S0/GBlHz
         HBO/uGxieEX/IWiDwvgSwZsUkAp4P+2s6YUMj8OISYuG4NcTbv7KcMIo9BlKelFkHHjK
         djWDuKa95/OBpiytODHD6JusLCjUeXrbJPOIJEGiU4yrRaQbrx88F3TvNMpk9fMxNH4l
         5aNWddYp9Sq8Qt3w/SrW1GeQvDNWhQ00sXXIu99ew8W+fqXqGqC/I3MIYUlk0s3IbGAJ
         tsgx/NapmlqlAu+nBlxvyf0QzGaxNbBNURZn5CCIxVux7mbnBPl7rAiEZw7TG0HgFpC5
         xzQg==
X-Gm-Message-State: AOAM530nL37Mck4Sx4l0OMrwXczMjg/wkqO+YIQhSn/eT3489mvQs+dT
        ujpQjXd/zYmgiXoIxQEDh7s=
X-Google-Smtp-Source: ABdhPJxDem+jS2SwEyfZ48s++v74UjuU+T7SnLMwq7xTeOMEu/UwzL7ENSL7qPJhDM3y9tgB/XqApg==
X-Received: by 2002:a17:907:7da4:: with SMTP id oz36mr4950145ejc.416.1643631361803;
        Mon, 31 Jan 2022 04:16:01 -0800 (PST)
Received: from adroid (027-177-184-091.ip-addr.vsenet.de. [91.184.177.27])
        by smtp.gmail.com with ESMTPSA id bv2sm13385358ejb.155.2022.01.31.04.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 04:16:01 -0800 (PST)
Date:   Mon, 31 Jan 2022 13:15:59 +0100
From:   Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
Subject: Re: [PATCH] ARM: dts: add 533 MHz step to p4note GPU opp table
Message-ID: <20220131121559.GA4022@adroid>
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
> > +
> >  &hsotg {
> >  	vusb_a-supply = <&ldo12_reg>;
> >  	dr_mode = "peripheral";
> 
> 
> Best regards,
> Krzysztof

I just noticed, that I overlooked a condition in the code which
decreases the step count by one which eliminates the 533 MHz step.
Please ignore this patch.

Kind Regards
Martin
