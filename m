Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE5349461F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358348AbiATD1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiATD1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:27:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCFFC061574;
        Wed, 19 Jan 2022 19:27:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JfScd50twz4y3h;
        Thu, 20 Jan 2022 14:27:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642649249;
        bh=wx04L+gh9duvBCx38lT3PmUNH1+xm5U7ajpCiDBB0QE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R2414c8qgjnoexkpT+bOBk9gHzjlXSRAB/M4rL9tA9M+o8RcuSJLKjBUFCbGuVq+m
         7S6iTwmDwqstsRDOkrU9iSqIAIpJun/94mAAkigS95lKcVrTsl8LWD7l0VOn2//7Js
         NmiyBX97VLNz5jJma9nzedw6/k835KbnfI24Sb7I2SfH0afGgyB/036dj5kQ1SQPky
         aKupUeuO0lF6x1I1h5itUS5iqwVvFo98hl3cPArTmIPCcv+n0pdWYiK3ps9yB5wfW+
         5p9R1OufFywpzOPrscgOcGKXAtQxHYyXNDd9yAcVwTkm+0Dc2xohiW42GjB7JSZ5aX
         JR9kzFYSGGdEQ==
Date:   Thu, 20 Jan 2022 14:27:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Evan Quan <evan.quan@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of Linus' tree
Message-ID: <20220120142728.28b0ee58@canb.auug.org.au>
In-Reply-To: <20211123162938.2bfc30a7@canb.auug.org.au>
References: <20211123162938.2bfc30a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K3pT50LAuyUuXTgKEJW.QDS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K3pT50LAuyUuXTgKEJW.QDS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 23 Nov 2021 16:29:38 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Building Linus' tree, today's linux-next build (htmldocs) produced
> this warning:
>=20
> drivers/gpu/drm/amd/include/amd_shared.h:103: warning: Enum value 'AMD_IP=
_BLOCK_TYPE_NUM' not described in enum 'amd_ip_block_type'
>=20
> Introduced by commit
>=20
>   6ee27ee27ba8 ("drm/amd/pm: avoid duplicate powergate/ungate setting")

I am still seeing this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/K3pT50LAuyUuXTgKEJW.QDS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHo1qEACgkQAVBC80lX
0GxE2wf9EEl1flcWZfUGeAwxLA9stFM9phd/lrcPTIUW2re9MxNm/V0ZC1oZy0CR
xLX7eOnjSoQvybUcmnvzNXLdmOANOBfo+wpCUBf8xZUPTPJ2qsn+k8ktZs8leS8K
CGr4TSK5QmPU3D0V/HLdOJl1Q1ieh3vw0i48PU6H/7bH9ChV33c0jO+5Gtzhq7ys
99NAypDPEVQMbnHkhK4zw0SsGhfwgwO8R+1uHjxt0wZt69/D5/yqUOvRw0kb3DrK
N3Nx6mvc0oxDhqJsrdy1Glyhms+TXuuzoPjEPM8tzREoWM642xfXBimrvsRf/MHM
sXvEdSH+7m1G0cEbqYkERxcN8AfP0w==
=8+Jz
-----END PGP SIGNATURE-----

--Sig_/K3pT50LAuyUuXTgKEJW.QDS--
