Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36C5806D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiGYVeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbiGYVdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35524947;
        Mon, 25 Jul 2022 14:31:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA2DE612D4;
        Mon, 25 Jul 2022 21:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF8DC341C6;
        Mon, 25 Jul 2022 21:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658784682;
        bh=YnAdTvdkIOGC+7pMiYpS3hDJn6eWky+auoqZHNKuAtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1YjzcdFQVb+vTO4zulz73bvybn7T1PEITN0+HyvOfe2z6l9unOXZniE/52tL9EdH
         0t6MxydMWOQ3VAXdJ+J5l1nQ10dUoYBwV2sogKxcMvDjijQsxZuV0N7lqzNDBXkSFo
         rdBM7N5sEEYlp948xmjZfm7FqbO4hIkUeI/2BbEivP8cb+QB7nXKs+uOPWuU4QxHIl
         0NZ7J4omdd9tV3VfzkgcMafgCz2u3fwKpeUylJRO25YDsAi7f25BaI3jbCc0kPqsMS
         f56Mq0FAnuQsfnzIlT9qohXRlUUTIKTm1oCG0oFQb1fYhBuf5eqHrjESsmRvtO9Y7m
         cQ++8RSs0IopQ==
Date:   Mon, 25 Jul 2022 22:31:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 29/32] regulator/drivers/max8976: Switch to new of
 thermal API
Message-ID: <Yt8LoUTS3T5fBBIL@sirena.org.uk>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
 <20220725212637.2818207-30-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qny21bcv0YhR5btK"
Content-Disposition: inline
In-Reply-To: <20220725212637.2818207-30-daniel.lezcano@linexp.org>
X-Cookie: If you're happy, you're successful.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qny21bcv0YhR5btK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 25, 2022 at 11:26:34PM +0200, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.

Acked-by: Mark Brown <broonie@kernel.org>

--Qny21bcv0YhR5btK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLfC6AACgkQJNaLcl1U
h9D0QAf+O9p3srCvN9Bu6WEuJ38fxNrUBsDBuYjS6X79p7JaLv3b70+31NjVPe2F
EERAMvIrHQvwiy60tlM6LBuClDM9dCihAPY6s6ZsNI20zr5QCtcFyscVsUELCsEV
KsvAtreJaSOWlgGKR2OCTh6RtpExc97sarKeojmU1SQsTsdzxRVFCubQ2ssdvefV
WYe3KYCqkj+l1CTLfeWEtwgsLHenLNt3G3LvC87bwYRYkz2cMvglT2cRK+DRQ/Vo
xYTiwBEGFrg0WncsfgoqZyAQye3+g5GtDLOWzDnzY81jZmg9IEeS/HpVz2PzBAgN
v4/DLL/MFWAZk2OeAgGKfkkWQwkVew==
=gY2i
-----END PGP SIGNATURE-----

--Qny21bcv0YhR5btK--
