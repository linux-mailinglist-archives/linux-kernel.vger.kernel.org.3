Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986ED5A3998
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 20:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiH0Spw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiH0Spe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 14:45:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E7B28E23;
        Sat, 27 Aug 2022 11:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 142C660E9E;
        Sat, 27 Aug 2022 18:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CC7C433C1;
        Sat, 27 Aug 2022 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661625932;
        bh=sLLCKxYxGQlymSR3HEsaESbRMIEl15W7BWXkNlC/6F8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSEtn7I7TweB+4Btk7FS//bCL0CTy4J7gn/7kuSOOVw2ze3+/59MbDvJ2Ks5nyARz
         LSDGLiF60gMNn0XsKCETQYmpBhWINM61m1pV7PI0/idcLDo/IY69+h7lDc7PEul9eS
         G7/V8et83SBjKAYKHh+COKZA4QV52Ax0s0gRBQ4LKvjELiIy5/MhG4ynm1xT395GoR
         1YdV83MBOmsoMA4VAlW6x+G2nDYfiEnIbwPRs59VGBsXyV8CZeySl6uIoVgcpKQM3b
         NORjS5jDOMbO0sRnhSQMwSSZwTKYoJO+EUoZuoZVZXoEzNQvkDcxUi4O72bHtJS3i0
         IURDdlTRbRp4Q==
Received: by pali.im (Postfix)
        id ACA41C7A; Sat, 27 Aug 2022 20:45:29 +0200 (CEST)
Date:   Sat, 27 Aug 2022 20:45:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add switch port 6 node
Message-ID: <20220827184529.x6f7vacuhypaq7bb@pali>
References: <20220825122102.18634-1-pali@kernel.org>
 <YwpldyOI5x1xgMoM@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwpldyOI5x1xgMoM@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 August 2022 20:41:59 Andrew Lunn wrote:
> On Thu, Aug 25, 2022 at 02:21:02PM +0200, Pali Rohár wrote:
> > Switch port 6 is connected to eth0, so add appropriate device tree node for it.
> > 
> > Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/arm/boot/dts/armada-385-turris-omnia.dts | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > index f655e9229d68..8215ffb6a795 100644
> > --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > @@ -463,7 +463,17 @@
> >  				};
> >  			};
> >  
> > -			/* port 6 is connected to eth0 */
> > +			ports@6 {
> > +				reg = <6>;
> > +				label = "cpu";
> > +				ethernet = <&eth0>;
> > +				phy-mode = "rgmii-id";
> > +
> > +				fixed-link {
> > +					speed = <1000>;
> > +					full-duplex;
> > +				};
> > +			};
> 
> Hi Pali
> 
> I've not been following Vladimirs work on multiple CPU ports. Is it
> clearly defined, both for old and new kernels, what happens where
> there are multiple CPU ports defined?
> 
>       Andrew

Hello!

On older kernel kernel versions just the first one cpu port works. Like
if second node is not defined at all. So I sent this patch to have
complete HW definition in DTS, even when kernel does not support all
features yet.
