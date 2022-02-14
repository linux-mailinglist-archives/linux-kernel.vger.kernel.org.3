Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710494B5371
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355211AbiBNOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:36:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbiBNOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:36:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D034F129;
        Mon, 14 Feb 2022 06:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B86161140;
        Mon, 14 Feb 2022 14:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8B4C340E9;
        Mon, 14 Feb 2022 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644849401;
        bh=E+kOlpQ5+sSN5EeUgc9Yx46fgmthvNaEGq85qwaWIAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9elcGysTGIwCUXi2iC7SAKPXok1BxDM8BygIqDpAIqTEMg09/0Xa98piB45nCLiJ
         Jd1l5eWAKNF8ABhTotzbnjz8y/7QYqXpdq3N4yAmYeBPGY0Fysnk6qbOfF1NgO18UG
         DRhOHoHBPpfdwaRzSTy8OIqGGBxa7A7CJjoJatAxURnwB8tFftlRMhf+ZWLaNyqq1Y
         U7/jyIGa+i4Q/ebMvR6bt7olhFw629Oh/43eLPc7aprEW5RJyiiqjVIhS0OQTCaJc7
         hWnbSHIr9To5QegwuuKutco5TtUPKo13VUfLQKavlI+jeYOsPXstB4ODwgUNI4wMCL
         dwzjeOwVkjT4Q==
Date:   Mon, 14 Feb 2022 14:36:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xue, Ying" <Ying.Xue@windriver.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] spi: disable
 chipselect after complete transfer
Message-ID: <Ygpo9YT9PrQAAIH3@sirena.org.uk>
References: <SN6PR11MB3008AF5619B0B026836FD7429F2F9@SN6PR11MB3008.namprd11.prod.outlook.com>
 <YgU1+cIlANAkJCAL@sirena.org.uk>
 <19c69765-8584-2e6b-25b8-7053a5afa5d4@windriver.com>
 <YgVH310gQ1sK6dlr@sirena.org.uk>
 <a5aa6dcf-e3dd-e8ff-edcb-edad96f8ddfe@windriver.com>
 <YgpOzw2rq+vAIPBU@sirena.org.uk>
 <8fd9c3ef-df64-b8ad-de6e-ef86806d53b5@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="72Gu1XoZSGNCURKI"
Content-Disposition: inline
In-Reply-To: <8fd9c3ef-df64-b8ad-de6e-ef86806d53b5@windriver.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--72Gu1XoZSGNCURKI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 10:20:21PM +0800, Yun Zhou wrote:

> I can't see from anywhere that when cs_change is true, we must keep CS
>=20
> active. If an individual controller needs to keep CS active after the who=
le
>=20
> message transmission complete, I think we should set cs_change to false
>=20
> rather than true, because cs_change means to change CS, not keep CS,
>=20
> otherwise let us rename cs_change to cs_keep.

*sigh*  Please also look back at how this has historically been handled,
this is not new behaviour.  I'm not saying that this is the greatest API
ever or that it'd be done this way if it were new but that doesn't mean
we can just randomly change the interface and potentially disrupt users.
Whatever else is going on the current behaviour is intentional.

--72Gu1XoZSGNCURKI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKaPUACgkQJNaLcl1U
h9CO1Qf/SC6MsM85RZDC2oqwT9XGNHnNUR8k9EPhEH+we3qFs2cv3N5L/5twaJHq
8aRJrzYs0WQ4BQyzlD72pJpNJOJu0XGHV/hN7seoaS1S4BNVi/C+z8ZqpeKSEXmg
3uq6LAnTC4dGklhP9Uvl7nwEgLVH9NULVN1xCUnNBFRP8g4mcQGegtPV+LM+M4Nd
7mOcwLzbsRwsG5XuLV0NeGWcNKYBWu79rqHY9f4Addz1x2NSJL100UlmqeEiT4Bv
75t8zjyTFr6EG9roywTHrKk1tDF+97WrCpTQeIG0xMPwHfPkEVDOV2o3vh+IOqIF
Bcd/6oYu94DXuNNuWY3IlhvhLQNI/Q==
=ko9Y
-----END PGP SIGNATURE-----

--72Gu1XoZSGNCURKI--
