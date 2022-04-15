Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B848D502375
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349805AbiDOFJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351395AbiDOFFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:05:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1596DC12D3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:57:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i27so13595495ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Deay7jAmMyRkDMzIjU7u06qBsjafRlssFVmGBUZbhvw=;
        b=YQ6/ULXIqpRb6u2jK1rgfGvE2zKp6qNt/qMH3C4USife7fpyw4LLsmAcimJDnKOe4t
         Mknnm8W7b4si5hzaJWBPPgdNQeJy2y9pZpGRXyU03ZJ9UWdf87vYVI9++NpwSPER2iO4
         d/flzGZ/3HQGZaf9+YLJepv64IEmekwR29w82r0+umht7DvATM5oSoEtRlkQ/1xszB/G
         IBBs+tok9EgAEcCNkzZGBuOMttHK6F3H7pFcHIOBBsYxD0LcGL7XYYXRoASiXGzV/JUG
         UqL3mzraRklxEXvdVLpBTN/iPApA586HvYoDhXKdokmtrnrxrJw61Gsy87S2n3YgR40Q
         6axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Deay7jAmMyRkDMzIjU7u06qBsjafRlssFVmGBUZbhvw=;
        b=vI+4NcQnhPUR9XLe9y7K7jTkhbcgO33itmRevLMGFg2Zz5LB6VAdE0DKX0m+Ze96RV
         ihdM9VgJmfgyrYv1GE0ZlMEz1LyfZ8kyWpOypDsqRrDxwN86DA8g0A46yOt3GubmSJig
         GaBGbko1jgsMFUdY/3bg4wmosWxDPjvVRWsSWHN9ffrEg78JbwfE1iPjZ+N5J61kpI0V
         z00HM3/XmnJwvSyM+wf6JU1JaE+ZT6ZFfdAHqm+wgOMwfHOOy9XUTsoXxz0k9yFiQn7Z
         SZMZQdHjxn5dcy8cdfNjAjzVgR96ipJvI5oGk7aoLbZJfxXG2a9JealzDTDFzx1w3oTi
         84Fg==
X-Gm-Message-State: AOAM533qimdA4KAKonqRwciSjrAaH8izGO+A/Eo0EtJ02yWQ9PHSfK8A
        h0z0eSKQVI7d5sTiAuhQ96qnd5+WvQw=
X-Google-Smtp-Source: ABdhPJxT+h0/uUni34qZRuQ/eKcZmKWVus9qXtZAnF8iOUd5G35juUA2O0IghxZcuE5B4CBxO9GVZQ==
X-Received: by 2002:a17:907:724c:b0:6e8:59c1:914c with SMTP id ds12-20020a170907724c00b006e859c1914cmr5180940ejc.172.1649998675372;
        Thu, 14 Apr 2022 21:57:55 -0700 (PDT)
Received: from leap.localnet (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b0040f13865fa9sm2017964edt.3.2022.04.14.21.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 21:57:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, Jaehee Park <jhpark1013@gmail.com>
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: Re: [PATCH v2 4/6] staging: r8188eu: place constants on the right side of tests
Date:   Fri, 15 Apr 2022 06:57:52 +0200
Message-ID: <2300552.NG923GbCHz@leap>
In-Reply-To: <baa4d5259e2eb48da1dd71e1863b62a086312a7e.1649990500.git.jhpark1013@gmail.com>
References: <cover.1649990500.git.jhpark1013@gmail.com> <baa4d5259e2eb48da1dd71e1863b62a086312a7e.1649990500.git.jhpark1013@gmail.com>
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

On venerd=EC 15 aprile 2022 04:48:35 CEST Jaehee Park wrote:
> To comply with the linux coding style, place constants on the right
> side of the test in comparisons. Issue found with checkpatch.
> WARNING: Comparisons should place the constant on the right side of
> the test.
>=20
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/
r8188eu/core/rtw_mlme.c
> index bb9d595a90b9..d57f2ffa069e 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -715,7 +715,7 @@ void rtw_surveydone_event_callback(struct adapter=09
*adapter, u8 *pbuf)
>  			set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
>  			pmlmepriv->to_join =3D false;
>  			s_ret =3D=20
rtw_select_and_join_from_scanned_queue(pmlmepriv);
> -			if (_SUCCESS =3D=3D s_ret) {
> +			if (s_ret =3D=3D _SUCCESS) {
>  			     _set_timer(&pmlmepriv->assoc_timer,=20
MAX_JOIN_TIMEOUT);
>  			} else if (s_ret =3D=3D 2) { /* there is no need=20
to wait for join */
>  				_clr_fwstate_(pmlmepriv,=20
_FW_UNDER_LINKING);

As Pavel pointed out, "s_ret" can not ever be equal to '2'; this could have=
=20
been an opportunity to remove a couple of lines of dead code and add one=20
more patch to your series.

Thanks,

=46abio




