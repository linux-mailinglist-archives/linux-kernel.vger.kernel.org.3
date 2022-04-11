Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B834FB3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244886AbiDKGUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244322AbiDKGUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:20:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201393CFE1;
        Sun, 10 Apr 2022 23:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649657900;
        bh=DEmNhBL/gohEUMJP8JibIxeatvMiK2dGmVjbuB97Fyc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DTYxIIxSrTbphxaZpPdNkGBdxIx4xgavKoAi0RQpMqIiaOpWpcmk5Z42kBtiauavl
         b3y9WRPtqX8Rut1wKJXPtC3kyBZXNsWWHGXhkSnfwZoIM2stMvQUJdmeEMctK3Lnmx
         8Ofp7p6LJYUWaEuESkPg+XwcEzuetajM+zfvZJiU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.145.57]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MulqD-1nuMpD1OYl-00rsZa; Mon, 11
 Apr 2022 08:18:20 +0200
Message-ID: <e0f26cb5-a67f-dbb0-46cf-441a19a82129@gmx.de>
Date:   Mon, 11 Apr 2022 08:16:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] fbdev: i740fb: use memset_io() to clear screen
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220410202833.26608-1-linux@zary.sk>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220410202833.26608-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wDZTZbxfEuUfXVVlZgGev+nwA1g7MKEILesmHJFJP4UYp3fOPxV
 kWzG+kJJSU0aNzxkRa1b1qqPnAMDd/jWqhk9l9kkJpvVvjWTHNTck+l5ISZB6fKiobMXV4+
 aP2IFDjxT1BrluJrHO5ppdKmmzC2vX18Ati0IYPmbRz1zXFxxEOZanwyZXkgqYqDuqT0T2G
 TNF13pw59FCq/9OoG8Amg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jYWVJBqjH/0=:yYvVfny61rLZJasumIHxC3
 wW2XCQSzcisl+0gcWX8hz1Om40LkQmMfGosY0XsbiPFADJJ6EnF4aNzvQg5egxeo+hPlwgO0H
 HubMC7f5Aff/nypweDl/u288F5XFfur80lXPUu+1qA8u1fsA8Xj5NqcDmOE0Wucg0i4IdFz3l
 9y+EOuzMvq31aSFWACw0dtMy8OLkBXGqwWK7j1b67lOvjPUVlp4nFrXEKU4bXwFkjEuemiaIC
 c57j6FhR9Mv6p2SZNShshJ+SrgPn3lKwNbIT78EKF2d09BUsdKX5/PCQE6dO+6gD8wEfDR7YL
 cF7Vlvie1pZ/qkKhmBRHoeX8RCdpgAuWdtojqTQWqdu0utqCjVvlVsnXPRCk30OqcMPooRnxI
 KePaQufjtB3KdV9pcLTN8GAeo0RHXhw5wsJQmdEA3CFOFWFf2Z2KYJRavI3nRAgoJ9dLMVlEf
 RDzdnrr5LqFvW2dRqmLQhqCUIokrlYBrucABlk1obczZGxsF/wfij+NkHf00S5qqHodeUWe6V
 hcaWpXakqBa/HLBv8Lxxl5anxayH8lBxT5vQEGVpUCmD+zYLTsX0HF8EFRF/cmxqp0fHJwmLZ
 sn/w0HP2RwcR9FHcVcsJ1pL9H12STHj0yx4KGvOegB0NBi8X7Xy7aBSHw49ay8SA8QWJyX0me
 0jRhxS+OPtCguuqpv6HiajLpUw5kgRTxc0i5YKgpbCfGH41CZ6OhP1Ve8eFsvqWIBjr391jMW
 BTljY+rkr0NHCYCptJ5Ok9JJJUpfP+R/MH8doFrkYW+DULuji8YpHmlN58gonxORW5H8hTSZy
 n9RByI80s9CjNb1KMgVljHV5ZInUOagTo6YogNA/46qB9eggZ9TwBrpCAaAPSkGMLPcejCpMJ
 JzjnqM+fyqc0kPXoUB6lPpa+t9WMmNmpqR80NQjJCcrqMNphnTzj3IxsGIYO4pEwFi2XqQNAz
 pTpF/V0R5TZC8TXcAVm2BcGRKoPfuP51l0pzN9yr4vitmT7PbIHHDqKxQioogPw8W3upskaLo
 PO5TcCr1HzgUIoeb28w4Ci6W7pCJvNnTZxaOufkGGgUZ7zN0WcDzB9qxOX4eQWA0BLPzsOs+j
 oZUgAjlooUUGqE=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/22 22:28, Ondrej Zary wrote:
> sparse complains that using memset() on __iomem pointer is wrong:
> incorrect type in argument 1 (different address spaces)
>
> Use memset_io() to clear screen instead.
>
> Tested on real i740 cards.
>
> Signed-off-by: Ondrej Zary <linux@zary.sk>

applied.
Thanks!

Helge


> ---
>  drivers/video/fbdev/i740fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
> index 52cce0db8bd3..dd45ea8203be 100644
> --- a/drivers/video/fbdev/i740fb.c
> +++ b/drivers/video/fbdev/i740fb.c
> @@ -740,7 +740,7 @@ static int i740fb_set_par(struct fb_info *info)
>  	if (i)
>  		return i;
>
> -	memset(info->screen_base, 0, info->screen_size);
> +	memset_io(info->screen_base, 0, info->screen_size);
>
>  	vga_protect(par);
>

