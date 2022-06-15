Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C4554D4E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350602AbiFOW73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiFOW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:59:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8460205EA;
        Wed, 15 Jun 2022 15:59:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LNgjL0Vbhz4xXj;
        Thu, 16 Jun 2022 08:59:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655333959;
        bh=d5d/IXe2LkYdx5k7DNB4uYu/qhr7MqhAXwMIkq0IZr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S50womizPOE/MYo07uLMQcWFqsctzgwvZiWerf0osMSG5zjbC8x0h2xehY+IjdAug
         Q8ZWTFPVx7O39mZzBj+pw1UNC7GFA6lTwdb8tao4+F984YmtCrcN1vX2/OU5yccXRA
         uFE1rKlG9y0acJ20YeAbKiDea2xVfYHRgL0BL1Z+TvearBUCWZcVRC8GPng+dmntd7
         1YfbKQmaxoCeOtv9udflSSoxCnEiFLyXXUh0/0+1fgY1ryzYFDvArpTDOhQLNHLwY/
         jNQZeGjrdhaD7Wk+xsXx8Xjq/HVwtGM63jBGHbzNCBZkhQVHNSnOAwJsyKqs4RQdR8
         99V/4B6nRk2cg==
Date:   Thu, 16 Jun 2022 08:59:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Please add another drm/msm tree to the linux-next
Message-ID: <20220616085916.113e477b@canb.auug.org.au>
In-Reply-To: <5dbc0159-cb33-db5b-20cc-05f3027af15e@linaro.org>
References: <5dbc0159-cb33-db5b-20cc-05f3027af15e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0Rts+dJPHVuFp7yBrsgCJ62";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0Rts+dJPHVuFp7yBrsgCJ62
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Wed, 15 Jun 2022 17:19:42 +0300 Dmitry Baryshkov <dmitry.baryshkov@linar=
o.org> wrote:
>
> I would appreciate if you could add
>=20
> https://gitlab.freedesktop.org/lumag/msm.git msm-next-lumag
>=20
> to the linux-next tree.
>=20
> This tree is a part of drm/msm maintenance structure. As a co-maintainer =
I collect and test display patches, while Rob concenctrates on GPU part of =
the driver. Later during the release cycle these patchesare pulled by Rob C=
lark directly into msm-next.
>=20
> During last cycle Rob suggested adding this tree to the linux-next effort=
, so that the patches receive better integration testing during the Linux d=
evelopment cycle.

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/0Rts+dJPHVuFp7yBrsgCJ62
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKqZEQACgkQAVBC80lX
0Gy8RAf+IsCrpN0TDFAO9/3ciyLA7BYcxQ/hKmvxNaN2bLcryQB1yauyzvsDZXgU
IK0JJ3IIj74Spo+BkUYsET41GEJdCKZ+wsz3oxhRrTHm2SuA1uV5NcScB2AMuAc5
li4wgBFQ9+QOO+gjijsWKgpNsC51hjvmra4c1w5RmPk074XJCBzuSJQ+/aACQL3I
706Aexc/pUvuwWgBeSW0d5ykai0t7GXSfuefJxebvZfgyBL7KFd8TUsR4RSQ5hFD
sxc5LxZqW9+L6XRM3LSLaLJnKcnqK7pjuWrH5tqV9fM113XhN9ccJjdUtrZ0c5CW
nFRpf2SjqtvYrK+v4wKzAIvh2eC00A==
=NQ/0
-----END PGP SIGNATURE-----

--Sig_/0Rts+dJPHVuFp7yBrsgCJ62--
