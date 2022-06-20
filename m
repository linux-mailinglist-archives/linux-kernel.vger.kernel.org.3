Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2AE5523B8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbiFTSSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241246AbiFTSSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:18:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EFF1CFDC;
        Mon, 20 Jun 2022 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655749110;
        bh=nDybV39t6Bl2Ro8KUpVT1iVcktYwIEWjKEfFqm5iuzE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=dua/itfsyJR4VfJ6JC3yK7eKZyUATPZsQMHr4XcrrY4Xh7RPvLe/N0AYu1mfd5xw6
         piNmzoguBMBwcUsR3Cem7FfELjfelIDaJI/Ycj5GrVFYGHkMYZUi2mJMhBawoopBX3
         2p2QlsGiR2wAgH7VhvEeIuElbvjlp93L08IRXY/s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.149]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQnP-1ntfj91gRJ-00Gt4g; Mon, 20
 Jun 2022 20:18:30 +0200
Message-ID: <6c572704-b39d-34cf-345f-9bd21a18be5b@gmx.de>
Date:   Mon, 20 Jun 2022 20:18:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] video: fbdev: au1100fb: Check before some function not
 needed
Content-Language: en-US
To:     Yihao Han <hanyihao@vivo.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220608114658.37105-1-hanyihao@vivo.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220608114658.37105-1-hanyihao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T0HtqgGBU9PMtL1wyCaJaVllY7W3Te23wRGH4P80xKWO2e9DmIs
 rKNvATaut5ZAvA15JabqNo4LV3cpjzOR4C+PcZYvh4z5AJ66bFZvBjE+I0e65AfTJgzc3oj
 U6/i1fLJFDQ5W8/9ph84QbnK/R27xRrB+U6ORcRf2wJ4aEwTkCm8Kw/Y/Y5yuPIYciHnDPx
 rsNxLoovcieoJC291tXGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WhJrOly8xXA=:EJTzvpjHRGxf9y/PfX/OYX
 bItf/PbMzBg9TJTR3wcWdU/0RdgHCBfBL0BWBlRIZj9ZIXN4ia33UWQ9Q4svWCfpb0RLFvu0n
 JpmmCVeSooAsrG8T/ADmv0Y/tmV27YowJw9uohPw3DgoN66jfjouBnp/Ucd8mwLE6R+sAKH/i
 8u8Lcz6zTwTmxY50hDkr1FKvou/h5PX2jdK1cgN32kxnnWIV3PAKPj1i+GfSrCo1aSL9wJJah
 P2PCbmgrb26DYWdWf5m79JPTQrlrIMNNz6TBo4GZ1depgvUvQYYghsw1vN8XVM/gaYaGgBKmt
 Qf+nrp7LrEbh+CoRtlkgUvrsZuEB7cUSpCXHL2YvC/HTfCrLUdKxd6LER12PORUs3MZ36KYRN
 Y9lePxSv5vXBLuQDgMYpC4FRXsiIuGOsaU82VTYyED4Lsw3x8pBdkmkmzaDsISFww3x+z6A4Z
 TxTFuXGZWb33Bc74YFmRvNLpFC6L+tJKCrKsVLpjaHG5nO//FqmtUyFbDP72WNocqnwCPbh+S
 H5QcbsL3eP1wBw9GQ313/yGvbRQzUa9xVqyW/5g2XyIPjjpW5K6B5/wPuqOa8EPfSx78qEeuD
 WUij41E2uQAJaQO0JtHmkeotBMqce2JooOJKJqq0EgdQm/lKikp6SUxOd8ZF2AkzhI5EfSwRk
 5UL41kUydTaJksXKJq/MrPA7jGsL5QjaEjlWow7nIoNIEfMCmnZyQQ7ffYD9MSMeSk6sXPW5c
 IcWozPgZh80NHxhHIcEldBzjnKbCckzFvoeBgfhEpYP4AeJH4/cEtxrJX5inWKJSXSdZKHaCP
 iNx24ZEik5yMTvh61SdzFpgRJDfDGrTAtKHY4UkPF3UP3S+xPhtKdOCVYdVRv4ssRN/jSbUVR
 Sc84pnLaA9mktMkEdX8KLDJSGLEuUPZHXZFfdti2FTFyA07jOTN0Tmlldx/nJR2dRQVzH1x5I
 BgQJy0lE9o+hJ/I3WCx/V5uOYuy0aWT91jjK0s+7G1q6VH582iZaOk7n7zTU4UFbTUlDhait2
 5I2JvxqDI5x+ZaeczlU0v3/l1jsGffXUicPQpv7vcN1WMusudx7+BmM5ac9B8afMpmmFlQE1t
 y08Bs/gbBCJllusYZAq76fxlL4xkIIcCAkabTUL68I3RXY77MqCQQfPsg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 13:43, Yihao Han wrote:
> clk_disable() already checks the clk ptr using IS_ERR_OR_NULL(clk)
> and clk_enable() checks the clk ptr using !clk, so there is no
> need to check clk ptr again before calling them.
>
> Signed-off-by: Yihao Han <hanyihao@vivo.com>

applied to fbdev tree.

Thanks!
Helge

> ---
>  drivers/video/fbdev/au1100fb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100=
fb.c
> index 52f731a61482..519313b8bb00 100644
> --- a/drivers/video/fbdev/au1100fb.c
> +++ b/drivers/video/fbdev/au1100fb.c
> @@ -560,8 +560,7 @@ int au1100fb_drv_suspend(struct platform_device *dev=
, pm_message_t state)
>  	/* Blank the LCD */
>  	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
>
> -	if (fbdev->lcdclk)
> -		clk_disable(fbdev->lcdclk);
> +	clk_disable(fbdev->lcdclk);
>
>  	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
>
> @@ -577,8 +576,7 @@ int au1100fb_drv_resume(struct platform_device *dev)
>
>  	memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
>
> -	if (fbdev->lcdclk)
> -		clk_enable(fbdev->lcdclk);
> +	clk_enable(fbdev->lcdclk);
>
>  	/* Unblank the LCD */
>  	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);

