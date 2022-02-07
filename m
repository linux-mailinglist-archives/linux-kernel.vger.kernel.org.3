Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF74AC85A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiBGSNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbiBGSLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:11:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C488C0401DF;
        Mon,  7 Feb 2022 10:11:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9255A61344;
        Mon,  7 Feb 2022 18:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC64C004E1;
        Mon,  7 Feb 2022 18:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644257511;
        bh=zTbjKhDfqGCsDFN7i/VJmHQxr5pfwFOsmqnPT/Z6K/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quON+9SF2XamyeVcfD+tNAVaBbqJZScaKFWF4xzg3sUzWwQ6Jm80t+P8MZE8WTASf
         BFyxFX5+LEcE2Es41sStvA8eOaEIbqPUdLlx67RfIRZ3pqy2R3JZzoijUG6rxLMG6T
         ARZtDmQwmFWpSMOgOFY29Pl6ZSSqdZeiQlNMtDnx+W194nixtlPgqmKD+p5fVSNLnT
         vPa/qwSW57nEyTvQ6D5BsL/rZzWp47Trd/YEUlhckkqTClzJvCGxo3ipGw+HFasPsf
         Xf8jr/9rDve9Jhgf07HXVZMbu02PeQGR5i4FX2kCrdcLkutI46XE0t+BbYW/1LjHep
         kxE1yRzearVZw==
Date:   Mon, 7 Feb 2022 18:11:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 4/4] spi: s3c64xx: allow controller-data to be optional
Message-ID: <YgFg4ev1yxohRRcH@sirena.org.uk>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Md1/Vl269h3xtQCX"
Content-Disposition: inline
In-Reply-To: <20220124082347.32747-5-krzysztof.kozlowski@canonical.com>
X-Cookie: Never give an inch!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Md1/Vl269h3xtQCX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 24, 2022 at 09:23:47AM +0100, Krzysztof Kozlowski wrote:
> The Samsung SoC SPI driver requires to provide controller-data node
> for each of SPI peripheral device nodes.  Make this controller-data node
> optional, so DTS could be simpler.

Reviwed-by: Mark Brown <broonie@kernel.org>

--Md1/Vl269h3xtQCX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIBYOEACgkQJNaLcl1U
h9B4zQf+LxRW+/UCv7GdznE4/1/MaI2bwd55sQIq9rNBbkIN8mD6U0XaWJVoRchN
ZPLRfdGeXeGvmQiaARD9A73su4XK3sBbwrR2qFB2ULx0XGj4twZ/f2X9yv2n9beJ
ep5UB1zX7DNgv1OMyG2Oir5upHSFCEPqAs/sU/fmMlObXIo3ges3dWGju9w66na+
UlS0BqHMNt7UEG71FTeH/D5TG8J9IZy3QKaVbJ8eo7DujX8B+HDLZoZmJp31Lsm1
VTjCBq1FSSVMoJZh1NnfjIP/VhNQGOvBb6pw5/mUdCNsbS4NYIriImcxyBBS0JL6
4wFh/Aw7Yg2GMFHiCimB2OidqopSew==
=+exr
-----END PGP SIGNATURE-----

--Md1/Vl269h3xtQCX--
