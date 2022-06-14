Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F9354AB41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355273AbiFNHyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355871AbiFNHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:53:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B2641F93;
        Tue, 14 Jun 2022 00:52:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMgds07Klz4xXj;
        Tue, 14 Jun 2022 17:52:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655193172;
        bh=PQo1e3aGs8YwrKBvyYc2tmj05hjtfb3An/WWvqqIFYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OW3geck3s55yL/YFvcXNUyEhAIiJw2KCSbDRc/gaSd8/8+ybHDLkloTkb7EQkkRfo
         n92Vy8ddXVF5GAkCKJSoJTTirZXaorEwqV0IffeiAwzFZ+nCod+jeuPSqxtELK4fTC
         hPSgND5Tr+WwnJ7gJchSfIS7XdC9pChhqkap+0HJE5tY05TFOjzDrz/TnOmDfNmAP5
         hRNIpEGVmdU5JWsgxT7u5k0hXsoZJIjDGJsXXMUjQc86L6rDgkrtdn0o73Q+z6j6qZ
         18jVUy+VQYWwiKEM6e9V31kQmP2ZwH0ZbIIKffNARF4zLfWMyaXduPqRAlzmIpeffB
         RwIKIGGR+oRUw==
Date:   Tue, 14 Jun 2022 17:52:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <20220614175247.30b02dc2@canb.auug.org.au>
In-Reply-To: <YqgtsXSNZKds2bDl@kroah.com>
References: <20220614120833.06cec8e7@canb.auug.org.au>
        <YqgtsXSNZKds2bDl@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Pf=S.ZBc5Gp8VAEJGCjogbb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pf=S.ZBc5Gp8VAEJGCjogbb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, 14 Jun 2022 08:41:53 +0200 Greg KH <greg@kroah.com> wrote:
>
> On Tue, Jun 14, 2022 at 12:08:33PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the usb tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
>=20
> Failed like what?

Sorry about that.  I no longer have the actual error message, but it
was complaining about a duplicate DT node "ahb usb@1e6a2000".  The
patch managed to be applied twice.

> > Caused by commit
> >=20
> >   2cee50bf4590 ("ARM: dts: aspeed: Add USB2.0 device controller node")
> >=20
> > I have used the usb tree from next-20220610 for today. =20
>=20
> Odd, ok, I'll try to revert the offending dts change from my tree.  If I
> can get a hint as to what went wrong with the build, that would also be
> great :)

--=20
Cheers,
Stephen Rothwell

--Sig_/Pf=S.ZBc5Gp8VAEJGCjogbb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKoPk8ACgkQAVBC80lX
0GwdDwf/XdxU6Fyo6YXnYAME/7DHdN5Tq+pRgfrBAPdipl4MqZAJNCVqkfJr7TRE
OjuGr0u5VOwytxLu8WXLgZZkom4smcMLRn2ZE5OEKhSgE7/VoR40xJaGnfz4OusN
89zdD/4H87Xjm11legV6I3LlNzahi91YTGO2c16VC5Y/revS9GkZos+5hcGovrGX
ND/6HDsn3YF5T2PAkklzj+Qg9qcfKyAx2+8KK00NTcYSYNaSAjsHrmhH66LsHEKK
2ZGtGGj8jaPCw3eYmz8TIhRzdgf5SsRpasnN+FP3wPYsTpCAw8TcLuhBuwm1R2vw
TFnmQiY6P76xNsvyNMWSC0WVbVDNWg==
=bky4
-----END PGP SIGNATURE-----

--Sig_/Pf=S.ZBc5Gp8VAEJGCjogbb--
