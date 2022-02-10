Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2D24B15A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbiBJS4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:56:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbiBJS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:56:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A9109F;
        Thu, 10 Feb 2022 10:56:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 306371F46711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644519369;
        bh=p879cBETubHXdemY/PEQK5hOnKUPCYkbBd8qPEuZydk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HUGcHd7Eryz+IswgcaQeXj1SE1zmzZPq8xlW/QQqmSZfcArilD7EgsPxJI4F7e4sY
         3SifqfLzbqXCbpE5sGfmg+cpRFfmqzoT2Rglv6woYuhs2+gDO2b9Mefr+IBYx9Cetb
         jXDqwGj78rL6j/sTIGD71YEhycfwVcmMROXV5bu6MO523USIhayfBfuDSVhmE9WJEV
         m2GIVq4RscFBadbXfFU8JV5ROwmH13cp1p0sk8/iwscy7U6uQFSQDJYAjU9ENJk4b5
         hMs9kdjtkVa9mwbrXz7JBGleZJ3zXxP0WBw5uoVLNniUYVxr1uZeuv/JGYBPTgYl+c
         Myk+Ebay3vFbQ==
Date:   Thu, 10 Feb 2022 13:56:03 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v2] arm64: dts: mediatek: Add Mediatek mt8192 cpufreq
 device nodes
Message-ID: <20220210185603.lmgf4ppppe3ccscj@notapiano>
References: <1609223471-24325-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <20220210144659.2vkuuh74xagic3ud@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220210144659.2vkuuh74xagic3ud@notapiano>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,
please see my comment below.

On Thu, Feb 10, 2022 at 09:47:04AM -0500, Nícolas F. R. A. Prado wrote:
> Hi Andrew,
> 
> On Tue, Dec 29, 2020 at 02:31:11PM +0800, Andrew-sh.Cheng wrote:
> > From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> > 
> > Correct dts node name in patch v1: performance-domain
> > This patch depends on [1] and [2].
> > 
> > [1]http://lists.infradead.org/pipermail/linux-mediatek/2020-November/019378.html
> > [2]https://patchwork.kernel.org/project/linux-mediatek/patch/1607586516-6547-3-git-send-email-hector.yuan@mediatek.com/
> 
> Those two series are now merged, so no dependencies missing for this patch any
> longer.
> 
> Please rebase this patch, as there are some conflicts. I've already verified it,
> and after you rebase I can send a reviewed-by.
> 
> Thanks,
> Nícolas
> 
> > 
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > index 69d45c7b31f1..a907ee7e650a 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > @@ -39,6 +39,7 @@
> >  			compatible = "arm,cortex-a55";
> >  			reg = <0x000>;
> >  			enable-method = "psci";
> > +			performance-domains = <&performance 0>;
> >  			clock-frequency = <1701000000>;
> >  			next-level-cache = <&l2_0>;
> >  			capacity-dmips-mhz = <530>;
> > @@ -49,6 +50,7 @@
> >  			compatible = "arm,cortex-a55";
> >  			reg = <0x100>;
> >  			enable-method = "psci";
> > +			performance-domains = <&performance 0>;
> >  			clock-frequency = <1701000000>;
> >  			next-level-cache = <&l2_0>;
> >  			capacity-dmips-mhz = <530>;
> > @@ -59,6 +61,7 @@
> >  			compatible = "arm,cortex-a55";
> >  			reg = <0x200>;
> >  			enable-method = "psci";
> > +			performance-domains = <&performance 0>;
> >  			clock-frequency = <1701000000>;
> >  			next-level-cache = <&l2_0>;
> >  			capacity-dmips-mhz = <530>;
> > @@ -69,6 +72,7 @@
> >  			compatible = "arm,cortex-a55";
> >  			reg = <0x300>;
> >  			enable-method = "psci";
> > +			performance-domains = <&performance 0>;
> >  			clock-frequency = <1701000000>;
> >  			next-level-cache = <&l2_0>;
> >  			capacity-dmips-mhz = <530>;
> > @@ -79,6 +83,7 @@
> >  			compatible = "arm,cortex-a76";
> >  			reg = <0x400>;
> >  			enable-method = "psci";
> > +			performance-domains = <&performance 1>;
> >  			clock-frequency = <2171000000>;
> >  			next-level-cache = <&l2_1>;
> >  			capacity-dmips-mhz = <1024>;
> > @@ -89,6 +94,7 @@
> >  			compatible = "arm,cortex-a76";
> >  			reg = <0x500>;
> >  			enable-method = "psci";
> > +			performance-domains = <&performance 1>;
> >  			clock-frequency = <2171000000>;
> >  			next-level-cache = <&l2_1>;
> >  			capacity-dmips-mhz = <1024>;
> > @@ -99,6 +105,7 @@
> >  			compatible = "arm,cortex-a76";
> >  			reg = <0x600>;
> >  			enable-method = "psci";
> > +			performance-domains = <&performance 1>;
> >  			clock-frequency = <2171000000>;
> >  			next-level-cache = <&l2_1>;
> >  			capacity-dmips-mhz = <1024>;
> > @@ -109,6 +116,7 @@
> >  			compatible = "arm,cortex-a76";
> >  			reg = <0x700>;
> >  			enable-method = "psci";
> > +			performance-domains = <&performance 1>;
> >  			clock-frequency = <2171000000>;
> >  			next-level-cache = <&l2_1>;
> >  			capacity-dmips-mhz = <1024>;
> > @@ -194,6 +202,12 @@
> >  		compatible = "simple-bus";
> >  		ranges;
> >  
> > +		performance: performance-controller@0011bc00 {

Actually there is a warning being introduced here on dtbs_check:

	soc: 'performance-controller@0011bc00' does not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$', 'pinctrl-[0-9]+'
		From schema: [...]/dtschema/schemas/simple-bus.yaml

So you should also change the address to not start with zeros: 11bc00

Thanks,
Nícolas

> > +			compatible = "mediatek,cpufreq-hw";
> > +			reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
> > +			#performance-domain-cells = <1>;
> > +		};
> > +
> >  		gic: interrupt-controller@c000000 {
> >  			compatible = "arm,gic-v3";
> >  			#interrupt-cells = <4>;
> > -- 
> > 2.12.5
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > 
