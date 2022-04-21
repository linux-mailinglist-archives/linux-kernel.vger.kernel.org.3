Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3C750AB88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442493AbiDUWeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442479AbiDUWeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:34:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0493BA52;
        Thu, 21 Apr 2022 15:31:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kksh95YYDz4xPw;
        Fri, 22 Apr 2022 08:31:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650580266;
        bh=K/i63ra8UxgMzrt5xDRATNjc2VCYqisfWqLaTNukyfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WqwBIvRilYOWPTWt1dEpFoqma8JQ4PZ07plyu54XcvevGowNkkexve3brkkvDuGbR
         vV4zqNKaUS/PplKUravPpqKUnpbHCogt2DjR1uBSYSjUyghbFgHWKOxYPJQsRQHNex
         6Ce5lcvMBxJPXvRAAjwTDvgwPQV96Whk8vMo0WG/qHnvxsPfiZRjl8yRlYGCvNAvot
         AjIpJrsWoRS8CgkBg3wnc4/WC/g8ufZpaORPBOuAaV+pYFpm1Q5zy24RILl8gavYCp
         3Q1byPQt3fGx+qeV6viX3vLWwf+MG52XZalu728Z+TLHJ0ZAEj+4rGADEeRBCq95k7
         EqG97iCWfO1fg==
Date:   Fri, 22 Apr 2022 08:31:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Caleb Connolly <kc@postmarketos.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tags need some work in the pinctrl tree
Message-ID: <20220422083105.6b778b90@canb.auug.org.au>
In-Reply-To: <20220421091055.12d6465c@canb.auug.org.au>
References: <20220421091055.12d6465c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jLpX_BaRe_Lq/fDUoiYfq=V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jLpX_BaRe_Lq/fDUoiYfq=V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 21 Apr 2022 09:10:55 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> In commit
>=20
>   6548c9dc711d ("pinctrl/rockchip: support deferring other gpio params")
>=20
> Fixes tags
>=20
>   Fixes: e7165b1d ("pinctrl/rockchip: add a queue for deferred pin output=
 settings on probe")
>   Fixes: 59dd178e ("gpio/rockchip: fetch deferred output settings on prob=
e")
>=20
> have these problem(s):
>=20
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").

This is now commit aa696c2e8f33.

--=20
Cheers,
Stephen Rothwell

--Sig_/jLpX_BaRe_Lq/fDUoiYfq=V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJh2ykACgkQAVBC80lX
0Gw0lwf/Xlnom577eoBWSwcngVhjy/oTTdvFYQn8cF+kFk1vXYimrGOhMDa+a3e0
4FhosQrdWJTspVfM492/WMqoG8rcwHmEGOW8GzhEVpB0DJ79IStKjao1zr2fNK50
R8wTbabfnqp4/YhBWRFV3ha/MgB0NBF4jgmCAtK2QmA8mRwpElrN5Gw8jmWKIKhc
gQ9kQ7mKb/RDbd+c9zmhVTel800/uoLDlnQ3NM9cgTG0TfzQn273FLdd3foxoEKq
2divPhBIlNIwmTdFHmigmfaR2YXt4Eio1nV/vKraTiKfQF0xr0sMgrFn2NfTcuNL
Tx+qnSnaz00fkhvCMEEDgRksKeyeow==
=R5cA
-----END PGP SIGNATURE-----

--Sig_/jLpX_BaRe_Lq/fDUoiYfq=V--
