Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70C656892F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiGFNP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiGFNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:15:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF7193FA;
        Wed,  6 Jul 2022 06:15:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lg18so7262489ejb.0;
        Wed, 06 Jul 2022 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=YMLDVTvyR9wt+eqPK81VYvFaLzU3RcWbb4f8d1UYbe0=;
        b=O7oIIbXjjWTNjkt5EfudQbxBsTYbqDCruMWFEeT6nHKIO0POe/a+KdpUphr1xzTG3L
         3ZlVzrkX8RNNVIoDZj5yoduQVQE55KGiqJ92r9B9yyW6H5q+Cpg2bGJbzQWURCrpCvi1
         ZkyIM9hKReEpHvkorY1RXdL3JtZTXX7DSpNyVWoHrWJiJHCF6ZZK5fJXFRj60M2MsgGm
         EglaEiBlz4oxEOLRyxWelf31rWqK7oRplnfbLNAentKnCYasfi0oJz5Rm1psBphPiYkB
         HfdIletDeaFJEs0+0JxdUp7EHeL1CqiWOqt1y0vH8yAITaMYh5yKOzLytBETYuI35rq0
         BIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=YMLDVTvyR9wt+eqPK81VYvFaLzU3RcWbb4f8d1UYbe0=;
        b=rH8OWdpHkG3vadB8CQf2Lvrps6LZOBSKcLzgNmVNbI/y94q8cqcYSdPkwUhikmALtI
         tH/pQT7pGzduSmqJmx3uaQNF6eHJpIfwXLQyEDu8Pbj15nCcnIJQL6PS/5lYkEpJlYqe
         WA6zjABVGj7Ax9Ob8/6+XKy7ueh42K6SX6zmXpcvjpcxmwAbQmBYZWzdec3V8n1M++ru
         yPypVr9GheQD6++B4lYSZT5oBG5jT4CXCJIrQhrYHF/72xa1EqJQw+z+0FPJgcjjP2j/
         A75umfHbdM4YuUSxVTVGm8fVwVZB6gghh4X5iFSSrsB8YMOzSHJV4O1xNoRhCjPahLPe
         EbNg==
X-Gm-Message-State: AJIora9jJpfdWlcIduvUavUCouIJNH3DoZzIJwbjqpAhlgHRiy2/0QGg
        7VpBRjOhoaNJLwz+lQt9Oic=
X-Google-Smtp-Source: AGRyM1sWdd5RhCFisyvcHYvpMka/7jI3qty/imuN5FuzgvtZXh/LrwdN+EtN4bg1i4WaM+cuJ4j/Sw==
X-Received: by 2002:a17:907:a40a:b0:72a:a61d:9ac8 with SMTP id sg10-20020a170907a40a00b0072aa61d9ac8mr17698037ejc.43.1657113348120;
        Wed, 06 Jul 2022 06:15:48 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id f22-20020a50ee96000000b0043a0da110e3sm9298427edr.43.2022.07.06.06.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:15:47 -0700 (PDT)
Message-ID: <62c58b03.1c69fb81.527d5.ecc6@mx.google.com>
X-Google-Original-Message-ID: <YsWHHj0bdrA+sjiI@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 14:59:10 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 06/13] ARM: dts: qcom: enable usb phy by default for
 ipq8064
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-7-ansuelsmth@gmail.com>
 <eadf03c4-7e4c-e2a0-b20d-6e2dff3af1e3@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eadf03c4-7e4c-e2a0-b20d-6e2dff3af1e3@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:04:44PM +0200, Konrad Dybcio wrote:
> 
> 
> On 5.07.2022 15:39, Christian Marangi wrote:
> > Enable usb phy by default. When the usb phy were pushed, half of them
> > were flagged as disabled by mistake. Fix this to correctly init dwc3
> > node on any ipq8064 based SoC.
> Are you sure they are used on *all* devices? If not, you will
> lose power by enabling unused hw..
> 
> Konrad

Well there could be device that have no usb at all... so honestly
enabling one of them is also wrong. Should I disable the other and
enable it for the upstream device?

Also it's all handled by dummy vbus so i think we can ignore the losing
power thing. (this thing is old)

> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Tested-by: Jonathan McDowell <noodles@earth.li>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index b2faa4a067e9..9c32c637ea46 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -1177,8 +1177,6 @@ hs_phy_0: phy@100f8800 {
> >  			clocks = <&gcc USB30_0_UTMI_CLK>;
> >  			clock-names = "ref";
> >  			#phy-cells = <0>;
> > -
> > -			status = "disabled";
> >  		};
> >  
> >  		ss_phy_0: phy@100f8830 {
> > @@ -1187,8 +1185,6 @@ ss_phy_0: phy@100f8830 {
> >  			clocks = <&gcc USB30_0_MASTER_CLK>;
> >  			clock-names = "ref";
> >  			#phy-cells = <0>;
> > -
> > -			status = "disabled";
> >  		};
> >  
> >  		usb3_0: usb3@100f8800 {

-- 
	Ansuel
