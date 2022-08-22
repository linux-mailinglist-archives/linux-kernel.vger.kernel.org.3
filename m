Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E259C46A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiHVQus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiHVQur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DD91C93C;
        Mon, 22 Aug 2022 09:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDD3E6120C;
        Mon, 22 Aug 2022 16:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FE7C433D6;
        Mon, 22 Aug 2022 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661187045;
        bh=irFANRY3GsRjnwPRI0klPXy+ob+GF+Bw2G52YNbFAI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijr/HM85cyz6VY0jd4a5MoWWZnMiH7N8aCu9H0tmPQE7N9pwWgBRK+uINBNYY7HYx
         iH0koBmAN8HQtsctV4cYzd7PulXqWvejNJ3nCTb3GLDdNbYxSdfJX1ap52dVios0sE
         AiBtZRS8YSFOw1c0lerTWmkc52E7sz9ISPIKiXZAQSUmvdvfLsH30C4eOW5QXKdU1a
         qu3EKa3sxvYKZqTUfPx9n+3Bqy4VXg5NSPBTPPOLECYSzV0ud0ESuivqhSMhocdL2R
         tr+IgDdimQ88E659yB31S2Whpez6zjzJdzck/2eyR2fWvTXtu6i5Goz9Zi3EY9CKuo
         k/1z14geqGyDw==
Date:   Mon, 22 Aug 2022 17:50:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        christophe.kerello@foss.st.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: (subset) [PATCH v3 0/2] spi: stm32_qspi: use QSPI bus as 8 lines
 communication channel
Message-ID: <YwOz4MJ5zc4YOb4s@sirena.org.uk>
References: <20220816161344.2599908-1-patrice.chotard@foss.st.com>
 <166118433897.209120.16190099503428270567.b4-ty@kernel.org>
 <319927f9-5265-81fd-2c6b-7c5146d90687@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ru+ez317Ifnz+ENP"
Content-Disposition: inline
In-Reply-To: <319927f9-5265-81fd-2c6b-7c5146d90687@foss.st.com>
X-Cookie: Do not write in this space.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ru+ez317Ifnz+ENP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 06:21:16PM +0200, Patrice CHOTARD wrote:
> Hi Mark
>=20
> I just noticed that the cleanup() callback is useless as the gpiod is=20
> automatically freed by devm.
>=20
> As you haven't send your pull request, do you accept a fixup patch you wi=
ll squash=20
> with patch [2/2] "spi: stm32_qspi: Add transfer_one_message() spi callbac=
k"
> or standalone patch ?

Normally you should just send an incremental patch but since it was the
top commit of the branch and I only just pushed it I've dropped this
commit (b051161f44d414e736fa2b011245441bae9babd7) so you can resend
with the fix squashed in if you want.

--Ru+ez317Ifnz+ENP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMDs98ACgkQJNaLcl1U
h9DjzQf/Xo7tBkOen7IJaH+SY49+yGc6Dq0+ywUqN5DVyTWKStCNrtpcCNWwph2a
DV79ZqI4YEaptZq95gwDcaxLxnFHxG9qGIXzPbScCKDyvMkjc9DWqDAMiq+A+PYX
awYxyh7tFX7zpfbD/2Pm61SpPg4myZNxbX+gq7tcB9j53+ULFJOeiSva9YQE1rNm
jrDLOLIgzbQTFXbsQ3K8Ipi6rbwTfHhHHs6ubzJlWcStXzxF4EZlggbv3PBW1bpt
IQp/+8hXNnpQl3NfsLpkGldV6gtBDS1P16quHh/cMZNiEOAAKtBtIbFUE+IJY4QQ
Pqr9astR2dA5vinRQx1+7maV1g84Bw==
=gTVk
-----END PGP SIGNATURE-----

--Ru+ez317Ifnz+ENP--
