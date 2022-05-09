Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356A151F782
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiEII5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiEIIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:41:44 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9981796F8;
        Mon,  9 May 2022 01:37:50 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2B68E240005;
        Mon,  9 May 2022 08:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652085469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+rqwth8FwDQSgAglp2OVaHDIsEvylppRxPGSliCTaDk=;
        b=biHVJ17QCvaQFMnFtvXBiAP2r+H9XZv6WH2tBZpnkIVs2l6lOyxylMUt2I9LrA86kVcc3x
        jXCG+YtSTgZOpwQQLBDw6xjk2jBCUk0E3+YvAId/4jB1qrn9AhXLHSkluoNnX3p/Wt9mOe
        1SB2aonss+BE4sk2pghWVZKGexpFT//N5ef+rsxT/8+z+huKuPixjFJzWcV4MK5EiFn7Ah
        szeidNVEo15naYzc7l1TNptHIxI3UCNxaAcImAhuWLBuWhKnVuTkZwy6p7o6oxrrRlQB6Y
        w4BY6kv+fBa1LNcgUi2KkovpgU9bmRiQZUux7my/eRSIPA4fuv9Xvc1J4j+jYw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>, Andrew Lunn <andrew@lunn.ch>
Cc:     kernel-janitors@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [ARM] orion5x: fix typos in comments
In-Reply-To: <20220318103729.157574-3-Julia.Lawall@inria.fr>
References: <20220318103729.157574-3-Julia.Lawall@inria.fr>
Date:   Mon, 09 May 2022 10:37:37 +0200
Message-ID: <87pmknrtim.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia Lawall <Julia.Lawall@inria.fr> writes:

> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied on mvebu/arm

Thanks,

Gregory
>
> ---
>  arch/arm/mach-orion5x/dns323-setup.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
> index 87cb47220e82..d69259b6b60d 100644
> --- a/arch/arm/mach-orion5x/dns323-setup.c
> +++ b/arch/arm/mach-orion5x/dns323-setup.c
> @@ -696,12 +696,12 @@ static void __init dns323_init(void)
>  			pr_err("DNS-323: failed to setup power-off GPIO\n");
>  		pm_power_off = dns323c_power_off;
>  
> -		/* Now, -this- should theorically be done by the sata_mv driver
> +		/* Now, -this- should theoretically be done by the sata_mv driver
>  		 * once I figure out what's going on there. Maybe the behaviour
>  		 * of the LEDs should be somewhat passed via the platform_data.
>  		 * for now, just whack the register and make the LEDs happy
>  		 *
> -		 * Note: AFAIK, rev B1 needs the same treatement but I'll let
> +		 * Note: AFAIK, rev B1 needs the same treatment but I'll let
>  		 * somebody else test it.
>  		 */
>  		writel(0x5, ORION5X_SATA_VIRT_BASE + 0x2c);
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
