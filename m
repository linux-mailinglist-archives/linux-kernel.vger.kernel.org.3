Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2350F563C1E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiGAV5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiGAV5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:57:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262DE70AEE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 14:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A224DB8311E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 21:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701B6C3411E;
        Fri,  1 Jul 2022 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656712650;
        bh=yXTRT9tzO60wn8/gIBmXfmphFtH4XAS8I5HrGSJt3a4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYcd/OJnv47UiSCVC/BLS7UxrG0iKII8DcVyW1YMqe2LGfxfH09d1iOk1BmN8Xhyz
         SZxEhyUuLWXF3gBVdHBJc+plVKOMcRJd/vcui4FSPsZuBpPlZUMOpU5UEzq9B/OY8y
         0ZOh4VNh3m20OXE8nigK4raAvVav6Z1coa3BTlpLpbGHoc6pOq+msFEIt7XsO8IaZf
         T5A2GGUjkPwseGQo6/TlPse6YMPPwkrhjcaR8M2rgnp7x8c3yPMUosF8nxfNQv9WWa
         3NUDuywEd6OaL+QfIGRyO5+qaP2iidTBH0tEIly1TdHmlvXcWKDD7hyhAQPFPTXuLY
         vtIUa/TdR+vhQ==
Date:   Fri, 1 Jul 2022 22:57:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        nathan@kernel.org, ndesaulniers@google.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] ASoC: codecs: wsa883x: fix fallthrough error
Message-ID: <Yr9txnScTv4rcSUm@sirena.org.uk>
References: <20220701155930.262278-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U2vGb+yzfZJZNnUw"
Content-Disposition: inline
In-Reply-To: <20220701155930.262278-1-trix@redhat.com>
X-Cookie: All models over 18 years of age.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U2vGb+yzfZJZNnUw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 01, 2022 at 11:59:30AM -0400, Tom Rix wrote:
> clang build fails with
> sound/soc/codecs/wsa883x.c:1207:3: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>                 default:

Thanks but I already applied a patch for this from Srinivas.

--U2vGb+yzfZJZNnUw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK/bcAACgkQJNaLcl1U
h9A9pwf8D3nT+3EkYz7kNqdr81RfrfTfL01RSpRwy2pnhvNZgTdvgo9NpDBwkC+i
jT8J29FfGwUfe5wgNmlj/27VkhFlgW8yPXYIxQq0KpU1J5rE+nFVbbN08JYxsePj
6mS5iTQ9cXbzL8cyVPbSHtZ+brG8dtdkmwzewsYroydUPsG0VwfGrPPTFTC9bFhx
8+y2wiXB5cPfQVX28WnvQ74L1vG4W6bqOwqb8DG/eJVJGTibJ8kPl24ADnq00Eau
CxUWJcR4TcCau3m4/R7u7hiNS1DpG6IrOhT7yvZvYxUr9qC78/lC07IMim9Oe46/
HsA1tcdgESTUGEIcPZfWyyMCzav0Kg==
=2iTT
-----END PGP SIGNATURE-----

--U2vGb+yzfZJZNnUw--
