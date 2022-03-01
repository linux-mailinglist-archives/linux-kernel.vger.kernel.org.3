Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAD4C875D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiCAJHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiCAJHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D007A89CE4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646125629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9yUIg5j65w+qFKrB2q98qn+HFOuWpxbJH81ykhBbNU=;
        b=FiaIDJBk+X2R558AyVBr5RQZ401EiJv4UHojjFdRgk8W/5lA6ilh+xHjUj6GWw9j/pMnLy
        JpIikOrila6PXj8I6gVaudXwke+tWMAPfWXVyp2TK6usLS4pAeIxIlQH4O/bku5m3BjKrB
        3ptf8BVu62ZGVU7mZMrgshSpgjT0pB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-PNX7isssMnCg8DTO-XnzpQ-1; Tue, 01 Mar 2022 04:07:08 -0500
X-MC-Unique: PNX7isssMnCg8DTO-XnzpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31ACB801AB2;
        Tue,  1 Mar 2022 09:07:07 +0000 (UTC)
Received: from localhost (unknown [10.39.194.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADCA51038AC5;
        Tue,  1 Mar 2022 09:07:00 +0000 (UTC)
Date:   Tue, 1 Mar 2022 09:06:59 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] virtio-blk: Assign discard_granularity
Message-ID: <Yh3iMymdtD6rGYzs@stefanha-x1.localdomain>
References: <20220224093802.11348-1-akihiko.odaki@gmail.com>
 <YhypTNtWpcgh3gb2@stefanha-x1.localdomain>
 <e306700c-3153-9422-974c-1f5f10e232d6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QjNeH+KS6pqTHNut"
Content-Disposition: inline
In-Reply-To: <e306700c-3153-9422-974c-1f5f10e232d6@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QjNeH+KS6pqTHNut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 02:43:55PM +0900, Akihiko Odaki wrote:
> On 2022/02/28 19:51, Stefan Hajnoczi wrote:
> > On Thu, Feb 24, 2022 at 06:38:02PM +0900, Akihiko Odaki wrote:
> > > Virtual I/O Device (VIRTIO) Version 1.1
> > > https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-cs=
prd01.html
> > > > discard_sector_alignment can be used by OS when splitting a request
> > > > based on alignment.
> > >=20
> > > According to Documentation/ABI/stable/sysfs-block, the corresponding
> > > field in the kernel is, confusingly, discard_granularity, not
> > > discard_alignment.
> >=20
> > Good catch, struct virtio_blk_config->discard_sector_alignment is Linux
> > q->limits.discard_granularity.
> >=20
> > >=20
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> > > ---
> > >   drivers/block/virtio_blk.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index c443cd64fc9b..1fb3c89900e3 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -913,11 +913,9 @@ static int virtblk_probe(struct virtio_device *v=
dev)
> > >   		blk_queue_io_opt(q, blk_size * opt_io_size);
> > >   	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> > > -		q->limits.discard_granularity =3D blk_size;
> > > -
> > >   		virtio_cread(vdev, struct virtio_blk_config,
> > >   			     discard_sector_alignment, &v);
> > > -		q->limits.discard_alignment =3D v ? v << SECTOR_SHIFT : 0;
> >=20
> > Should we use struct virtio_blk_config->topology.alignment_offset
> > ("offset of first aligned logical block" and used for Linux
> > blk_queue_alignment_offset()) for q->limits.discard_alignment?
>=20
> Maybe but I'm not sure. I had looked at the code of QEMU
> (commit 5c1ee569660d4a205dced9cb4d0306b907fb7599) but it apparently always
> sets 0 for virtio_blk_config->topology.alignment_offset.
> I don't have a hardware which requires discard_alignment either so I cann=
ot
> test it.
>=20
> I'd like to leave this patch as is since I cannot deny the possibility th=
at
> the host has a different alignment offset for discarding and other
> operations.

Fair enough. To do it properly we'd need to add a new configuration
space field to virtio-blk.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--QjNeH+KS6pqTHNut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmId4jMACgkQnKSrs4Gr
c8hVTQf/fK2GjZF044xLZweZrpcjLJNrkExfCsyHEH1Ah4G4APuU/5PSDiiYm6XX
EWrQanPgZ7Js5AkKfqsj5BslgH6HuTGUUfdP96Ww3uOxGG1jXpN3ifmN6vnLLUuR
+KQjF89iI6zAl8yuV1OvGWl7+KgT0zmGEyFlY2t2ELov/TihbI872+kohZxpUCf4
/7ZkXj7EL7BJxRmez/82PlVNzp1rqM7WsO9E+exIRL5uedb1w2lO8U96h9B7FO0i
eCJCD3MH8bTQ5q30xXMdEueNrRanBEnaXtteAmnAyrgXhK43mYGgvklxigXq2wrG
2ehNobgts6blVTE4GekOllSvt+9ZBw==
=qaMg
-----END PGP SIGNATURE-----

--QjNeH+KS6pqTHNut--

