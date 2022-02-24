Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303164C33FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiBXRts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBXRtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:49:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23941A8065;
        Thu, 24 Feb 2022 09:49:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d28so855586wra.4;
        Thu, 24 Feb 2022 09:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1GZ2b1dF2u/vr/4Ra313vIsIJHF22oWuYEwPmLamH0s=;
        b=UpalDvLpYcRfVbv9pRe5oXuMrynsRohvwQDcNb/fMMMAXYLtlSNPtzKwOMfzgVwg62
         WdpZKa/s/juBUvlqPhZGMLf0wnrVsYxZcd5rRb8H2nlxKzek4kJZ8TUxO2h9R7TPhcrh
         EhV8X+Off6uEF9tp1kcaFF5n/p9vJ2oDgEgzPeBc1z76bnocMGN46uwnoMPJgOt+fs/r
         KrauRIE/5N8vgdblZrNHZMf6HJ/ofbDTPbHMHczr1aCBABTOw0TbzQTjKLWa5r5X2sjb
         ocdrSJJiCy3jHm4gqBabNFATZY1KMSUfsJWZVXDccRoBRSkbCEF093bK6FKn1dkgQ9qu
         BiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1GZ2b1dF2u/vr/4Ra313vIsIJHF22oWuYEwPmLamH0s=;
        b=NhnPU+zx/x6/uHkQaGqRcgv++vL5NtYhgGO8Rdbeg7nzawaQabb/ToMOB1GNeEtgsA
         4AdmhO8/xPUNQ7r9WUltiENMX80g3a48bktqlUnlNSTLB6kd4+QMgcQ66N96xgyilF0Y
         zLOzUWnpBVP+qxypOFoltWVW34yc11/xw2EulDdu/7Fsivxk+EufHb9e2fckAMaakTi1
         iR32noA4jNt4He0QCtDighj+geidsHs36ePNPHzKM6rGLUtwm+ZektO6XoDXAheoJ73i
         86Ky7tNL231GH9FPYF/AvnWOkY64nsDtwlKUt47lxblDybugkgHnVJJkoJEDFgQe/c3R
         AZEA==
X-Gm-Message-State: AOAM531yIHGHPJRnwbUW/LtFQVO4Dah1NaCGdiv0w+84sIZrY2E7K8iL
        qU2s5aBSSmH894UZbAqxpDk=
X-Google-Smtp-Source: ABdhPJyDfevX/ISTuZmLojJ4HbhwSOGsG9B7xHR1sqNEQoF5J6in58XqR1f4DsD0tgZ+fpge4/qAJQ==
X-Received: by 2002:a05:6000:1546:b0:1e8:7b68:4f4e with SMTP id 6-20020a056000154600b001e87b684f4emr3150182wry.30.1645724954964;
        Thu, 24 Feb 2022 09:49:14 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.gmail.com with ESMTPSA id g6sm3319816wrq.97.2022.02.24.09.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 09:49:14 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:49:12 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/18] ARM: dts: qcom: add saw for l2 cache and
 kraitcc for ipq8064
Message-ID: <YhfFGIXF80wIfhNV@Ansuel-xps.localdomain>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
 <20220218002956.6590-11-ansuelsmth@gmail.com>
 <YhVBJaPR7a/E9n1B@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhVBJaPR7a/E9n1B@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:01:41PM +0000, Jonathan McDowell wrote:
> On Fri, Feb 18, 2022 at 01:29:48AM +0100, Ansuel Smith wrote:
> > Add saw compatible for l2 cache and kraitcc node for ipq8064 dtsi.
> > Also declare clock-output-names for acc0 and acc1 and qsb fixed clock
> > for the secondary mux.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 34 +++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index c579fb09e768..7df1c1482220 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -298,6 +298,12 @@ smem: smem@41000000 {
> >  	};
> >  
> >  	clocks {
> > +		qsb: qsb {
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <384000000>;
> > +			#clock-cells = <0>;
> > +		};
> > +
> >  		cxo_board {
> >  			compatible = "fixed-clock";
> >  			#clock-cells = <0>;
> > @@ -504,11 +510,19 @@ IRQ_TYPE_EDGE_RISING)>,
> >  		acc0: clock-controller@2088000 {
> >  			compatible = "qcom,kpss-acc-v1";
> >  			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> > +			clock-output-names = "acpu0_aux";
> > +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> 
> You need to add the pxo_board: label to the clock above or we get:
> 
> arch/arm/boot/dts/qcom-ipq8064.dtsi:645.34-652.5: ERROR (phandle_references): /soc/clock-controller@2088000: Reference to non-existent node or label "pxo_board"
> 
> arch/arm/boot/dts/qcom-ipq8064.dtsi:654.34-661.5: ERROR (phandle_references): /soc/clock-controller@2098000: Reference to non-existent node or label "pxo_board"
>

There is another series that introduce the label. Ideally it should be
merged before this. It's almost all reviewed so we should be good.

> > +			clock-names = "pll8_vote", "pxo";
> > +			#clock-cells = <0>;
> >  		};
> >  
> >  		acc1: clock-controller@2098000 {
> >  			compatible = "qcom,kpss-acc-v1";
> >  			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
> > +			clock-output-names = "acpu1_aux";
> > +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> > +			clock-names = "pll8_vote", "pxo";
> > +			#clock-cells = <0>;
> >  		};
> >  
> >  		adm_dma: dma-controller@18300000 {
> > @@ -532,17 +546,23 @@ adm_dma: dma-controller@18300000 {
> >  		};
> >  
> >  		saw0: regulator@2089000 {
> > -			compatible = "qcom,saw2";
> > +			compatible = "qcom,saw2", "qcom,apq8064-saw2-v1.1-cpu", "syscon";
> >  			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
> >  			regulator;
> >  		};
> >  
> >  		saw1: regulator@2099000 {
> > -			compatible = "qcom,saw2";
> > +			compatible = "qcom,saw2", "qcom,apq8064-saw2-v1.1-cpu", "syscon";
> >  			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
> >  			regulator;
> >  		};
> >  
> > +		saw_l2: regulator@02012000 {
> > +			compatible = "qcom,saw2", "syscon";
> > +			reg = <0x02012000 0x1000>;
> > +			regulator;
> > +		};
> > +
> >  		gsbi2: gsbi@12480000 {
> >  			compatible = "qcom,gsbi-v1.0.0";
> >  			cell-index = <2>;
> > @@ -899,6 +919,16 @@ l2cc: clock-controller@2011000 {
> >  			clock-output-names = "acpu_l2_aux";
> >  		};
> >  
> > +		kraitcc: clock-controller {
> > +			compatible = "qcom,krait-cc-v1";
> > +			clocks = <&gcc PLL9>, <&gcc PLL10>, <&gcc PLL12>,
> > +				 <&acc0>, <&acc1>, <&l2cc>, <&qsb>;
> > +			clock-names = "hfpll0", "hfpll1", "hfpll_l2",
> > +				      "acpu0_aux", "acpu1_aux", "acpu_l2_aux",
> > +				      "qsb";
> > +			#clock-cells = <1>;
> > +		};
> > +
> >  		lcc: clock-controller@28000000 {
> >  			compatible = "qcom,lcc-ipq8064";
> >  			reg = <0x28000000 0x1000>;
> > -- 
> > 2.34.1
> > 
> 
> J.
> 
> -- 
>       Hats off to the insane.      |  .''`.  Debian GNU/Linux Developer
>                                    | : :' :  Happy to accept PGP signed
>                                    | `. `'   or encrypted mail - RSA
>                                    |   `-    key on the keyservers.

-- 
	Ansuel
