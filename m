Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150AC50216C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 06:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349411AbiDOEby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 00:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349402AbiDOEbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:31:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C458EB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:29:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u15so13490067ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FgxYdQH4K38jxNj0/3LE0gePenpz/atsMgD0HUgrDoY=;
        b=e4jXfgsF5YlWiMUmnnB0B+djmpAX1cPH6imE207G8QL6ayEIlZBgagLfXWWwnJDJzv
         FW5NzNeum50fDZBq4cYUXPV9R9VXWci0YOwdipH3e6iHXVGAHUFxy10UgqvhrtijONJY
         jHWeW9ht6IjUVmu6r7WtuH2LKQ/KB2jekSCBi0XUQlHA3sCCf9Ztk0dD1xmQsJlZX9P5
         rvoBGyE2xUkSy2Iihndwf/vd+tPVNMS//QsL4icjiHBJfinxfkRZRmewG9+Z+3Y8rxjD
         oZsyf3064cyeh8/lMjDebuvCEOv9IIumzIA5qFb1Z9U4tYdJUm7bKKqn7cV7Sq/UwBCW
         H5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FgxYdQH4K38jxNj0/3LE0gePenpz/atsMgD0HUgrDoY=;
        b=QC+Yw7EAQBrlUeCDmJHjVnL5zt1G9twAcqAq79WY7+Or0VTNOSZ7Aa6EkwNCGEAwV+
         2sjL7TdRwmdoOEDvzBKSRrW5uu8TVJ2A+nQIKCXNYC5iZiTfu86OoAs73dwDo836ZxjX
         VGaPk8SoH0kH0aqdosMfrMStdoxHn9JnVnhNjQTqTqmwd5fibQ8ydPRGhISlrvts3hvc
         C/CT1T7a9iinbIkFQ6GvvgGf1565Ab1LkOpfex22WW5PYkNa0+hHdP259EV2p3/5fKjD
         I3ts8xV6OjMnn/ZOspmziooYMB/SCuNPCISvI2c9kNRECugthk1vblRWUXjwkvho4gJf
         iSGw==
X-Gm-Message-State: AOAM5317NSVyLyljWpV1ZlGOGp2lI16pcbEFp4SkpbReVJi4xxSdFHW9
        UTvyOewZcjuS4t9UwzvEh6g=
X-Google-Smtp-Source: ABdhPJxhIdWVi5QikpsHemiGrQkXmL48dWqnyIk/NRWOmMCNgUvcg7ZoWvSluufqF+Nb/7co/OrUKQ==
X-Received: by 2002:a17:906:7943:b0:6df:e5b3:6553 with SMTP id l3-20020a170906794300b006dfe5b36553mr4892245ejo.398.1649996959018;
        Thu, 14 Apr 2022 21:29:19 -0700 (PDT)
Received: from leap.localnet (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id e35-20020a056402332300b004209638cb94sm1960352eda.6.2022.04.14.21.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 21:29:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, Jaehee Park <jhpark1013@gmail.com>
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2 1/6] staging: r8188eu: remove unused member free_bss_buf
Date:   Fri, 15 Apr 2022 06:29:15 +0200
Message-ID: <3608313.MHq7AAxBmi@leap>
In-Reply-To: <e41e0d3b62395d04f41d6934074074c431e7aacc.1649990500.git.jhpark1013@gmail.com>
References: <cover.1649990500.git.jhpark1013@gmail.com> <e41e0d3b62395d04f41d6934074074c431e7aacc.1649990500.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=EC 15 aprile 2022 04:48:32 CEST Jaehee Park wrote:
> The free_bss_buf member of pmlmepriv is unused. Remove all related
> lines.
>=20
> Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
>  drivers/staging/r8188eu/include/rtw_mlme.h | 1 -
>  drivers/staging/r8188eu/core/rtw_mlme.c    | 7 -------
>  2 files changed, 8 deletions(-)
>=20
> diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/
staging/r8188eu/include/rtw_mlme.h
> index 1dc1fbf049af..0f03ac43079c 100644
> --- a/drivers/staging/r8188eu/include/rtw_mlme.h
> +++ b/drivers/staging/r8188eu/include/rtw_mlme.h
> @@ -319,7 +319,6 @@ struct mlme_priv {
>  	struct list_head *pscanned;
>  	struct __queue free_bss_pool;
>  	struct __queue scanned_queue;
> -	u8 *free_bss_buf;
>  	u8	key_mask; /* use to restore wep key after hal_init */
>  	u32	num_of_scanned;
> =20
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/
r8188eu/core/rtw_mlme.c
> index 3e9882f89f76..aed868d1d47b 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -61,7 +61,6 @@ static int _rtw_init_mlme_priv(struct adapter=20
*padapter)
>  		res =3D _FAIL;
>  		goto exit;
>  	}
> -	pmlmepriv->free_bss_buf =3D pbuf;

Hi Jaehee,

"pmlmepriv->free_bss_buf" is assigned with "pbuf". The latter is a pointer=
=20
to virtually contiguous memory which was allocated by vmalloc() or=20
vzalloc() (I didn't check, but the vfree() in _rtw_free_mlme_priv() tells=20
me that indeed it was).

>  	pnetwork =3D (struct wlan_network *)pbuf;
> =20
> @@ -109,13 +108,7 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv=20
*pmlmepriv)
> =20
>  void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
>  {
> -
>  	rtw_free_mlme_priv_ie_data(pmlmepriv);
> -
> -	if (pmlmepriv) {
> -		vfree(pmlmepriv->free_bss_buf);
> -	}

Therefore, here you are causing a memory leak, which is something you=20
should avoid :)=20

Why did you delete that call to vfree()?=20

I think that you are misunderstanding what Pavel said. Even if it were true=
=20
that the code makes no use of that region of memory (again, I didn't=20
check), nevertheless, that memory was allocated somewhere and its address=20
is now in "pmlmepriv->free_bss_buf".

If you can confirm that this memory is allocated for no purpose you should=
=20
also remove the call to vmalloc() / vzalloc().

Thanks,

=46abio M. De Francesco =20

> -
>  }
> =20
>  struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/*=20
_queue *free_queue) */
> --=20
> 2.25.1
>


