Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C347581C15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 00:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239860AbiGZWZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 18:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGZWZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 18:25:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8ED18B32;
        Tue, 26 Jul 2022 15:25:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lss1j62rGz4x1T;
        Wed, 27 Jul 2022 08:25:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658874346;
        bh=xGrZ3aTU/oPpYkeuyBcrBFuj6wgn2CesnAP18XIoYPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lKeaDuURvJOrx7CjEV3CXcb+LDbXXTFlJdwmYdQn7wtVV/6iwvw4j3/Nk/Hix1/bj
         sPmHVxRWPpVQIpfQu2esIZEVm8Tip3uzLGH/Zouy+mfJXkONfGqmI6Vo0Dcg4AxVeC
         04/vLXwGhkc0IXP81dr6A2gyJq48wQQ8j3ajXTKquC8skBiQYCWLHlv+OWDHnE/jMo
         qdLbXfecMEjV4372YAzZmTdfKYB3GRroWx6F9mRx+BY+QdSOIVQaOZCeMrSjbGBPDf
         wnQAaR52TK3X+e5A4IpI76tANxupM1tseMAf7NulXY9g2pRN/AZZtBF0zY5d/sPWeu
         p46hGeEOOzO+A==
Date:   Wed, 27 Jul 2022 08:25:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: run time warning after merge of the mm tree
Message-ID: <20220727082522.65bff1b5@canb.auug.org.au>
In-Reply-To: <20220726183217.37gnocd33nbjuguw@revolver>
References: <20220726212340.72499268@canb.auug.org.au>
        <20220726183217.37gnocd33nbjuguw@revolver>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rqjIFaMmisOSm9HorNiM89w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rqjIFaMmisOSm9HorNiM89w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Liam,

On Tue, 26 Jul 2022 18:32:23 +0000 Liam Howlett <liam.howlett@oracle.com> w=
rote:
>
> Where does pseries_le_defconfig come from?  I have a ppc le config that
> I test, but cannot find a defconfig by that name in the git tree.  I
> found a pseries_defconfig which is BE that I can try to see if I hit
> this issue, but it appears you are running BE here?

If you do "make ARCH=3Dpowerpc pseries_le_defconfig", it is constructed
from pseries_defconfig.  My build and boot test architecture is ppc64le.

--=20
Cheers,
Stephen Rothwell

--Sig_/rqjIFaMmisOSm9HorNiM89w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLgadMACgkQAVBC80lX
0GyO4Af9H8FPslb4O7QuUCb4S7wQSoHm0UzuaOMlXV/CkoV8W+OKxizuD98RAhbX
W3wzHhMIkVL5IevS8J4f7aZlmt0YSeMRVeVpR0jT4CsZ1LktHvlMWqgJMoUALLX8
ZTFQ/lBT6jha5lOCYtfSpGsu/4GHBGnsj7FxYeRFWeAJzvW8i82vqz8dzkqZ8bes
M0abepo4UN5Zo4tW+VEFBsLCgXZkzBSqSZbQJXTk3fwa87vuvot+x/EJ/mtXaW7F
QOefsIq1TyY4tPa6IgyOKaVFlYkqwNlWZ/ell1E9hG5TouWBzy4CiTnR8b6uZxgZ
cYORV6cmM+JOpHOSYJUamgO+NxreNg==
=T21h
-----END PGP SIGNATURE-----

--Sig_/rqjIFaMmisOSm9HorNiM89w--
