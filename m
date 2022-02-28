Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8DB4C68CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiB1Kz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiB1Kyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:54:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AE5D6E8C3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646045529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IVYeDVfzq28sn8+/lq8Z6rjLomlALnQoJ59O71VHfzQ=;
        b=QL485AYazn+KPuyyAY7M4ADSJfxaeGCWnHWj6fA2wm8KPplDiIBL6PSuw3MWz5d0Ouns63
        FVkW/jjqibyRuC42b0dxJzSMBqZcMGjKIG+Nh43Z/I7n30HhKkwIPPGO/Pp36uDdtqYPTH
        0om93BBoyyBfawgdaZqgDmWwS7FgpPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-q7kWgGG-NKuf4SMC_VkNLg-1; Mon, 28 Feb 2022 05:52:01 -0500
X-MC-Unique: q7kWgGG-NKuf4SMC_VkNLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 499E651E0;
        Mon, 28 Feb 2022 10:52:00 +0000 (UTC)
Received: from localhost (unknown [10.39.193.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9241182E57;
        Mon, 28 Feb 2022 10:51:57 +0000 (UTC)
Date:   Mon, 28 Feb 2022 10:51:56 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] virtio-blk: Assign discard_granularity
Message-ID: <YhypTNtWpcgh3gb2@stefanha-x1.localdomain>
References: <20220224093802.11348-1-akihiko.odaki@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o6KFt0EAQYlUHcer"
Content-Disposition: inline
In-Reply-To: <20220224093802.11348-1-akihiko.odaki@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o6KFt0EAQYlUHcer
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 06:38:02PM +0900, Akihiko Odaki wrote:
> Virtual I/O Device (VIRTIO) Version 1.1
> https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd0=
1.html
> > discard_sector_alignment can be used by OS when splitting a request
> > based on alignment.
>=20
> According to Documentation/ABI/stable/sysfs-block, the corresponding
> field in the kernel is, confusingly, discard_granularity, not
> discard_alignment.

Good catch, struct virtio_blk_config->discard_sector_alignment is Linux
q->limits.discard_granularity.

>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c443cd64fc9b..1fb3c89900e3 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -913,11 +913,9 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		blk_queue_io_opt(q, blk_size * opt_io_size);
> =20
>  	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> -		q->limits.discard_granularity =3D blk_size;
> -
>  		virtio_cread(vdev, struct virtio_blk_config,
>  			     discard_sector_alignment, &v);
> -		q->limits.discard_alignment =3D v ? v << SECTOR_SHIFT : 0;

Should we use struct virtio_blk_config->topology.alignment_offset
("offset of first aligned logical block" and used for Linux
blk_queue_alignment_offset()) for q->limits.discard_alignment?

--o6KFt0EAQYlUHcer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmIcqUsACgkQnKSrs4Gr
c8gvvgf8CUBI66KzLI88mzNHI2Vrynk7iPeOE+nt95l0+w7br24PncTRvUQCHPko
u1d/0UZcCsOAG9cW5CSwRRQedrVbCrhNaJm6KywnghK/41SCcMHDJEAwQNyX9GCy
FvmYghT9oHxhkucTD91oVuD0Sk714G2ikPNleZmijh/+kn224gCy1eP/3/S/KWGr
/edZF24TIDpujQNdR9emr+UF7eLoWBC3n/ldoDVU+fmgXaCIT2DjZXbsqiu6Cjir
ytI7KakJsyjFuWMXTSEIg9RKV0GRJTj/YYLspFMNEDZGv2ikaMatl/MNxDNpDvln
+bylNvU54z5CWo7wObRdwWmybWOTzw==
=Ldv1
-----END PGP SIGNATURE-----

--o6KFt0EAQYlUHcer--

