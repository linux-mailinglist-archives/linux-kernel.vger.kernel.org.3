Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F014D47A4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 07:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbhLTGLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 01:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhLTGLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 01:11:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC31C061574;
        Sun, 19 Dec 2021 22:11:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHTkN1CFSz4xPw;
        Mon, 20 Dec 2021 17:11:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639980700;
        bh=xUlUVm970/HDHnNVurSk+4XF/Ezez2ohLvfSRRoJbM4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SEp/epnL6qdbv90kJWGlYGuhVK4Ez7R0Awf2nKuRWydWKi7rJ0hnJ2Yu/PtuY37LQ
         NYgmiI2zpm1j9GJKntZLcP8OBtZNfi4DoZMbfVZQ4EHv3ng+RcL9hUaePIv9yfH4gx
         UCQ9quKDi/Du7pjo7pZ57iPY8WDbel5f7esrzhPW9UdSQ23dfkUyjXKMOizcuLrXL7
         T0jUrEFRXisTrLxEOl3BSnMVWkl5dvVxfJbtWFOFGoJZvPyYh/vF3BPRrIGuwBhSCv
         RJtYfHXlGe+C3mJVD8kzRyKTRu6OoiHFBgklnXfSAQ3Euth7BKlYm332ytrO/HZWOg
         k4H+8ZXUOVuRA==
Date:   Mon, 20 Dec 2021 17:11:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shyam Prasad <Shyam.Prasad@microsoft.com>
Cc:     David Howells <dhowells@redhat.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steven French <Steven.French@microsoft.com>
Subject: Re: [EXTERNAL] Re: linux-next: manual merge of the cifs tree with
 the fscache tree
Message-ID: <20211220171139.654db374@canb.auug.org.au>
In-Reply-To: <KL1P15301MB034331969F371B30AAD6642D947B9@KL1P15301MB0343.APCP153.PROD.OUTLOOK.COM>
References: <20211216124317.4143405-1-broonie@kernel.org>
        <20211220104610.5f074aec@canb.auug.org.au>
        <KL1P15301MB034331969F371B30AAD6642D947B9@KL1P15301MB0343.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NAS0vxE=0Wbe/BCj7JU5yKv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NAS0vxE=0Wbe/BCj7JU5yKv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shyam,

On Mon, 20 Dec 2021 04:31:27 +0000 Shyam Prasad <Shyam.Prasad@microsoft.com=
> wrote:
>
> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>=20
> Sent: Monday, December 20, 2021 5:16 AM
> To: David Howells <dhowells@redhat.com>
> Cc: broonie@kernel.org; Steve French <smfrench@gmail.com>; CIFS <linux-ci=
fs@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.or=
g>; Linux Next Mailing List <linux-next@vger.kernel.org>; Shyam Prasad <Shy=
am.Prasad@microsoft.com>; Steven French <Steven.French@microsoft.com>
> Subject: [EXTERNAL] Re: linux-next: manual merge of the cifs tree with th=
e fscache tree
>=20
> Hi all,
>=20
> On Thu, 16 Dec 2021 12:43:17 +0000 broonie@kernel.org wrote:
> >
> > Today's linux-next merge of the cifs tree got a conflict in:
> >=20
> >   fs/cifs/inode.c
> >=20
> > between commit:
> >=20
> >   830c476f5eb82 ("cifs: Support fscache indexing rewrite (untested)")
> >=20
> > from the fscache tree and commit:
> >=20
> >   68f87ec9c1ce3 ("cifs: ignore resource_id while getting fscache super =
cookie") =20
>=20
> This is now commit
>=20
>   b774302e8856 ("cifs: ignore resource_id while getting fscache super coo=
kie")
>=20
> in Linus' tree.
>=20
> > from the cifs tree.
> >=20
> > diff --cc fs/cifs/inode.c
> > index dc2fe76450b96,279622e4eb1c2..0000000000000
> > --- a/fs/cifs/inode.c
> > +++ b/fs/cifs/inode.c
> > @@@ -1372,20 -1370,6 +1367,7 @@@ iget_no_retry
> >   		iget_failed(inode);
> >   		inode =3D ERR_PTR(rc);
> >   	}
> >  +
> > - 	if (!rc) {
> > - 		/*
> > - 		 * The cookie is initialized from volume info returned above.
> > - 		 * Inside cifs_fscache_get_super_cookie it checks
> > - 		 * that we do not get super cookie twice.
> > - 		 */
> > - 		rc =3D cifs_fscache_get_super_cookie(tcon);
> > - 		if (rc < 0) {
> > - 			iget_failed(inode);
> > - 			inode =3D ERR_PTR(rc);
> > - 		}
> > - 	}
> > -=20
> >   out:
> >   	kfree(path);
> >   	free_xid(xid); =20
>=20
> so this is now a conflict between the fscache tree and Linus's tree.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > so this is now a conflict between the fscache tree and Linus's tree. =20
>=20
> Hi David and Steve,
>=20
> I think one of these two branches need to be rebased. Can one of you plea=
se do it?

Nothing needs t be done, the conflict is trivial.

--=20
Cheers,
Stephen Rothwell

--Sig_/NAS0vxE=0Wbe/BCj7JU5yKv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHAHpsACgkQAVBC80lX
0GyyOQf/c+PTloCznCkaa65/7FonJm0jDjkFIcxrmAhwu1Q8bV2qwtRsYoDOz0vF
e9l48cGmORVRBcAjM4q9YxbEPDnL351zO6iK7V7KAAXTedXAP3kR9kdoDgEfuMPu
AcBKlnbDOvabFDLVPfR0n0rjUoUVF7LD7Z8dHQSAnVqnC3JsJx2VrA2FrxUVL5ua
XtPbEVv2DDYQFbVAmMDEiLr+YpvU6Y/VzVTiqTB/ZeaEu1mhlgYt+YyUSqs11GIU
eR6M72mRyNhuD2/zPiqmcrFzi/4fat6tdy9mBnqKQ58MVjiRMkUr+zf4SRf4VQ/J
vFAqclCUC54k3dHibYZqWVt8XEMeuw==
=2uMb
-----END PGP SIGNATURE-----

--Sig_/NAS0vxE=0Wbe/BCj7JU5yKv--
