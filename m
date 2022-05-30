Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384D153853C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbiE3Prp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242853AbiE3Pqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:46:47 -0400
X-Greylist: delayed 862 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 07:58:38 PDT
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826A21649B8;
        Mon, 30 May 2022 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1653921250; bh=idjzIs6nM/GzEGxcBT5U9Zvmwvs1WbeN6ytiAFKcA/M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qkrj84hcUoYR17888l+IifmTZFDvK4R7zKao/29k7PHMWnpCu9vaUfiQrmwkWOl1y
         J/YgyDDK27WXn2lBC7DGmXHnFaMK6k/T2vlDIQIdk+y7QTc4m8e5LMnvTiN8BA83WE
         T2IpUls4AbmmUkP+8siXcj26vS9kmnJdzB5kTmy6n46485N72bZ0AAXEJPLpgxRECF
         ZtFgGu3xy3rXpEicA2tYLwr8rkH6OWRrHgmNUrVkbci5d9BzDicFN/3j2tu9Gs2hbz
         mrU81t2SiQccsxcpFgS9TS5HIjJ1iH2YFwNGUhlDbfrJa4C6Xh/lSaCX0fEtCV4uNd
         KcJ/TvunmhEPg==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 03A5B3B7DED;
        Mon, 30 May 2022 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1653921249; bh=idjzIs6nM/GzEGxcBT5U9Zvmwvs1WbeN6ytiAFKcA/M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GmWNllcbKIoAUVIxhCH5rQiQpya4rETl28xsA8jdTEkntFAr6kBFjUmW4UrO9Ij/P
         wYCAPYMrPp4MDsff+RVjSUkONQKYMi2vVsSvNO1FSTCrPxafM3gtSp7t+kTDxv9p1y
         O8QnSt5vc5SlVxlbA9vypjujLo86N7qCq8GLUPeC9lwL0qy16xJ2xa3drhaEI0W9JT
         fpJtwULyFvxYyXzNucUVV3I4isREqQ/iY7EZ+OkctOZtRop1bjpcQUzIFawYgpymeL
         se+Dv00LH7Z93Nj87qQESli+MXq6CGxdMKvixsJ/t1qGba5h8hQuw0DMxMBalGZHFp
         P4wn1+pH+kJiw==
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi [88.112.131.206])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id 8B8F93B7DE9;
        Mon, 30 May 2022 14:34:09 +0000 (UTC)
Message-ID: <148d6f7b-3973-0b58-c777-7a3f889d5032@mleia.com>
Date:   Mon, 30 May 2022 17:34:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] clk: nxp: fix typo in comment
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     kernel-janitors@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220521111145.81697-42-Julia.Lawall@inria.fr>
From:   Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20220521111145.81697-42-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20220530_143410_035189_0CCDEF31 
X-CRM114-Status: GOOD (  12.89  )
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/22 14:10, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>   drivers/clk/nxp/clk-lpc18xx-cgu.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/nxp/clk-lpc18xx-cgu.c b/drivers/clk/nxp/clk-lpc18xx-cgu.c
> index c23ac463ab0f..1bb18dc0a80a 100644
> --- a/drivers/clk/nxp/clk-lpc18xx-cgu.c
> +++ b/drivers/clk/nxp/clk-lpc18xx-cgu.c
> @@ -609,7 +609,7 @@ static void __init lpc18xx_cgu_register_source_clks(struct device_node *np,
>   	if (IS_ERR(clk))
>   		pr_warn("%s: failed to register irc clk\n", __func__);
>   
> -	/* Register crystal oscillator controlller */
> +	/* Register crystal oscillator controller */
>   	parents[0] = of_clk_get_parent_name(np, 0);
>   	clk = clk_register_gate(NULL, clk_src_names[CLK_SRC_OSC], parents[0],
>   				0, base + LPC18XX_CGU_XTAL_OSC_CTRL,
> 

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
