Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C844D627B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348943AbiCKNg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348935AbiCKNgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:36:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EEF19BE6F;
        Fri, 11 Mar 2022 05:35:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F1D461E5A;
        Fri, 11 Mar 2022 13:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F8CC340E9;
        Fri, 11 Mar 2022 13:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647005748;
        bh=3w2+xqDZNMpp9s+ES1A/ibvQ0ZTOcFvQcvIC2U+pkTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hp2HvGHue01M9aAI1AxfZ8iSyByzPEJMMH69/eiSZQ1gxGmBjT/9ceFjWWhG6KW4w
         Z8UdBgEOoVqPWhoeFgxpL7nXn9BMqlKSpZjXo/mW2fjKAqGgmX9k2DVYLRDP2sS8uB
         TcEz8GEIv1/kE3LT1pADonrblWxdE9CyaZebS+RZDsGsin5WneJulkgdv3tDux7VNT
         RseO0gptnxh/xccN3xR7rtUGEVvJMBc2I+WF5Lb9gWsucvDmlO8Zur9rvayM/u8nI6
         f2Tx/rIArXFDCpNFPvhbOSfXzKVDhjSweB/7tYJ4qszlBAwJ2QXSQszYM1CBTIgKr+
         Ik/qGjLQOo2fw==
Date:   Fri, 11 Mar 2022 13:35:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        oder_chiou@realtek.com, robh@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] ASoC: rt5659: Expose internal clock relationships
Message-ID: <YitQLsUAEHM7gXEG@sirena.org.uk>
References: <5c531e7c-58e4-2c55-57cb-85eff68b0927@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8wZvnWaTLkzb2sYl"
Content-Disposition: inline
In-Reply-To: <5c531e7c-58e4-2c55-57cb-85eff68b0927@nvidia.com>
X-Cookie: A fool and his money are soon popular.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8wZvnWaTLkzb2sYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2022 at 08:29:26PM +0530, Sameer Pujar wrote:

> Yes, it would be required and I will include it in v2. In this series, I
> wanted to get some initial feedback if the idea is right.

It looks plausible.

--8wZvnWaTLkzb2sYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIrUC0ACgkQJNaLcl1U
h9CiCAf9E0eqTsp3uhv/jiRjqxZnSq6Jy4IVm/W/bCSx1hf9JQr7YPQOE1LAQF42
LTlskNZzOyyOPckwauOS4rLiD0mn5Ht8wsEi7PikMpYDa18l0h9j17MLxGCHTtrm
YAdUR1hcXhMGEXZeICyOc9lFL5+Y2pUEgxThXnRvo4VWCJwegyTm0rw05cAzVe+U
FPdXhB/R+TtcHbGB4a+cHbUs/PsmFyS/Tps0IQZXSzyB3hFEwlTFAs7/czml3HPO
x4cBwLRDFyIB+1OTaF6vyfH28gYyJYO8elFHKBbLKBS/m3Kf60Th04c7142gE939
YlkFwkK8LWMXUkwFQ1QAYaxhNuV9DQ==
=iCaa
-----END PGP SIGNATURE-----

--8wZvnWaTLkzb2sYl--
