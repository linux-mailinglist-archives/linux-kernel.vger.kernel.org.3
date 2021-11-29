Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677E74614CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244705AbhK2MPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:15:45 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36192 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbhK2MNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:13:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ECDB6CE10D9;
        Mon, 29 Nov 2021 12:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63830C004E1;
        Mon, 29 Nov 2021 12:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638187822;
        bh=h6s+MqOMnU6klzx1xy26RnX4HKXsAzJ9VQrT/O0Ckk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYyJjYP9jAHgaAxUe16q2Z02mLZpoqjAKj+p/cNuahshpbsDryiEZaJGtRvl8wwoD
         rbOcQ3OX4+6g23HBqfcoVCOTm9gcWjww/+6G2G3kXF3tZLmhdsbvElaYmIMtyWqBAE
         LByeYOenOJY6xTvB4MnVVZzxjfK2OXlOwaAyCEXtsSZGt9kuP75PSSkwReWKvcC6dR
         aPC8x0yrZIoEx0te2jI7tL1MLZhdMI4LE1VWN1DZYkLDiWNZwVaWV1u3L6s4oWBXy1
         tpRURVgDSgwmMd/gfuXSbAMKb37O4tDVY3EHyLPF0jdIT2RAyFkPpJ7z2oMqazyxl3
         f7vGNGgGZmBQg==
Date:   Mon, 29 Nov 2021 12:10:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: linux-next: manual merge of the sound-asoc tree with the
 sound-current tree
Message-ID: <YaTDKNOOP2I2dbI+@sirena.org.uk>
References: <20211129113554.59416109@canb.auug.org.au>
 <s5ho8635n9g.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SQYlZzC3+HKaQPIe"
Content-Disposition: inline
In-Reply-To: <s5ho8635n9g.wl-tiwai@suse.de>
X-Cookie: Thank god!! ... It's HENNY YOUNGMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SQYlZzC3+HKaQPIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 29, 2021 at 10:23:07AM +0100, Takashi Iwai wrote:

> Mark, could you resolve in the latter branch?

I'll just leave them for now, Linus got angry about merging up fixes
just to resolve conflicts so if it's not an actual dependency...

--SQYlZzC3+HKaQPIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGkwycACgkQJNaLcl1U
h9ByMAf9F8Bh4B+tyX2zPcDnge8A4Gtz/6hxjO7slkqJ28Xq5mdmYjJlorJVsN+7
9dwRnXU5/MxfCNJtb1RLT0hD+c4G31UIeKHfe8W0Qj4Y8YuQnqe4fgRHlYCfBJ31
K6wYIkYB2IyJiyFzCUT/7U8eNWJmF5t0NTWZj0ZLYurVxj6z3HTfp85Ua2BXQdSS
S2BKeWr8BbOQqoSWILcV7+hdm5EOvFIwEGmN1PgX4DP1To59dEf7HCsHsJunyyzc
n7+1rcShSPGpc6yJf+W0fCKvyad74cK+0F1ui4PDEKJSnCp6I6OaWEWb1aJlL+2Z
jU4XcBsof5Z26bjhRHZ6BXSx7cHGzQ==
=XwcJ
-----END PGP SIGNATURE-----

--SQYlZzC3+HKaQPIe--
