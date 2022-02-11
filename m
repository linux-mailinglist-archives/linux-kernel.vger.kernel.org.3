Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66DE4B2513
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349793AbiBKL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:59:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiBKL7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:59:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40D4F54;
        Fri, 11 Feb 2022 03:59:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83D8DB8294F;
        Fri, 11 Feb 2022 11:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1541DC340EF;
        Fri, 11 Feb 2022 11:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644580772;
        bh=PiUJ14tYj47Er2g/nnFkWUDiTAM0HXvy8rHp6sWes4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVjjoDYjljaSNrrw28tEpXjxzCBjDiRorduusFsO+h0pDRy+ol6iJZjGRNysfKtmi
         erIckeqPuzh4HCUGrp0eeYjW+7SU41PZy6krRpJNqfekJK1CFmrARXzrX+SGTjzDgI
         0m5mrqmSCGh/MDUy4Ugxuks5ptufdHykeYSyVkBWY4NSILvIw5IcVFbpWjytq3lpkJ
         Q09791mpgTDNE+nFaoIB9o7vsh8GrvhpXclHMw1x828OqYQ7lRgxjbqlcCl5NvqElu
         5j3iWEh+UF6Ag1SCGDvrf6UgAUnyZs/DghbfnIXtX7+NH/IAX3Mj/xaMHUb2ueoIYg
         p6AnKE/VLl3ig==
Date:   Fri, 11 Feb 2022 11:59:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/5] regulator: dt-bindings: maxim,max77843: add
 MAX77843 bindings
Message-ID: <YgZPnjbYq21BWNOT@sirena.org.uk>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
 <20220111174805.223732-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ova0lu0FGhibrYcp"
Content-Disposition: inline
In-Reply-To: <20220111174805.223732-4-krzysztof.kozlowski@canonical.com>
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


--ova0lu0FGhibrYcp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 11, 2022 at 06:48:03PM +0100, Krzysztof Kozlowski wrote:
> Document the bindings for MAX77843 regulator driver.  The bindings are
> almost identical to MAX77693 bindings, except the actual names of
> regulators.

Reviewed-by: Mark Brown <broonie@kernel.org>

--ova0lu0FGhibrYcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGT54ACgkQJNaLcl1U
h9A77Af/SZ/OT9yzOh5MHwXqhEaftBX041jmWBTNrBn8l/t3s7vs4wdjxvKUAOMY
aUcWsiHgTcleTHRClpBjo5y89ViTuCjDIerQXLv9G5EjY51zcmSpbsOnmyCAzUVR
qAK9vEUvDrROJpeZCAR6Av8tRcmoXYuSpqObjIxmbeYWb98x7Q7RXOK4x3iUnzul
Zphttov/KJxuYO032xRWRcQ00VR0G4jBP/alQzz/6m2OGkqxDoS+uLHwF87Feebo
NEZCzAHioggTCaB0kCWZTFV+qBnza6ih3ZdeImBS5DalTE0PAZSWUtnzjXXeld0r
0Kub2EdrdVsiHFzby3w33WohjQ6viA==
=hIKA
-----END PGP SIGNATURE-----

--ova0lu0FGhibrYcp--
