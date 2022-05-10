Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C904052160B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbiEJM6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242038AbiEJM6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:58:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8A92A83E6;
        Tue, 10 May 2022 05:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EED94612ED;
        Tue, 10 May 2022 12:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B65C385C6;
        Tue, 10 May 2022 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652187254;
        bh=4PivaWWi4aEx+cxNzcxek9VaB+oZC2dWimjoWJP0lEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prHSrTuY6SWToZk1S1G9KfEht4wO8o9B6JcZav7Jczb+IsjukMdEwDYWRiBweoJo8
         YPhv3WJ1ivSV9Ogg4OcHvox5ZIRJH30+2bDQB5YyCux8FxtykmT03WlZkrzuOUXtCp
         vlUJ5lmdEl2wieeeXEHobRBBpA1RnOcCP6+5aW7Q37uVoam18/1b3cKjLjuMOY6n4c
         i/tel7fHiiz8zoiek7/ffgOHy3MZXEcARJ8reaQn1vMzUlQLazBW8RCa+yT3sjX4/3
         LOl/gKSoeIXiKB/pAEGmp4EsC1zoT0a9mUAoiqfKvktbfb9yzYrDsMroI2eIiti8c+
         HuoPtieR/WPrw==
Date:   Tue, 10 May 2022 13:54:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: fsl_micfil: Add support for i.MX8MPlus
Message-ID: <YnpgcAVzADHoCUgI@sirena.org.uk>
References: <1652087663-1908-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2Z522tNyah4CHNrF"
Content-Disposition: inline
In-Reply-To: <1652087663-1908-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2Z522tNyah4CHNrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2022 at 05:14:22PM +0800, Shengjiu Wang wrote:
> On i.MX8Plus there are two updates for micfil module.
>=20
> One is that the output format is S32_LE, only the 24 more
> significative bits have information, the other bits are always
> zero. Add 'formats' variable in soc data to distinguish the
> format on different platform.

You can set sig_bits to say that only the top 24 bits are meaningful,
though I'm not sure many userspace applications pay any attention.

--2Z522tNyah4CHNrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ6YG8ACgkQJNaLcl1U
h9AAZAf9FIpl1VBhFVT54/Bc818gjoAdE0BtGCj8hJx+BkHhVZrP/j/zQDPMsSwm
MicGHeGYNhAOFvKVkSFNg+9bZkho8sFtnlEaJfZ/JqFob5427lAlk4fr1EcfqU8f
1ICz//JQzP6UAXI9UpI/JlqdBRHbW9OmMiQiVCtoGSPV4ReuXP4vQTvW6nSdFeXS
yJaa7rvTSHn92leRXDek3XAxGEuci7VJ/zvFFxbO9wPLXGEj6VkMqSSaJ+an2Rgy
bfB4kztha4PQsEPWaMZxYkbxwiLTNIDKYNMRkUWc43OpxCF6+hu5jimP18vRToGl
25szXXQxFjmC9ojtkMeYsNeOQBqYPw==
=M2n0
-----END PGP SIGNATURE-----

--2Z522tNyah4CHNrF--
