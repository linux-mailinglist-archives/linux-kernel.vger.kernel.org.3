Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107D6531AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiEWT0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiEWT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:26:32 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65574187D94;
        Mon, 23 May 2022 12:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/VahUGf3jIouTElSgvltjM8fcx6Y4GBfBctItJCCR8o=; b=PhFghKivnQDS61KDy635j7S0Ny
        j3o3syCqONvFNZAeGYDvsVE33SAl6yc0pW2Ui4S8fLpFh9+zSdcsFkjMc6xkj4EFp2fBPvMXeuR+Y
        TwcttVSLoUY20v/HHtaDDPkcSvvU6YTQjwzMtkDlrOm2RHZ2rLKBksmQ+abD1/1ZyhXE=;
Received: from p200300ccff0dcc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:cc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ntDN9-0004DT-LY; Mon, 23 May 2022 21:05:43 +0200
Date:   Mon, 23 May 2022 21:05:42 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        alexander.stein@ew.tq-group.com, marcel.ziswiler@toradex.com,
        linux@rempel-privat.de, matthias.schiffer@ew.tq-group.com,
        cniedermaier@dh-electronics.com, sebastian.reichel@collabora.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        nicolecrivain@gmail.com
Subject: Re: [PATCH 2/2] ARM: dts: imx: Add devicetree for Kobo Aura 2
Message-ID: <20220523210542.0735dd5f@aktux>
In-Reply-To: <402c7e38-7ad0-581f-146d-3db88e77d37c@linaro.org>
References: <20220522214415.254959-1-andreas@kemnade.info>
        <20220522214415.254959-3-andreas@kemnade.info>
        <402c7e38-7ad0-581f-146d-3db88e77d37c@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 12:03:09 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

[...]
> > +
> > +	gpio_keys: gpio-keys {
> > +		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_gpio_keys>;
> > +
> > +		cover {  
> 
> Generic node names. You could add suffix if needed, so either key or
> key-cover.
> 
hmm, the example in
Documentation/devicetree/bindings/input/gpio-keys.yaml

shows names like I did. I usually expect to trust binding documentation
to have something acceptable.

> > +			label = "Cover";
> > +			gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
> > +			linux,code = <SW_LID>;
> > +			linux,input-type = <EV_SW>;
> > +			wakeup-source;
> > +		};
> > +
> > +		power {
> > +			label = "Power";
> > +			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_POWER>;
> > +			wakeup-source;
> > +		};
> > +	};
> > +
> > +	leds: leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_led>;
> > +
> > +		on {  
> 
> The same. You also need property for color.
> 
here the documentation clearly indicates led-.*|led

Regards,
Andreas
