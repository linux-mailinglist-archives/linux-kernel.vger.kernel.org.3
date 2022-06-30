Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16974561E04
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiF3OeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiF3Odu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:33:50 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF1744A11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:18:36 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w2-20020a056830110200b00616ce0dfcb2so9485682otq.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UKo47eRwZLqOtIrb9MKf+6m0GMopJmkATiSd2gO3qbY=;
        b=OMZKzP51T9zH8ddRl/B6r/fPanoxskVeywxtbh3g18v/DFZAnaekqUgrNljfvUVVbn
         1Xg96wnvXkyGNt7LisqVFnDWuYGxo7wcMwPKsoBPPEjx1coiODlfsVFEBXGgQzhMl8nm
         IV197EaWoBeq0GkSBH8H+I2r8tssvkmTIpDoimyuG4ceKupSRCGhNmo1mqy54hnVHH9T
         3b8exQJ/pY9h3OrOzeyFI/8vWzAdeB9CJ0QElsMU8db1Vhz59UvoBfIrJ0X5gTkdlirv
         IEgO3n3ryq02Dg8hGBuEqaNxNInlrUmhnBcmfE7NbDBrbl6ex4LeQJoZgcsyjN7HX90t
         f59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UKo47eRwZLqOtIrb9MKf+6m0GMopJmkATiSd2gO3qbY=;
        b=NOsBn6nhg24eyro4OiRReskfIXYpLtHdIgZm5UeEsf548lggYlw9Hl5s2TYoWatzXr
         cf5y8yvHW359UM1EMty/w+xcdaAd2PWRACqOBuk8A4Z3pV5fQlLEil3HJf93gddF7tlF
         cDfeFNkEYMqw24OR/NmkkVqo2CwN/IjcAdTryZVL8eSPABOrMTQt2tKb/sPNRiNRHbzv
         kdLixJtmIRT7bHEDJnt0UBA7pa/7NLT4KIIg75wmI18Yb0D5UCkWwMTKTwz+vm27c2Ds
         hHfVF32DQNidzvhrZ+gUROV5RSSltyqOF3mc+QGEvmUAbkYMOvi5UOvHHK09JLDfX3K3
         07QA==
X-Gm-Message-State: AJIora8dNlhOQRmwCUbHbpF+U//vAd78ciD/8OW13C3m35tzVU6IEI+I
        sAtwKVMCRKugHqpU/wActHuGHA==
X-Google-Smtp-Source: AGRyM1vFfXnm58GfvKKmrQUCEv0TWeibI+q0clBmyfCEd+bphEKgFThB5Lc2P9qbVpK8bd2M6zYkhA==
X-Received: by 2002:a05:6830:2a11:b0:616:831e:37f4 with SMTP id y17-20020a0568302a1100b00616831e37f4mr4143597otu.203.1656598715163;
        Thu, 30 Jun 2022 07:18:35 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g13-20020a05683030ad00b0060afaae0e34sm11200311ots.0.2022.06.30.07.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 07:18:33 -0700 (PDT)
Date:   Thu, 30 Jun 2022 09:18:32 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andrey Konovalov <andrey.konovalov@linaro.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: fix default pinctrl settings
 for blsp1_spi1
Message-ID: <Yr2wuHpedbS4RELd@builder.lan>
References: <20220611195713.131597-1-andrey.konovalov@linaro.org>
 <YrKmGfUrOw5awgNw@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrKmGfUrOw5awgNw@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Jun 00:18 CDT 2022, Vinod Koul wrote:

> On 11-06-22, 22:57, Andrey Konovalov wrote:
> > The current settings refer to "blsp_spi1" function which isn't defined.
> > For this reason an attempt to enable blsp1_spi1 interface results in
> > the probe failure below:
> > 
> > [    3.492900] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> > [    3.502460] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> > [    3.517725] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> > [    3.532998] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> > [    3.548277] spi_qup: probe of 78b6000.spi failed with error -22
> > 
> > Fix this by making the functions used in qcs404.dtsi to match the contents
> > of drivers/pinctrl/qcom/pinctrl-qcs404.c.
> 
> Right, I cannot find blsp_spi1 which is the only one which is missing,
> not sure why...
> 
> Bjorn do you recall why SPI1 is treated differently...
> 

Looking at the available pinctrl functions, I believe that blsp_spi1 has
two possible mux options; identified b y blsp_spi_*_a1 and
blsp_spi_*_b1.

Regards,
Bjorn

> > 
> > Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs404.dtsi | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > index d912166b7552..0d9e1f19aa67 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > @@ -669,8 +669,25 @@ blsp1_spi0_default: blsp1-spi0-default {
> >  			};
> >  
> >  			blsp1_spi1_default: blsp1-spi1-default {
> > -				pins = "gpio22", "gpio23", "gpio24", "gpio25";
> > -				function = "blsp_spi1";
> > +				mosi {
> > +					pins = "gpio22";
> > +					function = "blsp_spi_mosi_a1";
> > +				};
> > +
> > +				miso {
> > +					pins = "gpio23";
> > +					function = "blsp_spi_miso_a1";
> > +				};
> > +
> > +				cs_n {
> > +					pins = "gpio24";
> > +					function = "blsp_spi_cs_n_a1";
> > +				};
> > +
> > +				clk {
> > +					pins = "gpio25";
> > +					function = "blsp_spi_clk_a1";
> > +				};
> >  			};
> >  
> >  			blsp1_spi2_default: blsp1-spi2-default {
> > -- 
> > 2.25.1
> 
> -- 
> ~Vinod
