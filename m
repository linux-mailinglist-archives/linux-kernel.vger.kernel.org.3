Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF514DE79A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 12:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbiCSLY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 07:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbiCSLYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 07:24:24 -0400
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Mar 2022 04:23:02 PDT
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D510C1C7F17;
        Sat, 19 Mar 2022 04:23:02 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-3-17-nat.elisa-mobile.fi [85.76.3.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id 2421220AF5;
        Sat, 19 Mar 2022 13:16:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1647688562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3HSI3kgBP9o10gxLuhqQNqLjuiIJtyoXFee1GnFDww=;
        b=TkMLjdYlVQkEsd/BWSVLtjFp8B67Ez3eL4BSXr0RA+K4/KZVTk70jqOF5kFaavGKqP4Wfs
        WYOewSwRGkUoEgAwaWmDcMX28ae3IeJ+SSqOqm4n2hrDrPTSnbrczkXggvrdW8AS+OuG4A
        MW28lQgDLjhMZNtGh6ow+BIuAiXHdz4=
Date:   Sat, 19 Mar 2022 13:16:00 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omap1: htc_herald: fix typos in comments
Message-ID: <20220319111600.GC1986@darkstar.musicnaut.iki.fi>
References: <20220318103729.157574-27-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318103729.157574-27-Julia.Lawall@inria.fr>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1647688562; a=rsa-sha256; cv=none;
        b=M8vH3FQS7nMt/sEnmefQnt/ZQdwIv5ZXxQuReK8V8VxC0tmsowmna3DAczgS7a4prjQyje
        U/tFgcWy+ZTYOtitNqo4vUzu503yFxL341nLhd97ZEMLAMCMwZiQLuAiNPEsPRLE1JLIND
        ilIr0artOjDu2hbfuGT4+BMBuv08+S8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1647688562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3HSI3kgBP9o10gxLuhqQNqLjuiIJtyoXFee1GnFDww=;
        b=cVhaRE9aKxgRXpjNeSDtn7BCgdquclIasP3INrQmN9teRDa4wFerlEolusuFKmx3cWp3Bf
        H6x5kJVi+J7k5GGNsMIHEPLvFxXsDNbzYvXC61kmuVoLFARt3w+hsZdhGEKUyvWGNEWDPd
        t0/gF0fIlBo52HVdV9PyMe7ZE/m7ut0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:37:22AM +0100, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> 
> ---
>  arch/arm/mach-omap1/board-htcherald.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
> index 258304edf23e..d528b8497061 100644
> --- a/arch/arm/mach-omap1/board-htcherald.c
> +++ b/arch/arm/mach-omap1/board-htcherald.c
> @@ -170,7 +170,7 @@ static const unsigned int htc_herald_keymap[] = {
>  	KEY(3, 0, KEY_VOLUMEUP), /* Volume up */
>  	KEY(4, 0, KEY_F2),  /* Right bar (landscape) */
>  	KEY(5, 0, KEY_MAIL), /* Win key (portrait) */
> -	KEY(6, 0, KEY_DIRECTORY), /* Right bar (protrait) */
> +	KEY(6, 0, KEY_DIRECTORY), /* Right bar (portrait) */
>  	KEY(0, 1, KEY_LEFTCTRL), /* Windows key */
>  	KEY(1, 1, KEY_COMMA),
>  	KEY(2, 1, KEY_M),
> 
