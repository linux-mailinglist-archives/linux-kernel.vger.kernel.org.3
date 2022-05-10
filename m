Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8C521360
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbiEJLSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbiEJLRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA242A9764
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:13:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29F0F618A0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC27C385C2;
        Tue, 10 May 2022 11:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652181234;
        bh=1lnw92tFFloxyz+SRQlzXfqNdO+aQowWyIOa52kNAoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pl5hgu98j7yQeST24Yw4a4Bnxroe3JtiVCx0s5ijY3lMBTK3zMSbd14egmddDqkWz
         pe6fbHPnicg0Nq2GGjXrz+gX9lbor8lwTH3KLDekNnHR9SkJfEOBF6c8dQXj2Txkl0
         qCqAjjQc17dScfL9n2ZHLfFqVXKLWAnJk2BKVx1OMRCf5yGgOWbrp2Ezyo5XkBZDGt
         HWEtfQkv9QX4wixm6/g+f8PK0FED8Bcc5T6zUaDcusv7VbePcwncqwZNH+moOl1Yla
         2WDYcbT6CyD87Cooq+GL8A0TNvEfOpSVLDZ9qQeS6CfYVq9NCRz/JJygAhqOz6EY6I
         P/y4PBWpfmPjg==
Date:   Tue, 10 May 2022 12:13:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] ASoC: wm8940: add devicetree support
Message-ID: <YnpI7CTiXzCYn918@sirena.org.uk>
References: <20220509121055.31103-1-lukma@denx.de>
 <YnkxIe1nVUiKNmdq@sirena.org.uk>
 <20220510092438.528ef474@ktm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qAf9JxhdA/2u1K62"
Content-Disposition: inline
In-Reply-To: <20220510092438.528ef474@ktm>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qAf9JxhdA/2u1K62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 10, 2022 at 09:24:38AM +0200, Lukasz Majewski wrote:
> > On Mon, May 09, 2022 at 02:10:55PM +0200, Lukasz Majewski wrote:

> > > This adds devicetree support to the wm8940 codec driver.
> > > With a DT-based kernel, there is no board-specific setting
> > > to select the driver so allow it to be manually chosen.

> > You need to provide a binding document for any new bindings you add in
> > code.

> The second patch in this series adds proper *.yaml file to Linux source
> tree.

You didn't send the patches as a series, you sent two separate threads
so they got totally separated in my inbox.  I did eventually connect
them.

--qAf9JxhdA/2u1K62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ6SOsACgkQJNaLcl1U
h9Bpsgf9HulPrkkCBhalLtUuryJIf4qV7x1Y04CyPnGjl9Ho8sS9mNtiwG6Czlo0
+2f1GImlUw9xZWtHGEcjralJLVOsCXfr5vEtFsGTKhFclWa7zgwvyAEW4362zW51
BU+u1iZxL3/BHfKS5zk8+VztfDA7EkkRkIFgzl3b4e6yIUQZdW0BHn4qKFR98NVH
cVqsLpjo1xhwmsk+3NvzL6YBP4mBXadd+XiwW0BJ8X2PCtV9AIvqIy8+Eg+AHONL
yxVFnpM4Z4qHh9XZ/k2MOztDeLAdtowN13JGEcjVCDW/JOkNBrqNQLtnPNRtHUOd
sPFGLyuiYVFwUoSRouldnuTpbfZdrQ==
=WRQT
-----END PGP SIGNATURE-----

--qAf9JxhdA/2u1K62--
