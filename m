Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639A74D9BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348614AbiCONQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiCONQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:16:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DC3527E6;
        Tue, 15 Mar 2022 06:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04CABB81632;
        Tue, 15 Mar 2022 13:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A97EC340E8;
        Tue, 15 Mar 2022 13:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647350123;
        bh=UseLGcGOm/pva/SYnye9j1eMFLi438hMBLmXnU/SEmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/6ksWqtcBc+GFZBAsCSt7uqXHjc02cvBcR93rZ58hH1iHPxtHAy9ziZBY0wZZwkC
         LnhvnWFZLyhFxFQRXO2z4lzF1f+FfJKArX8vnTekK3m43Xk271wUamIHMB1SSHaiDJ
         7YU5b+ZLoXA9cxjph4jnSB3sYg9yKnlr0qGDUhOtbL9EctztbABkd/3keiW2QRIKCe
         TjGvcYTff3RATNurjgiocg/Wbn70SDooQjKZMbbvpXNBSwhETLKfM5Bo0drySRmlxe
         hAjl3RSbAuGM6YLbyZJGEoCeklflvLjXCb06Escm5Vi7Y0mdz9SocJgDmCJ10luQD2
         lCEmrQqHK7lxQ==
Date:   Tue, 15 Mar 2022 13:15:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>, robh+dt@kernel.org,
        aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v3 10/19] ASoC: mediatek: mt8186: support tdm in platform driver
Message-ID: <YjCRZTu8AkYI0JVR@sirena.org.uk>
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-11-jiaxin.yu@mediatek.com>
 <3c7c6e67-072c-6377-05bd-1b5baa579666@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l81KvQLrUFtHOxoG"
Content-Disposition: inline
In-Reply-To: <3c7c6e67-072c-6377-05bd-1b5baa579666@collabora.com>
X-Cookie: Tax and title extra.
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l81KvQLrUFtHOxoG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2022 at 11:39:11AM +0100, AngeloGioacchino Del Regno wrote:
> Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> > Add mt8186 tdm dai driver.
> >=20
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >   sound/soc/mediatek/mt8186/mt8186-dai-tdm.c | 695 +++++++++++++++++++++
> >   1 file changed, 695 insertions(+)
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
> >=20
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c b/sound/soc/med=
iatek/mt8186/mt8186-dai-tdm.c

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--l81KvQLrUFtHOxoG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIwkWQACgkQJNaLcl1U
h9Bgtwf/RH2c0IQZVoBoFn8poE9HNrcM4ygfZJzlVBNxt9YQYh0qv/JjP8SsDxX7
V7A0sxQKGv73G6memlblfku6BE/MGVExc2siRVrmGAHnGD2dAuszueDp4XS4mrA6
eeKUvgHb6a3eV6fK/ELkpGTN++EHeypOx0MmZ4QqNS4L7ZKImNq+d44g+NTGervs
3Bsuec4/q7EJOKo29k/FwCfROip7uXzbpnjMsFxw5DFxrV4rATzpT+CqrgtqDs4m
bPlk4/BaDQyEdijcsMtgkh/UqSS5pUcxWnpB3dLanBJ3i82HVLjLh184VzRi+/3k
N5Wpe8EHd91mUjff+MRKzjD57IBd2w==
=RzsX
-----END PGP SIGNATURE-----

--l81KvQLrUFtHOxoG--
