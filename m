Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8872E4FDD80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbiDLLKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356423AbiDLLGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:06:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5DC6AA40
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:00:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7E8761F444E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649757611;
        bh=q0ltO9jPgC2ENTqqGFru2UPens5pv58VO6KgGl1a8cY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KohamFiaBuk0jv4Y0OpQx57PPloK2w3if1pkZ+xv0YQH+HYH/UeC9gmBPFObifoDw
         30q4AvCXFZvK4MokuW57HMQpw/MXO7juDwXhf14MNJmRMtDRC7honsL2ZUXv4I5Lxx
         lyptiT02bmMRJkCOpJvFLtfRWGPMuDQ9QB3wrVXV1K9EUBaNLisIOxsDJkY7T0RNbO
         hn42+PL7EXT97XZlj7HphTnmaX7hFbL0cqeiXQgTxXR4x1npE5Tmq3MX23NrPsBVWo
         ZKK0niAw+xpEFURyKCaKo+1NPCqTbNZaRhZIXD5uCFjHQ06xiE/NeBS/sCNoyUHqMc
         KeV82kvqvfHZg==
Received: by mercury (Postfix, from userid 1000)
        id 509511060340; Tue, 12 Apr 2022 12:00:09 +0200 (CEST)
Date:   Tue, 12 Apr 2022 12:00:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hsi: clients: remove duplicate assignment
Message-ID: <20220412100009.nd5akezypy5lycdm@mercury.elektranox.org>
References: <1648728460-37288-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hnaftqma46pljnb6"
Content-Disposition: inline
In-Reply-To: <1648728460-37288-1-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hnaftqma46pljnb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 31, 2022 at 05:07:38AM -0700, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
>=20
> netdev_alloc_skb() has assigned ssi->netdev to skb->dev if successed,
> no need to repeat assignment.
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/hsi/clients/ssi_protocol.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi=
_protocol.c
> index 21f11a5..7aacb19
> --- a/drivers/hsi/clients/ssi_protocol.c
> +++ b/drivers/hsi/clients/ssi_protocol.c
> @@ -796,7 +796,6 @@ static void ssip_rx_strans(struct hsi_client *cl, u32=
 cmd)
>  		dev_err(&cl->device, "No memory for rx skb\n");
>  		goto out1;
>  	}
> -	skb->dev =3D ssi->netdev;
>  	skb_put(skb, len * 4);
>  	msg =3D ssip_alloc_data(ssi, skb, GFP_ATOMIC);
>  	if (unlikely(!msg)) {
> --=20
> 2.7.4
>=20

--hnaftqma46pljnb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJVTZwACgkQ2O7X88g7
+pqFmQ//Tk7WimaocfFMEigICLkJ9XDeWiK8siEAL2Ent2o2HOyGYtlLVAB81cyr
xTGyTKvxbnSJ2yyt7qXsgwOFV2U7wlloE9l8PXuBLYFMjtC34nPlKUvOBbVlJX7u
Z2+3aAJeCjyL9lXesqCmCwJEsY/ObHWTVKLnbvvS/IwQQ9GEpWJKAELauvaWu2y0
wWcuUubIC1ssTXwVSClTFl4WV+pVg6ZiDJJo/PKYR7AIwnFPit8AVl/oUbTN4VmW
pNZSDU8uhTcEsoGncd0AEn1rxYjzuwiQajOhd63X/X6s43G4z6/2v77bKYQJZ3c7
u7b3TyfxCZytJwq9LbDYRPYFgjTJ5egWRZIm6vf3UqIdSPMzZsy4mrWm5lV4Rxta
wTyW0seYrmorOZdLLvtRRkxfc40zcKw4sQzjp8Jhh0Pc1BII/WzuYI/NkBlL5XB5
i6g412uOFvU67DWICs03+v5i3zwCHy3RyyzstDWFp9mxhaCdtmwnu7I8oWDnj2QT
cfJsTC0c2Zf2EohwOtniCdFLYCLaqA+xRg2MMYSy3/MgIEeewWOqy+lTTDqvXTrw
HBG5TGwUq8/JLdXBGG9rrwxR5pb2IyJexrJ9QB8wlPtxhhbV7u3Wduv/bc5Se916
yn1JdUB1VE2fR1mMgiK3EDYc9wdaXRpv8USQSv9wtlq61ZkXyAI=
=uU61
-----END PGP SIGNATURE-----

--hnaftqma46pljnb6--
