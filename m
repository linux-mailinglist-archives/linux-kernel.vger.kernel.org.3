Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60E3592F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiHONBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbiHONAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:00:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE1CFE7;
        Mon, 15 Aug 2022 06:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02314CE102B;
        Mon, 15 Aug 2022 13:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0854FC433D6;
        Mon, 15 Aug 2022 13:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660568439;
        bh=p1nYEeDHz9Tdc8s0zIpf7Z77OotsoiiTDh68tCsieDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LM38E2nbT3q9Irbd4UgVADLlzM26e+8WSvWJJGHmwnj49hshxlji/DEIWYlmtRWw6
         /E0jqCv+Ipkh3DKcVEDbbWLzGCyDFxoJ0Es+ygVKZ8aCqjVjHPO/V+8X+UI09fYhCa
         a0nq5H3zlDtT40YbM7XQVYjayR/tBlo8fWp/b92GjAhtF6cMNxJUJKVYJPNtVRg/oW
         ITrxxXx22ffQabx1oCgTl+FwkfCmOPGspXNyZldPS+egyeG4E3sRespUpaVFRddmtw
         BtVKOJcy7l/TCURVQH4BKaAwvycK/o103mdAUT/2pNObqHRHJwW+82/VWScG6xrclD
         /AtB9fygWsQ0Q==
Date:   Mon, 15 Aug 2022 14:00:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] docs/arm64: elf_hwcaps: Unify HWCAP lists as description
 lists
Message-ID: <YvpDcuEKEXyFxOKV@sirena.org.uk>
References: <49253b17-738d-795e-f539-55857fdaee64@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o2zm79aWRd7cLWC7"
Content-Disposition: inline
In-Reply-To: <49253b17-738d-795e-f539-55857fdaee64@suse.cz>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o2zm79aWRd7cLWC7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2022 at 11:19:40AM +0200, Martin Li=C5=A1ka wrote:
> Extends what was changed in 94bdaa7d9a9d778d893c670d494c06d8e007c1cd.

For those playing at home that's "docs/arm64: elf_hwcaps: Unify HWCAP
lists as description lists".

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read.

> Add a series of blank lines to this document to get consistend rendering =
as
> an RST description list.

The commit message says that this is adding blank lines but...

>      by Documentation/arm64/memory-tagging-extension.rst.
> =20
>  HWCAP2_SME
> -
>      Functionality implied by ID_AA64PFR1_EL1.SME =3D=3D 0b0001, as descr=
ibed
>      by Documentation/arm64/sme.rst.

=2E..the actual patch is deleting them?

--o2zm79aWRd7cLWC7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL6Q3EACgkQJNaLcl1U
h9AkswgAgc8tN8uHAAD7VsV9pJ3CbHeuAdt0tvcBpTSjP4VYAK6HZ6D2uo9kNlQf
HEKlej6b2oVlyDveywkjqaOE4vqOj6p37kxLad/Qsb2xVP+ZybkJHCSlzbAqU3US
ZxfaE2y8Z7nkxcnSwmbQ0MFEniKOWT+tmfl6Ck0wnnpH/fTAxU22wAviUNzWo1x5
HotxIEpK1eobssB7gtQtOeCOEYiIrdIOq+QSGr263o4QRws0T/PFgqH8Kto/lxB3
epZ7gx26w4X0jB7wZVIi3rhmCfb2CT/Zo/GaKBVfSAxcItzVcmRjIWSw5UjIaRN0
kT0K3WtW2r2nNArkUQ+9t0lcYmI+ow==
=jMH6
-----END PGP SIGNATURE-----

--o2zm79aWRd7cLWC7--
