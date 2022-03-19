Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56844DE78F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 12:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242766AbiCSLST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 07:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiCSLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 07:18:16 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2332E2C3DD8;
        Sat, 19 Mar 2022 04:16:55 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-3-17-nat.elisa-mobile.fi [85.76.3.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 5311A1B005E7;
        Sat, 19 Mar 2022 13:16:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1647688610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LtNthnYK/2RafUQShjpikkAGPGYQA3FW9B2cxMSy73k=;
        b=RR2PqifMXA+DY1ljIC2dkKNovLXtB+EK/A4uUub169rxOkKgpOMZTcXw17egBUoNCbqhNc
        Wj567aPXirL15p77CnkoT3Mir9vsQ3xxf8zHTDe3gjPea7AcMpTNaMp58MTn1gfzxcMdzA
        mwWvFW9HGFpu7lkzh633SlBCYnGabIzJ9RgCir96BkdJqlo+m9y07XN/1vlnO0TGCaXQvy
        d8o6FZGLTIlVDIXpRLeYMiuYaQ2g54TVvlxSWZRUrz/sqbk97mMAEMLa/QPto20uX5rFnD
        +HzQl/7XIGy7/Sp8LS22KeA/aYgpDTEexdpm5td87+zYuZb12KAfKVpQnp6hJQ==
Date:   Sat, 19 Mar 2022 13:16:48 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Paul Walmsley <paul@pwsan.com>, kernel-janitors@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: fix typos in comments
Message-ID: <20220319111648.GD1986@darkstar.musicnaut.iki.fi>
References: <20220318103729.157574-33-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318103729.157574-33-Julia.Lawall@inria.fr>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1647688610; a=rsa-sha256;
        cv=none;
        b=lA+W8taBKSTwr16a/oezH/zLCzbdc2OmKMJKF/mDWPTRA9pbccAxyi3cSEiuDB8G1TJJeu
        lqOXO/TjQVo7mNO0w7LuFwwSw4NS7IiI5lYXkyBUZRxEdZKS8guQy1NoF1QG6Ux9P9nHq6
        zC3OlXbCMLaQIigdlTrCPOBmyhhTPtQ4/9lQ0oRoqOP0zDtVLI6p1cWjUU6KX/TyOYB6nn
        v/K9p2rEAFmTsOVlM9OmbiYentzoRF9x7anwWGXRJdR4xxrfVecpLB5akNSO4smbwA9AQh
        OFwDf17S6S+IR8W9CfRfh8Mpqn2rxM03jfJkRiVCJrWmYQWLLXdAbWwJjsadBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1647688610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LtNthnYK/2RafUQShjpikkAGPGYQA3FW9B2cxMSy73k=;
        b=E6y98qRVObu5fsrif+T7yAkDCUzEbR5CZlsNnAdB7ZJsHB7wuXOT4gW2bAx88qA9wxK9XP
        Ch2uXSg+4yZssuTR32PAgEduUIYLkOj7MoeMCwbc+yWasxq1fLQ8IeifPknIlC64M4/bco
        wy8aZl1rSU1323chFUNZlTaNwhY1+9lZAadz5biK4Tg+7K9oVqj8trV5B5vTOGDoVs2eIv
        qnz5688Y2gjLc0zKUnYjlxKDpHBBZXy/vra+59nUyEvSamazQWP7yNimiEOpc8o3NsxpAd
        VnjtLXVjkUi20FJ0BlMjiKrgizaRJ8oyRFYX+uSVMCGrJ6NS4OAyjUobEvgzyQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:37:28AM +0100, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  arch/arm/mach-omap1/clock_data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
> index 3ebcd96efbff..c761e72563c1 100644
> --- a/arch/arm/mach-omap1/clock_data.c
> +++ b/arch/arm/mach-omap1/clock_data.c
> @@ -818,7 +818,7 @@ int __init omap1_clk_init(void)
>  		omap_readw(ARM_SYSST), omap_readw(DPLL_CTL),
>  		omap_readw(ARM_CKCTL));
>  
> -	/* We want to be in syncronous scalable mode */
> +	/* We want to be in synchronous scalable mode */
>  	omap_writew(0x1000, ARM_SYSST);
>  
>  
> 
