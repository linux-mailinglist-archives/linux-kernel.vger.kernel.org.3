Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52032582605
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiG0MBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG0MBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:01:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7755132BA0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A06EB82022
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA7C433D7;
        Wed, 27 Jul 2022 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658923295;
        bh=hYlfHhZS5nNnBcVpoKvotCjnbGCGmx+c8y6ayFMdDwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iT0ED3VvEOhUC+vzOLgiG8/2jadT5tO51UofTJqMUv46x0EM78C5wafH7nCv51hGy
         vvz223Yt2nf2bPubccBc5zoBvhYtT3V0C096kYPZGI/wC/UlSSsAq8P098V8V+sLaO
         sfkeSdGFvL6SCBSH1GI1ZTjLWKoa5FLOyWuZxdpm63EwCpCBWMLyDYmASnZQU+QlJR
         9lIvH/HPEmcobJjmAVW0MDN+xUXacnnKh+uQXvwLrlk7E4uW+WOA5iyOwLHY4EUf5Z
         SYXOAkTtADK2MMpgyIVFvh2n+4R81zBf5+mjqPaopu+I6Am+B5LKWGKswiR9dxFlvw
         eMJBNnsLRznRg==
Date:   Wed, 27 Jul 2022 13:01:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH RFC] regulator: mt6380: Fix unused array warning
Message-ID: <YuEpGTD/DbC1T9Z0@sirena.org.uk>
References: <20220727132637.76d6073f@endymion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+UGA3SVN/7XA5mgj"
Content-Disposition: inline
In-Reply-To: <20220727132637.76d6073f@endymion.delvare>
X-Cookie: No motorized vehicles allowed.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+UGA3SVN/7XA5mgj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 27, 2022 at 01:26:37PM +0200, Jean Delvare wrote:

> This assumes that the mt6380 driver can be used without OF support.
> However, I can't find any in-tree piece of code instantiating the
> "mt6380-regulator" platform device by name. So unless there's an
> out-of-tree user, a better fix would be to remove mt6380_platform_ids
> and make the driver depend on OF. Chenglin, would that be OK with
> you?

It's helpful to keep the build coverage high.

--+UGA3SVN/7XA5mgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLhKRkACgkQJNaLcl1U
h9BSBwf/Y0QxIwkYpaF8CB4xGeqHFOqghj/Dj9sa0aWjIpBsaMkNeNxMHtqRtqeY
GZGehdnvw2kccw7982xlwlA/xRLnEnjRjNRuhx7FeudSQSoWqk6JuGvo45f/IkEY
ly8kpfFBAw85hdE2CdoM2bLYNDe4R09hlcdmVI5C31/RuzbyVbmm4Kd2DS+AaGwX
HYAVDVugwQwi4/aMIsoaXleFVw/ImmCboN5WklrsdQc8iiqeju0t5eJuWy6nzAbk
5a/GeIZ5q1u0QM0XE6jarTqiUuQQ0jsZfIgeQWAC3qmZpy26RcPI5gzKPXJEbjya
8tLdIvzBzB9ZGbc8ijkNHccUyBt8qQ==
=FE8f
-----END PGP SIGNATURE-----

--+UGA3SVN/7XA5mgj--
