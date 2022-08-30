Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E875A714A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiH3XAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiH3XAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:00:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A3A94EE8;
        Tue, 30 Aug 2022 16:00:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHN7c497Yz4xG6;
        Wed, 31 Aug 2022 09:00:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661900428;
        bh=nE0WEQfnKDXBwm/+0D7dRm2n1Xi9E32uQ4lYG6IirkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DE4/T3ojyedyVuNVt8m9+GuuACl2DIKfc/EEh0vXdNiYO4cXjLrptwkR9aZtdxBMh
         f3NL39gG0UQvvf8FJjTXhTXqjUEt8wEuMaHbkgfuJ0FiSw6TrBAhGjgKMTIqp7JWq3
         PUv1O0UgJpX5EwSizhD6ZYtGMfmAk8W+DDZCaugOZNGnmkqv4NGqhvC0LP3Jewuhuk
         rd1ejomR5dH4Sq5ZSWo5bRuRHJx77lbSIfsZVYKO7vhFFmIc5AiR1t+RaUBG9noVnl
         PU0JBCA+B2r9AwOTqhKuHy2Nd8wPRCRm4k9EaYLjLILsaC781TLYtuosuDQruWPpxr
         WSVgPizYED0aQ==
Date:   Wed, 31 Aug 2022 09:00:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the amdgpu tree
Message-ID: <20220831090026.2e6b57ac@canb.auug.org.au>
In-Reply-To: <20220811121050.0da83776@canb.auug.org.au>
References: <20220811121050.0da83776@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tTkT0.sZmTTKPObn2kXxfth";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tTkT0.sZmTTKPObn2kXxfth
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 11 Aug 2022 12:10:49 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the amdgpu tree, today's linux-next build (htmldocs)
> produced these warnings:
>=20
> drivers/gpu/drm/amd/display/dc/dc.h:465: warning: Enum value 'MPC_SPLIT_A=
VOID' not described in enum 'pipe_split_policy'
> drivers/gpu/drm/amd/display/dc/dc.h:465: warning: Enum value 'MPC_SPLIT_A=
VOID_MULT_DISP' not described in enum 'pipe_split_policy'
>=20
> Introduced by commit
>=20
>   a2b3b9d57bdb ("drm/amd/display: Document pipe split policy")

I am still seeing these warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/tTkT0.sZmTTKPObn2kXxfth
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMOlosACgkQAVBC80lX
0GzZ5Qf/bM3zEdfIHo6hsYGNHDO2SlqPgO2cKKrCYEI+knlRPnaSVrjSBkSpSEt2
DMhJO8QrBgtOphBKDdVtHshz1ArrsRibjNo58t7dqcNh/tzLPYxUYqTdrpLEH1KT
V+gdUN4kTtEgvwdq5olhNw2JtzMJv5Yno/+1eml5SuHN6MCztIYq7aQQVoa/ysgT
KSjXWHbqgh5781g6cIXRl0W7vGKZ5rXb0t8ZMiNQJzt2M71qTx1COwD4MUGL6VmY
e/oArXcAF+1GipFUa0oxMfN3BHQsw7ZmbrlJDwKy/tbgQ20WFP37ZCQ5yP1vCbGe
8vsrzTo5vYEPas0dXMToWVtj/yksaA==
=IFam
-----END PGP SIGNATURE-----

--Sig_/tTkT0.sZmTTKPObn2kXxfth--
