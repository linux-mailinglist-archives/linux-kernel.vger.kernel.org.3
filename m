Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227AA569765
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiGGB0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiGGB0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:26:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE71D2E9CD;
        Wed,  6 Jul 2022 18:26:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lddzm2g3nz4xXj;
        Thu,  7 Jul 2022 11:26:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657157204;
        bh=QNLWE/k+VusIo03qhTqVGkLaFHv3Y8wqyv5WGDliXc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O4xiZQzyhgTC6IvrHadLPrqBZG/6IER1aMM4s56vxUIpvf8bstEVc1H2welgVDMbj
         9GlZWafM26NrbW2XNShly+aIJRJuYMlKvEaka2mBoS7ceopcHY7Dlc5ek40uPds66U
         grwfQbK0DKJK2RnppZwoLxAU6PvRozJ8w9YvxmWLaEyKoJ9jMVFiXzry5qT2Q3EAxe
         q+2B29n9gcwqXqnq07Jpl6ITwCiQhJ/G2fhPmxy4i1meSg/hHU+AFcdn+SjRhfASNg
         l24Z6ilF/rxQkg8yBjJSLt0pLi4PYdofRuKu0ELQO448BQUke0qYYoy82+oA/nsJX2
         yYoDRZm8mbfxA==
Date:   Thu, 7 Jul 2022 10:52:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Amadeusz =?UTF-8?B?U8WCYXdpxYRz?= =?UTF-8?B?a2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20220707105243.7952b5e6@canb.auug.org.au>
In-Reply-To: <YsV7jC2eoEx6G3qH@sirena.org.uk>
References: <20220706115529.7deea289@canb.auug.org.au>
        <YsV7jC2eoEx6G3qH@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qxu3fVwru.D9wnUu74y0uUZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Qxu3fVwru.D9wnUu74y0uUZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, 6 Jul 2022 13:09:48 +0100 Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jul 06, 2022 at 11:55:29AM +1000, Stephen Rothwell wrote:
>=20
> > After merging the sound-asoc tree, today's linux-next build (x86_64
> > allmodconfig) failed like this: =20
>=20
> Which toolchain do you use?  I've been using GCC 10 since it seems to be
> what Linus is using, anything else I try has tended to get spurious
> failures in from his tree.

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0

--=20
Cheers,
Stephen Rothwell

--Sig_/Qxu3fVwru.D9wnUu74y0uUZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLGLlsACgkQAVBC80lX
0GwSFAf+LvTE544Tx79wOVfrcDOv2h8X4ohcZN7fn7ue9nQgUuYOpUSIv0umTinX
lhAJCcSBtpS2WJyL9agwqIDynAYb4lSdNMBu/vi/vskLpUK6uOqs77ci82frgjPB
9gbwgVkS1dvV9DcE4IEiNjgwRnMCpAOyFsHjkM4RL3yP1S50xpdrAdRF7a7CwHxy
9A2YHIDUBIr/TS+9vbniXZvbcTrzL/8kV9aGcFdB9s/24JW5I0TZAeGp73HYHXvL
V8halFLVaMAc5Z5asUK8PXaTxEYUGE7JMo0asaJ32Zs2y2uWAPHbfDggFoxuKCPE
IBLSHrAgwOV02iUR/LZFWf85yjXAXQ==
=26x9
-----END PGP SIGNATURE-----

--Sig_/Qxu3fVwru.D9wnUu74y0uUZ--
