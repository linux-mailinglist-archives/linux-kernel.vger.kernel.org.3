Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978444A5B42
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiBALek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:34:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:50575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233560AbiBALej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643715270;
        bh=4T9RDTLAr0KcpEvaIH55Bk1wM7UlBol83f6Gumr1oQc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=aQ7cVv7O6Bql8HHixoJaMPIfib4BrLNPDMLB3e5mLTZQsZRHvtipBrHszj430jBzo
         uofR8PJosaIiI4AikVkLooCk07g0A097724LAXpLtbkxNvlHROvfhqDTFCcp0+9AY5
         EPKGVkAUy3JI6QQFnjcMWEDNlI9cmsTKuHjkdIBw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.146.124]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCfJ-1mjsIB2eK9-00V5UA; Tue, 01
 Feb 2022 12:34:30 +0100
Message-ID: <dd999255-5a3e-80fa-6c13-287ba6aa7bcb@gmx.de>
Date:   Tue, 1 Feb 2022 12:34:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH -next 1/2] video: fbdev: pxa168fb: Remove unnecessary
 print function dev_err()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220201062633.102519-1-yang.lee@linux.alibaba.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220201062633.102519-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7TIhoWnCFwcYD+6lyAPYwUlkSAKdBfZg9gO2QgIrAzZn4YrMuQi
 2Mz6h3koks5vciCXOer/qt4qcsd51ayCFRB3osBzV+AZzEDi2v1X+GTKDzlkhzsnDJkwqmx
 CS9LXZUZuuRffPhp0hD4km8xBaRpb0QDCvxFCECMYIOf742PhGyzvDgP3FXOxD8gWRY2elU
 Vc2Oacl2jPfDIZrVy0wFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ckmF39JFUTw=:JYMFqTl+/vuUllTRQqe7mN
 wfKWqR+TRfoarZ0DVwFxOTUj0GPYEhid8ruhDW61RJ+4wG/8uADZk8De1/HJwJM4RrDN5KvWK
 PglIKzQ8f1vgVSLD9ZFgSpXylGU1TVUgwq3GvAMs/FJ969UzpqjgqlTb+MPSnRwDugByX1gHq
 gJRe33JaFKmBlsG1cUOvn4GXM0KWquABorRAIZbUfsDiDUp8Jhrl/YUMiIi7BiFFLZd99LAic
 YTjBna2HhoahW3W8S3okg2Nx2SRbU4VmeCSPYtWKaEb7A6+6tsqDSO0tigsS8U52N7S1Ruwpx
 y1+RtP4gSFxw8nWi9kvaJT3YLyX8uqbyCaEKAygCJEkL9/TMl2iAzI9UlAbmAcwCKAcoJbKVg
 zuX8jB+Tel8vbiDlDHfoAdc0/Gghqqtad2Z+uA0QWWUWj2kfwKYE2gyR0D58cpBQpIKYD5lv1
 lKM/a90AlZEkr0X9d2OPfceAVmXNf7ds9dpdTXeH44TuOMJfuT4CKeECxtjZqUaZPoRieIWs7
 o3QnfnC99XwH+JYdF0cb/72WcKicQKfVV3rsAGpDeYFxyyVj4AhSpYBajXCT0EhJYWLIPzb1x
 0/FR7SpU2SyKic6J2o68vyIdb3SkcC1tituX/1fCIiwQapqZ5VWeQmU2ZOqxoEn1qCrqQox31
 OdFZN8cKc15xXjoQqEnfSBWF+Yk4defv6AZNfcfRi65jK+HK+zxGiQLjvrXveFjOQDwoMrw+I
 oa52w+8590vnLHqesOMLGVGLTopMGjwXIhkmoRvDSzi1KMHksjNkAljtySaxRgqykyaM2zTad
 ANKDg55mHirrKqxpBZmqtAupDhZK3P7k5JRZmjgw7jGK91vlmSjVGkKnE/CL+UhSpo2Jbwdkb
 TcstBKS86NC5DbAQXXElwh2AI8/dyK8H7NV+KiQCGNxQoeNeXT1D8fsmOUuuIiqJh4kN8D0wy
 rIOW7ABCtt2zuwfZMKEiuQvSoPOMIvBV1IUll3mkyljeR5S8UVYkBi9DG1HJyXZfgDIiKy5bw
 DktfRqWJ25Lr3lekoTkHgXN7+TGCooCzoXgmHlr2cHdmPY4185EiW1bVgxfvBFUHWUQknPLRg
 hhBfMySA3fKWzk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 07:26, Yang Li wrote:
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
>
> Eliminate the follow coccicheck warning:
> ./drivers/video/fbdev/pxa168fb.c:621:2-9: line 621 is redundant because
> platform_get_irq() already prints an error
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/video/fbdev/pxa168fb.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168=
fb.c
> index c25739f6934d..d533c0bf7031 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -618,7 +618,6 @@ static int pxa168fb_probe(struct platform_device *pd=
ev)
>
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "no IRQ defined\n");
>  		return -ENOENT;
>  	}

Please drop the surrounding braces then as well in both of your patches, e=
.g.

	if (irq < 0)
		return -ENOENT;

Helge
