Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B273259C011
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiHVNEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiHVNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:04:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CC5E03F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B66E8B81134
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1475C433D7;
        Mon, 22 Aug 2022 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661173464;
        bh=vIb4UZI/92cxyBbJg8AExe91iFXBczfLb+FceTDbGNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmCuKh5fGisFQtbi/Y2IeMMO7GS/Jyd9g61b3drBtxAKDYmlBuHX5/ykHliH1t6vy
         1M2YTfhDjLbf+66FHG4jrSXDc0cExFBq3Bo1/iH41AWuhZSadr/PQL6agp7XdtubcG
         HHZSjkuuQcPYJMjJ5bxa/UMla+wHrMPwTB/wH6G3v9qsx4Xa7It0a02ATv2yadYdg8
         ZU/BUmynZaVHLGxID3koqT/+EHKoS0P7BXOA3TLCZumMw6C5GJ8Bl/TQu3w/GN2Eqf
         4Xrabqm2XRpPRtzhkgiXfg8u0ECGWofKugPWnDbTw0Wxuyo1fj8Niujle0tMMA5SiG
         D8PjbEfdwU6zA==
Date:   Mon, 22 Aug 2022 14:04:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: dapm: Export new 'graph.dot' file in debugfs
Message-ID: <YwN+0yHSOSC2aD+J@sirena.org.uk>
References: <20220822095242.3779-1-povik+lin@cutebit.org>
 <YwN2Pd4Ez08yDFno@sirena.org.uk>
 <3234D74E-0DFF-4BB5-87ED-6135BAC1F31D@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XpiXeP+qgN0GU/v6"
Content-Disposition: inline
In-Reply-To: <3234D74E-0DFF-4BB5-87ED-6135BAC1F31D@cutebit.org>
X-Cookie: Do not write in this space.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XpiXeP+qgN0GU/v6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 02:38:09PM +0200, Martin Povi=C5=A1er wrote:
> > On 22. 8. 2022, at 14:27, Mark Brown <broonie@kernel.org> wrote:

> > There was a tool floating about in the past (last copy I knew about was
> > on Wolfson's git but they took that down) - can we not just continue to
> > do that?

> I don=E2=80=99t know the tool or where would I find it. I think it=E2=80=
=99s neat

Copying in Charles and Richard who might know about the status of the
tool Dimitris wrote.

> simply having a =E2=80=98graph.dot=E2=80=99 at hand, especially since it =
requires
> little code. (Although sure there=E2=80=99s the danger of it growing.)

I'm also worried about people going in and wanting other more tool
specific formats adding, if we didn't have anything at all it'd be one
thing but we do have something.

--XpiXeP+qgN0GU/v6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMDftIACgkQJNaLcl1U
h9BhVQgAhlYauVDB2TMVjfnWr1F+7/cau+jUQ0QXgSPk1Ypqi1/ENVv2H4kyM09x
Qsk7wyl8aFnnn/zl4RFiZH2FT9H9dSZENhlb124dH0+FlAYXrCEuUn52/mg7Jddk
aRhlmWlBtFqpt+hKBGokVm9uImJ7Pcq6ISjXVjzhft6AN44gC8XpzBhQnMPgKHbL
+UFQtYcTIIpq+PBB6XpnbvOm9BXFy/7+fmviPM+SmUlbwtTPxnTlMYUZPQea9AQw
DbIPKx09nrL83HACwh7XFCpNWu9zX3jOWC4mrJMQunjDriXbyX3um/QgLKvqvrb4
s56C/Ac+73PfnD5/qeenUr09NK4j4w==
=T8Gc
-----END PGP SIGNATURE-----

--XpiXeP+qgN0GU/v6--
