Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60025A5061
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiH2Pnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2Pnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7087B868BE;
        Mon, 29 Aug 2022 08:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E87260FD2;
        Mon, 29 Aug 2022 15:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFEFC433C1;
        Mon, 29 Aug 2022 15:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661787824;
        bh=4PNAQAvCUsFccSS7sDfDcRqqhjiiTiNWG27WrEY28OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKiPFxEX8ubsQZXf3x3GDEhZKfzWFkDh/W8D6dA3aCQiLFZBB/J7N/q+PjVnbJ1/V
         L9K/kqa3TDPoVUGTviXCoQyiCj/cF38wUL6/mnz1t7aleC50cJ0uRCf7I3oB9aLeAy
         bNZYUt+P3Wqr7OqFnaOUL6FolVKD5oJjqr6pQQDEz53J5lcVBGqzaO6H2kE59mNJvC
         QedDom7+52MdJePLmkk6OgVWwrvyxQI8b7xrz8D13R1U0momnloSeT9hbClgkcS3h1
         O1opywiXcmanWyhAhWh95j4QigAq1JuMcJM9ntUZbroudSSkuMEpC8OuZPKpTlPbkr
         RYl50BMuZmeDQ==
Date:   Mon, 29 Aug 2022 16:43:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian =?iso-8859-1?Q?Kohlsch=FCtter?= 
        <christian@kohlschutter.com>
Cc:     m.szyprowski@samsung.com, heiko@sntech.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        m.reichl@fivetechno.de, robin.murphy@arm.com,
        vincent.legoll@gmail.com, wens@kernel.org
Subject: Re: [PATCH v5] regulator: core: Resolve supply name earlier to
 prevent double-init
Message-ID: <YwzerCnjvTKsEyIi@sirena.org.uk>
References: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
 <20220825212842.7176-1-christian@kohlschutter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7tSS3dt8q5rPP2p4"
Content-Disposition: inline
In-Reply-To: <20220825212842.7176-1-christian@kohlschutter.com>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7tSS3dt8q5rPP2p4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2022 at 09:28:42PM +0000, Christian Kohlsch=FCtter wrote:
> Previously, an unresolved regulator supply reference upon calling
> regulator_register on an always-on or boot-on regulator caused
> set_machine_constraints to be called twice.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--7tSS3dt8q5rPP2p4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMM3qsACgkQJNaLcl1U
h9BzXgf+KnfusKtcsjB9ILjjP2+jZth8EOVUrcSQ1eWVsI26muwHmEE91v4C7YFv
EtgzW4cRU0k9M766Mk6UaZUqToxKcmAvfP2sUg/VzHrlXljLq5+B8a+3SSGNNoe+
G2adSxucfxIpqqn9HXAJJTcpPuVUUX53LpYdXdw7yxrQr8jmVqGCR1YfrRnfgIgW
nG+n2JowmobA5H8B2nT3GA5QYyrsCwWUXJEjytf0JEGEEPOCXlylTcsBAE3Yr+RG
6FsUXXRlLaz0rlpWjCSjIgQNiYfhE0rW6KSLSiaaLJ0ZtVAoHonnpsxWWXVgXdXP
aLJ5Jp+VPK36CkS8Yjx6Ds25ptvv8Q==
=CJmJ
-----END PGP SIGNATURE-----

--7tSS3dt8q5rPP2p4--
