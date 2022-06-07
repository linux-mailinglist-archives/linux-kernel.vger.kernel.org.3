Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEEC5421DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441848AbiFHAxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385381AbiFGWVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22B31994A3;
        Tue,  7 Jun 2022 12:21:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CCF960906;
        Tue,  7 Jun 2022 19:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF4FC3411C;
        Tue,  7 Jun 2022 19:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654629687;
        bh=ErEmBZd3G+2nCeZwKqv3UDzHU86hysk68o0uchcsTnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMrxxJJVlB/KVuBZmk4eOUrThqeqR3mCWDLGLjT19/9FVY4iwJhsnYCO9qj6nX+Vo
         KmJAgkvfGdSF2uB8DobBDYTHQ77BWzXWmrYc1LW6yPjKKFkW3MmikIE0DO8bUUleFx
         5HBwJh0RMz5iIejETu8ACYocZ78pZ6JO2xtNZvKn9JitLU4b7zZGijaDSwsUGOq+jh
         D4uEtTveg9XJPSEsVHO/wBouTb6T4FWEmLYeKC316fV3l8rYYy3w7D8Owwx7qp1KlF
         Pl1xv72R0bsv/dTlc7yQwptnedhMOveFRDmwb9QXuuNO8C9Mpd+GSELpTITQ7OvoRK
         kZRe1BiJKh7qQ==
Date:   Tue, 7 Jun 2022 20:21:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: qcom_smd: correct MP5496 ranges
Message-ID: <Yp+lMm66+imh1wvk@sirena.org.uk>
References: <20220604193300.125758-1-robimarko@gmail.com>
 <20220604193300.125758-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PVVUTsmlegdQ6yDN"
Content-Disposition: inline
In-Reply-To: <20220604193300.125758-2-robimarko@gmail.com>
X-Cookie: Where's SANDY DUNCAN?
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PVVUTsmlegdQ6yDN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 04, 2022 at 09:33:00PM +0200, Robert Marko wrote:
> Currently set MP5496 Buck and LDO ranges dont match its datasheet[1].
> According to the datasheet:
> Buck range is 0.6-2.1875V with a 12.5mV step
> LDO range is 0.8-3.975V with a 25mV step.

Doesn't make much difference here but in general fixes like this should
come before new features in a series so they can be applied without
dependency issues.

--PVVUTsmlegdQ6yDN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKfpTEACgkQJNaLcl1U
h9AhTgf+Od+PkiFj34Fq+VGSFfiNc7og5D8mxgVCFTFSZ3zf4liijqW0zWl2kJFw
auCo3cJ75iR7DlDFOUGoU57JQeVRTKFI8oiy22abWM8/X06HWyV8MJhwwII6Clk9
m/muvCiPowA9AWT0VvXu5r4Z8G6TC8ANmcNlw21pHtmX7fhDpPlQGaW1beF3YkOJ
+8FZvaNWwC7mCx5ARiDmfW0EfBtjcFl7NQK2uozEiYRmTe2EzWDfA4jx8dPH/sTf
qxgwEfeGn2Souy+Ax3ns4XiiVSoFJX+R3UGyU+MpcJ33/gtlkz7i6JQgf2whuXMP
u1S1lOtUHQRp44gA03oVbHqMP00XBw==
=TPNT
-----END PGP SIGNATURE-----

--PVVUTsmlegdQ6yDN--
