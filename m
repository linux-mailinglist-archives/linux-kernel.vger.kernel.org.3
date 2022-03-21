Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F354E3096
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352518AbiCUTMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352472AbiCUTMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:12:46 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0497D18CD3D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:11:17 -0700 (PDT)
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id B037ECBD5F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:09:38 +0000 (UTC)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 78855200004;
        Mon, 21 Mar 2022 19:09:29 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Eric Valette <eric.valette@free.fr>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Sasha Levin <sashal@kernel.org>
Cc:     David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        1005005@bugs.debian.org, Evan Quan <evan.quan@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>, dod@debian.org
Subject: Re: Bug#1005005: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic in suspend (v2)") on suspend?
Date:   Mon, 21 Mar 2022 20:09:19 +0100
Message-ID: <4421935.LvFx2qVVIh@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <3873010.MHq7AAxBmi@ylum>
References: <Ygf7KuWyc0d4HIFu@eldamar.lan> <164405721350.15142.10930772309423612672.reportbug@ylum.maison> <3873010.MHq7AAxBmi@ylum>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2269141.ElGaqSPkdT"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2269141.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Eric Valette <eric.valette@free.fr>, Salvatore Bonaccorso <carnil@debian.org>, Thorsten Leemhuis <regressions@leemhuis.info>, Sasha Levin <sashal@kernel.org>
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Luben Tuikov <luben.tuikov@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 1005005@bugs.debian.org, Evan Quan <evan.quan@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher <alexdeucher@gmail.com>, dod@debian.org
Subject: Re: Bug#1005005: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic in suspend (v2)") on suspend?
Date: Mon, 21 Mar 2022 20:09:19 +0100
Message-ID: <4421935.LvFx2qVVIh@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <3873010.MHq7AAxBmi@ylum>
References: <Ygf7KuWyc0d4HIFu@eldamar.lan> <164405721350.15142.10930772309423612672.reportbug@ylum.maison> <3873010.MHq7AAxBmi@ylum>

On maandag 21 maart 2022 19:49:56 CET Dominique Dumont wrote:
> On Monday, 21 March 2022 09:57:59 CET Thorsten Leemhuis wrote:
> > Dominique/Salvatore/Eric, what's the status of this regression?
> > According to the debian bug tracker the problem is solved with 5.16 and
> > 5.17, but was 5.15 ever fixed?
> 
> I don't think so.
> 
> On kernel side, the commit fixing this issue is
> e55a3aea418269266d84f426b3bd70794d3389c8 .
> 
> According to the logs of [1] , this commit landed in v5.17-rc3

It was included in 5.15.22, but the newest 5.15 kernel uploaded to Debian was 
5.15.15, so their is no fixed 5.15 in Debian.
It was also included in 5.16.8 and the earlier version in Debian which had 
that commit was 5.16.10 (uploaded 2022-02-18 to Unstable). Current version in 
Unstable is 5.16.14. Testing/Bookworm now had 5.16.12.
In Experimental, on 2022-02-12, 5.17-rc3 was uploaded.

HTH,
  Diederik
--nextPart2269141.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCYjjNXwAKCRDXblvOeH7b
bmG4APwKJH+NoQnMbqymwjfra7bWQF9in5WYMwgRu3GlvTiYhgD9FLab2MAFTrVL
ufgQ54YsqRhBZcrwAhR1mtZBNyRlLw0=
=SPqa
-----END PGP SIGNATURE-----

--nextPart2269141.ElGaqSPkdT--



