Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF854CD82B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiCDPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiCDPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:44:07 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FBF6BDEE;
        Fri,  4 Mar 2022 07:43:18 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 706891BF203;
        Fri,  4 Mar 2022 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646408597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DuDywd0Iu3hrHJ/1yYYDf0hLNoWpE4Lk1omLHli7PTo=;
        b=Tx0sM4e0E3YYWrdHr5WHAVMou9sbVVE89x7T8TvtJejAdc3K6t4ECWHIQ59CcaII3TC2uR
        8IMR4ewGNjFC8SrZgxcyGCjYB/xatqblpyX4ixBgAtQgpzCycJAO/TlE5k0pTi2C0hlhMp
        w8j4mIovOQC/CsqVmRvfsVKsppudhWm4zNywgzzitNLvyFKB0536OJhRMJ9YVN2w5L0Q+Y
        Sjov42xNsFDmCpV48k6W15adLOigXQGsIJQEWBeROcxdqPOnYsau4rGXYkgFFPL9EsW9LG
        j6u6Suf8tJNrRIi06sfeSDeOTdodqX4b4B68VrVlNS+R+lgFPNc5CVOZRNtO8w==
Date:   Fri, 4 Mar 2022 16:43:16 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sergiu.Moga@microchip.com
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, Nicolas.Ferre@microchip.com,
        Claudiu.Beznea@microchip.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ARM: dts: at91: Add the required
 `atmel,rtt-rtc-time-reg` property
Message-ID: <YiIzlN3GpuVTsikk@piout.net>
References: <20220304142746.121947-1-sergiu.moga@microchip.com>
 <20220304142746.121947-2-sergiu.moga@microchip.com>
 <YiIn/NJyqeYlhV/z@piout.net>
 <8f5d56ba-1a51-f9ab-43a2-86d7c938fbe2@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f5d56ba-1a51-f9ab-43a2-86d7c938fbe2@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 15:29:45+0000, Sergiu.Moga@microchip.com wrote:
> On 04.03.2022 16:53, Alexandre Belloni wrote:
> > On 04/03/2022 16:27:42+0200, Sergiu Moga wrote:
> >> Add the required `atmel,rtt-rtc-time-reg` property to the `rtt` nodes
> >> of the board files that were missing it.
> >>
> >> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> >> ---
> >>   arch/arm/boot/dts/at91sam9261ek.dts | 4 ++++
> >>   arch/arm/boot/dts/at91sam9263ek.dts | 8 ++++++++
> >>   arch/arm/boot/dts/at91sam9rlek.dts  | 4 ++++
> >>   3 files changed, 16 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
> >> index beed819609e8..3c1f40b4a13e 100644
> >> --- a/arch/arm/boot/dts/at91sam9261ek.dts
> >> +++ b/arch/arm/boot/dts/at91sam9261ek.dts
> >> @@ -178,6 +178,10 @@ dbgu: serial@fffff200 {
> >>                                status = "okay";
> >>                        };
> >>
> >> +                     rtc@fffffd20 {
> >> +                             atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> >> +                     };
> >> +
> >>                        watchdog@fffffd40 {
> >>                                status = "okay";
> >>                        };
> >> diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
> >> index 71f60576761a..1208bb580d14 100644
> >> --- a/arch/arm/boot/dts/at91sam9263ek.dts
> >> +++ b/arch/arm/boot/dts/at91sam9263ek.dts
> >> @@ -102,6 +102,14 @@ mtd_dataflash@0 {
> >>                                };
> >>                        };
> >>
> >> +                     rtc@fffffd20 {
> >> +                             atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> >> +                     };
> >> +
> >> +                     rtc@fffffd50 {
> >> +                             atmel,rtt-rtc-time-reg = <&gpbr 0x4>;
> >> +                     };
> > Do we really need two RTCs with the exact same features on that board?
> > Is there a check failure hen the property is not there and the node is
> > disabled?
> >
> I can understand your point here. No, it is indeed not really needed 
> since, from what I can see, they are both disabled in the SoC file. The 
> reason why I added both was that I thought it would have been more 
> consistent. Do you think I should remove both in this file and keep the 
> changes in the other 2 files only?
> 

Well, I would keep the first node but not the second so that you have a
good example, ready to be enabled.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
