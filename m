Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195145618CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiF3LL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiF3LL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:11:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E43A45513
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A031622A7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5634C34115;
        Thu, 30 Jun 2022 11:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656587516;
        bh=gY2GwuIoEENdxG1SB1lnnV49S2t2kuQ/2lN1uJIHe7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVrcb0+6182VKbB5+5bvi1s47yAwFfK8wb6zyFp/VYh39jS8CJX26v7VDJPXvmt6m
         Sq2aO1HVesfnXCRoOn7xIDqeid4zMoKig2AFowAiyxupDRcEhytjTmgOOHIFxtLXlw
         WnQGX/rMorDO05WZfM2GdvgCHMyaE58VmvJkvF/xcXat99lPVXYetwLQ6IeXcy6B6f
         JUK0/znx1WjGYVUCDVrm+wdH0I0gZjJYAJ33E/C25y9dFkfwom6jJpMDF2fXuNb3lL
         IRkA55V7usztN7WA1+/7khpvE/IZDERTGKcml1CeNR8YLLfUFjZrTIDolXBotPH1oW
         I7lLsShPC8ArA==
Date:   Thu, 30 Jun 2022 12:11:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        zhuning@everest-semi.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Julian Braha <julianbraha@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] ASoC: amd: enable machine driver build for Jadeite
 platform
Message-ID: <Yr2E9SQCtk1u6V+i@sirena.org.uk>
References: <20220630031755.1055413-1-Vijendar.Mukunda@amd.com>
 <20220630031755.1055413-6-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KL9cDJfR2Dto7H+U"
Content-Disposition: inline
In-Reply-To: <20220630031755.1055413-6-Vijendar.Mukunda@amd.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KL9cDJfR2Dto7H+U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2022 at 08:47:55AM +0530, Vijendar Mukunda wrote:

> +	depends on SND_SOC_AMD_ACP && I2C && ACPI

The code treated ACPI as optional so you could relax the ACPI dependency
ot be "ACPI || COMPILE_TEST" (I think the same applies to I2C).

--KL9cDJfR2Dto7H+U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK9hPQACgkQJNaLcl1U
h9Dsnwf/ceuWdmQ1YUNUCt6hr1dWc8w8GCz8hT5Wl9l1lyRROuKUldbDQWBk2+Ye
7cCxrDYlIRL09GtZbdu+Ct5uWqDgBEZ6K6RT4eDMrYVTlpRbKe8uCBSQem7NXmqD
jfIU9Z5b1gpqJsSWuFRY3I48SjN5UM6NclGCfUPv+XMr3QWw6jcSzIAvReP/GX/r
3VczbScE+g1wZ2jIzEjAkiIdK53sb2+C0Z4PmrI0B4KvLvCSZOXFLIlydLtsTnsG
OZRUjPW2Lb7mxEksPzmMuUAMQ3bwd4iHK6rqcw1WZ9VvLXJwBcP55U8blR/bNlVE
MvRRSDyctG4b+sAJy5gA+gwjPQYjOg==
=Eu76
-----END PGP SIGNATURE-----

--KL9cDJfR2Dto7H+U--
