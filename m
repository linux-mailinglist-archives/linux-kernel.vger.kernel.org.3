Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7355A4CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiH2NAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiH2NAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:00:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A70F8E9B4;
        Mon, 29 Aug 2022 05:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 357D86108E;
        Mon, 29 Aug 2022 12:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F86EC433C1;
        Mon, 29 Aug 2022 12:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661777500;
        bh=+YExUL11paCuGkFEn/xxjBioMQoqHUqELISH6lg6JKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ALT7a+zgxsT2eJDYqgsUiz5sdZV387Q/x3kgnVJmEkZwVQTmXKPkRmjWn/swSeP0b
         jcF/PTtBtwnM0/qvGQSm/599sq0Xp5h3FjexsmlVp3KPI3bHutECx8yp+UGIVp8Iuz
         cUio3+td6844UcstNFlRbl8gcnbz4ECpAv2EBqanjvNz5ZcShuPxteKGFDGFyLNrtw
         X0+7FdOwmoAY86h5BtgBDB7aZGvjwO3KEcutbfi73jczBWe0yStQKgjDLoDnZcllU3
         HFAi73M18hjffRm5NqblCxlDMgTZSIcUQRNp5xchd4JCJVL62AtzurjoAZkWnCVMln
         M7V1cWr1lZ3iQ==
Date:   Mon, 29 Aug 2022 13:51:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     patrice.chotard@foss.st.com
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
Subject: Re: [PATCH] spi: stm32-qspi: Fix pm_runtime management in
 stm32_qspi_transfer_one_message()
Message-ID: <Ywy2WUIc7YxJv1Eo@sirena.org.uk>
References: <20220829123250.2170562-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lga38wB0m89/rqLP"
Content-Disposition: inline
In-Reply-To: <20220829123250.2170562-1-patrice.chotard@foss.st.com>
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


--Lga38wB0m89/rqLP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2022 at 02:32:50PM +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
>=20
> ctrl->auto_runtime_pm was wrongly set to true when adding
> transfer_one_message() callback.
> As explained in commit 6e6ccb3d4cdc ("spi: stm32-qspi: Add pm_runtime sup=
port")
> the expected behavior is to prevent runtime suspends between each transfe=
r.

This doesn't apply against current code (the for-6.0 branch) -
please check and resend.

--Lga38wB0m89/rqLP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMMtlkACgkQJNaLcl1U
h9AWIwf7Bl8Ztd6KYTti6FFUahcShnjdHIH8gce4QYwl56qNfC9CJR4g1xwMUG7/
Y8HPMLkssDFVtTV4iHUg+7NExufImSBhqimUaLuH17IkYGecPAchTahI3Sl/RVki
VXl4J6JWSQtFVICCSyV0pVAKVa/4IGFie9UuonXSgUbSy+dTijW+kSNkeBOwfwgq
t4Sihg2WanUe+m/5gDLlH5V8bpeWQmXunSPRyWcUGJHTwMnLfgpgCV4CloCM0UPt
ChK46MrpHdaKm85RthsAQY3VQ0c33SgODoOaNtXrzGwwQrli7lFVjgAF7pYCkxMZ
v/zul2JTDqke8QmVdNxkbqP6kynzSQ==
=utvX
-----END PGP SIGNATURE-----

--Lga38wB0m89/rqLP--
