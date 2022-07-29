Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82186585659
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 23:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiG2VA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 17:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiG2VA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 17:00:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EC62CE2A;
        Fri, 29 Jul 2022 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659128438;
        bh=Ktqdjqu+6Rheao55tLBKwaUTf5LNpkYU9YBAv8YJN8w=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Vy/sdIzFBVYlgafnkF5OqBRRyBQdbmv08mLBfQiEKzeVkeMrl1S4zhwDvQ6lu03Il
         Wcu4b0WyLof3YsvhAy6QdbuPn4AF7JvGIuN1jF25pu1pS8IVr8vixt0zlWzDCEMspf
         mE/MWEU5vWIEO/Nh+el1R083sozed7WMnIJP7seU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.189.204]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1nikVj1j7Z-00ZeBp; Fri, 29
 Jul 2022 23:00:38 +0200
Message-ID: <c23d058a-4dc0-3877-083a-2476ba4e1714@gmx.de>
Date:   Fri, 29 Jul 2022 22:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] video: fbdev: imxfb: fix return value check in
 imxfb_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     u.kleine-koenig@pengutronix.de
References: <20220729024134.159942-1-yangyingliang@huawei.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220729024134.159942-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SiuDRY8Bd5qRt2CpLM3WzAW+ejCYC4ZwYRSYz3iy3fq/YAyfSb3
 u+IJQL7dsjhX0gtqoSIUY3RVYDiG0yQ4GBdD06MTOmWhs/hvos0qDshahQtY5T17DBNGQpg
 dSBFC5INj8GjqYxdsIvGWWUTR0b4KcAjIuzzDOM93cLOdfmNo27NoYdTmXrSAm69nsNWeYD
 iir7V1C5ixec7wtA3SxlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SWiYiZMdrx0=:z/J1yJxGJ0BYoUpshkPa6W
 LxjBNDV0tQsKq0aAgxKs/56bLD8fw5H06GMASLPKlqar71ILprIbcXqIqjpZOOnhkHka0oVmx
 LiP8dhHGWmIIntGsWgBq0dn4bW6sxcrZcVBDQ6qy3QmLy/cfMZe5kZCu7T6feLmHJijAWxBp3
 MVymZhfK7Sa/1vMUR7M/duVBSP3qBnGiV7zSs+S9sGvEzuf0kJA5H2rgJMMHTVn/x6qCZylsa
 j9BSsDbfgFtqvxYKaX4hOOfkSwkf3mlt+MAqkteMmzRBUFBi5sJn0IvTh0xDUZ9jUJnEe7gkG
 hrzbNKRgej4MJuH4MuTPR8/yq0tRmB5fX+nAqVg90lie6n5ou03xLKt7Av/sEzAIh61ptO0YL
 CgOs/1pcSz5MuTkWQdayBPMKtdDq2BEQr5n8w5YSE1RXqAIQ6HfnyLZ6FL9TD0y+KS4My8c+q
 qesySeoyioiq9IQVpaHDfZlK2xqxjcWWF11q3StwOPlfCr3gsx/K/JARGnfRkQG0PAf0a//jO
 WZ0CjCQtFdLDLaxu1bj9X2qwPbIIHC72W72wwS96LcVM0ihW7wTlAhzJirjrvMSPKjS3Kza31
 ZLyeoEOVStY+5YdrS06stJ+IQu+njjUgV6ualCkWIHmgat9+oK59kjLLKE6yoHcaQdDCeVoJJ
 9ZdVLLCMMkVbGWA0WmlQzV3ypI8pQXnFLGiC7y5b66VReVhyggnVHEDcT1lY4WahrKsyzmQ6q
 n60jMEan2k7gbEaG+trZbkIZpu7FTmeX0U96m0oP4+zzeSHHURPzXLCWbFGv0lOtOig+832pg
 WENPIPlJNelJ4hBgR1HOhn/lEjaR/BaXISohyM084WgCnl8Ef+BWrkRKKx3elNdiV38t+Thnc
 pSssYAFlASOpbbJSn+T91WtZPqADAalHuGS651mGQSaw3Dqt20mtdsA04eJ6d+KG3otxYX/6z
 K9d/WirI7B2MLNDUVJvnEnUvsOEji4deCsCuGy6V4m4/EKhpiWnZykT0Q3R64+qPFkBt+YW0H
 +s3X394t6VreiEV7jII5xBu/YiKPWsoa5q1xVDTIqK82N5rtDdYz2Oq6sN4Ed3LdT4b40iUSw
 3EhoquAWMFgA5rm76mK8F4Fd+W2hab90cXRzz5525okj1pqCOYn9UkH5Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 04:41, Yang Yingliang wrote:
> If devm_ioremap_resource() fails, it never return NULL, replace
> NULL test with IS_ERR().
>
> Fixes: b083c22d5114 ("video: fbdev: imxfb: Convert request_mem_region + =
ioremap to devm_ioremap_resource")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

applied to fbdev git tree.

Thanks!
Helge

> ---
>  drivers/video/fbdev/imxfb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index c48477893dd0..d97d7456d15a 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -971,9 +971,9 @@ static int imxfb_probe(struct platform_device *pdev)
>  	}
>
>  	fbi->regs =3D devm_ioremap_resource(&pdev->dev, res);
> -	if (fbi->regs =3D=3D NULL) {
> +	if (IS_ERR(fbi->regs)) {
>  		dev_err(&pdev->dev, "Cannot map frame buffer registers\n");
> -		ret =3D -ENOMEM;
> +		ret =3D PTR_ERR(fbi->regs);
>  		goto failed_ioremap;
>  	}
>

