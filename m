Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E295384CE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbiE3PZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiE3PY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:24:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18251CC63C;
        Mon, 30 May 2022 07:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED6060DF6;
        Mon, 30 May 2022 14:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABBAC3411C;
        Mon, 30 May 2022 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653920753;
        bh=saYkzz6/Bxx+TCHOWJ3kqLX/CFp8+t6kRB+V5Vc0gWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TajnoueX0WPBLvP2NyXtPjnH7Lbf17+aIc8WM5OMeAbXKnTN0fGlgenaNQyB44Hv1
         OFIbLofzQEbCr0j0IcGE6uJsfMJ8ANOxkaO66bFnHWQlzrqSBX5PlaG5pYJ7Yw/g3w
         uu7DcTrRgHPeUJZYP1dOzV3lVBzK4qhpkPtKhxSo3LnuUmNFgKmAsx/67UrBmRNmme
         NYKDJ/TrBAmeJDFbmeN9jZbEuIZq1IN1zr5iXa8loEY/gmUxlAZig6R8wzHR6gAPdc
         v7PSI3ez232iK4R4yDORQRQVV8ewieBfUlo4fE21UC5uCkc4E+a0R0mLmQAu6mdxW9
         21ikbrKkdfpEA==
Date:   Mon, 30 May 2022 16:25:50 +0200
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     kernel test robot <lkp@intel.com>, lgirdwood@gmail.com,
        llvm@lists.linux.dev, kbuild-all@lists.01.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 4/4] regulator: Add driver for MT6332 PMIC regulators
Message-ID: <YpTT7l0oAJ51Df5A@sirena.org.uk>
References: <20220523154709.118663-5-angelogioacchino.delregno@collabora.com>
 <202205262341.pY4PkDL7-lkp@intel.com>
 <540be3e8-6a97-5e80-3767-892025ded07b@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M/QnrxKiHPTf+/lZ"
Content-Disposition: inline
In-Reply-To: <540be3e8-6a97-5e80-3767-892025ded07b@collabora.com>
X-Cookie: May your camel be as swift as the wind.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M/QnrxKiHPTf+/lZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 30, 2022 at 11:33:28AM +0200, AngeloGioacchino Del Regno wrote:
> Il 26/05/22 17:12, kernel test robot ha scritto:

> > > > drivers/regulator/mt6332-regulator.c:15:10: fatal error: 'linux/mfd/mt6332/registers.h' file not found
> >     #include <linux/mfd/mt6332/registers.h>

> Note for maintainers: this failure is expected, as this series depends on the
> series that introduces the MT6331 and MT6332 MFD device (with its headers, used
> by the regulator driver of this series)

> https://patchwork.kernel.org/project/linux-mediatek/list/?series=643602

That's

   mfd: mt6397: Add basic support for MT6331+MT6332 PMIC

It looks like that's not yet been applied - please resubmit when
that series has been applied.  I'll need a pull request for the
MFD bits I guess, please make sure Lee knows that's going to be
needed.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--M/QnrxKiHPTf+/lZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKU0+0ACgkQJNaLcl1U
h9AsZggAgZpjGrzxtd8KkXrv69DF/0hxAr/jx7H3w2zmf8aLSB4qEedlb5dWzKZk
vI88CBNqC2odiuuNYqCF1IiiMQZD1ADsbtBZTzbti27HJ++Gplo6S6SuNzn8IrVJ
93g8sr8sZ44zNixlJttjrQRlQ2DvzBOMZgd/3HboinR8fv8rwqM/EfHEjJaFE7uI
tZcB0sjaEAFbR72N9wV24okXAFQMCOpEgRz/DG6ivdIbQPpeg6LDD3hNnm7oEgRB
rXcN5A/8t1djYba7C1WBmEtwE0rIuMbmI/i+CR6mpTeN0D/U0EBe7PE2LYJzazfn
BFMlFIahn5vPuC9lY4Yv1rc9i21W7w==
=FtuI
-----END PGP SIGNATURE-----

--M/QnrxKiHPTf+/lZ--
