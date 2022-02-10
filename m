Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7114B0ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiBJKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:36:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239875AbiBJKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:36:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4245FD8;
        Thu, 10 Feb 2022 02:36:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5993A61B95;
        Thu, 10 Feb 2022 10:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFB5C004E1;
        Thu, 10 Feb 2022 10:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644489364;
        bh=v+o/pVXW0jbA4rH4iLmFawzXy6jeZG+7qU8hQVcABk8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fGr/GgaTlNVwq40OWT7jAcnPQ9ivu7mq7xKwRyJeV2t5pJ7AZxBo//9/moMfUE0wY
         2WBL59Hl2t7Ir7+2kzzVisVdKM7cpxq9zNyoXyju/nYuyeo/O+9qlArpcIrU83AbJx
         WDYCT2sla5PdhRZUE3s7VW5ZSiDHor2/iDX/9H+atkM4tH0TCj1PcDBaxG4XKxA7J6
         kLdBymLKKp+hmY5lX0+qoYcCBJJxcPTTUDlo7dhXR9NLuwGkcqAtk3TnU4tRwkse7H
         XpGakSB0bl3G5A2lq7b2KB3/N7b1TOzBFYjOvUgH7KL21orcj5/ifxYmPL85NHoj6T
         VM14GuJQ6NI4g==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nI6ny-006sNS-OR; Thu, 10 Feb 2022 10:36:02 +0000
MIME-Version: 1.0
Date:   Thu, 10 Feb 2022 10:36:02 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: meson: remove CPU opps below 1GHz for
 SM1 boards
In-Reply-To: <20220210100638.19130-3-christianshewitt@gmail.com>
References: <20220210100638.19130-1-christianshewitt@gmail.com>
 <20220210100638.19130-3-christianshewitt@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8211344a481dd40f260106bdd3f03bfb@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: christianshewitt@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com, narmstrong@baylibre.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-10 10:06, Christian Hewitt wrote:
> Amlogic SM1 devices experience CPU stalls and random board wedges when
> the system idles and CPU cores clock down to lower opp points. Recent
> vendor kernels include a change to remove 100-250MHz and other distro
> sources also remove the 500/667MHz points. Unless all 100-667Mhz opps
> are removed or the CPU governor forced to performance stalls are still
> observed, so let's remove them to improve stability and uptime.
> 
> Fixes: 3d9e76483049 ("arm64: dts: meson-sm1-sei610: enable DVFS")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 3c07a89bfd27..80737731af3f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -95,26 +95,6 @@
>  		compatible = "operating-points-v2";
>  		opp-shared;
> 
> -		opp-100000000 {
> -			opp-hz = /bits/ 64 <100000000>;
> -			opp-microvolt = <730000>;
> -		};
> -
> -		opp-250000000 {
> -			opp-hz = /bits/ 64 <250000000>;
> -			opp-microvolt = <730000>;
> -		};
> -
> -		opp-500000000 {
> -			opp-hz = /bits/ 64 <500000000>;
> -			opp-microvolt = <730000>;
> -		};
> -
> -		opp-667000000 {
> -			opp-hz = /bits/ 64 <666666666>;
> -			opp-microvolt = <750000>;
> -		};
> -
>  		opp-1000000000 {
>  			opp-hz = /bits/ 64 <1000000000>;
>  			opp-microvolt = <770000>;

That's not nearly enough. If that's an actual issue, the driver
should be updated not to use these OPPs, and you can't assume
that people will just update their DT (mine comes from u-boot,
and it is unlikely I will update it anytime soon).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
