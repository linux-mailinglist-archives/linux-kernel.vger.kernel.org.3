Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28439588CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiHCNR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiHCNR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:17:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244F018B39;
        Wed,  3 Aug 2022 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659532639;
        bh=2uXVOsfdm/Cp3uY6kF6GOzfMslaJ+Q2URlY6OMkhB4k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iUwyh9kivAhjHDlcF29t/6ST0ba/e5FHfKgjwoD9WzmxwR57Fevoqu7kmOaNGXP1x
         JF2oY6YA2UGTTF2yR+zB52qlz4SeeSDrnoONmPggQnpiRXKUUBFW//BRXsskDZbv9z
         E5FzmuyroQmiHk8W8RoZ5ZNMgb8RSzqkFaAAQUqU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.136.66]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRVb-1nue1M2bf9-00Xx87; Wed, 03
 Aug 2022 15:17:19 +0200
Message-ID: <cc6fd011-7859-3e3e-b5dd-54cdf0d4c348@gmx.de>
Date:   Wed, 3 Aug 2022 15:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] video: fbdev: i740fb: Check the argument of
 i740_calc_vclk()
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220803092419.2821723-1-zheyuma97@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220803092419.2821723-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eRSeW4PJIGssh/5M3NkXRiTW3dOVBM6Og7Z93prx9vqyWoQpOh8
 Ax0mO7cda3IQIsEZLIV2zyez3BqNfDOzrLF9FRn4Y149joFv74w0gapuLID3YWN6xHfg7H6
 lPwPNaENP0Jts2kzu5PeY5OMtw71VWxqePrTSL8S4Hg/knmz6BR/6uj2w2YATuGuD8sFYIH
 CBCf40KUfpMZuS29jb9mA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bWjkjY+hQbs=:gfeB4WA58CZy4EfG67nxkX
 5cXuvP7udvnFQMddeAmaWjLy4aDBDevEv1vnxaMOetJrOh0AXkmUeQ40uo07yKan1/HajTdDV
 8bdJ1Ofx2eUvS95aoLDrl5DfRhY1cKU9n+o5WMDn4o2F9Hv5WB+iRxrNQNdNdaPz2Oatpkazu
 AaBHb8kTvi62/QkoKRJtOY+5M9OXP1i73DwGqfh2QHuQCSvNDwfAfUzKE/GGG/vYvdfUzcLcC
 ZOnsHOGixOTFEvyiwdiFZ+rltWQKO95w4nkJgL/IAJvkXmImufnQlX+OHOR9qIpi8OQAcxMC5
 qls25f6XB7HVp/iyguytExp4jODLx3iIDSJS4bSHzLlPR4bPim7zvWguO+3MgQYfs/mvV2uet
 V8pmv9gmOrkoeVTnLqRcNpsKnKT1Bf6JGOmqHm2qFsZ7eZvyiH/pnj5pCMXEhQdtkwXyNPlvC
 7u0URUWrvpQNxVVGo8Pe0FVUO9HNqtTbYWo0ezoXGA2v4NheOJkkSgN2nWGtyo/THJtafBxPu
 F21q4g5aadCIXckmq6k0aRUo48gnlmtP7TVGHZxthDRLR2KLiOd9gpo0+1vn9vNBJbBvRvJWM
 qGp61OSRW9sq9ZIEB7KHoy7zQMxicKL+yi4ktNO2ygA+QZOy0+UyUXGaxHsmWulXYLChxXGjW
 8Yjbb/RtZG7u1T22+NesNyr+TOlSm5ZyczdCljK0HyuTg+A6AfoX4YjxwX98s1jO8pVGki6et
 ItSt1oOlQy2URTxN3Qz88Yo4KIaiZ9Ac+lbO1JUGIUO0b0iX8oo/IvjTAZLDSK4xvI8tBdOkw
 0FwrnpNBKU9bIJ3WPFkbKZh4nJ1ygVaxVC8ny0GGu9l+W8p2pAhcdbo3hEuCT5RngnYhyEt+S
 dstUFK2wqvMOMQhXe+PfD1PRxZTHZ/6zbXtpD4A6s2XOFse3+XLrpiWXZuq3oustBY5Y77PjN
 cz1VkSmhF5hU/nPxh3xK6bkqIPeIgE6agvVw3EFDoge/5NFJfGxilk3di0E59+O0CFdJ1dWpq
 S7xWnwxsIpF8ymELT9uCuOTtlbmRlksnhbwr/w+JC6LmqH1smplzl8wJSjaLQCacwiZPQJWi6
 Gh4BR51KJlcazs5ZE9vYGjkAxugC+tzlGvqNIKVKRD3bZD5zuDfDNOunA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 11:24, Zheyu Ma wrote:
> Since the user can control the arguments of the ioctl() from the user
> space, under special arguments that may result in a divide-by-zero bug.
>
> If the user provides an improper 'pixclock' value that makes the argumet
> of i740_calc_vclk() less than 'I740_RFREQ_FIX', it will cause a
> divide-by-zero bug in:
>     drivers/video/fbdev/i740fb.c:353 p_best =3D min(15, ilog2(I740_MAX_V=
CO_FREQ / (freq / I740_RFREQ_FIX)));
>
> The following log can reveal it:
>
> divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> RIP: 0010:i740_calc_vclk drivers/video/fbdev/i740fb.c:353 [inline]
> RIP: 0010:i740fb_decode_var drivers/video/fbdev/i740fb.c:646 [inline]
> RIP: 0010:i740fb_set_par+0x163f/0x3b70 drivers/video/fbdev/i740fb.c:742
> Call Trace:
>  fb_set_var+0x604/0xeb0 drivers/video/fbdev/core/fbmem.c:1034
>  do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1110
>  fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1189
>
> Fix this by checking the argument of i740_calc_vclk() first.
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

applied to fbdev git tree.

Thanks!
Helge

> ---
>  drivers/video/fbdev/i740fb.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
> index 09dd85553d4f..7f09a0daaaa2 100644
> --- a/drivers/video/fbdev/i740fb.c
> +++ b/drivers/video/fbdev/i740fb.c
> @@ -400,7 +400,7 @@ static int i740fb_decode_var(const struct fb_var_scr=
eeninfo *var,
>  	u32 xres, right, hslen, left, xtotal;
>  	u32 yres, lower, vslen, upper, ytotal;
>  	u32 vxres, xoffset, vyres, yoffset;
> -	u32 bpp, base, dacspeed24, mem;
> +	u32 bpp, base, dacspeed24, mem, freq;
>  	u8 r7;
>  	int i;
>
> @@ -643,7 +643,12 @@ static int i740fb_decode_var(const struct fb_var_sc=
reeninfo *var,
>  	par->atc[VGA_ATC_OVERSCAN] =3D 0;
>
>  	/* Calculate VCLK that most closely matches the requested dot clock */
> -	i740_calc_vclk((((u32)1e9) / var->pixclock) * (u32)(1e3), par);
> +	freq =3D (((u32)1e9) / var->pixclock) * (u32)(1e3);
> +	if (freq < I740_RFREQ_FIX) {
> +		fb_dbg(info, "invalid pixclock\n");
> +		freq =3D I740_RFREQ_FIX;
> +	}
> +	i740_calc_vclk(freq, par);
>
>  	/* Since we program the clocks ourselves, always use VCLK2. */
>  	par->misc |=3D 0x0C;

