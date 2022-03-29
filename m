Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94E04EAEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiC2NkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiC2NkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:40:24 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E72D1CFCD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:38:39 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id k125so14042018qkf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=Ol3Hp+YMfuySWgvy8mFMxAXv90sbOTJsuyiieSGKpH0=;
        b=uWtiNW8FCMmk0oKEj1lpvSj6VTxqSChA1CLjNhZgh4nNFksWEZJP3UhpiHRorzgYVS
         GDKURNQ2RSYUcE1e/4lLkzfcxqdQRRan2aowWp6Rn9zo897pbtFCxhAKAqyxn7ci8e4T
         AQhxJRFOLpBmd8WEdBUcGa6sJSWhPBQCcpHWmGTFlZYVstybbVayYQaMMh5GDO/AmjJq
         EGAihYlBDg3YTxi6gETdllsFzYUw8a60NGW1+hFpj7gD7EUaZIQd4FwP1xl8pGBWXXGF
         EsGq4yPW6ImAeQGFBiAV95QkDeQI8YZ7EZMTdnAJ7W8llq7qSib0w/U+dWwIFy9Sb295
         H9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Ol3Hp+YMfuySWgvy8mFMxAXv90sbOTJsuyiieSGKpH0=;
        b=sae3140HVtovwMPHiGOhIkkPDuWfqvDSctv0nWJCsAAf7yI+XvdmX7LOvCPwYuLBTP
         osm84CDkgKx3ktQELGUzKaQBnbh4jwskzyc5OkcH0MX1mVq7xc5JagQD015udSl6OyQa
         S3wXEkzjpWjPEicAhw+dMSOGxOMEVrTJzrU+idbLV2QnYaPYuojHlksnPCB8iVNimUzz
         SXqxNMnob5ThGZTxVwtPDCmLLc63VJsr2RY75m0EsBQPVU9Tvs5XlN3oZCCgLvWKq/5P
         Fe56xa2yEV4IjJNR5ixrAJHk7DRpw/EjAKAMakuW2vazwlkxPjEqQxihniVlBz8SfNTy
         Thcg==
X-Gm-Message-State: AOAM531HT0a57CzocBpdJ72wG5iJqx4cerKaeW3H86tWn8Q5jN+Y12ip
        KrDLuvTs0T2Sv/gdQRsui++Glg==
X-Google-Smtp-Source: ABdhPJx2ys3r6Td+fhKB2RWe9KMZbIu2iD6bmzq/KiPUzkPdG2Oc2JFJ7L6ZgRrS826lRxgALCpzxw==
X-Received: by 2002:a05:620a:4311:b0:67e:8a0f:4cd5 with SMTP id u17-20020a05620a431100b0067e8a0f4cd5mr20367074qko.363.1648561118001;
        Tue, 29 Mar 2022 06:38:38 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id g1-20020ae9e101000000b0067d4bfffc57sm9168660qkm.117.2022.03.29.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:38:37 -0700 (PDT)
Message-ID: <cb6a47f29c8ff3b6259d8f4b25da6a2d8b57bfba.camel@ndufresne.ca>
Subject: Re: [PATCH] staging: media: hantro: Fix typos
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Mar 2022 09:38:36 -0400
In-Reply-To: <20220326183603.66797-1-sebastian.fricke@collabora.com>
References: <20220326183603.66797-1-sebastian.fricke@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sebastian.

Le samedi 26 mars 2022 =C3=A0 19:36 +0100, Sebastian Fricke a =C3=A9crit=C2=
=A0:
> Fix typos in comments within the Hantro driver.
>=20
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 2 +-
>  drivers/staging/media/hantro/hantro_hevc.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/=
staging/media/hantro/hantro_g2_hevc_dec.c
> index c524af41baf5..c0645e335fc9 100644
> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> @@ -406,7 +406,7 @@ static int set_ref(struct hantro_ctx *ctx)
> =20
>  	set_ref_pic_list(ctx);
> =20
> -	/* We will only keep the references picture that are still used */
> +	/* We will only keep the reference pictures that are still used */
>  	ctx->hevc_dec.ref_bufs_used =3D 0;
> =20
>  	/* Set up addresses of DPB buffers */
> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging=
/media/hantro/hantro_hevc.c
> index b49a41d7ae91..9c351f7fe6bd 100644
> --- a/drivers/staging/media/hantro/hantro_hevc.c
> +++ b/drivers/staging/media/hantro/hantro_hevc.c
> @@ -59,7 +59,7 @@ dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *c=
tx,
>  	struct hantro_hevc_dec_hw_ctx *hevc_dec =3D &ctx->hevc_dec;
>  	int i;
> =20
> -	/* Find the reference buffer in already know ones */
> +	/* Find the reference buffer in already known ones */
>  	for (i =3D 0;  i < NUM_REF_PICTURES; i++) {
>  		if (hevc_dec->ref_bufs_poc[i] =3D=3D poc) {
>  			hevc_dec->ref_bufs_used |=3D 1 << i;

