Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917EE581F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiG0F3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 01:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0F3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:29:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5B3ED7C;
        Tue, 26 Jul 2022 22:29:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lt2Qc5xk0z4x1N;
        Wed, 27 Jul 2022 15:29:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658899769;
        bh=t6GtL0o7F3ASgGvLPXZyUX2HoU/gSo1MjzIn5KMR42M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XmrhGllSSMzWX9M3E4HBKWwH+z+Bi5ZGYSWT2vka+2ShYBFBwsfmkNmTzgPDlnYR1
         IwfO//VNFO82+97kbg5lhQ5zD87VA+lHqVlkIUxNtv+t7/tI2uUT2vF+xd6FZW+0RI
         1KEoYCdR8zBPyy1YpadlmNkbO5Gh9eW52yDMfVyK5xNAwHSlGigcb4YzNejmlyffsx
         Rm0oYFlsuGjMmltgOqaF9vB4w/LN20cTIfFMgWOpHuGJGIo+NrARP5RzN+2qhjCOFv
         CvZacdFIXtnk8rJ83fvlPUDrexQfgkUFCNPIBNZNFR6N4FNTnrBZSjfZmvji5Hby/F
         VcGBOPGoOiZaA==
Date:   Wed, 27 Jul 2022 15:29:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu and
 powerpc-fixes trees
Message-ID: <20220727152927.3880f350@canb.auug.org.au>
In-Reply-To: <87zggv9wdd.fsf@mpe.ellerman.id.au>
References: <20220726205458.0b5ca446@canb.auug.org.au>
        <87zggv9wdd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LlCsQtoledexGW4Ix6xJUtA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LlCsQtoledexGW4Ix6xJUtA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 27 Jul 2022 11:29:02 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > Hi all,
> >
> > After merging the amdgpu tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >
> > ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard flo=
at, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
> > ld: failed to merge target specific data of file drivers/gpu/drm/amd/di=
splay/dc/dcn30/dcn30_optc.o =20
>=20
> What compiler are you using?

Debian's gcc v11.2:

$ gcc --version
gcc (Debian 11.2.0-10) 11.2.0
$ ld --version
GNU ld (GNU Binutils for Debian) 2.37

--=20
Cheers,
Stephen Rothwell

--Sig_/LlCsQtoledexGW4Ix6xJUtA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLgzTcACgkQAVBC80lX
0GxKhwf7BW66Nm1XYsAAWjFwT111PJwl9t7TjxT8GhUG3K1FbFsKlnLWURRnYhm3
2cSo70l+VVLi0KQ/glHqtq1zw6cTRXdcsBHNGRncnbixKWGyF8kYZc3K5mBZ0Y3q
boC4+BuiqDf4x205hjwEq4xCvE+rsgQ/AJLEyRmYbWZcJ+nvGWbqxZoD5g+US4U6
MMvtIVmFMo9WEQc2megjtS7aRKWcEd6sbFanyxrptPtyxRZJZ1u9o7prSi7AX1ON
Lvd8YoUJ9BKA57uAoCWs4B55aw6EqEa5l9OBBn00Gk3q3ZaKbLitARMzQEDYx8bz
7LgcC6NvCwc/pXU2AfSf1rbo0Zi17g==
=R8VK
-----END PGP SIGNATURE-----

--Sig_/LlCsQtoledexGW4Ix6xJUtA--
