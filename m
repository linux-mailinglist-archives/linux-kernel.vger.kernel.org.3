Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05754BCF18
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 15:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbiBTOpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 09:45:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiBTOpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 09:45:30 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E3153701;
        Sun, 20 Feb 2022 06:45:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s24so17897601edr.5;
        Sun, 20 Feb 2022 06:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9WBIrLV7a7ITqe2gJcFg0OaqJzdOIMlPPMgtT7XmAPU=;
        b=H0+WHetxE3GHBnp1GDl3r6+qGiyJk3Rrd5db2S2XBkX0f4gUOf9+dOiE601TZBMNvK
         IL47+O1eoRDnhJpw/ehMBCkw7lIM6BGDwr94NnWAZ89hl/ck/F1mSmYZuxRmlMmoc8zH
         +w1NtPAN0whbKWUXSxHj+eoScSeggIAeE3ZunxCAfhqJlAEedXnP9Q2gNsiu/MmRGALz
         8F07UMSrKtY4BzuqnPlOpklayIVU8RXWXJXuChOj1r0kvVSraITTXGjBQaqu13C4o5kl
         BLexyC20HFa5vKBuWmmJ+OuOgMEJse7DLQQBR2n6vSPp3oMAGkuG+isfsE+cuDJFpfhX
         o6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9WBIrLV7a7ITqe2gJcFg0OaqJzdOIMlPPMgtT7XmAPU=;
        b=pcQlYFnj2X5brC9pmpM2/hANfGEgqQ4g+zhDqdhgN8kgmGtWk0Ps7ORs5zXaLHiGPU
         j/ud9OjZwpvLEJMAJHeFp3PxFDO0rpWYbv0vJosxZQYQjUnfFfA/PMhq8UqdFiPVh5SI
         QQSXVc4yZW32KjWrbCToVYQQVj90j7XRRBQHX0HbdDVS8t76LPvnSbmPl/fSceXtWVE6
         t99og57lKCtNdt2hTeZymHfQh8n68dpwuFnwA0CB3Hp8NT30Gh4WFbBGX4PUMX1cpyck
         2+kD/O8/uC7XaCkc0ULIrXKYgs3sYbSJ5WXwLbe5MMGsV1QFDEUZ/6sk32AR6+ZTOgx6
         gxCQ==
X-Gm-Message-State: AOAM531ZD61RLHCvW3h+V8KbuKGzQYp/Mt1dAtzhTddsaJXIyHKSfWKJ
        W2indIBXK35VSh3On/YDvpG8Eprhh5Q=
X-Google-Smtp-Source: ABdhPJw69n/kzMU1yI5alkes24zOZOzztseCW0XJxNuMy+DzX+BR7QzCWzxYjqZgd7jVRDahFEO0BA==
X-Received: by 2002:a50:aa9d:0:b0:40f:d653:ff0f with SMTP id q29-20020a50aa9d000000b0040fd653ff0fmr17436302edc.114.1645368307039;
        Sun, 20 Feb 2022 06:45:07 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id x12sm7133581edv.57.2022.02.20.06.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 06:45:06 -0800 (PST)
Date:   Sun, 20 Feb 2022 15:44:54 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/18] ARM: dts: qcom: remove redundant binding from
 ipq8064 rb3011 dts
Message-ID: <YhJT5gD2TuwucnQX@Ansuel-xps.localdomain>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
 <20220218002956.6590-17-ansuelsmth@gmail.com>
 <Yg+pL44ogVscn9Kw@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg+pL44ogVscn9Kw@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 02:11:59PM +0000, Jonathan McDowell wrote:
> On Fri, Feb 18, 2022 at 01:29:54AM +0100, Ansuel Smith wrote:
> > Mdio0_pins are now declared in ipq8064 dtsi. Usb phy are enabled by
> > default.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 17 -----------------
> >  1 file changed, 17 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> > index 0982b6214fb7..ddc9cc49ab60 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> > +++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> > @@ -259,10 +259,6 @@ &gsbi7_serial {
> >  	status = "okay";
> >  };
> >  
> > -&hs_phy_1 {
> > -	status = "okay";
> > -};
> > -
> >  &nand {
> >  	status = "okay";
> >  
> > @@ -309,15 +305,6 @@ mux {
> >  		};
> >  	};
> >  
> > -	mdio0_pins: mdio0_pins {
> > -		mux {
> > -			pins = "gpio0", "gpio1";
> > -			function = "gpio";
> > -			drive-strength = <8>;
> > -			bias-disable;
> > -		};
> > -	};
> > -
> 
> This sets the pins to "gpio". Your earlier patch sets them to "mdio", so
> removing this will break MDIO0 on the RB3011. It's likely that your
> fixes for MDIO/QCA8K mean that the RB3011 can be switch to use the MDIO
> driver rather than mdio-gpio, but that will need tested and this change
> alone will definitely break things.
> 

I could be wrong but I remember that before the mdio driver we used the
mdio-gpio driver with the pins set to mdio function without problems.

> >  	mdio1_pins: mdio1_pins {
> >  		mux {
> >  			pins = "gpio10", "gpio11";
> > @@ -358,10 +345,6 @@ mux {
> >  	};
> >  };
> >  
> > -&ss_phy_1 {
> > -	status = "okay";
> > -};
> > -
> >  &usb3_1 {
> >  	pinctrl-0 = <&usb1_pwr_en_pins>;
> >  	pinctrl-names = "default";
> > -- 
> > 2.34.1
> > 
> 
> J.
> 
> -- 
> /-\                             |  Even the Evening Herald slags me
> |@/  Debian GNU/Linux Developer |                off.
> \-                              |

-- 
	Ansuel
