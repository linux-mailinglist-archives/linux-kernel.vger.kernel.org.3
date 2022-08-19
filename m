Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FC55991DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbiHSAkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbiHSAku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:40:50 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8625FD806F;
        Thu, 18 Aug 2022 17:40:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E8BF05C004F;
        Thu, 18 Aug 2022 20:40:45 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 18 Aug 2022 20:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660869645; x=1660956045; bh=hKTkgJE0Em
        hoc0KV5we9aVtrEb2/1qqim2MoVzcgNlc=; b=e3KNLBFMzdrV5ln0JmwiYxzfz0
        ApOZ4LAZ6OWcQk/D+QdrOpuNR2Z+Cooc2WqCGSLwNDD8kxrvhsdv5xAz4PllADPC
        wM6bTRb+kNxC7J7An7JBHEsOD5aUBKajKWSe/tJeXk8F+vXQKvYaV+qSWudkKtQB
        Q9VoBK7PfLv/WfaJWqZTQDIl7nUIlViLzphq0/jmIVVoYN6yFed+b2uQFr0gar41
        hSDHIo1PE3gnt79Rsud/cSN8b/8WwL0DCljxyllGd7UGRWnJ3XZyFrRnvXdIUmJU
        KCigc3NSBFzhvoNTUBN7VQSrEIBaYzFYWsKPXUzOsUqvn+sLQoN55pqT2U1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660869645; x=1660956045; bh=hKTkgJE0Emhoc0KV5we9aVtrEb2/
        1qqim2MoVzcgNlc=; b=g19ZwDjpwZXpIHfXWknm8aq9Hj+TwAhKOOiHU/lR7CtG
        zAEvnj5oKFXct5/wpjL/FiZPv6q46oVM7/prf7W8p1Wwy2fmqFeieBUa9jSvphSc
        Droaj3pzFKl12Ay1WcP7qlerWvyXOh9jYxQUweCHCIX7r7wuR48C5GLdHbZVLscL
        EyRY+pi+2uGSmNhPa0iq7XszAJlpAr15KqMbT3oaud5QyeTcz1qLtnYYbdIzZcK5
        9xo/o7zEXKLfEtq+8USRydVqJYNkhQVMWVtk7HtAhEU6rvWIETVEEp1aj7BrmH/t
        TZIBLFNm25TNfX7gf1Sk9iizXtFwqnZE43WTAGsfJw==
X-ME-Sender: <xms:Ddz-Ys0-ONHJpseK2y0wnQGeqI2jaAv3nWrptauIQCqO0bZ8U0sVMQ>
    <xme:Ddz-YnEHUZCf2-AnEkql-bV7c-2yTxliygidanxhd5eLaitoi2bq8-eD4makMZNwm
    _eJPWaJqtZPBebOnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeitddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:Ddz-Yk4JvBCnbiGqQKoR1Dzu1dkvJJtUQJYdU6wADRjzzoQErJ1CSg>
    <xmx:Ddz-Yl12N43ZaVw5U-tfGvS2THFrChJL4Z7w-GJk_xKyBYsApQWAyg>
    <xmx:Ddz-YvG39PTDjnc58Umc1jsk_ANIC2uV5JV1Sj5XKtpPC32Eo7Sz2Q>
    <xmx:Ddz-YgOpuE2nfaNANOws3Bi_Zgn2IMZoryaLn1FSe_nZAMA9avIn7Q>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 03D201700082; Thu, 18 Aug 2022 20:40:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <6845561a-cb33-4939-a760-2a5722134851@www.fastmail.com>
In-Reply-To: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
Date:   Fri, 19 Aug 2022 10:10:23 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Billy Tsai" <billy_tsai@aspeedtech.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: aspeed: Force to disable the function's signal
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Billy,

On Thu, 18 Aug 2022, at 19:48, Billy Tsai wrote:
> When the driver want to disable the signal of the function, it doesn't
> need to query the state of the mux function's signal on a pin. The
> condition below will miss the disable of the signal:
> Ball | Default | P0 Signal | P0 Expression               | Other
> -----+---------+-----------+-----------------------------+----------
>  E21   GPIOG0    SD2CLK      SCU4B4[16]=1 & SCU450[1]=1    GPIOG0
> -----+---------+-----------+-----------------------------+----------
>  B22   GPIOG1    SD2CMD      SCU4B4[17]=1 & SCU450[1]=1    GPIOG1
> -----+---------+-----------+-----------------------------+----------
> Assume the register status like below:
> SCU4B4[16] == 1 & SCU4B4[17] == 1 & SCU450[1]==1
> After the driver set the Ball E21 to the GPIOG0:
> SCU4B4[16] == 0 & SCU4B4[17] == 1 & SCU450[1]==0
> When the driver want to set the Ball B22 to the GPIOG1, the condition of
> the SD2CMD will be false causing SCU4B4[17] not to be cleared.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c 
> b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> index 83d47ff1cea8..a30912a92f05 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> @@ -92,19 +92,10 @@ static int aspeed_sig_expr_enable(struct 
> aspeed_pinmux_data *ctx,
>  static int aspeed_sig_expr_disable(struct aspeed_pinmux_data *ctx,
>  				   const struct aspeed_sig_expr *expr)
>  {
> -	int ret;
> -
>  	pr_debug("Disabling signal %s for %s\n", expr->signal,
>  		 expr->function);
> 
> -	ret = aspeed_sig_expr_eval(ctx, expr, true);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (ret)
> -		return aspeed_sig_expr_set(ctx, expr, false);
> -
> -	return 0;
> +	return aspeed_sig_expr_set(ctx, expr, false);

Okay, maybe I was short-circuiting things in a way that wasn't quite 
right. However, I'm a little nervous that we'll end up whacking state 
that we can't restore and give ourselves mux-request ordering problems. 
The Aspeed pin controllers are such a complex sea of state. Hopefully 
we get away without needing to fix the theory behind the driver's 
implementation.

This code is common to the 2400, 2500 and 2600, have you tested the 
patch on platforms for each to get coverage for the various pin state 
expressions we have?

I also wonder if we can write kunit tests to build some confidence with 
the expected SCU bit state patterns for a given set of desired mux 
states. Is this something you've looked at (it would be handy if kunit 
can intercept regmap accesses)?

Andrew
