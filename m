Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A3949D94E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiA0Dg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiA0DgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:36:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5DDC06161C;
        Wed, 26 Jan 2022 19:36:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JkmTg3DvDz4xdl;
        Thu, 27 Jan 2022 14:36:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643254583;
        bh=67YArlkiLvaRLVOPDmiz9ch+7cLvuuV7sqMtBAoF9d8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OsfaojZ70MQbucunf8pHTL6gPT7tUM4SE8FcrDaBfU+HeIUnTRFwYdwcxEbWU8lWZ
         0jzGcaTB0fPWTI/HSXOZN9JVCZs09sYv0o9ChnI+s1pRB8MJbdAy6kDDR8t//mQjh5
         dkEfglYLRZr5rahLT37rwxAGlYT6iuLRVxibDLotzV4wPsILNNCv0XQXofxFfT5vJw
         v44NvoEjR604WiWVp0ke9DqG4trmQSsDeY+EoaV7bqNTma+cDr1Q/VmeLrCehJEYyw
         t/bGAlqi+TyH9NZ5mjll1EwRyUP7ij2NhTbW5giXyrOhFGHNSqNAdlPjmzdhm4uMt5
         K2C+kNqK6ea3g==
Date:   Thu, 27 Jan 2022 14:36:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the jc_docs tree
Message-ID: <20220127143622.6803bd22@canb.auug.org.au>
In-Reply-To: <20220127141518.54dbb9a8@canb.auug.org.au>
References: <20220127141518.54dbb9a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mo5amGFlXOIEZgDegaTc7Xc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mo5amGFlXOIEZgDegaTc7Xc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 27 Jan 2022 14:15:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the jc_docs tree, today's linux-next build (htmldocs)
> produced these warnings:
>=20
> Documentation/tools/index.rst:2: WARNING: Explicit markup ends without a =
blank line; unexpected unindent.
> Documentation/tools/index.rst: WARNING: document isn't included in any to=
ctree
>=20
> Introduced by commit
>=20
>   1ce5371ee32f ("docs: Hook the RTLA documents into the kernel docs build=
")

Also:

Documentation/tools/rtla/index.rst:2: WARNING: Explicit markup ends without=
 a blank line; unexpected unindent.

--=20
Cheers,
Stephen Rothwell

--Sig_/mo5amGFlXOIEZgDegaTc7Xc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHyEzYACgkQAVBC80lX
0Gx6lAgAmHRaVdD3+KWLWKAG6RfrsGnP9oQIvPSDIwx3J7+pMv6CK/TwCeghkdkx
VakHJjG5q3H3VJvOSD75CVAWAU2Majj1N6iOEaou/Ly2kawiucKjDn0qEDbZIqVv
ewGSiegOfzBrlFjpJ2666UjdJAc/+o0c5kSSMsFZwxYzXH/nh9Y54h0SpXfM06v4
/8/A5rOc39wrzOu/SBO/vvaiZG+2kfgRrvtrlN2xDYUzWhGj8hk43tiujhzIUtfv
5Rlt+Aynk0Vc0ZiX3uwVEvlFkaj5QhvJ/fMCS4zclQPC2gD179zNNWGHE2ad04on
FylwZlR1Agf8FKuF3qZtbVqx0KHFTg==
=c0G5
-----END PGP SIGNATURE-----

--Sig_/mo5amGFlXOIEZgDegaTc7Xc--
