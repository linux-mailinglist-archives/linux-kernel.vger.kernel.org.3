Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6B54FF711
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbiDMMuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiDMMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59DDDF1E;
        Wed, 13 Apr 2022 05:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF9A616E9;
        Wed, 13 Apr 2022 12:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E59C385A4;
        Wed, 13 Apr 2022 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649854064;
        bh=yxfL3ywdnIr/K38Xc28ibqWKM75z90Wz9zeFMmPk3kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z95JqEkfPGNdJWzbSpi3NXHM6dkFnLeZOUW5DykdRGN3491oeVNXbLa88V3MqBtnl
         66bDr/V/cepeXRamQiy1NjNBq95axE1bsc7yjdbXz7PlfoVl/P4JKs8yECTGf5huLS
         Rrh8DgajTZV2Qn2NGKE+zJdP57edr0z9L0taeKgzCE+Fy90fshg46gQg76BnUgSV/4
         CazjpgUbk4Zcv2lGr0J/jr9TBsI46NRLLaLhoIIJ23kTHrRcZxL7P4G/0NQDrnHmiT
         892jbMg/Ob8a6Mr9tRZhWjlc8GT9ZtbpCDzXYhM48X4kVD0bjP/FLUDlYEebUV0GNO
         eNm4KgPCGBAEg==
Date:   Wed, 13 Apr 2022 13:47:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     ikjn@chromium.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-mtk-nor: initialize spi controller after resume
Message-ID: <YlbGaq/o888LNXGk@sirena.org.uk>
References: <20220412115743.22641-1-allen-kh.cheng@mediatek.com>
 <164979303551.449574.9303978009033918270.b4-ty@kernel.org>
 <aba056b08ed834edca7811ea00b957df748703a6.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M26jxRTuGK/Rcnx4"
Content-Disposition: inline
In-Reply-To: <aba056b08ed834edca7811ea00b957df748703a6.camel@mediatek.com>
X-Cookie: The horror... the horror!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M26jxRTuGK/Rcnx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 13, 2022 at 11:33:47AM +0800, allen-kh.cheng wrote:

> Sorry, There is one issue I want to correct in commit message.

> "To handle both issues [etc]" should become something like:
> "Solve this issue by reinitializing the registers right after resuming
> the controller"

> Do you mind help me modify commit message? or I can send a new PATCH to
> correst this.

Sorry, there's a merge commit after the patch so I can't easily rebase
(which I don't generally do anyway) - it'll just have to stay the way it
is.  Not the end of the world even if it is unfortunate.

--M26jxRTuGK/Rcnx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJWxmkACgkQJNaLcl1U
h9CIYQf/besmgKeiisuhVRwPw3ZkHtB6qPamIdugavjaLLEaWWPkcwZpJXGH7RxA
xZnwy3/y6DVpBoFdYO6BMJ5LDsbAHAGwlxXWXhJVnec0y0KbMyAa31sTYgjpa4lP
KXcFT93FVRiklaJDtvuhi9EB8fz6tQBtrs/43Bd+sYyCVkZ/iqWIi+n4fnn0koSW
ETiOv73yw4pIm/UH3LdDrOZrngK+xZ9hCaODdZN2d5ziTy1KFr2MzpVKDPIMDS1R
4Zms4iEI+MInwIwhwY/V2Bg9zF7XZVy9j/YD7kLhp/QM2/J+oDK3mx5xza1GQNEL
iIMgjvz7vZgFtZoT88Qw9HQ0rdPaxQ==
=0F9p
-----END PGP SIGNATURE-----

--M26jxRTuGK/Rcnx4--
