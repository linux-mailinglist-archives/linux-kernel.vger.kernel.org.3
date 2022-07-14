Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B09A5754E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbiGNSYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbiGNSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6B442AEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC32362184
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA2FC34114;
        Thu, 14 Jul 2022 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657823067;
        bh=tCZ0jNLcDixmwl+imDjO8i90+JQQfZ8pBLps3gbZBno=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DZoKR2n7hjftYG47jy16eLZkLjkLX+uuluOBsECaJudjd7tnq850j4Byid6wtmSG0
         MesiNCQw90CRzTIMb8ddUKoQAcOGKsBfivGbLYJW14GFOoTkrCPCCa+6aDXNQtu6iS
         pU3+OwUCqqvRDpUkEK5+6f2Adz2UhlMKoQbYRTzeILk6EfZtYJ3AwpLJmCK9EZWuph
         hX8qe5wYOkcTTRrxX4At2z6u6uEMVC75DbJ3XSaH9/0JTk4BpoybQx8P2GKVM+tjwj
         LoStU6pLceOs/5W8/v0VkHjXzwJKUezuPb3biIX2aFLnwLHgE1Bk3E9oIHUH6kiz3U
         eeijSLIVqusZg==
Date:   Thu, 14 Jul 2022 19:24:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, robh@kernel.org,
        Zev Weiss <zev@bewilderbeest.net>
Subject: Re: [PATCH v4 0/4] regulator: output-supply DT support
Message-ID: <YtBfVoQsSZ9xLf9s@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ohi3h8rFgcIQdpWS"
Content-Disposition: inline
In-Reply-To: <20220714141712.GC2229197-robh@kernel.org>
X-Cookie: The devil finds work for idle glands.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ohi3h8rFgcIQdpWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 08:17:12AM -0600, Rob Herring wrote:

> Please revert this. The vendor prefix is not even appropriate here and=20
> the binding has lots of issues. The first being whether it should even=20
> be in DT. It's not been reviewed as none of it has gone to the DT list=20
> and the only thing I got was '[PATCH v4 1/4] dt-bindings:=20
> vendor-prefixes: add 9elements'.

As discussed on the other subthread while some of this might not be an
actual problem others are causing serious concern for Rob so I've
dropped this series, it was the top commit so I just reverted the merge.
Sorry about the hassle here, hopefully the issues Rob has raised can be
addressed.

--Ohi3h8rFgcIQdpWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLQX1UACgkQJNaLcl1U
h9BlAAf/bCHDnGPJhlG/+2I7CRo12f4EBhDFtFHk6VkQRifu8Opzi/lPWDCBxURo
wNABD5/Hn/hrstSoV3N7T9istdqyBt95yKVx0NHpx2FCFeovkVxWm+YOrYytPujx
xjnZj1cmJAnGiRCHZnrxbM2hTwl3la40zcFATNY2+pBUkl3FkhA50EsR9melqBD0
8JWo2+M7Sw7CfRiCqpMlDr8du9aohxLtH4r4MTsDaXBm/8eXp6VoyVfqyRreYzui
pjSRgjHNhqy5dcsnnuf7e8/i5TmzGsPNoYaXh9+7ydKqBElO9WyYyCppMKX9mI3X
Nov2ByPwCRLfOdkggp4ufmFMwYklYw==
=dbSc
-----END PGP SIGNATURE-----

--Ohi3h8rFgcIQdpWS--
