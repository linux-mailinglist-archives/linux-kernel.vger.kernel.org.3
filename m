Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474F75954E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiHPIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiHPIU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:20:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943A530F46;
        Mon, 15 Aug 2022 23:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B1A2B81600;
        Tue, 16 Aug 2022 06:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52582C433D6;
        Tue, 16 Aug 2022 06:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660629817;
        bh=Op1C0ruR4yfGwck7Lh6JhCOywz+i+Hxt6tKxf5OV0tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uEc2u1kJrahMwQXigTsouxNkaYv7rQTdHUSi+mObFEZoh+ENEz6Kt4Jli5NJOaJ9Z
         YUTGffSm1pj0CcyxRNWR7YSYfnbn6ZRrvst1UcLhbl3EQqNgXgki2dKEWwVQ80zBYt
         irXcsDwkcq/1f+7CU+Ps6J/znzKLtA75Mk/etff7o9ywvC7DS9laGWK0m8RWxgaTwB
         EjRiKV6kebXtOLPqrROgYiEst0LwQdz7XGS5SOaGRDaGPaPHKpe7zEFl/WspYM0al7
         +W+xUD+u0KB/rQhfesmxHFrADxNkuaXeB6I9yAdrTm+5Mtdn2cXI2nmc2Kkxy3SPwX
         psGnVpzSg3MOg==
Date:   Tue, 16 Aug 2022 08:03:25 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        linux-input@vger.kernel.org
Subject: Re: linux-next: Tree for Aug 15 (input/misc/ibm-panel.c)
Message-ID: <YvszHpWoIT37lcoD@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eddie James <eajames@linux.ibm.com>, linux-input@vger.kernel.org
References: <20220815122926.7fd3ac58@canb.auug.org.au>
 <0d836243-6a02-e031-961e-1e334dfd167d@infradead.org>
 <YvsaCjnkucMeyj60@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tMCH14dxriKnVX9v"
Content-Disposition: inline
In-Reply-To: <YvsaCjnkucMeyj60@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tMCH14dxriKnVX9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> It sounds like I need to adjust the depend statement to be:
>=20
> 	depends on I2C && I2C_SLAVE

Yes.

Thanks!


--tMCH14dxriKnVX9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmL7My0ACgkQFA3kzBSg
KbYu7RAAntx4h7OI+nbik5C3ob6SCavobkUI89eS+S0aazjO391XxCv4zMp/UVMm
TKJiYGA/HpZkp2XxloSXqCrvJhWINWVj59PtPUPggUq5IShXusvVKGFYA9mtS5cg
co7WSXatItVDZTkCimfvhxMExCVB0MBD++YXF4E7lUM4z6IutPsY/ceuZ96KnCpJ
nDoWpww+26k3Mq+R1a2svEuZNIZsHIwkgBxhBOYB9W1Ytlv9/jNdBcJNHF3yICry
UqSuNA2KBAiFqs0KACmv+qVO19ISECbIQE1o4y6AgRuZwE3wf7UeUypCbwxMpJT3
l6PD28awPyI1EjvR8cZ5XuX8sH+QP1e/YiW/s/6UM3BsH8G2Cv7XFOsQnPpfJ6wf
FYgdUzv8a6+u367FVuVHNsdyi8tbk5Bc3bM61btnN/aoIScItLVt/0Ka5m4q7rkK
6C6sxRLAAxTbrH5/l1pGx+TnhUMB0KYiYnlP8FkKT+DxEHAv6cmmvx1+uiQQwzNx
1ot/kw6DGgWUa0TyWQWLUXdd1cNVEfsCXw2oB8bxT3o/uGlFwhTtkS+hNr9jS3T+
0OdSwSaXTA8wec3ZVgdboIHefWwnCuq5o0xqi5NNi4sbX8eTRtZjHHWfH3QiXuTv
QAOsHIJUexTf10JpRo8I+dUl4GUrDNW3QCvA3szyyVfYHyOv0jA=
=o0e6
-----END PGP SIGNATURE-----

--tMCH14dxriKnVX9v--
