Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB2057185E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiGLLP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiGLLPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:15:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F651149
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF4C260C6A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A7EC3411C;
        Tue, 12 Jul 2022 11:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657624518;
        bh=pl+XSTy71759ycCBgu9SNDcZUWjRzFBZrxHr5o4NhkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ij/VftPgtX3+p7oZlqQcNN5X4dIQyuD2oyvEMy/kkK0HkdTOPivSOS9gdF6Faz3Nf
         aUaNyyqRK1qIcgwuhwiki0AUEcELQlz9tmwnVSshklWq2Sxy39jfBLdPiJTyDh+qC1
         dA/R/95PdNkPd9CvjIYA5JxoRSNcPWiD1bikxvks11Alkp9kv6x0NwKT0H78aWQHYA
         IfTbm5APcUCzxBmtj1hwiCk/SLcIOooR1hvG+WjDP/oxLEhTgKplMI6ZTk5iBNx2Ck
         Wp0a77ITRnEpA1c1IOB1y0l7kqsa655UY9kOthW/QvuecFdALJmOnG+g5WvS7OXk8F
         qzZAj0r1/JzlA==
Date:   Tue, 12 Jul 2022 12:15:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, judyhsiao@chromium.org
Subject: Re: [PATCH] ASoC: rockchip: i2s: Fix NULL pointer dereference when
 pinctrl is not found
Message-ID: <Ys1Xvp+IMIUpzNzo@sirena.org.uk>
References: <20220711130522.401551-1-alexandru.elisei@arm.com>
 <CAGXv+5HyD63MSmnNSoHX6euR2qpnqh-Fn9rdRYRYz4Ci90+w8Q@mail.gmail.com>
 <Ys00vczqcIGzOadV@monolith.localdoman>
 <CAGXv+5G=YvDkm8a=Wyui4mqSskqPq-kQJfU4HGNXSGzz0hXiqw@mail.gmail.com>
 <Ys1UqkHRyvv91UC7@monolith.localdoman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9fEy3WxPqrp25A5C"
Content-Disposition: inline
In-Reply-To: <Ys1UqkHRyvv91UC7@monolith.localdoman>
X-Cookie: I like your SNOOPY POSTER!!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9fEy3WxPqrp25A5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 12, 2022 at 12:02:02PM +0100, Alexandru Elisei wrote:
> On Tue, Jul 12, 2022 at 05:25:43PM +0800, Chen-Yu Tsai wrote:

> Any suggestions?

I think Chen-Yu's suggestion of reverting both patches for 5.19 is
probably the most sensible one at this point.

--9fEy3WxPqrp25A5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLNV70ACgkQJNaLcl1U
h9CbyAf+JJJlABFoNhMUptCoSgIxg6keunheh8+GJnPLI0O/NtsiaWYFVqZXpuwR
4boFSbhWcQ5u2r03Utj676hsh7pGIztD0DgmlPrz8mDrLkxBJOxCBD/pLgGjgIBE
ET844Y3Bvfd+3YEPZ/oBNYH6/IALfruWjCoNeT8gbLLbFuxh8b13Vi+m/+YCINK0
Wx/upzf3+kzP70TytIzjtOE3lFmvalhbXg+2L9KI/KuTshS49kARSbx88KyHLlDx
4pF/HG6rRxqlIkCZYnWF+BVwuDqWlxl9zG10PAauBoOfflhoccMb6mk0nhW8hlpP
fRJ/16Nq5K+4KFtQN9U/lSG2jERAwA==
=X9aC
-----END PGP SIGNATURE-----

--9fEy3WxPqrp25A5C--
