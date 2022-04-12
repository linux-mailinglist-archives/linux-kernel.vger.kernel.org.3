Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C44F4FEA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiDLXYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiDLXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:24:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B7CFBBB;
        Tue, 12 Apr 2022 15:10:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b24so155590edu.10;
        Tue, 12 Apr 2022 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=63bKLrS07j9JmiWXjKpYNjAmmDlr+7+wtgKZRYTSf18=;
        b=LJFofX4aSk0OzYymSwiFtyFFhCMrYHM61Qpf8isMleS9oQQDsNM4pIk0iZBsnMcExw
         czbRo4RjOo+FmkcGUwZZ7sCrFXjF3vakY95vFLx/GT8539xWLiHdd0tkPGdrwPXO6UOp
         /mjyo9V3LFDzyW753i+pRfHJ531CADKefV3rnWmsVoZ0ZztmJuhkIHZp3RIT/uiWcxwA
         v3NlhrdminvH0ZUsfbBzyUSlgmkba+nMWxF4T1OMpqKVvjvaXUmT0f8Z/Kt9YIZHEMb6
         rqbBNBBLdoD0tKF3ZZWGFMyzgFHi7v4a7XtCp54XXjyK3HiG7IVvVUorXGpUCvIBhzZC
         vOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=63bKLrS07j9JmiWXjKpYNjAmmDlr+7+wtgKZRYTSf18=;
        b=b5k0lm/IIRlE2VVUpPPhbyz16BRrsYiqGTVAZfoSBSMxdNTAUnP3NAemL0hUx0HDak
         W3m8vlzhE2wh7bZBqcJL0J8V2Jnm7j+Xyz385lfNpjSzn9oK88YumkpVrYukbCTrSmzO
         yK/BbF4svbQU1bEWmz4rzDwMIbJ2DgFTv8PH6ZEsuBraSTOEAGbVq0y5InUC3xHPjfB/
         H2rPypDpBP+EwPYEuLjUMSsD/eD0a2tgpJGEGhgBw4A5gFUediTIsChGjGBvITA4GVKe
         tXJS7ZMUMzZVoLGlskDLIV+sx2q3GynfBLfAhK85bzoZ9rA1A8DSreAcdvtlo5MKPfY9
         dauw==
X-Gm-Message-State: AOAM532qa7RfFyW/JlWkMQJIWE4uSW35QcXDFpV4lA2pfHCFdUA9Vdy3
        M9B7M0KTT8GRMkUrG8+VMZw=
X-Google-Smtp-Source: ABdhPJxJ4dUymq7nKdznhIfPjRkKSnM60VTsq16sw6lp06E/SpkvlIt7Ahk8kjkZmJAsz3OXQ6AbNw==
X-Received: by 2002:a05:6402:5106:b0:419:45cd:7ab0 with SMTP id m6-20020a056402510600b0041945cd7ab0mr40793251edd.116.1649801449956;
        Tue, 12 Apr 2022 15:10:49 -0700 (PDT)
Received: from Ansuel-xps. (host-80-182-176-248.pool80182.interbusiness.it. [80.182.176.248])
        by smtp.gmail.com with ESMTPSA id p13-20020a50d88d000000b0041cd1a083f7sm328292edj.1.2022.04.12.15.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 15:10:49 -0700 (PDT)
Message-ID: <6255f8e9.1c69fb81.2cc35.1d5b@mx.google.com>
X-Google-Original-Message-ID: <YlXWcqNKFTHwz8YY@Ansuel-xps.>
Date:   Tue, 12 Apr 2022 21:43:46 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH v3 01/18] ARM: dts: qcom: add multiple missing pin
 definition for ipq8064
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
 <20220309190152.7998-2-ansuelsmth@gmail.com>
 <YlXZGKpbYQZgGGwW@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlXZGKpbYQZgGGwW@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 02:55:04PM -0500, Bjorn Andersson wrote:
> On Wed 09 Mar 13:01 CST 2022, Ansuel Smith wrote:
> 
> > Add missing definition for mdio0 pins used for gpio-bitbang driver,i2c4
> > pins and rgmii2 pins for ipq8064.
> > 
> 
> I'm probably not looking hard enough, but I don't see where these are
> used. Could they be introduced as they are being wired into their client
> devices?
> 
> Thanks,
> Bjorn
> 

mdio0 pins are used for by the switch connected to the SoC.
i2c4 are used by rpm but in theory should never be used.
rgmii2 i think were added for as some request for some devices that use
them but not present upstream. Is it that bad to declare pin even if
they are not used? They are used by any device downstream. 

> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > Tested-by: Jonathan McDowell <noodles@earth.li>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 34 +++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index 11481313bdb6..cc6ca9013ab1 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -382,6 +382,15 @@ mux {
> >  				};
> >  			};
> >  
> > +			i2c4_pins: i2c4_pinmux {
> > +				mux {
> > +					pins = "gpio12", "gpio13";
> > +					function = "gsbi4";
> > +					drive-strength = <12>;
> > +					bias-disable;
> > +				};
> > +			};
> > +
> >  			spi_pins: spi_pins {
> >  				mux {
> >  					pins = "gpio18", "gpio19", "gpio21";
> > @@ -424,6 +433,8 @@ mux {
> >  
> >  				pullups {
> >  					pins = "gpio39";
> > +					function = "nand";
> > +					drive-strength = <10>;
> >  					bias-pull-up;
> >  				};
> >  
> > @@ -431,9 +442,32 @@ hold {
> >  					pins = "gpio40", "gpio41", "gpio42",
> >  					       "gpio43", "gpio44", "gpio45",
> >  					       "gpio46", "gpio47";
> > +					function = "nand";
> > +					drive-strength = <10>;
> >  					bias-bus-hold;
> >  				};
> >  			};
> > +
> > +			mdio0_pins: mdio0_pins {
> > +				mux {
> > +					pins = "gpio0", "gpio1";
> > +					function = "mdio";
> > +					drive-strength = <8>;
> > +					bias-disable;
> > +				};
> > +			};
> > +
> > +			rgmii2_pins: rgmii2_pins {
> > +				mux {
> > +					pins = "gpio27", "gpio28", "gpio29",
> > +					       "gpio30", "gpio31", "gpio32",
> > +					       "gpio51", "gpio52", "gpio59",
> > +					       "gpio60", "gpio61", "gpio62";
> > +					function = "rgmii2";
> > +					drive-strength = <8>;
> > +					bias-disable;
> > +				};
> > +			};
> >  		};
> >  
> >  		intc: interrupt-controller@2000000 {
> > -- 
> > 2.34.1
> > 

-- 
	Ansuel
