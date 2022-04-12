Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23994FEB19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiDLX2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiDLX1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:27:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C6E125D;
        Tue, 12 Apr 2022 15:34:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l7so432716ejn.2;
        Tue, 12 Apr 2022 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=FafwHJHCvkay4y+ls36HJhZzn1yzq14wSSj6X3swf1s=;
        b=Dzvnd0rPx94Q971Tqc9OactuCidS+CcvfBihaMSIB6c93FCmcYavPo3PQ+O1DaIfbR
         iOYNOQyUFXKiBdd26mUWabthDPhNpeFx5B8o8OOiRMmvFAriub7uoNIQAqlIVjgA3y0b
         Nzu3SaJUgoTAhVLLbf2j/eXSqfvY6v/0uiB/BjHZW9RvZXup1wMIbuYL0IuZp8xHZakS
         l8EdBL7nvLygGN40kZLSsDKp1u/3/QNlR3EzsHj9erGLwLIToAbdFZYBjOglT6TvArqK
         2+W++bx8ZE4Ln9mE2QxtmSlhJNyuiPl8V1pExYLJAfPAOKirg2ly92HSOr4asx1RfULv
         QV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=FafwHJHCvkay4y+ls36HJhZzn1yzq14wSSj6X3swf1s=;
        b=HG3JO9mDQL/6qZMY5V1UHF9iUNYVACWRWqqudJaKnkWcseMqNKzd8Yk3jOZ6SCs0Bz
         z7/Fe2MuI/2tYRh72AvyhmiDQLVy4KZtIhYctsggqisARGT9AggNpi4d87Imn0RTFCPW
         S0jxkRwLUsisfH/YwbbIWE0Nu+7+5yQpLu29TIy6KX6ChB3+Zg7k9kRKyW63jxOAj1xx
         MaD2jxcXoySstMGNBTQ7yy5rJxW0W1AtZKmkifsFYOCgrMMSVAq0UR7TwtIiQodn06HY
         72s9b2lxO0br3Cr9fsZtrXVDtnI9//g/M07e7yS5O8L0ZcwsD+L9fTwzUajhjvyr8XIw
         iVLQ==
X-Gm-Message-State: AOAM532s+x7q5O2yueral1uIvBq6Sg6RQnoHqgz4Pz+DtzkzridmNhJ1
        HGmd8mjR2GEsgKKGGfrm0IWiIPuFSiU=
X-Google-Smtp-Source: ABdhPJyCPaqifSUltjbLOIjqRmekqDuH9+xXz8yac5SgvHPlXlNL/9gn0d81nbGQj31HuPnxA7sQjA==
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id mp9-20020a1709071b0900b006d8faa84a06mr36414759ejc.701.1649802898274;
        Tue, 12 Apr 2022 15:34:58 -0700 (PDT)
Received: from Ansuel-xps. (host-80-182-176-248.pool80182.interbusiness.it. [80.182.176.248])
        by smtp.gmail.com with ESMTPSA id g2-20020a50bf42000000b0041cc5233252sm342550edk.57.2022.04.12.15.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 15:34:57 -0700 (PDT)
Message-ID: <6255fe91.1c69fb81.3ce58.2045@mx.google.com>
X-Google-Original-Message-ID: <YlXcG1EB1yu4NEOG@Ansuel-xps.>
Date:   Tue, 12 Apr 2022 22:07:55 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH v3 03/18] ARM: dts: qcom: add missing rpm regulators and
 cells for ipq8064
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
 <20220309190152.7998-4-ansuelsmth@gmail.com>
 <YlXXH3ikA5Tcdx9R@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlXXH3ikA5Tcdx9R@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 02:46:39PM -0500, Bjorn Andersson wrote:
> On Wed 09 Mar 13:01 CST 2022, Ansuel Smith wrote:
> 
> > Add cells definition for rpm node
> 
> Why do we need the cells?
>

Mh I'm referring to address-cells and size-cells required for reg or dtb
will give warnings.

> > and add missing regulators for the 4
> > regulator present on ipq8064. There regulators are controlled by rpm and
> > to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
> 
> Are you saying "...to correctly work, gsbi4_i2c must NEVER be disabled..."?
> 
> If so, that's good information, but how does it relate to this
> particular change?
> 

It doesn't but since it I had many days trying to debug the regulators
not working only to discover that the problem was with the pin, I thought
it was a good idea to add this info. Should I just drop it or should i
add some comments in the dts?

> Regards,
> Bjorn
> 
> > reject any regulator change request.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > Tested-by: Jonathan McDowell <noodles@earth.li>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 36 +++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index b309bc0fbbcd..0938838a4af8 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -842,10 +842,46 @@ rpm: rpm@108000 {
> >  			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
> >  			clock-names = "ram";
> >  
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> >  			rpmcc: clock-controller {
> >  				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
> >  				#clock-cells = <1>;
> >  			};
> > +
> > +			smb208_regulators: regulators {
> > +				compatible = "qcom,rpm-smb208-regulators";
> > +				status = "okay";
> > +
> > +				smb208_s1a: s1a {
> > +					regulator-min-microvolt = <1050000>;
> > +					regulator-max-microvolt = <1150000>;
> > +
> > +					qcom,switch-mode-frequency = <1200000>;
> > +				};
> > +
> > +				smb208_s1b: s1b {
> > +					regulator-min-microvolt = <1050000>;
> > +					regulator-max-microvolt = <1150000>;
> > +
> > +					qcom,switch-mode-frequency = <1200000>;
> > +				};
> > +
> > +				smb208_s2a: s2a {
> > +					regulator-min-microvolt = < 800000>;
> > +					regulator-max-microvolt = <1250000>;
> > +
> > +					qcom,switch-mode-frequency = <1200000>;
> > +				};
> > +
> > +				smb208_s2b: s2b {
> > +					regulator-min-microvolt = < 800000>;
> > +					regulator-max-microvolt = <1250000>;
> > +
> > +					qcom,switch-mode-frequency = <1200000>;
> > +				};
> > +			};
> >  		};
> >  
> >  		tcsr: syscon@1a400000 {
> > -- 
> > 2.34.1
> > 

-- 
	Ansuel
