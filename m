Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76385911DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbiHLOF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiHLOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:05:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBD828722
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3938EB82439
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D60C433C1;
        Fri, 12 Aug 2022 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660313148;
        bh=L6s/3V+2RDSqXqOMABgXGLBrmMH6VzcuNjpEgd5MJBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKWGf6OgnJ8rk3ranVglnmL9dUgrcCMg99d3LsNTEgL7a2uvNpv4fCP+ONUiAuzfN
         9jfTB2XbZfJYO3fLpG4bC5Go9CgNHl50OKxJQZ5XI0NgMNqAGoSTssdLpPimbMqxiu
         U4/qhfyQuoYKAqIZF6c/eV28SrPSs+6WEvg2p5khqnvEE/kCe3OHdVM5LX4I3/FTB6
         P06TWh5Mo6dEdjZEZ1sNLbE7H3IVVuNFSbxAcRNGXNAoPKg3lc5Z2ZvQ6wtHrJsEzg
         tg7Lt1gv91RYZh3EqHpBPU/a7hsTYlgvmX40mgbJr2r8pZWMulXevHExxmCNgToIeY
         xU80TZUzxDBlw==
Date:   Fri, 12 Aug 2022 15:05:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Syed Saba kareem <Syed.SabaKareem@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        mario.limonciello@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Julian Braha <julianbraha@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bard Liao <bard.liao@intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/13] ASoC: amd: enable Pink Sardine acp6.2 drivers build
Message-ID: <YvZeNDg++YwEsgdI@sirena.org.uk>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-11-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ho5JmIyVDF+a7B7s"
Content-Disposition: inline
In-Reply-To: <20220812120731.788052-11-Syed.SabaKareem@amd.com>
X-Cookie: No foreign coins.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ho5JmIyVDF+a7B7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 12, 2022 at 05:37:28PM +0530, Syed Saba kareem wrote:

> +config SND_SOC_AMD_PS
> +        tristate "AMD Audio Coprocessor-v6.2 Pink Sardine support"
> +        depends on X86 && PCI

Could this be

	depends on X86 || COMPILE_TEST
	depends on PCI

to improve build coverage?

--Ho5JmIyVDF+a7B7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL2XjQACgkQJNaLcl1U
h9A40gf/Y3kAtYJe9AfxmEWCRlcGJIgx5gfE0NqOS0ki0Gb+Za0kDH0Trmk3SYVx
zA+g2WX4B3+vU3pXcejOfqWyskeClXTBwhPsoeZDY8QvmKmI5NGWGkpbnR5UahrY
DwaJE96SfO0bnlGUa6OXQsTf9qvs18UYkJq4mzbfScHRxxHgmjMsq4dF1QvfwFji
pHzLKovxE9mCtE3DErpQJQNvo5ZHS4+zVZxbPL1kUlWFiy1TEkuEqwM3UdnK/pgG
y9MwfrziAblT3NOhN6fgMdBNWEI+jLs/XXlwhfBmFSA1ekP1fZKrOL7zFSh9aE8Q
tBXNDR+y4RWfHQC1+GDfww2g9VRsQw==
=RyBW
-----END PGP SIGNATURE-----

--Ho5JmIyVDF+a7B7s--
