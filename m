Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB01463C81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244606AbhK3RIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:08:47 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46650 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbhK3RIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:08:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CAE1CCE1849
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99524C53FC7;
        Tue, 30 Nov 2021 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638291924;
        bh=hphnhkSHJqskZN4ZuF98O5+cfuFGJ6VcXrVGP19KjW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raSMytiymPsDF37jsefWpuEssrdKGFTnkc0xVsXg5OUDGyOTJmH108r+um0Y0ZLj2
         9J/4f2tVEDqbeGQw9MCJZDX+EuYKv8Napdelblosb4Plmhw9Yo/YvGA/qtK++xXjTS
         xeOiO/8xtYrDXHcRft8KyDrl37gbrIr2bUPUO1vsCRDqYp6otMcP0aecuFT+tbcvVX
         yf3xGtGLgC1KW9Ze4j2MJcfW/5MhaWWqwjMElX/w60CiVmkkCyoq0ggk92TxA1eIM3
         MLV8VvkyhfRAhrMJuCa2+FLEm1LIMzion8nkwMEkkWerTAzv7I4wh7w57PiETRADPu
         HKJN7VUvrn9Eg==
Date:   Tue, 30 Nov 2021 17:05:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        daniel.baluta@gmail.com,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        AjitKumar.Pandey@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Julian.Schroeder@amd.com, linux-mediatek@lists.infradead.org,
        Balakishore.pati@amd.com, yc.hung@mediatek.com,
        vishnuvardhanrao.ravulapati@amd.com, vsreddy@amd.com,
        daniel.baluta@nxp.com, Bard Liao <bard.liao@intel.com>
Subject: Re: [PATCH 07/21] ASoC: amd: Add module to determine ACP
 configuration
Message-ID: <YaZZzSPQDz0vHRQY@sirena.org.uk>
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
 <20211117093734.17407-8-daniel.baluta@oss.nxp.com>
 <CAMuHMdVV6Os8Gzc9JVjD2CAtN38=7KFn9GqosnWvByQc-7uA=Q@mail.gmail.com>
 <bdbea252-09e4-eb60-acf8-4ea8a1d924c4@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W5Gh1d/V7Wj5vuMq"
Content-Disposition: inline
In-Reply-To: <bdbea252-09e4-eb60-acf8-4ea8a1d924c4@linux.intel.com>
X-Cookie: Check your local listings.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W5Gh1d/V7Wj5vuMq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 30, 2021 at 10:49:30AM -0600, Pierre-Louis Bossart wrote:

> To Geert's point, there may be an additional need to add a

> depends on SND_SOC_AMD_ACP

> There are also a set of

> SND_SOC_AMD_ACPyx options, not sure if any applies as a dependency here?

Or put them in an if block (IIRC I thought they were which was why the
dependency wasn't needed but I don't know what I was looking at if I did
check that).

--W5Gh1d/V7Wj5vuMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGmWcwACgkQJNaLcl1U
h9D5uQgAgM41glVdyKm2UPfvCs9Az0pVc/MIJufe1A5vkcXTuQx9PDfAr4gjWNHD
nIKNoikwGdj3FKLiM6jVSJuRMe5o/q63tokDrrNGBkwGyXN8jHNnlJL8ZuEDt2Y1
E2BlZaZPiVfO1K96M3xaRzEAivY52k1wp6k5EbtTGRQpW7X+TkGmF3v+ybdknZR8
Z84uqU6c60huQpTPHL9HQ5UOXLqKf5Ew/OJlEWkDRqziihmpgu/PLpNDqQDq/+tE
/bbHLPgrBs6GkGKGppCmGBgq0Bv55QXBPWeG76OFqKUGrkzCFQ5NVRNj0lL9c1hN
x2pXo3PKtOUT7+o1wcpmg5dAZmys8g==
=jZMX
-----END PGP SIGNATURE-----

--W5Gh1d/V7Wj5vuMq--
