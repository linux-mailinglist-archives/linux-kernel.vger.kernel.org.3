Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697F4478DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbhLQOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbhLQOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:41:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224E0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 06:41:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 798A7621F8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 14:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8BEC36AE1;
        Fri, 17 Dec 2021 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639752078;
        bh=7Cvnp/ZTaHG8nzRCSQUsaA6z+nwKUnTyShmyFjYF6+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6ktUtpev9sn7AigNJF30+1zvoxQLn/0L/oEszOVrUXEI7TjXdRqhWRCr/BI2MkoT
         sWO2AcsQv1FXWOMUMrsB5qXjX0/kBg1zJDTxk1PgFtPDk3o0QQlUG8/putWroiCOq+
         kdeYRrfoarePADTee4YDIaGEvuqlFECodiyKVRTNk5dZxzaElG9jjeGPCerDzkiV7K
         NPgTYWufqW3a85XD9/1y0bAMcC+XSgtW1kUk36xeSQjxbEWOr4NPi+y8MBmyP/i1E3
         MLhbZZZUK4NISlcl/cr4Nzos1ax3xw2c/L4leY40WVwJFr9v9trBYLbJfsPXgKNfSZ
         x9tZLkpZd4PKA==
Date:   Fri, 17 Dec 2021 14:41:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     matthias.bgg@gmail.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] isoc: mediatek: potential use of error pointer
Message-ID: <Ybyhir3PjKii/yok@sirena.org.uk>
References: <20211217143551.675368-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d0USlWQysP9phstr"
Content-Disposition: inline
In-Reply-To: <20211217143551.675368-1-jiasheng@iscas.ac.cn>
X-Cookie: Pause for storage relocation.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d0USlWQysP9phstr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 17, 2021 at 10:35:51PM +0800, Jiasheng Jiang wrote:
> The return value of devm_clk_get() needs to be checked.
> To avoid use of error pointer in case of the failure of alloc.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--d0USlWQysP9phstr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG8oYkACgkQJNaLcl1U
h9CHMgf+JJKucdSSOzHdvJK5oPUKPzOqgM/6veVDk3VPfJb48zMOSmHGfgd1Bim0
oMf5jgOlMZvniPZkz0b/BzGw72b8eTpnHfTqN7tOn5wZAfqyVH7rrC/VJUoPvh4S
6f6dnpPtEt3H83Nqpt2kdc/75qyeUpQxg29ZVA7WwxDQlwOolAXSlzw7fTR9xhmB
D5NBvRtjOleL+tnj0CYmaMzU08jcixi7RAEyp9+KmIvfgfsWXm/x1QEQmg8zcf79
divhLW9uAg13qwgst7ukkqS4Hej0mzm3AqwQ7OEt4QbEr/LibgBPrL2JboAQdlJi
FAfMsmze8wv0V3zbB0qGe5holN1FLQ==
=1UVU
-----END PGP SIGNATURE-----

--d0USlWQysP9phstr--
