Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0AA592E02
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiHOLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiHOLRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:17:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C9D193E2;
        Mon, 15 Aug 2022 04:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3006B80DF1;
        Mon, 15 Aug 2022 11:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F09C433C1;
        Mon, 15 Aug 2022 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660562234;
        bh=W/yaUD8H8osi7PCA/66K+FamhQo0vP2gI8ZlpSabsTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHYYImmej84M4LXH8eqS+5hGIRxVDwEtUkFtyAxqB0WiaqZrrSs9EI96GWgMLA2wR
         kxPGeOGj3+Xg1KKroysyEjX4adZdkIZvFgs2ql+p7Crva3yqjiQjNeYle3zcSjYplz
         tvHPd0Re2MdtoUR/g0MFJJ5TBrO5Hqb8cE39+5VBfiFh2LFhY1G+/X9nbbwtTMpQma
         zLcVw/f59vNWR4hUG7Z5rM5yEhUJXL7UyltUQparIRyMCHA1EG4KhJgKxUJdCUoVUI
         eGGL/PDv1KakBpc+188Z61aSMoVYhB654nWpviweRn0n0laFgcZdds8yS3mc7hI/Ue
         E1fx9OnTtb/NA==
Date:   Mon, 15 Aug 2022 12:17:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian =?iso-8859-1?Q?Kohlsch=FCtter?= 
        <christian@kohlschutter.com>
Cc:     Vincent Legoll <vincent.legoll@gmail.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Robin Murphy <robin.murphy@arm.com>, wens@kernel.org
Subject: Re: [PATCH v3] regulator: core: Resolve supply name earlier to
 prevent double-init
Message-ID: <YvorNPDQQr2SH/NF@sirena.org.uk>
References: <CAEwRq=qe+Frwpe=Zr4n_8A6vjOJnV3noegdnHSN7NTazkKejBA@mail.gmail.com>
 <EC5FFA28-21D3-4FBB-B188-7DB1C9E1AA9E@kohlschutter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BS4sURjwakEpPU/r"
Content-Disposition: inline
In-Reply-To: <EC5FFA28-21D3-4FBB-B188-7DB1C9E1AA9E@kohlschutter.com>
X-Cookie: I'm rated PG-34!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BS4sURjwakEpPU/r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 04, 2022 at 12:44:29PM +0200, Christian Kohlsch=FCtter wrote:
> Previously, an unresolved regulator supply reference upon calling
> regulator_register on an always-on or boot-on regulator caused
> set_machine_constraints to be called twice.

This doesn't apply against current code, please check and resend.

--BS4sURjwakEpPU/r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL6KzQACgkQJNaLcl1U
h9DrAwgAhaRSjo1ExkJa1YbJUMKKn/otOtBO7eNxVvWSciwG/IAiYAXEJ87HPXmS
HzfPMs5fyoix7TsGJenFDKFWIrVdURL6piTK4buR81ysMXuWTuHljsEZvMAS2fBp
aj7d67yUUfrlReiCowW5+ELF6ni1jKhbOM6mDJXCS7tA3V7HAy8+nht6Z68D/INA
p9y8+BXf+nyMRHZrGVU2l+HXApp8AmfAtqd3TDyJFrHygLZdEgWND/hmsVUAuWwI
s1gdUbg/ZjMB5QOB8LjnId6QApoNuVOcVJhMj1QiuxcUsRauCRiQTKHv8cdVCr8g
yIzW2N5bCkTkbK8elVvDSowLpjxTVQ==
=L30m
-----END PGP SIGNATURE-----

--BS4sURjwakEpPU/r--
