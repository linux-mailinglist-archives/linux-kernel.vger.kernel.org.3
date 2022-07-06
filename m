Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C762B568A21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiGFNxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiGFNxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:53:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54361F638;
        Wed,  6 Jul 2022 06:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D99BB81CA6;
        Wed,  6 Jul 2022 13:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72A3C3411C;
        Wed,  6 Jul 2022 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657115580;
        bh=wj0NkPcbCotORQarBdiAbSyb16QUQjz/pSt7plsm12k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujscI4t2rRUPtr7y8Anf64wPRLszGIv84LzoyP3wQScr6oE3TRorySkt6CJnlfDI3
         nT/3GFuLRp8lokOcckMG/k8COVF2RSVgGeoBef6JqK0hgH0QJuQBLfrhuVa9/2H6mF
         G7Q++OAelNQynATL61wo7/tTBzbwHpBengktpcmkjudFThcBtk6cNiGK5i/sy2zHeP
         1BOxXsot8XtLyrlnhiDbxab9dx5irQvE9qoi5eJlalmSyzXI/W3HxYwoh5exGdSbT2
         0HCo4KBHjvJtFwuLA2DEbhsMuRPzKvUzc4okW+wCEzVBUgM55wTNNWaweq+wOOwJw/
         3UDlhNevAkc6w==
Date:   Wed, 6 Jul 2022 14:52:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lee.jones@linaro.org
Subject: Re: [PATCH v3 RESEND 0/4] MediaTek Helio X10 MT6795 - MT6331/6332
 Regulators
Message-ID: <YsWTt3YSHI9LLpnw@sirena.org.uk>
References: <20220706100912.200698-1-angelogioacchino.delregno@collabora.com>
 <YsV9IerWCoa/xtwM@sirena.org.uk>
 <57367b11-f2d4-476b-b92d-16c1726316c0@collabora.com>
 <YsWG0jfqAf4EqojE@sirena.org.uk>
 <82736173-b3b8-1e1a-3e2e-25d9ca3287eb@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+0DViRXHLgzETHHF"
Content-Disposition: inline
In-Reply-To: <82736173-b3b8-1e1a-3e2e-25d9ca3287eb@collabora.com>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+0DViRXHLgzETHHF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2022 at 03:38:34PM +0200, AngeloGioacchino Del Regno wrote:
> Il 06/07/22 14:57, Mark Brown ha scritto:
> > On Wed, Jul 06, 2022 at 02:49:56PM +0200, AngeloGioacchino Del Regno wr=
ote:
> > > Il 06/07/22 14:16, Mark Brown ha scritto:
> >=20
> > > > This previously got 0day failures due to missing dependencies which
> > > > need would need a merge with IIRC MFD, I see no reference in the co=
ver
> > > > letter to dependencies?
> >=20
> > > The only blocker for this series was the MFD patch, which got picked =
and
> > > it's present in next-20220706 (as you suggested me to resend when thi=
ngs
> > > were picked... I decided to wait until they actually landed on -next.=
=2E.)
> >=20
> > Right, I also said I'd need a pull request - if I apply the patches
> > without having the MFD bits they depend on in my tree then it will fail
> > to build.
>=20
> I remember writing that to Lee... how do we proceed in this case?
> Should we add him to the Cc's of this patch to notify him or..?

Lee, Angelo has sent me this series for Helio X10 which needs some MFD
bits (not 100% sure which, I guess Angelo can fill that in) - is there a
tagged branch available to pull in?

--+0DViRXHLgzETHHF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLFk7YACgkQJNaLcl1U
h9BVVgf/bVTIQ3LJY8DflcGkJacwVGb56elDn1Amq9pkxXbkJtQnWXq1DMcGQSKF
LnkN4wFuVKAOvPId86+vggsnTiqYoXFIUge+e4O9q+dyMS4cTGSaeNgzJFz6Kp8e
njWWIV9OfQsiIXJV+P+CBUrbKePomFwOgSiiOr1j240ou7TBYJc6uGOfMOC1A6Kw
zJxkp6clmMWF1gGu/YaK0I4L+p4L3LoJCyXT491GxjpwIs2zzSa8jMMVCzfi81Ny
V8n7BZCF4sVXQ/D6I9LL8iPUiR6JMtZppenkPYmqPSVbJihcmEC28sXODzvvpSMm
tTfrpr8NVhtxJ2kdZT0OEcyqEoGI2Q==
=2065
-----END PGP SIGNATURE-----

--+0DViRXHLgzETHHF--
