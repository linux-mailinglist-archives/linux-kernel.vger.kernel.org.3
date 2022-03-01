Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CEE4C853B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiCAHcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiCAHb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:31:57 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFABD44740;
        Mon, 28 Feb 2022 23:31:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K787Q5rKqz4xPt;
        Tue,  1 Mar 2022 18:31:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646119875;
        bh=2s02Gozkt/Xh7bXyEXeQyUkQU9LaC2Kkc8W3e75QPbs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fji1ifk/y38oPBdnibMktSbFWOHZYZ0CR1Q4MxThi/OhtEdoN/GRVyBb1kSjNaaa+
         hKbfaUAE3aCSudh9dwAsWxFv0yASnP0oyU3mt2mpl5rgpbLlmEi4FSxvFgV88vjWGy
         iPvrHOq1JxPp8nTVsDJG+rM5bA4Fdd/+dQDkwby5b01m9QuypaRe/uY/d6G8iW40Ra
         TVGIKF7LdnhZDrr4uSzGda7Pltd9H7uRKbiOhX36QprFNM2tHH5lkGZiXNyx+cHElN
         LmjELQIpVWrsh1bazFSQB1b/3SukTc+7tkNGwzHLotMIHuMUxIE+Cfr5w2vimZiz2L
         WixDX7it4MsAQ==
Date:   Tue, 1 Mar 2022 18:31:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     broonie@kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Gioh Kim <gi-oh.kim@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Md Haris Iqbal <haris.iqbal@ionos.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with the block
 tree
Message-ID: <20220301183114.240e6078@canb.auug.org.au>
In-Reply-To: <20220221215911.2948692-1-broonie@kernel.org>
References: <20220221215911.2948692-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WZPIab3C398Z3QMKg4G16ze";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WZPIab3C398Z3QMKg4G16ze
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 21 Feb 2022 21:59:11 +0000 broonie@kernel.org wrote:
>=20
> Today's linux-next merge of the scsi-mkp tree got a conflict in:
>=20
>   drivers/block/rnbd/rnbd-clt.c
>=20
> between commit:
>=20
>   448025c103938 ("block/rnbd: client device does not care queue/rotationa=
l")
>=20
> from the block tree and commit:
>=20
>   e8e9884730b36 ("scsi: rnbd: Remove WRITE_SAME support")
>=20
> from the scsi-mkp tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc drivers/block/rnbd/rnbd-clt.c
> index 1f63f308eb394,dc192d2738854..0000000000000
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@@ -1606,13 -1607,13 +1603,13 @@@ struct rnbd_clt_dev *rnbd_clt_map_devic
>   	}
>  =20
>   	rnbd_clt_info(dev,
> - 		       "map_device: Device mapped as %s (nsectors: %zu, logical_block=
_size: %d, physical_block_size: %d, max_write_same_sectors: %d, max_discard=
_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discar=
d: %d, max_segments: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
>  -		       "map_device: Device mapped as %s (nsectors: %zu, logical_block=
_size: %d, physical_block_size: %d, max_discard_sectors: %d, discard_granul=
arity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max=
_hw_sectors: %d, rotational: %d, wc: %d, fua: %d)\n",
> ++		       "map_device: Device mapped as %s (nsectors: %zu, logical_block=
_size: %d, physical_block_size: %d, max_discard_sectors: %d, discard_granul=
arity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max=
_hw_sectors: %d, wc: %d, fua: %d)\n",
>   		       dev->gd->disk_name, dev->nsectors,
>   		       dev->logical_block_size, dev->physical_block_size,
> - 		       dev->max_write_same_sectors, dev->max_discard_sectors,
> + 		       dev->max_discard_sectors,
>   		       dev->discard_granularity, dev->discard_alignment,
>   		       dev->secure_discard, dev->max_segments,
>  -		       dev->max_hw_sectors, dev->rotational, dev->wc, dev->fua);
>  +		       dev->max_hw_sectors, dev->wc, dev->fua);
>  =20
>   	mutex_unlock(&dev->lock);
>   	rnbd_clt_put_sess(sess);

This is now a conflict between the scsi tree and the block tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/WZPIab3C398Z3QMKg4G16ze
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIdy8IACgkQAVBC80lX
0Gz5HwgAl/bJDeep+TA/UT8k4j95Do+LeWr8C294Wbo/NL+ZHgNXP1ouEL8ER+Ys
yznnuXGt53FjTSujA0eAixWPmRAOFAduSPXYHylxYvseJLUT4I4WDC/8pp7/9quD
uMgUGZ1nn+JE1cjiTosY/mjVg7i3nuBmrUoSZZc0Lo3RufjKzViVVGcxxpvO7p3u
MEXN4qLp3MTSrWtDIwujJoGTlOnvLb0TmDAjg4QoT/Pn3Vp8KONfJK1ayaPwMHaQ
2EOOUQ02quBEz1SxvNi8CQRWgu8SE5HbzD/2FrKrEEOTPYRvY3c8z1jNaXvA6cnW
vAhBwdjN3upO3rULSf/Z9u8UEh8IHw==
=jZQf
-----END PGP SIGNATURE-----

--Sig_/WZPIab3C398Z3QMKg4G16ze--
