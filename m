Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C4D54D188
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbiFOTZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiFOTZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:25:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FFC39B93;
        Wed, 15 Jun 2022 12:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 156A260AAD;
        Wed, 15 Jun 2022 19:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7D3C34115;
        Wed, 15 Jun 2022 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655321149;
        bh=mjycc28titw6b3oBQHfrm902kDC3ORDO+qAz3zRHORo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5mpo9Oq2B7L9BefUEXvKAxz7oDNd3WuQ52foZSGBOLylVRsnviPlu8IQ0tbcsDEI
         XQrTSo/+rXm/ayE33b7vLdirqWV/UeDv9XdQrx1z4RPgksJCJ3avwSkV2vqGU3FMEG
         XmiekWH92Sp0t1AV3PU20x/iQmOisOmaAF7NDUAWIml+SLo7Jhlc3XqTT4xvRorN1+
         haS5yI/jKW6Sh0h2v/UZ8oAwiRMUCz4h3ZSDFe3VblTB1hJcIpTTCNQvB8QQ+BbXFP
         7xJ2W61KR00XxJGhIm2lNzCyXhpkOL6nBgZE2v8YGAms7dNuCMflJfZUeNeYsPzwVq
         c5mwWneRLD50Q==
Date:   Wed, 15 Jun 2022 20:25:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksandr Ocheretnyi <oocheret@cisco.com>
Cc:     mika.westerberg@linux.intel.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, p.yadav@ti.com, michael@walle.cc,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, mauro.lima@eclypsium.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com
Subject: Re: [PATCH v2] mtd: spi-nor: handle unsupported FSR opcodes properly
Message-ID: <YqoyN2BplOCSOIa6@sirena.org.uk>
References: <6A852B9E-D84C-4F80-9C17-62BFBB98CC8A@walle.cc>
 <20220615191153.3017939-1-oocheret@cisco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31YcxwvFtDq3oCQ"
Content-Disposition: inline
In-Reply-To: <20220615191153.3017939-1-oocheret@cisco.com>
X-Cookie: byob, v:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31YcxwvFtDq3oCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2022 at 12:11:53PM -0700, Oleksandr Ocheretnyi wrote:
> Originally commit 094d3b9 ("mtd: spi-nor: Add USE_FSR flag for n25q*
> entries") and following one 8f93826 ("mtd: spi-nor: micron-st: convert
> USE_FSR to a manufacturer flag") enabled SPINOR_OP_RDFSR opcode handling
> ability, however some controller drivers still cannot handle it properly
> in the micron_st_nor_ready() call what breaks some mtd callbacks with
> next error logs:

Acked-by: Mark Brown <broonie@kernel.org>

--h31YcxwvFtDq3oCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKqMjYACgkQJNaLcl1U
h9BXAgf+PejyCaMSeNp44aV3Jxkp2oUooVeKCeh7KO0RIFkhx53PKA9IT4E4gBQ0
2+bZxWUS+GVU5CHYqtn3rmaoiWLf9bR5+0JIPfWCGfUdkk7+/RR66ewMIc13LIHQ
9qxAPK/UtYGPbdTL94xkHpRGY8frBpWKIYDcQqGHyjR/b0aYXUedc/ixOLvz88Xs
Shd7bECwsmrnpzRdKUS7hWI9iPYqNHgKNYHeV4ETupt3Krpka2A97JkXtpHEzIZ8
e0l3sfmhm3ligaCYcoavd4IIwnnRSWLkb2rdBbj4Rw3QkJ3ckUk8SNrR/csuHArF
9irMzdcw4uM9CpHtRqvr2KqmFMW/QA==
=jVgm
-----END PGP SIGNATURE-----

--h31YcxwvFtDq3oCQ--
