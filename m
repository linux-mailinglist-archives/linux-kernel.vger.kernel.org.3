Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D102A4B2441
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiBKLZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:25:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiBKLZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:25:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DB8E5D;
        Fri, 11 Feb 2022 03:25:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1CF7618BC;
        Fri, 11 Feb 2022 11:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9BBC340E9;
        Fri, 11 Feb 2022 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644578750;
        bh=ooE2AsnndLLEx4IulCajtBCoOFATRnSUIKVcqUODsfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVTDbyw3LUGxl1D//PLAAiRYqvaahdXQgc9XJv51V+RP3s3k7fRvuoSq46DWV7Cy4
         FBKp/GWGXw/4DMwbZB2W2dA53fbdVizW64wfQl9yG6xtDLD+ExToVXX+Mj0C1jVUlO
         CdTcYXUzaC6PfLmSwuOvUAN4mOWrcFyB6+g5r9RMR445u8DFUuPktsy+100pKVAXek
         9974LFFHv7cy1+gl/GtWTEWQnPRYhaS8ag+k3nVoxF7N0CDjPoKyDEekY9IiHcappd
         c9g8g+6gfDP0tUKrWjYHsK36u8LgSJUQD+EO/v8uHmtTtgfOCY6qPTO1DQMAStYJq0
         adTis85IiCpUA==
Date:   Fri, 11 Feb 2022 11:25:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] spi: rockchip: Fix error in getting num-cs property
Message-ID: <YgZHuSCZWvl7XC1t@sirena.org.uk>
References: <20220211034344.4130-1-jon.lin@rock-chips.com>
 <20220211034344.4130-3-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+3G0Mf5QYROxU3Hp"
Content-Disposition: inline
In-Reply-To: <20220211034344.4130-3-jon.lin@rock-chips.com>
X-Cookie: do {
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+3G0Mf5QYROxU3Hp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 11, 2022 at 11:43:39AM +0800, Jon Lin wrote:
> Get num-cs u32 from dts of_node property rather than u16.

Bug fixes should go at the start of a series so they can be sent as
fixes without dependencies on anything else.

--+3G0Mf5QYROxU3Hp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGR7kACgkQJNaLcl1U
h9AF6wf+IsUGIpR8g7NGFO5SPH84Ca4yPmqUlnZbd6YyB6j9zQwVX+AO5vy8BILj
wC4vTWKhaFTHmC8BVzFzLQk6J38QEYgFy94Y/Xi6g+8E193AVRqi3Zja3QPgoAJH
uUB8kaq1NbLQigE5SqsIE0xOMpPLR4DnTuIr7MC/RhqXgM8lp2TNKHpZE9ZmOb5U
0swruPV2Xj38yUSt+xJKj5a2RX8Dc0lGmU2t6XsxLf5IZCVJ4g0DTvxkPOM7Kcvc
rhSHkDa07szRs1dtcimH0o96pnxaWI1wvSdwy17PfG81/a6j3Te77WaW99z04N56
l/c8TMoVTf+bTlV53bljJT2p1frykg==
=NXJy
-----END PGP SIGNATURE-----

--+3G0Mf5QYROxU3Hp--
