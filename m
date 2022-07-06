Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3522C56859D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiGFKb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiGFKbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:31:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF926541;
        Wed,  6 Jul 2022 03:31:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u12so26281641eja.8;
        Wed, 06 Jul 2022 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=kZqIs70OTt6jii795NJ0qzTYWchhAv15K9Xbii8uxEY=;
        b=ojxfvPkFrNi++Sxaxk8fgSMW1Gsz6qhemLuJhcq20+PotSdo3KyBODTIqB6z/LGD+m
         LX00zjjNlyHPUZ+UL3CjpxyEh6YT5Bsp5hr+fjSYWnHowpi66bN9Z07TPqNfcXBkqqCi
         O6NaEM3NTTHiR/fuAG4+BDC64QipwU7k9C724rH5ZohdWJprSfYC94IxpfSBtl5DrY4G
         pBdCTsrBcbZ+sJMQzOEbvAW2r+CaESlQ/5aut/oU8Urn7DE9SKp6drBIpDeNofK9k4uA
         WAnAIINR8rK0mmzxVkaWVXpWxyf1UG0PswMSjveTc6zGq5r3t8TsZj8SUr70FTv1a1Ok
         d9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=kZqIs70OTt6jii795NJ0qzTYWchhAv15K9Xbii8uxEY=;
        b=jx4W/mUBB5urdtm+SK40pqkwbiA62f8rj6YiGPKg9bcRuos9o292JkhVZ3qlu+r+GD
         10kxmGZt/N0czM96ftuXvRcVLjaauu9l6D9lGOxobjKhzEHGoQ8xm5aSQwU6MaSBeHLj
         gwvjYtX6QQQKQHKYziPWPvQ/YDRv4elWMLrHRrPMxl3utNbgIRWZwDz3lCwqZMcRjifI
         UX2BVY5/e8rGMZOGf3+VWBvc4MN530CrGjfXiLE7V5QzUnlrNKhivyBkv1Uf8cAjLpPK
         B0XZI7dIF1UB5LX9D1S2GCqk8eSv4bPf7xIk64YymjPlnhxKZK2Vue412SBqauXHdvrI
         jdsA==
X-Gm-Message-State: AJIora9ndDZ+YsF3T75/pk9ptcpnHRzlSZ/83g6iKYzrmbLzFBv+0vMj
        AG1w+LtQFbLQcwbXI5ZXFnk=
X-Google-Smtp-Source: AGRyM1v6fxEC2x1zCBi16bwizxaClsgUJu80BMz4g/bFoXggudO0Qbz1kaXsSRWtgQ6ovciwd0/sRg==
X-Received: by 2002:a17:907:6e01:b0:726:9a7b:59b7 with SMTP id sd1-20020a1709076e0100b007269a7b59b7mr39760566ejc.752.1657103480336;
        Wed, 06 Jul 2022 03:31:20 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906538100b0072a55ebbc77sm9122331ejo.66.2022.07.06.03.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:31:19 -0700 (PDT)
Message-ID: <62c56477.1c69fb81.8ec4c.f1ac@mx.google.com>
X-Google-Original-Message-ID: <YsVgkpprrGAgg5oz@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 12:14:42 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 09/13] ARM: dts: qcom: add smem node for ipq8064
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-10-ansuelsmth@gmail.com>
 <c5bf6246-a350-8a87-71bc-bc13d502a8af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5bf6246-a350-8a87-71bc-bc13d502a8af@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:39:16AM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 15:39, Christian Marangi wrote:
> > Add missing smem node for ipq8064.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Tested-by: Jonathan McDowell <noodles@earth.li>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index b5aede3d7ccf..98527a7d885e 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -908,6 +908,11 @@ lcc: clock-controller@28000000 {
> >  			#reset-cells = <1>;
> >  		};
> >  
> > +		sfpb_mutex_block: syscon@1200600 {
> > +			compatible = "syscon";
> 
> syscon alone is not allowed.
>

Mh... This is problematic. How this should be handled?
This should be put in sfpb_mutex and change the driver to use regs if
present instead of syscon?

> > +			reg = <0x01200600 0x100>;
> > +		};
> > +
> >  		pcie0: pci@1b500000 {
> >  			compatible = "qcom,pcie-ipq8064";
> >  			reg = <0x1b500000 0x1000
> > @@ -1332,4 +1337,17 @@ sdcc3: mmc@12180000 {
> >  			};
> >  		};
> >  	};
> > +
> > +	sfpb_mutex: sfpb-mutex {
> 
> Generic node names, so hwlock
> 
> > +		compatible = "qcom,sfpb-mutex";
> > +		syscon = <&sfpb_mutex_block 4 4>;
> > +
> > +		#hwlock-cells = <1>;
> > +	};
> > +
> > +	smem {
> > +		compatible = "qcom,smem";
> > +		memory-region = <&smem>;
> > +		hwlocks = <&sfpb_mutex 3>;
> > +	};
> >  };
> 
> 
> Best regards,
> Krzysztof

-- 
	Ansuel
