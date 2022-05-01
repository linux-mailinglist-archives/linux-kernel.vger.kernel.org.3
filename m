Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57F05168AF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 00:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355762AbiEAWkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 18:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344401AbiEAWk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 18:40:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3EE2E6AA;
        Sun,  1 May 2022 15:37:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ks1LM5BNDz4yST;
        Mon,  2 May 2022 08:36:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651444620;
        bh=0DNXzgmAEMw+zIAcNBeUrH2cqgWBQ1aTbhcx6s5Vh2k=;
        h=Date:From:To:Cc:Subject:From;
        b=gobCHnLpX2KDM6lYEO3hhOX7AZKPA+iXEnQ6XBsa3siG0NuVePDjoq6EiFDYsS95s
         ZAnRw+ntDV/X72eMjoN/s9JA9B5xtW0EoZ1ogcR2PKqt9TmfMVROegkOJCco3EBaN7
         1wcg3NLB5G3Eku+/2QHHdsBC1wbDdVCKCJkVO0p1Og1QIl1W9E6zV42vIcKf4vqEtB
         NrJtlywaRpRpvcO0gt7o5WyWesM9HMFqOPMaMmSv2MGaJiIa/ev6lLHLZIJ9tnwb97
         1VrapltUkr6LFBzwcviN2IDMaawGxoZpPvImPWy6B0AvOujZpiUOKEFj+BYMvuUeUB
         wdsLGX45jctyw==
Date:   Mon, 2 May 2022 08:36:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the driver-core tree
Message-ID: <20220502083658.266d55f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eBx/0VcJ0k0.QK2U0AseUa/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eBx/0VcJ0k0.QK2U0AseUa/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (htmldocs)
produced this warning:

drivers/base/firmware_loader/sysfs_upload.c:285: warning: Function paramete=
r or member 'module' not described in 'firmware_upload_register'

Introduced by commit

  97730bbb242c ("firmware_loader: Add firmware-upload support")

--=20
Cheers,
Stephen Rothwell

--Sig_/eBx/0VcJ0k0.QK2U0AseUa/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvC4oACgkQAVBC80lX
0Gw5ggf0Dn92oTaDF0+KOZvAPZO5aMmbdjqdvpWhHFArghzH7j5/M0MB6v/ehNLH
CNxK/kXUCRVQ/VWG7yMSUnyDDM45b31hZTI3swqnl4heoTmJ9jKYpgExPeZ7TXYJ
omOppEFnN8Lqov93rpw9v+cEk0ixfaXV0igFm8D6yo8qIAqdsDlGhiYVZrqNuYLU
OxHbORo1EvPuSjTcYSP8R+cs4mnzIkehJqBK6V7Sk0WfnYZYlveNJT93LcyQ4Y5a
B4Q6nsVcYnHK5eVLQKZTotogfe7/MT6dyahz4CAlUOhRCtPNMQ8onyg4U/a665Ml
oKP72nZBlBx+Owpt3oqRSl8eTz/F
=REp7
-----END PGP SIGNATURE-----

--Sig_/eBx/0VcJ0k0.QK2U0AseUa/--
