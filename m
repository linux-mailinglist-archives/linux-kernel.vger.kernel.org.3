Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C460059BF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiHVM1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiHVM1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:27:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E27B32A9D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DABD7B8111D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ADEC433D6;
        Mon, 22 Aug 2022 12:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661171265;
        bh=aUEahSk14C2D4VY+24DDPQUNApAcftefeXOc7P9REmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sMmjAuhi1ZkgpyEJuzIt3cp9qztm5Pn9m3o7Z6R4bVmpNbhjbVot+Q5W/Y5EiKGxL
         7Jw7MrDdLUlfpqAHC63ZZfii65rHIalalJIiqWxI0+v8zswwvzecDsy1rPgQz3W0M8
         TD3pOM/Iwj3dGmVEoP1tkAygTClJrqVB+d5zLN2M+GlxP6wDqTc7GSKb+npYuQAtIM
         OKuxxUXrLiDbriI7fkXpcN7vwhsniAl3DE+tQf68CKoBYCRuNiUvJCpu/GsSeXVZhZ
         WqDDrP66untaxGqqz1IlSONIl9WQT8oYarXxQOhtEkqMeED/pVRwA8pyylw8KBVI/g
         OJFGiRaDtx3Pw==
Date:   Mon, 22 Aug 2022 13:27:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: Export new 'graph.dot' file in debugfs
Message-ID: <YwN2Pd4Ez08yDFno@sirena.org.uk>
References: <20220822095242.3779-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H0vk/nqgiuFqMzfW"
Content-Disposition: inline
In-Reply-To: <20220822095242.3779-1-povik+lin@cutebit.org>
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


--H0vk/nqgiuFqMzfW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 11:52:42AM +0200, Martin Povi=C5=A1er wrote:

> Provide a DOT summary of the DAPM graph in a newly added 'graph.dot'
> file in debugfs, placed in the card's DAPM directory.

There was a tool floating about in the past (last copy I knew about was
on Wolfson's git but they took that down) - can we not just continue to
do that?

--H0vk/nqgiuFqMzfW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMDdjwACgkQJNaLcl1U
h9CpgQf/YpXIsBv47/vLUdj+ktYB8vSAnTLc3Zwc24N6Q6H/0Zqz3P75GOcIxIO7
FXLfNx9fkoK9jFVJTo51CKgOuBADb9DJWkVRDUdWzPx0hhOVx2IL4S67bHhtNybo
vAvUI2poQFa9kNxaWpYuz8X9BoWj45QmfvN/2uI03C21/CY6wZ/k2QLOcfx4gz9y
X+gl9+fv3mCNo+NsFhzq3AG4+aEAuQM9YOq9r65EkaPR9besOQ7it+ivnwUnY+dn
vRBMD5JXD3JC26GHdADAUL5/rs5XI9rr0OOPp7+MthhMNGrs2b3uG5ipbdiuakKm
uM2yKH8eusk56vFsWCTaHr8HZP2a0A==
=SGiF
-----END PGP SIGNATURE-----

--H0vk/nqgiuFqMzfW--
