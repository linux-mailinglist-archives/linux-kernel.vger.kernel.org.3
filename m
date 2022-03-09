Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679574D2FF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiCINci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiCINch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:32:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB38117AEC8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:31:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87B9761A55
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F2DC340E8;
        Wed,  9 Mar 2022 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646832697;
        bh=gsS5cRgldnuxZAezSoBJuvEEol4eNludlAbg3VTEF1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2xT1tNQM+/AqoliEO4iFOckPn9Z+WvH/LteeXq+/IShe7WT1zilF2QJUcmuIur9O
         oPkCwnmatbGWCXBxKppkgF/yr06/H1/+aKaD4M6wBl7gWVp573xk0wMRrZ9S5ZWa0b
         myfC8Ih3AbuWf8PZBVlpGXngdMReIooEDXn7nttZd2kXhARHbkaBOt0+1PMP9/TTaA
         T5Yys2DrLryw1tVaXfgUdDBFI6lgkS/oFYE0nxeic0gaNCdz2J2HjNobJllcOlDhFD
         adMPvo+7VR4NzJweC8MwnfhQus30rfqitM9aj/aoKSIJG18bBw8MF5RaBbfrHjuBzo
         dkWA/T4dKipFw==
Date:   Wed, 9 Mar 2022 13:31:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: qcom: fix Kconfig for SC7280
Message-ID: <YiisNOT2AjGX7S3K@sirena.org.uk>
References: <20220309124453.25841-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m8WzhEHmoEep+AhC"
Content-Disposition: inline
In-Reply-To: <20220309124453.25841-1-srinivas.kandagatla@linaro.org>
X-Cookie: Caution: Keep out of reach of children.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m8WzhEHmoEep+AhC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 09, 2022 at 12:44:53PM +0000, Srinivas Kandagatla wrote:
> select would force the symbol to value without checking the dependencies.
> In this case selecting TX and RX MACROs directly without checking its
> dependency on COMMON_CLK would break builds on platform which do no
> set COMMON_CLK.

This doesn't apply against current code, please check and resend.

--m8WzhEHmoEep+AhC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIorDMACgkQJNaLcl1U
h9D97wf9EPYIg3qvPojrTzttroxLFn9j8boMx6+4sAcU21aSI7iraIA7gYj8ZITy
/PgkxQnRh1Ifva59LFSkACqyEetgfmQpywD5tJFRbQrYwewXfOvrCY1P8Q4ALqs+
dCnF9+hNLSLSrCPsranzmQ2P9qhJPQoP+KMHd5Zy65nF0AdEXigWEneTPOn8jZe2
tU07eZCgV1wI4+RbXrN8AnM5BTNOdbNnl2jGYKgy9BOVQTaeJUiAXOAxtfjTlA+o
otms0m0tJuT7mhvDAYEvfR0KbszYRYjRU7hYMe6Kc4gm6HMoqMTIfi0KRfGvjZWM
weYqWTYNAVL3NFHx+UCaxWZowx4LLg==
=KG/+
-----END PGP SIGNATURE-----

--m8WzhEHmoEep+AhC--
