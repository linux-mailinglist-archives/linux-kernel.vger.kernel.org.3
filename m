Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A251FBB7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiEIL4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiEILy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FBB1312A7
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B720261225
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D88FC385AB;
        Mon,  9 May 2022 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652097033;
        bh=b4aTBZ4v+rVQoWlkbu6lUJp1RJHxYYLupXeHe22aK+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlNdM41fWWZMMZ5VmLAz0aq7w+uOUXEjhHnW6/VgxfsZMoyrZEny2Hkk0t+Qv65VK
         Aj8zV/bpPwgdiVytEIyiebz+eM7UwsQiIejW1ruXiyORKicJHyx39i5753qVcKZKlB
         /bGzM/mn/8gwltwCt0274kMqGFL/a2QWaY1zOPYn+f5PfNRs80fuUoZb53eo0vyYUi
         SJf1xPUdJiVa5yYAvrwkBL9jW1ugsH/fByazvJobZTvXZzsrMCaCqV9ESFKrgA1Nmn
         IygHhchmdKOTVFwPQM7Vf5JivhSD2Ks2GjaxTh2CgBtZpo7rp/rteudTZB27n7F3V4
         Ciy68yOBXKDyw==
Date:   Mon, 9 May 2022 12:50:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com, trevor.wu@mediatek.com,
        arnd@arndb.de, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: mediatek: mt8195: Fix build warning without
 CONFIG_OF
Message-ID: <YnkAAx3VAXCMFOTn@sirena.org.uk>
References: <20220507021424.12180-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dR5KuFyvd2qk11zt"
Content-Disposition: inline
In-Reply-To: <20220507021424.12180-1-yuehaibing@huawei.com>
X-Cookie: Anger is momentary madness.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dR5KuFyvd2qk11zt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 07, 2022 at 10:14:24AM +0800, YueHaibing wrote:
> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1639:32: warning: =E2=80=98mt81=
95_mt6359_max98390_rt5682_card=E2=80=99 defined but not used [-Wunused-vari=
able]
>  1639 | static struct mt8195_card_data mt8195_mt6359_max98390_rt5682_card=
 =3D {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This doesn't apply against current code, please check and resend (it
looks like you have additional patches in your tree, am doesn't know the
base SHA1s?).

--dR5KuFyvd2qk11zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ5AAIACgkQJNaLcl1U
h9CSpAf+JWlnlwHrSebKB8rGFYewj7XuvxJYOCgKGxDjC0jGkchj3AvBNkFD2Kq1
oKVPST+oVCaXX3JrpiWXMJzRjyokDkQsXjQFuQ3xOLDyuohNk/lwI6KKLk04edeh
0DIySvexNYhTyNPrP3MjLrYvb9VTLJVSiNpmkCFBjg0ZMd3mZu37nmpMwXsE0HFu
go20cHPF9WoxMI6KUBmYD2sWaVqJzwXbnZBpY0Nf+HABKDX2tnjtXNqje7eAJ8Ai
WwiEC0IYZh1tmINQ87V4TahiDHNu7Sx+gFzEL410N557iw7AR/HLjxcdpUulA1zY
CcLY4c5Cj+UjV8DRBrLtzzxzZmEzcw==
=GTnm
-----END PGP SIGNATURE-----

--dR5KuFyvd2qk11zt--
