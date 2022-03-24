Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEE44E5F80
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348520AbiCXHfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345603AbiCXHfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:35:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B561B6;
        Thu, 24 Mar 2022 00:33:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KPH5Q4GKQz4xLS;
        Thu, 24 Mar 2022 18:33:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648107211;
        bh=O57ZBYrPDINAUUx0bUCirgO8vfrhhHxthCe7aIDcEOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QeSOHTW8IT7HnYb6BSsed4NyWLi8uCu6EIrDYegoFGrYffPVsC6qe6269vqPrMyD/
         i+rqSdcMQ6RRVTdGV6id/jafU+nYGg9ox/32z42V4t1L9so5yuKIMW2Z+KL86m10N7
         Od8qIUlcGXSL/GRofPwmjWJqSofOfBmHnOQbBb/hWn+BYs431p9NATodGIAK+vANYE
         P8Rv77jLizzufi45zkVXgYdPLw8i50Lb4OcLio5wNneynzFdCmYu+g5QjEdFbHHCCX
         bBZVbYd6/Ou2xNNg4l0n9Zf3xumm6njxO+KT0rmmeBEgOkCWX0/MVmWIQTadCpUtYw
         u3xXRjILizpuw==
Date:   Thu, 24 Mar 2022 18:33:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Message-ID: <20220324183329.22c97ea1@canb.auug.org.au>
In-Reply-To: <20220301201659.45ac94cd@canb.auug.org.au>
References: <20220301201659.45ac94cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Oo9++qc_i1g+bCsw1KwBD90";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Oo9++qc_i1g+bCsw1KwBD90
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 1 Mar 2022 20:16:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> After merging the drivers-x86 tree, today's linux-next build (htmldocs)
> produced these warnings:
>=20
> Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Unexpected =
indentation.
> Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Block quote=
 ends without a blank line; unexpected unindent.
> Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Definition =
list ends without a blank line; unexpected unindent.
>=20
> Introduced by commit
>=20
>   2546c6000430 ("platform/x86: Add Intel Software Defined Silicon driver")

I am still seeing these warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/Oo9++qc_i1g+bCsw1KwBD90
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI8HskACgkQAVBC80lX
0GzmdAf9Ee5WD9mFVQOACExXVLu/4fz94hieMWq9wlN5BRyAY3hVAR6FIHuk7R0q
EwLYL9IEWdNLH1jD8XgqsFhrfi57IoXHXAJ0WjLONEH4B+ZHCFj6eXIkO4v/JndX
lod5PsVIWYsOMRwEWyPhwcViL1uQx19EtdwZ/gHv9UfrNMqn3P1W/vkwFvjBzN62
7nvL/czwwPWkiJP+/4pjrlZBZWQG8AojL9vH5OU8mbzp74DfMnW7mcai6ghFqwWV
fK8bNk2/ntu4qD6X0Z+txNz4ft2bh1vR67A1Ci2XFn/Yk2lzUyyLgEeywrtYjmyI
SL8qAx3efFrhNyWFzqUcuUQI54YK9g==
=p/0x
-----END PGP SIGNATURE-----

--Sig_/Oo9++qc_i1g+bCsw1KwBD90--
