Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDA14E6AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355568AbiCXXAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiCXXAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:00:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC4BAB9D;
        Thu, 24 Mar 2022 15:58:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KPgcr2H6mz4xQv;
        Fri, 25 Mar 2022 09:58:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648162717;
        bh=HUHF4CksvsqpNJ127PIKPVtDevMByiZc7pwqv+FoKn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E9S014tLW2G3Zdc4C7Vsfb4OeyHSThjg2V6yv25OMLJHrTVX+qGhZdea2eq2kG951
         LaB31hxgyjnQ3wR/XeqrbrfblpYYszUPJTiaMfjWJ7s0C91Ubi2SBSIbIDZHvLA/AZ
         xg0nd9iL/aOcOpvJd3eENso8frLdiWN42inQqoiBQQQsnRjVHpoVeHNc2wprB5JiyC
         Kh2omvzcjBRN9x9Ng2wYnOQUieGREx6HvAyX7hlsXuVHp5rmJl3kvm/9ijKJ9K8ky6
         vE3D2fkdzWG0Wj+ERF5RE6rVFcspDMfqVKvSdUFxdknSuIoaOzf8nX9+laXRJbDxot
         /EAYmAuUYnTQw==
Date:   Fri, 25 Mar 2022 09:58:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the h8300 tree with the asm-generic
 tree
Message-ID: <20220325095835.0782c6e6@canb.auug.org.au>
In-Reply-To: <20220228114018.30fda009@canb.auug.org.au>
References: <20220228114018.30fda009@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XwZLdLw0TUUkynjymw9a4Ig";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XwZLdLw0TUUkynjymw9a4Ig
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 28 Feb 2022 11:41:06 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the h8300 tree got a conflict in:
>=20
>   arch/h8300/mm/memory.c
>=20
> between commit:
>=20
>   967747bbc084 ("uaccess: remove CONFIG_SET_FS")
>=20
> from the asm-generic tree and commit:
>=20
>   81dd24966885 ("h8300: remove memory.c")
>=20
> from the h8300 tree.
>=20
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the h8300 tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/XwZLdLw0TUUkynjymw9a4Ig
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI895sACgkQAVBC80lX
0Gz1+ggAlgD5kR4NYM3USADTFC8xifGltOIc846LzIXjH4Z/Wa36Zbsb9GFpN9tK
gjunpcFuuVtt3bGK0aWc9TG5uEskOLLniut+uaR6db0omohZt5vdo7z4MbH83GjH
ahESsb6Ra2qi50Zflwc95SY2vZ4SiX4x9KAyF5fHlcKr1nDxiVvnJd/s8PpF8RFS
mWR1ZwxyRN+8BqOK7deJBZGU743cvgu/8rKvEMatepOokKmxfCAywnBosxBZ0CUo
AMkuaphU+iw9YV4i4dVlOFUJ8L6EiXBdfA1547khxtBUJkVtQH1ApxeNC0nl7woD
5pl6hvfr5kvse6dhKYZ4vre3vks7Nw==
=Qm79
-----END PGP SIGNATURE-----

--Sig_/XwZLdLw0TUUkynjymw9a4Ig--
