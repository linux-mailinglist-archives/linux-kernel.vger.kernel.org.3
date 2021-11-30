Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9782463B64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhK3QQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbhK3QQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:16:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1521C061756;
        Tue, 30 Nov 2021 08:13:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 269F5CE1A5D;
        Tue, 30 Nov 2021 16:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1D3C53FC1;
        Tue, 30 Nov 2021 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638288787;
        bh=RQsFpcDyHf4srgmnNCL4bgMJUInhxMAX/3HgHnGTd+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSex20PpNNt01eaPfXM8dzXkpkScJHf0Y0tSv7ePGBfbn580nPcFz4XTS/YW6G1qa
         OCxj/ANAV5U0xu7RMI+HXU85KeEa5TbP9IrOPH6fA8U8K47WXMcRTFzFzE7Ft2Ry4H
         qTWW2D/2RE7019Gp/lGjBx1KZDHcghIsQp0op/9asfRJMibVC9AYIivKC1JqnntecS
         GNQkkQefrttsH5Lby20GJOYidVWdpWDDnuuWuR04KvVQVLycNQ0ZG3HEy+sBM69kS0
         GaazzyuDsusKjceUZ+sMem4TfaTIfKrtHC0rtq4QHjFA8HgBls2STyZsEYtMUUTPrA
         fE/EMrflp7QoQ==
Date:   Tue, 30 Nov 2021 16:13:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: tegra210-quad: add acpi support
Message-ID: <YaZNjgnJZWdKwT+L@sirena.org.uk>
References: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
 <1637834152-32093-2-git-send-email-kyarlagadda@nvidia.com>
 <YZ+ImY1LrvB5a5iF@sirena.org.uk>
 <BN6PR12MB124973BF5CBB4AB35CC59B8AC3669@BN6PR12MB1249.namprd12.prod.outlook.com>
 <YaTHKuohUNt/hVLq@sirena.org.uk>
 <BN6PR12MB124927C4F4FAF53B59C2A23CC3679@BN6PR12MB1249.namprd12.prod.outlook.com>
 <YaYhtFnHlZob9s0J@sirena.org.uk>
 <f6c68e0a-eaa9-12a8-cc44-84b13592c1d9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tfdgiQzglU0HJMw6"
Content-Disposition: inline
In-Reply-To: <f6c68e0a-eaa9-12a8-cc44-84b13592c1d9@gmail.com>
X-Cookie: Check your local listings.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tfdgiQzglU0HJMw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 30, 2021 at 05:14:07PM +0300, Dmitry Osipenko wrote:

> The ifdefery, that this patch has, shouldn't be needed. We have a
> similar ACPI patch for Tegra I2C [1] and it doesn't have that.

> [1]
> https://patchwork.ozlabs.org/project/linux-tegra/patch/1637859224-5179-1-git-send-email-akhilrajeev@nvidia.com/

> I assume this patch could be reworked similarly to the I2C patch.

Yes, that looks much cleaner.

> Agree that should be better to have a common reset driver for ACPI
> instead of polluting each driver with a boilerplate code.

Right, I think that'd be even better.  It's probably best to split
adding reset support to the driver out from adding the ACPI ID - they
shouldn't really have been merged in the first place TBH - and then try
this approach first.

--tfdgiQzglU0HJMw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGmTY0ACgkQJNaLcl1U
h9BRCAf/YAUVoIhTKIfyTduGz7fcp6nmtLdKrJNwvoGaeiuGW22yH5OO9tjiuHeg
t0kA0vf6DlVOeAh6lFmgSfpPvugvwrAZaOM5w/1FAdwtsI16LbBueHr2BoUlBxZN
f0VSEe976TFdLqJ8Vnj7D4mp+6FKNIMf/JRqjrLlHAQNr/H3kLn3UOdgIscLEmTj
8aju/l8h7oVdjKu5v2dBLlIreLxb96PKkhYnuOsOhLyy35oUVtLKva/l/KFzxuap
iqQ4g2fHdQKPAJuCzuEfkV69uTfygCvfFA4UiOECqITWo24iazYJDhioquVbUHWL
CSTSkM1rfYsfrs4rln5lMO63+cSKEw==
=UWwB
-----END PGP SIGNATURE-----

--tfdgiQzglU0HJMw6--
