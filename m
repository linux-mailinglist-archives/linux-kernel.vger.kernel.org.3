Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160AB58CBFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbiHHQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbiHHQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:15:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6CAB871;
        Mon,  8 Aug 2022 09:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B406B80FE4;
        Mon,  8 Aug 2022 16:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE6EC433C1;
        Mon,  8 Aug 2022 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659975334;
        bh=XSBNzbT6LXKAr8IpvipaSnA2f5Z9VpcdM9dEEX8beb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brRulXjV7S/0t0z/EaJxObEiPu1kZTXIMbkxiRKI61TYA7zex7B53B55Cr4qqH0yU
         TSN3MqtwvcbfEYL7PP5SNxJGCiTjvOhDiOPKWeYIZOV+0rGXzXJAYwxNMNQKDxhQC7
         Swq8XleUL3JYsZfEDzTpx6eS2SbWWJAI0U5G6JByAstSB71/CJrzB9H+/WpzUmLnfL
         XNgvePW9QpveDKEk2towuejHl9LXrR0PfX5zk2GSlEskEzYRxKRQMnoCtEWHr6Bazu
         vdd1euNH1wHIZqwME/l3M7mgCVCeNFShlu5wMc6zvUTPvWL+GM2YOn96+j+G+L9oTt
         putHF/JjQNwSw==
Date:   Mon, 8 Aug 2022 17:15:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: stm32_qspi: Add transfer_one_message() spi
 callback
Message-ID: <YvE2oN7EDDFLlxyv@sirena.org.uk>
References: <20220808074051.44736-1-patrice.chotard@foss.st.com>
 <20220808074051.44736-3-patrice.chotard@foss.st.com>
 <YvEP15/7KmQGyPgL@sirena.org.uk>
 <bbe8f91e-35f4-fe80-4b6e-25d21a6547fc@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uC8gnb5PKUmB6mjc"
Content-Disposition: inline
In-Reply-To: <bbe8f91e-35f4-fe80-4b6e-25d21a6547fc@foss.st.com>
X-Cookie: Flee at once, all is discovered.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uC8gnb5PKUmB6mjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2022 at 06:09:51PM +0200, Patrice CHOTARD wrote:
> On 8/8/22 15:29, Mark Brown wrote:
> > On Mon, Aug 08, 2022 at 09:40:50AM +0200, patrice.chotard@foss.st.com wrote:

> >> +	ret = pm_runtime_get_sync(qspi->dev);
> >> +	if (ret < 0) {
> >> +		pm_runtime_put_noidle(qspi->dev);
> >> +		return ret;
> >> +	}

> > Use the core runtime PM, there should be no need to open code.

> Right, i will use pm_runtime_resume_and_get() instead.

There's also core SPI support for calling this - set auto_runtime_pm.

--uC8gnb5PKUmB6mjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLxNp8ACgkQJNaLcl1U
h9AyFAf/c/JlPakgNi2pE4cLX1TuxOSGJ8lGkAMOizwJksSpHV6k+e1iN+dhc9NK
fSxOjFkXL6gKyzPwpoO1hgr09RdmibswfrpsqZ9S8YdZ3F2DTZusCayYJKM7qHku
Kjh8ZcTqk1rWhJqzMB6I6V+zRzJgvFkim48znIMJ1iNdkvHjS0NbTAhy3spmCR5D
yUu2eejgpD3rgKTMd92KOXKabBMUAcVekHCXOjVrcx3Z2Yr9C4X3+TXY6N3eh5SS
+v6OMOjAHGlv8msMj3t+b68Zt4+kQ0/IVnIRHenhU1rmOL3PAKH7+FtTFchVA0UT
PphizwOFmcTie/b8CHLMS32uIYEbKA==
=fz/n
-----END PGP SIGNATURE-----

--uC8gnb5PKUmB6mjc--
