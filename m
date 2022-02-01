Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3554A6773
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiBAV64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiBAV6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:58:55 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56379C061714;
        Tue,  1 Feb 2022 13:58:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h21so34659202wrb.8;
        Tue, 01 Feb 2022 13:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6B/NWvJqrE/2wlY9LkJWv0Qob6wwHCO8chgqhXbR0zk=;
        b=E4GbTk/oDhOn38qWb5tJo2V9+CFFpwvqqZQdx1Td8gmSzjzm9Nari+TxomndUFQxQ8
         u8r63Zzr1w0Okpseq8Vhgjxhh8k1iZ6fEQDXQM250ePHH0ybkv4c6hvgKamNE7FBZ8dF
         MbGha3XnVEzltJWNlckiYRtiTulKDVMnHnDfAdcQI39JYbiOfCxKM+mALyRri6Gd31TK
         yg9sgIrch5v59o+IGm0WNQljVHwHXLKifqM+kvWMk4R2kU8RVJEiWeth1yp3xv1owM6i
         rvboomBXjN/1D7YxxIsJp6rrf94nk4lHqWpAqN80G6t2R/Zu4R/woxcFJSP481b578V0
         +KTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6B/NWvJqrE/2wlY9LkJWv0Qob6wwHCO8chgqhXbR0zk=;
        b=18GZ+dZAHNuD0uXevleKCJ0BNx6jbyYi2JbyN9WyLvnqGClmUWOEAVNI2OGRCYSTXt
         Au7W9GJt6NrT/KyAAYerErRsFrFxb7/kbS/np2jgeNJpDovp5muC/mH3ddb/FDpDDYD4
         L9fF0cjiapUSHXPYpFykMMGuHGzFos7kkpCeyskEbj0hXrdRybhUcfexBCd2oYoyv2n9
         iTzwHJeK2BYTLhKPRmjgJpOGmsJahKFFi0aanGJ/IeXAjLu7yUt/9RJyhzDq+sI+uLO1
         JoagRwUeLooN0sky5Wqij1jlmq6/xqL2jIGhUbyOQM9+7gIAr0ZQjaGDAD+yQcuiefjB
         g1Qw==
X-Gm-Message-State: AOAM533URqRIvA7hMwFh/XLO5yew3zddF0q3dAzJPcD3HvMcMS3rHVgv
        oKakN4uHBmI6zRkLZtTw5K0=
X-Google-Smtp-Source: ABdhPJzxB0aa7zd/vnW0gEX8lz85w3lIstMpkMfA2FLKYH87q2cgPIp2gDI/ocrzLcNCozNCREbMVQ==
X-Received: by 2002:adf:ed42:: with SMTP id u2mr22804655wro.519.1643752733696;
        Tue, 01 Feb 2022 13:58:53 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id b2sm17994310wri.88.2022.02.01.13.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:58:53 -0800 (PST)
Date:   Tue, 1 Feb 2022 22:58:52 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] ARM: dts: qcom: add missing rpm regulators and
 cells for ipq8064
Message-ID: <YfmtHFfW00Qr2cLc@Ansuel-xps.localdomain>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
 <20220118012051.21691-4-ansuelsmth@gmail.com>
 <Yfhmum8BnB1JIALP@builder.lan>
 <YflGGM45F3TqERNj@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YflGGM45F3TqERNj@earth.li>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:39:20PM +0000, Jonathan McDowell wrote:
> On Mon, Jan 31, 2022 at 04:46:18PM -0600, Bjorn Andersson wrote:
> > On Mon 17 Jan 19:20 CST 2022, Ansuel Smith wrote:
> > 
> > > Add cells definition for rpm node and add missing regulators for the 4
> > > regulator present on ipq8064. There regulators are controlled by rpm and
> > > to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
> > > reject any regulator change request.
> > > 
> > 
> > Is the SMB208 mandatory on all ipq8064 designs, or should this be pushed
> > out to the device dts?
> 
> It's not; the RB3011 uses a different regulator (a TPS563900).
>

Fact is that that's a special case. We have 20 devices based on ipq806x
and they all have smb208 regulators.

Is the TPS563900 also controlled by rpm? 

Anyway should we use a dedicated dtsi to declare the correct regulators?

> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 35 +++++++++++++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > index 094125605bea..824cf13dd037 100644
> > > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > @@ -829,10 +829,45 @@ rpm: rpm@108000 {
> > >  			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
> > >  			clock-names = "ram";
> > >  
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +
> > >  			rpmcc: clock-controller {
> > >  				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
> > >  				#clock-cells = <1>;
> > >  			};
> > > +
> > > +			regulators {
> > > +				compatible = "qcom,rpm-smb208-regulators";
> > > +
> > > +				smb208_s1a: s1a {
> > > +					regulator-min-microvolt = <1050000>;
> > > +					regulator-max-microvolt = <1150000>;
> > > +
> > > +					qcom,switch-mode-frequency = <1200000>;
> > > +				};
> > > +
> > > +				smb208_s1b: s1b {
> > > +					regulator-min-microvolt = <1050000>;
> > > +					regulator-max-microvolt = <1150000>;
> > > +
> > > +					qcom,switch-mode-frequency = <1200000>;
> > > +				};
> > > +
> > > +				smb208_s2a: s2a {
> > > +					regulator-min-microvolt = < 800000>;
> > > +					regulator-max-microvolt = <1250000>;
> > > +
> > > +					qcom,switch-mode-frequency = <1200000>;
> > > +				};
> > > +
> > > +				smb208_s2b: s2b {
> > > +					regulator-min-microvolt = < 800000>;
> > > +					regulator-max-microvolt = <1250000>;
> > > +
> > > +					qcom,switch-mode-frequency = <1200000>;
> > > +				};
> > > +			};
> > >  		};
> > >  
> > >  		tcsr: syscon@1a400000 {
> > > -- 
> > > 2.33.1
> > > 
> 
> J.
> 
> -- 
> ... "There's no money, there's no weed. It's all been replaced by a fucking
>     big pile of corpses."  -- Lock, Stock and Two Smoking Barrels

-- 
	Ansuel
