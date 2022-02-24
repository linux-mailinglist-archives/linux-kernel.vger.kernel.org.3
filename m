Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0784C3497
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiBXSXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiBXSWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:22:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF16191405;
        Thu, 24 Feb 2022 10:22:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 659C9B82423;
        Thu, 24 Feb 2022 18:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD85C340E9;
        Thu, 24 Feb 2022 18:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645726938;
        bh=1v8i4Usg2NZhQW/sf9Ue9s+VQpGM0wf62sj9FcuUiCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5HtBT8xRekoXQ9TFILItsIyY5OZbGan9Gf0sw92TzJ+YxT0Ej6xTuC1G/QWQxEym
         svCNfPjA1CSlA1o68nGuAKlOovsj3yLllwSSKOotyQ0NfJiosGnLXSYv6Pt2GZG+FP
         MyOfjeqj7lhtqpeVl3tEYI/qPOPW+JZjCalkGDMwHh5fJ8r3rIv1VCqzWKAG+7CNT7
         Lqe5AjcPJmbiruhnyw4Q33BxD5OnIISnaFgZK1IVBJUgVjyatF838ptBSgiIYfAo0S
         //UDM+ctqsmVzHn9UCndE8juMdvtNgKg/pB7EK3q0WpMtxVgJjgMRFOjKZQMXblFam
         A+Wd+V28yPEgQ==
Date:   Thu, 24 Feb 2022 18:22:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 4/5] spi: tegra210-quad: add acpi support
Message-ID: <YhfM1DO8vmvHah+f@sirena.org.uk>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
 <20220222175611.58051-5-kyarlagadda@nvidia.com>
 <YhUtQ/8Kgcx4OY4S@sirena.org.uk>
 <DM4PR12MB57693F28A727964ED67BBEB4C33C9@DM4PR12MB5769.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NN31DYzJ28edf/nu"
Content-Disposition: inline
In-Reply-To: <DM4PR12MB57693F28A727964ED67BBEB4C33C9@DM4PR12MB5769.namprd12.prod.outlook.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NN31DYzJ28edf/nu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 23, 2022 at 06:32:56AM +0000, Krishna Yarlagadda wrote:

> > > +	if (has_acpi_companion(tqspi->dev))
> > > +		return 0;
> > >  	/* flush all write which are in PPSB queue by reading back */
> > >  	tegra_qspi_readl(tqspi, QSPI_COMMAND1);

> > As well as clock stuff this is also skipping flushing of pending writes
> > - is that intentional?  It's not called out in the changelog and seems like
> > something that could cause issues if someone runs on a system where
> > the firmware does implement runtime suspend.

> Runtime suspend is not enabled with ACPI firmware. Converted compiler flag in v1 to runtime check.
> We must add more changes like setting DPM flags for runtime pm support with ACPI.
> Can take this as part of a different series.

It at least needs to be clearer what's going on here, the changelog
doesn't match the code and it's not obvious from the code that ACPI
won't kick in and power manage the device as things stand.

--NN31DYzJ28edf/nu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIXzNMACgkQJNaLcl1U
h9DJyAf9Hrv8ZOPOazKwh+GeTMwE1UXZSJtI+PhEMyvmN762w6PZV/oFVg3ZBx9E
rTMUjp7KwLQ810g+62lvBwu3Qqqhq3q50DXXLLtMStFHB1m+S9KaNlnWSAQyXjF2
A9388F0TTvnpOOzHufONVxNKqUCl3my8vvAFNYL24IHD/7af4ZGJGwMvTC7o6LtI
4Cjfm8BgQAaDcxBW2928tC1/NIZ5Qsep35p12FFL1dtHzlr30+Nlr44L8PZqIPDv
0Fv9hAi5Lg2LaA6bTZPmBh+cLIdL8BEOiw1gxFprahc+EKqkxIUN1KC+ZQDnMQhD
/G9CuHYJgIah4Oa9LBiDsQIDJc/xYA==
=Nx2b
-----END PGP SIGNATURE-----

--NN31DYzJ28edf/nu--
