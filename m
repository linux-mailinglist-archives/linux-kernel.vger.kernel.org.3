Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15EC557856
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiFWLEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiFWLEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:04:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A54B431
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E774BB81BF7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D82FC3411B;
        Thu, 23 Jun 2022 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655982249;
        bh=aIdW+I8dNqFwqnLgbomd19CUJMezjB4BlkNogKF1XZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f94JHIY2LJbI2Z629AcUkVoFj6tJtMk6c6chxLzm/Y40OJmm/H3oD/tx9PhFDkM+R
         akJg1h/M78V9YOs135hgonnv43OiVa/CDM/PR3a1YGeQ/5n+hYZLJQhmIaeIR/OOCe
         w/liblWEHu65ul29/nr2gN8BWFXIuCAw/++yEk3UfAGWrbxzwEldfC99bk84QTNfHJ
         Sm72tCN2sIz+b+wNKtmui59HDfV2Vx4S6YA1Q2RgN4ke86e/9aHDiF7lqDVRpOsFmS
         ApZ7rzgErYj75gj/K3Lkw262ujnaGbyq0Q2caYXBeuhL3hc+ZnRSXTUufhqvmBzQ8/
         FBE+onHEaBEhA==
Date:   Thu, 23 Jun 2022 12:04:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Message-ID: <YrRIo62na5FCCa06@sirena.org.uk>
References: <20220623021153.587423-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bAAQzJfUr8Tz2hZ6"
Content-Disposition: inline
In-Reply-To: <20220623021153.587423-1-judyhsiao@chromium.org>
X-Cookie: I had pancake makeup for brunch!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bAAQzJfUr8Tz2hZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2022 at 02:11:50AM +0000, Judy Hsiao wrote:
> The patches series is to fix the unexpected large DC output
> voltage of Max98357a that burns the speakers on the rockchip
> platform when BCLK and SD_MODE are ON but LRCLK is OFF.

An earlier version was already applied, please send any changes as
incremental patches.

--bAAQzJfUr8Tz2hZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK0SKMACgkQJNaLcl1U
h9CrCAf+LQBNxKh07eXpoNhG69/PzuPmq/iy71grFtQtZnGyzGn2Z1HDltI4l5pW
ac3Pqo+XRj3DYnI6TbysWctR7ZrsootwIfuugKZ4zSLxvC4RX94EnKxKsOSDq+6Q
2+eFccgAih/GvhGR+RXmtx72jixO0eq2Ywpfinfn3+TsbWQSNL6MbyHX1WsErIqR
+OUii5syBaM8/AlOwbJBz53Ad0beGnKYGk4TvN4mNugXh7QIHNX3tRRomZ95A+Kn
f33IjTorYaXsJXsi/3OUT9/Jhb5ZBH7gy+2yVUsRbUH5jQzyIgVAYcHvTRSb0B1A
zP0bwOPq6qUNV60QFV8VXDwMqGzYTQ==
=K5QJ
-----END PGP SIGNATURE-----

--bAAQzJfUr8Tz2hZ6--
