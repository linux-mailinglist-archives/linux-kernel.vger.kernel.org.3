Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91124AF279
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiBINQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiBINQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:16:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107F1C0613C9;
        Wed,  9 Feb 2022 05:16:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A04B66197C;
        Wed,  9 Feb 2022 13:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4156AC340E7;
        Wed,  9 Feb 2022 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644412586;
        bh=r+TyYwi977hPcUIqZmzER+AH6wmdkK7fSexRgOiCxEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJTxtz0FvwzUhuA9S8r+8ImuyAy7E/nJ9O59kMAza/2Ony5qRXbiAjqiJ9Xp3FDEa
         eGSGAwjEw5Ctpi+dyTQ6960QM2kInNlK47o8visp79UZSu02qxmcx/HRVLjsuZslcc
         dFC7zOlDAiRbIRn97Wrgtjgn9Upc+CprBxS67IKGaQOpCdkZ0rrwI/ckuHUDQdOyQX
         teHb6+Ykv5Tk/Y7KRkwSS+Q2B/TQDK45sETbBDCKp0l9JHec/Zk4KzvJ+0NsUDjAu3
         FwcVa2uKo7UYiwvq8pIilrrohz+1wmQvYxsEs4vD/jW102hD/hm9wacq48yNTjzrRg
         cjPBQWKFU4JpQ==
Date:   Wed, 9 Feb 2022 13:16:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH V5 0/3] Add compatible for Mediatek MT8186
Message-ID: <YgO+pXPtptHCQ9Zu@sirena.org.uk>
References: <20220209014443.12443-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5R+mG6GScGdLDrKy"
Content-Disposition: inline
In-Reply-To: <20220209014443.12443-1-leilk.liu@mediatek.com>
X-Cookie: Disc space -- the final frontier!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5R+mG6GScGdLDrKy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 09, 2022 at 09:44:40AM +0800, Leilk Liu wrote:
> V5:
> 1. re-send these patchs based on v5.17-rc1.
> 2. add the flags: "Reviewed-by Rob Herring".

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--5R+mG6GScGdLDrKy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIDvqQACgkQJNaLcl1U
h9CTrAf+IL1W+QaItaOmV9RPnJ4UrhJnchjr0HroF9X473KfHJU09+xhzNuFyo5v
teyCMIi4gThNQV/AT1AejZO0sXe3mmj3jWcYTgsdoJ1hV2H/bZHWLDEpXVhWetBm
67z2vgk1radpZjWz8vD7E1ChdTaRAsi5pdMcmg6sh2+qaDSl3fNamIVT4TiAT/uH
C+EozMAZQXGq0QELx+JYSsxJi0CPVx9abSbiULA0B/qjrZT9wbsiHc9CiaE81AVE
dNxEeCXffZuBfPvLfYxsNY5OhyBwZoTrYSUxJ1ZNhwhQ36ZbkllpMkoweiOHw76n
nzqs5p2NmkZjXcmBTZ+DtCr39avFVA==
=p3Fj
-----END PGP SIGNATURE-----

--5R+mG6GScGdLDrKy--
