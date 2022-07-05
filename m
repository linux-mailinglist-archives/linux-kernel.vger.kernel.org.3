Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA6256684A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiGEKlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiGEKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:40:46 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6436C15733;
        Tue,  5 Jul 2022 03:40:44 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o8fyz-0002Jv-01; Tue, 05 Jul 2022 12:40:41 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2413EC0230; Tue,  5 Jul 2022 12:21:32 +0200 (CEST)
Date:   Tue, 5 Jul 2022 12:21:32 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: mscc: ocelot: enable FDMA usage
Message-ID: <20220705102132.GB9951@alpha.franken.de>
References: <20220624152548.128700-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624152548.128700-1-clement.leger@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 05:25:48PM +0200, Clément Léger wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Enable FDMA usage by adding "fdma" resource in regs and interrupts.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> index cfc219a72bdd..6bd8a1ad94da 100644
> --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -136,13 +136,14 @@ switch@1010000 {
>  			      <0x1880000 0x10000>,
>  			      <0x1040000 0x10000>,
>  			      <0x1050000 0x10000>,
> -			      <0x1060000 0x10000>;
> +			      <0x1060000 0x10000>,
> +			      <0x1a0 0x1c4>;
>  			reg-names = "sys", "rew", "qs", "ptp", "port0", "port1",
>  				    "port2", "port3", "port4", "port5", "port6",
>  				    "port7", "port8", "port9", "port10", "qsys",
> -				    "ana", "s0", "s1", "s2";
> -			interrupts = <18 21 22>;
> -			interrupt-names = "ptp_rdy", "xtr", "inj";
> +				    "ana", "s0", "s1", "s2", "fdma";
> +			interrupts = <18 21 22 16>;
> +			interrupt-names = "ptp_rdy", "xtr", "inj", "fdma";
>  
>  			ethernet-ports {
>  				#address-cells = <1>;
> -- 
> 2.36.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
