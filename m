Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C019B5612C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiF3Gwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiF3Gw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:52:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2CA31383;
        Wed, 29 Jun 2022 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656571934;
        bh=ZU0HKrj/U8Ky903QI1buKExZhrj7mMmS2iFC6fGomSA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BPRpkDGLZ8JerUWKg3YxeyOz1mG3U3AJFEKMR1oVNymBxcF5WPPggtAgI2W+v18v4
         7iPmwMo4DjgJtwVKPRxMdHVtEfPBkCkvdTcfbYzHaUUkz0VPL0Fu6h5cMzQJdaap5N
         FfaVUzip5JFnTAJOKmME+SKDLMy22Jem9PjZA/qU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.136.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTABZ-1oCXsv2XjL-00UXU7; Thu, 30
 Jun 2022 08:52:14 +0200
Message-ID: <9eeb98b1-b53b-f90a-7610-5d40509d8204@gmx.de>
Date:   Thu, 30 Jun 2022 08:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] fbdev: fbmem: Fix logo center image dx issue
Content-Language: en-US
To:     Guiling Deng <greens9@163.com>, daniel@ffwll.ch
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220628163641.4167-1-greens9@163.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220628163641.4167-1-greens9@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:StuGJg+gOrxZU2TSBaJ8FvbtcixzBEVjwjRW/XpF+r7xjRTqsbA
 L1foNai+z+dE3b12FpLtKY8bsEAjKmLkj0YHIk9W0if8S/kByI417rYFOfuNCk/SJSeTl18
 Mu28R8moWuoohDBYds+JRUtU0dSaJDo7XN76BXyZnxMZOFhIQ8mb8f1ky18H3V3kE7g6QNR
 ZRJGSA7N3Ab8VjJSu3jyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nvcOhbkODdE=:Ai4lNZWMkIN1tgmRB6ou01
 9xmzZAukr7+lp4SM/jpnY7hyqhQeEe1FY9n23rjdzidoURTHkTwUnfdL7OHjH4fo0/UvL5Co2
 Fec5WoV5TGariKDl1aALOMzaX1FKwS+ES/szQMfQ0hsFdI6cvXJPelT9OBx1DAh+0GbgH9V8H
 57UgAEF4pShZjyVEGFIQ4xD4hebXJkGj4Tk+m3ZBdQzB6YWY70fqmhphTrNfVDh3RVyx8fSIm
 CZd63lJariinn290Abmv3/t1L79ng1FBjgDOnQKJQsZFR3lW2+NjH+DCLg565Cq6L8lpiT5lv
 w+QwERLA8BBnj4wGp3LOrrvqaZ50oMxTqcDTcvOBf6c1waoab1qWE4vg9suPFjwVr1kfVjvVy
 lAxZaCyPFdNK9S5yrNgOrih4/J5Fa7Xck7MicPrsVO++HzQdwMcs3p72FRMWDSR+qLJIM8WcL
 CzgwIuZvmKFFIzJGZyHBfs+rDM3+GG5Syv5+8pjM+dKzAsHTRgFHZnWchHhCAFUp6LwUXu7Gy
 HrEh9O7FdPFMj6Da1z1rPkYqVgyqw8tLlBwBAMyUPMCO0dx72bArxhebskznasKxt8R81ya/z
 CWzvyE5g4WxUPGyQrjkYlRHhxBbq28xmHTo80QDBwtRgWzgPds7xySISk9NdBmwS1ZK7N256b
 NVjVIvIz+iShIAHpUGajBkwqHf02OVno0jGo/hulWwsdcFDQTGsBBTVQ7ypimF8wklEW0wx/0
 7R72NZ8wm/3SQr9Z5NuU42v25YQ2K2BvttjllRn7puIp9hZhspJVKQ9IzmpHBBRdZWeBH0QfB
 GrFCIaDCpAXzStJd2GFAIlCefeQPFhozC4CLtlvHzvJlq2Oc27472T23ipdj4cK1JZoGrzYwt
 9fCwO7m0WrIivUnDoPQhikRyFq9z7AzKv1rj6XOYFq3AbNgGUwaNCKiorGsy3TWwpILDjH9sV
 KUVLLwTSaM1376tAz6NwgyYrjBspBmj/2QLPT3oMcZ/EzOplQqr6oXtAd0dam4EzIOhiMaGEB
 0Ms541SzJw41/DAph/7j9/Vy+79O6HGCEdLTrI3t0Ytqbkldm/Skj4B6arn4g0vcdrB9uDvFw
 FW86Hv1VrLEq/5dJzQUGTFGRtrMboCRsWEk2VE479ILHkoMPDYHToRhlQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 18:36, Guiling Deng wrote:
> Image.dx gets wrong value because of missing '()'.
>
> If xres =3D=3D logo->width and n =3D=3D 1, image.dx =3D -16.
>
> Signed-off-by: Guiling Deng <greens9@163.com>

Nice catch!

applied to the fbdev tree.

Thanks,
Helge

> ---
>  drivers/video/fbdev/core/fbmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core=
/fbmem.c
> index c4a18322dee9..1fd2bdb11266 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -511,7 +511,7 @@ static int fb_show_logo_line(struct fb_info *info, i=
nt rotate,
>
>  		while (n && (n * (logo->width + 8) - 8 > xres))
>  			--n;
> -		image.dx =3D (xres - n * (logo->width + 8) - 8) / 2;
> +		image.dx =3D (xres - (n * (logo->width + 8) - 8)) / 2;
>  		image.dy =3D y ?: (yres - logo->height) / 2;
>  	} else {
>  		image.dx =3D 0;

