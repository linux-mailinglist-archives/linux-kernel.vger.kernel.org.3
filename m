Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B254AC290
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443187AbiBGPKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354785AbiBGPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:05:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5D4C0401C1;
        Mon,  7 Feb 2022 07:05:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58AEE6145D;
        Mon,  7 Feb 2022 15:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7672CC340F1;
        Mon,  7 Feb 2022 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644246337;
        bh=j5R4Gv27wDTelz/5MkpZClOBJ+BnL0TYVY4HhplRl4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RsSjUqwnB108XHjy4DpeXhNZRDJQfdUVj5DgQLcXjvYwGZ3e02kLXwlIiEsuk/ob4
         a3JAY6QGJ2ByFyuxOwNjC9TWd35teKnyd5hEwH5BE1KAJ7PmZOVKfadSvqBuL1MC4O
         tuGE5UxdAiI/vcfCVHPvMXGpenjf+GQyxZ44zy0NFzgzY3UHxRJUPKGC9FF8hA7zUW
         f4ErsoqYf1J4TUYGjUfpXljPLHCFKi7EItaAVxJBT8Q9ww5AtEDnWpMYHeCjfc+XsZ
         i1R5nISuNaO3tm+Faok2X5kx7uINBpgFT0I7pz/6r7WXCimT2kcETLXLVYjJFP/bdB
         vY5HMS9WKMQiA==
Date:   Mon, 7 Feb 2022 15:05:32 +0000
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
Subject: Re: [PATCH 6/6] spi: tegra210-quad: combined sequence mode
Message-ID: <YgE1PD2irQeinD9N@sirena.org.uk>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
 <1643970576-31503-7-git-send-email-kyarlagadda@nvidia.com>
 <Yf0zkdS2nqHOZjMG@sirena.org.uk>
 <DM6PR12MB35630A9020EC4B309D877086C32C9@DM6PR12MB3563.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L2V1A7HZ4pNge4n4"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB35630A9020EC4B309D877086C32C9@DM6PR12MB3563.namprd12.prod.outlook.com>
X-Cookie: Never give an inch!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L2V1A7HZ4pNge4n4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 07, 2022 at 02:54:00PM +0000, Krishna Yarlagadda wrote:

> > > +	if (cdata->is_cmb_xfer && transfer_count == 3)
> > > +		ret = tegra_qspi_combined_seq_xfer(tqspi, msg);
> > > +	else
> > > +		ret = tegra_qspi_non_combined_seq_xfer(tqspi, msg);

> > This check needs to be more specific.  But like I said in reply to the binding
> > patch I don't see why we can't just pattern match on the data without requiring
> > a property here, we'd need to check that the message is suitable no matter
> > what.

> There is no real-world use case we encountered so far preventing us stick to pattern.
> But this was to avoid any corner case where there could be 3 different transfers sent in single msg.

So you'll remove the property and just pattern match on the message?

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--L2V1A7HZ4pNge4n4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIBNTsACgkQJNaLcl1U
h9BFNwf/ZmIVt/rPd9AefPfAWPMK3pHWlBlYzPmBgZi391BXYFZQwyI/4bJYQ7Ab
PMBM5GNFjTtqa2KFmkQ9hikJEuxTzcXckRikQ0wO+kix9rydqC/DYSxKl0Bo/y1V
syLYHM1voFHziWbqfnaFATKU88+CtaTHBNjfIqagE+MtUUZi8yeF+TJB444m4gxt
Pp4o+Ux83APBvyLsuYWYT5ua22o4ChDhAjOTQWP/fh4Eywd/yBDDw4kYDB0GYEwg
OR8NX5K+nZgz/TSavbQqeDx1NrY4WcV5TyFfGa4jajDXw1BlcgA2hZcwOMfO7MOI
GscayI2JryM5qaUgVL3vSM7ePri9Jg==
=5TVG
-----END PGP SIGNATURE-----

--L2V1A7HZ4pNge4n4--
