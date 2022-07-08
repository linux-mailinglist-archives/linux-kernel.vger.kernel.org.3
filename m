Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861C056C1EF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiGHWJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGHWJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:09:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1379FE06;
        Fri,  8 Jul 2022 15:09:48 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 268M9gp8076075;
        Fri, 8 Jul 2022 17:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657318182;
        bh=BlXwRGaPw5o1YFhTRP4d6RoP/VRJ5AKvNwGx2X9N4b4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oTRxozMX/ckWbVGRdBl3pPKc5UiMOsUqwWT1zaHwP6SGTlvwHabcyzrAE/qRmAhC4
         Yc7xFI6tvp+mRBRiCRFR64EvwIKEJb0pX6RPkjlRus7yz9dUR2iEBekWFws/5JLbzC
         BzxDCWu6N4YpNx95rzJbOJSdjKaJjEW3bjwmJW6E=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 268M9gdY086110
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jul 2022 17:09:42 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Jul 2022 17:09:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Jul 2022 17:09:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 268M9f0v029095;
        Fri, 8 Jul 2022 17:09:41 -0500
Date:   Fri, 8 Jul 2022 17:09:41 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am65-main: Disable RNG node
Message-ID: <20220708220941.skpq7i7ilccw5zdt@secret>
References: <20220706190838.26074-1-afd@ti.com>
 <20220707144400.tk3wmpeijdhuxpzv@bryanbrattlof.com>
 <cb353a3c-96e7-f770-c8bd-17b8a4b4b3e0@ti.com>
 <20220707171734.e22t5rx5ux7k5kcr@magnetize>
 <1d6d171f-3c91-530a-27a5-c93153cb2378@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1d6d171f-3c91-530a-27a5-c93153cb2378@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:36-20220707, Andrew Davis wrote:
> On 7/7/22 12:17 PM, Nishanth Menon wrote:
> > On 10:01-20220707, Andrew Davis wrote:
> > > On 7/7/22 9:44 AM, Bryan Brattlof wrote:
> > > > Hi Andrew
> > > > 
> > > > On July  6, 2022 thus sayeth Andrew Davis:
> > > > > The hardware random number generator is used by OP-TEE and is access is
> > > > > denied to other users with SoC level bus firewalls. Any access to this
> > > > > device from Linux will result in firewall errors. Disable this node.
> > > > > 
> > > > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > > > ---
> > > > > 
> > > > > Changes from v1:
> > > > >    - Added comment in dtsi file
> > > > > 
> > > > >    arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > > index e749343accedd..9de5a8294acd6 100644
> > > > > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > > @@ -127,6 +127,7 @@ rng: rng@4e10000 {
> > > > >    			reg = <0x0 0x4e10000 0x0 0x7d>;
> > > > >    			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> > > > >    			clocks = <&k3_clks 136 1>;
> > > > > +			status = "disabled"; /* Used by OP-TEE */
> > > > 
> > > > Just curious about how we should document disabling nodes. I was
> > > > assuming the reasoning should be described in the bindings?
> > > > 
> > > > I would like to start disabling nodes by default in our dtsi files and
> > > > enabling them in our top dts file, making it easier for others to use
> > > > our device tree for a more focused purpose than our dev boards. I just
> > > > didn't know where I should document why I disabled the nodes :)
> > > > 
> > > 
> > > This got push-back last time this was suggested, I'll have to lookup
> > > the history. IIRC we landed on the other way around, all things should
> > > be described by default, then the specific board can enable/disable
> > > what is not used as needed.
> > 
> > See thread https://lore.kernel.org/linux-arm-kernel/YiizsYnKB0X9bDY2@atomide.com/
> > 
> > > 
> > > I was worried this topic would come up with this patch series and was
> > > almost just going to delete the whole RNG node instead of disabling it
> > > to avoid that. My reasoning for disabling here anyway is that this device
> > > *cannot* be used by *any* board, it is not just a board level configuration
> > > decision like disabling I2C nodes by default or similar that was proposed
> > > last time we had the "nodes disabled by default" discussion.
> > 
> > Hmm.. If that is the case, then why even have it in dts - is that
> > because of cases where OPTEE is'nt the TEE and users may want to
> > directly use it? OR is it because OPTEE can potentially use device tree
> > itself and discover the rng location from dt?
> > 
> 
> Hadn't thought about the second case, but it could also be valid if we
> started using DT in our OPTEE. The intention was for the first case,
> this node has valid hardware description, didn't feel right to delete
> it due to it being unusable by Linux.


Fair enough, it is a bit late for me to let this series cook in list and
then apply and wait for linux-next stability before I tag for next
kernel, I suggest improving the commit message with rationale in the
next rev.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
