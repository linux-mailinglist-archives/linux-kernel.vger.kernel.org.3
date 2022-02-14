Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC91E4B4517
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbiBNJAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:00:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbiBNJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:00:09 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8B15FF02;
        Mon, 14 Feb 2022 01:00:02 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u6so29184937lfc.3;
        Mon, 14 Feb 2022 01:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=5l+v5pzNn5KQVnCblsmvtHCF/M7BFv5udnT/OOc7mTI=;
        b=T22CPkeKleiEtfoVS9g2HIynFn43DvOSEhaNAsox1+oZQZIJ5VYAmqM6fOIhGPjNGR
         l/ddwTCM5DeYuEmDzmb1FjFva1oj73R7Ab5EW7J/fILB0mAERhcdaPHfN9GPY8zt3ZJq
         uP+1jMPX+wqmhIIGCCyEWX4dUe96jnQUkyuGzG8xL+xN/Vc4YXTucJjHv4PHgTxe5FQu
         cSqahqXl125mcNUwnJ9G/Olk5Apz6EMWQfl/oJJe5ZK0awgGiiFisMQ/6TWS0Fzi2f8w
         dPyva1LWfjzn9Xi9k2SVdZwTryQenS7blMt5WeVLi9IwgYoFRCH9BfpW782ome9OMtZp
         ns2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=5l+v5pzNn5KQVnCblsmvtHCF/M7BFv5udnT/OOc7mTI=;
        b=Htb+o/lc09TpYpbjFohVPv7jXUBlyNzTR+Fj6XIHHARfoa4B5JZtcQiCVYgl6XUt9I
         Wde+UOU/SguM4R1H3ibX78uxH+PNjmTxawFmxHs8GDSCKoWntjPQb+yTWQtNN7g8vbIJ
         B/zZHKM9fhHgMnn7buQAWasTzdkOSDCcBgyYnDrR98ih8pIydmCnFmFHMNEUvboX4s2t
         lNN4nNf2V6ttjoCRJHFRYZTlwr0Oa/JDXk1dDPgwLid6WMg/dmhrd/NkIR0b61bjoOYK
         sektj8bPBeTONztWSeaoPs218Fp5fDGS3ZQSaGaclhRSxtoD2mekFZYrPJwKQOppN/kY
         CFUQ==
X-Gm-Message-State: AOAM533UCKfeilzgoh0357EpNCxP+wAZFeOagWzxUUM0SmaFTI6dORsv
        ZwYGxO3EBAFKTxm+bswnGco=
X-Google-Smtp-Source: ABdhPJxhJC87IskBvz+AIuUlSPJygS43mqmjho06rx5ZeM+1LclmLcZl0OXccErvkbzjxDrFF0bZfw==
X-Received: by 2002:a05:6512:70a:: with SMTP id b10mr10225611lfs.672.1644829200579;
        Mon, 14 Feb 2022 01:00:00 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id bp37sm3814816lfb.86.2022.02.14.00.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 01:00:00 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:59:50 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] drm/doc: Clarify what ioctls can be used on render
 nodes
Message-ID: <20220214105950.7e399705@eldfell>
In-Reply-To: <1644433047-20753-1-git-send-email-quic_jhugo@quicinc.com>
References: <1644433047-20753-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=kW+PCAj.SVDDFlVSKplH9l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=kW+PCAj.SVDDFlVSKplH9l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Feb 2022 11:57:27 -0700
Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:

> The documentation for render nodes indicates that only "PRIME-related"
> ioctls are valid on render nodes, but the documentation does not clarify
> what that means.  If the reader is not familiar with PRIME, they may
> beleive this to be only the ioctls with "PRIME" in the name and not other
> ioctls such as set of syncobj ioctls.  Clarify the situation for the
> reader by referencing where the reader will find a current list of valid
> ioctls.
>=20
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>=20
> I was confused by this when reading the documentation.  Now that I have
> figured out what the documentation means, I would like to add a clarifica=
tion
> for the next reader which would have helped me.
>=20
>  Documentation/gpu/drm-uapi.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst
> index 199afb5..ce47b42 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -148,7 +148,9 @@ clients together with the legacy drmAuth authenticati=
on procedure.
>  If a driver advertises render node support, DRM core will create a
>  separate render node called renderD<num>. There will be one render node
>  per device. No ioctls except PRIME-related ioctls will be allowed on
> -this node. Especially GEM_OPEN will be explicitly prohibited. Render
> +this node. Especially GEM_OPEN will be explicitly prohibited. For a
> +complete list of driver-independent ioctls that can be used on render
> +nodes, see the ioctls marked DRM_RENDER_ALLOW in drm_ioctl.c  Render
>  nodes are designed to avoid the buffer-leaks, which occur if clients
>  guess the flink names or mmap offsets on the legacy interface.
>  Additionally to this basic interface, drivers must mark their

Hi,

I think this is correct, but I didn't actually check the code, so

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq

--Sig_/=kW+PCAj.SVDDFlVSKplH9l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmIKGgYACgkQI1/ltBGq
qqcfSBAAi7KZBj4UfBbRpE+DZy55fcnl4riq7F9On+Dv7toIXXlgYEJw8EW22vct
kCgVOHsNE2aL6qheIfk1p8QZysm8xYVByaM+w/qSBQLwAJHxmJsN12YsDohYQVgX
C64vtWfUPo1Ckf9dWjNKVMv+xpjMB0O4WkpFluzi4hNC4QnycbdROLvgOwnlhfdA
u53H9Nn3egNd9pkaXp3nS6yncUilzp6XPiR8PnXaCdYddLMAlC0TuCBjpkhP5hKN
ELamOUEY7lhuJHon7xz5HCCB2NbXW2+CleHBole3L65Tloju+Kw2kMc8F4e4wIze
gGAMD4/D4dri6F9tErrYaRSLg9Bps19qauCCxAdowfRZ7VHgsJYHMg5OBWwnHXb+
ytwCHC3NP9vHav3AcTSUdzpa5Oj6mHQR4Bq+BAcy78Cz2jbqA51ReyCZ7wZC7rmJ
aVVp4/ZY7iqbCSVqa0YwPadvEIgpJoxZrwzQnhZ6pPtfABYYyY6lUXr/wCpQBNPo
QOSEDdPQK2LReDWVpu/2pO8jF4fbhy0m2hoWJns+YeKhn1RAIhZwEeftFnkp6s6t
Q4oNnwehLaUIImAJre2IKRtWThwIVJIJD0Fc+XhNQENVHB11TFEzSWkrxAIVM3wd
glZ7Fb61Z6hupf3ZJkB8ErtdGqTskaTNHse71qcAmVl+4AcNFfg=
=nqHa
-----END PGP SIGNATURE-----

--Sig_/=kW+PCAj.SVDDFlVSKplH9l--
