Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8FB4720D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhLMF5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:57:51 -0500
Received: from muru.com ([72.249.23.125]:37912 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhLMF5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:57:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2B179809F;
        Mon, 13 Dec 2021 05:58:32 +0000 (UTC)
Date:   Mon, 13 Dec 2021 07:57:48 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Merlijn Wajer <merlijn@wizzup.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] pmic-cpcap: add motorola,droid3 compatible
Message-ID: <Ybbg3GNwST5Cr9Br@atomide.com>
References: <20211212230459.13579-1-merlijn@wizzup.org>
 <20211212230459.13579-2-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212230459.13579-2-merlijn@wizzup.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Merlijn Wajer <merlijn@wizzup.org> [211212 23:00]:
> The Droid 3 and the Bionic appear to share the same hardware, so add
> the compatible for the Droid 3 as well.
> 
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
>  arch/arm/mach-omap2/pmic-cpcap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/pmic-cpcap.c b/arch/arm/mach-omap2/pmic-cpcap.c
> index 668dc84fd31e..b9188dde13b9 100644
> --- a/arch/arm/mach-omap2/pmic-cpcap.c
> +++ b/arch/arm/mach-omap2/pmic-cpcap.c
> @@ -245,7 +245,8 @@ int __init omap4_cpcap_init(void)
>  	voltdm = voltdm_lookup("mpu");
>  	omap_voltage_register_pmic(voltdm, &omap443x_max8952_mpu);
>  
> -	if (of_machine_is_compatible("motorola,droid-bionic")) {
> +	if (of_machine_is_compatible("motorola,droid-bionic") ||
> +	    of_machine_is_compatible("motorola,droid3")) {
>  		voltdm = voltdm_lookup("core");
>  		omap_voltage_register_pmic(voltdm, &omap_cpcap_core);
>  

Looks OK to me, however we should also add all the mapphones to the
Documentation/devicetree/bindings/arm/omap/omap.txt so we can avoid
dtb check warnings. Care to also do a patch for that? Looks like the
others are missing too.

Regards,

Tony


