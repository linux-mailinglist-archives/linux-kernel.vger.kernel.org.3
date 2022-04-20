Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF95088A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378769AbiDTNDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378786AbiDTNDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:03:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917E841FB3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D71D461A10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB68DC385A1;
        Wed, 20 Apr 2022 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650459629;
        bh=GgFN/NG7MZ+CMRVLpa6/uG+FQSLb79x6dY9Ok/gLJm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDqR1lgYVZDVjAXFl780znRq+EzCZQtAuBgWRXdWCJ7Bt5zV6QFyJ2NG0pkhDpG8B
         bNSbR3XnDAZK+jYXEc7zQl9PFxkDbITb2BsAmp40ALkiUU2tbWu3YbbCEPWBEcgehD
         e1Y4AM575lwbs6h7I8cVT0E+FPqZA8WPD/h9puvOwtU/3wTDp1nEVs9KjH/ifeZS9g
         6anzzGmEqB7iSeCo9MUEvPoOFCasBEkvfz4F6EXUF/jNA05CgsVj9znVEp3JcHD0sw
         xBbBjLqWeT48cOXw2HnflRuZqIi/ySnN4gMHeLRep2MFiziRWusSFPVsXRirIB1din
         yhMrE2DCoqX1g==
Date:   Wed, 20 Apr 2022 14:00:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl: Fix error handling in pcm030_fabric_probe
Message-ID: <YmAD6MIuKdjgm7Yu@sirena.org.uk>
References: <Yh90u+E3RTuGEDWU@sirena.org.uk>
 <20220420021855.8224-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="efKG2CWXr2Wpj9k0"
Content-Disposition: inline
In-Reply-To: <20220420021855.8224-1-linmq006@gmail.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--efKG2CWXr2Wpj9k0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2022 at 02:18:52AM +0000, Miaoqian Lin wrote:
> This will call twice platform_device_put()
> if both platform_device_add() and snd_soc_register_card() fails.
> return early on error  to avoid duplicating the error code logic.
>=20
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - use return statement to return early when fails
> - rebase on top of commit 559089e0a93d ("vmalloc: replace VM_NO_HUGE_VMAP=
 with VM_ALLOW_HUGE_VMAP")

Why rebase on top of that seemingly random commit?  Is there some sort
of dependency here?

--efKG2CWXr2Wpj9k0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJgA+cACgkQJNaLcl1U
h9DFwAf9GF3I/YlhSyVTcxq76mzScrKVify5IYug75y6034V/V8EfvQpAl74iFSA
j/ojJnAVUN/zwIlJArD+ODRonrsps1Ie9t44AgGOZPvRkniOTvgCjZAJAzTF5gzI
lKevcKZKOTCu30CRsLDQIpozLNGaZHqg108ppkn3pbc+tqL08oBJt4fdGTI7EVhV
eyMPbXa5DGuSSed5CY8zWiHRB7Kr31I20izJje8j92n4UkEvUMnvaUStFXHPVZWo
4z7amWIBtXixq7Kyh6APPmp6cb5jKJv3RFblBzFdbz62n5qFD1erZtzKGja70WT5
j4tg4q5ZVOWv5BVFAnI1ZpCtSSB8/A==
=wBgb
-----END PGP SIGNATURE-----

--efKG2CWXr2Wpj9k0--
