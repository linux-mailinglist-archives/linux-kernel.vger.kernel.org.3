Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD37959C02E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiHVNHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiHVNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:07:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB1933A1B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13C22B81134
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A786C433D6;
        Mon, 22 Aug 2022 13:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661173624;
        bh=tc+H2IZAZYCcsk+W/qTN/Gurc56MzvlVN7bbGRvcG/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWbhguo6slX2gCkBvkQDKi4z6EJRsxjArA7HDElXkjZM/QcrN7bJXNogEVMDwzfhR
         wT8xkpFbn/8v1NhEkjj091LbJjSYthE2j7m8R/BjYJuFa+C0sl1ltXbzaP9ozJwKi1
         9W/TlWvxIuY/U3bG8AT8l30zQ4WdyM1ZOcngH8lb3MsczRS7ulh5FimlfTtUZV3oUb
         afQzRsua+Mnsll8h/6ETgCYdNO7/g1legmMBODv1HG6ex5WoQIYHZk7CujwjgG+fU/
         1a9jy4qoQUyQZOqJt+E7gfllyZl8FTgviAzqdMb7LhkdSq5Cq6wOGXIvZSoaj23Nip
         8sPWCHgEN8+uA==
Date:   Mon, 22 Aug 2022 14:06:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_sai: Add support multi fifo sdma script
Message-ID: <YwN/c0Q8ooBCIB1z@sirena.org.uk>
References: <1660555546-24223-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u43b6UwMPrtGu+8T"
Content-Disposition: inline
In-Reply-To: <1660555546-24223-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Am I SHOPLIFTING?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u43b6UwMPrtGu+8T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 15, 2022 at 05:25:46PM +0800, Shengjiu Wang wrote:
> With disabling combine mode, the multiple successive
> FIFO registers or non successive FIFO registers of SAI module
> can work with the sdma multi fifo script.

This doesn't apply against current code, please check and resend.

--u43b6UwMPrtGu+8T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMDf3IACgkQJNaLcl1U
h9BAlQf+L5kP4l9lQLSb9J7A0IJngh/vpXFA7wuR/7oW6SzHZxsyamK1IEPXVijQ
6Is+lGT3ObIPZydx36IzJS+qkTOCIbuNTjeAl12SM/qCOQX4wZzhn80eKO3SKtvK
9PVvmTaFFWvn+ANBeNWDKOXtdawBfBK5K+yLhiTNifOqQZ+8e0kL0TmnOhdecYEw
//MgiNAkSEQV3c8F+u6JmXReT/9J7LLSGKbxTzu2Il8rXRPPbEfrfTxTF9V5BH3L
XAYQYUTdrQ9/1rPXEW8/jAPJxvEOljTT4Q6iFAN5KF2xslmGD7pCuM5FW9ClHuCm
rFKX5gZWGOaQn33E+zDa8HWh+usyVA==
=BNOe
-----END PGP SIGNATURE-----

--u43b6UwMPrtGu+8T--
