Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD9C58A9E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiHELEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbiHELEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:04:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE55B4B4BC;
        Fri,  5 Aug 2022 04:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A108B827E7;
        Fri,  5 Aug 2022 11:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A390C433C1;
        Fri,  5 Aug 2022 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659697484;
        bh=gC/a99Ij5cyWFflxaubBtEFvPnGSnVRK/jArM0HrjDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tzLV1sSe1UNkxUbJeqPUHwgZeoqEnGMRjmYiwj/pmmZLxTkqt1L94ADCct6AeOSxu
         YM/ngA+jTbOzrNCTffFBE2k6bEMQ9DBTgTF+EDX53UYCrFds2lgQx5WmFiqnxIle51
         qlZ1vCsjLifulc3ElIjfxgwhwZzwitler3bxi00qQQH/5MMA3o9enadRJcEegd6vaN
         TNomJh4i+0LbE5RfuYAHUZ342YXsb8L1PtazYs4Js0pTUloMwSjWsPv+uAm9oPqnoo
         fXSq1h9SPvzBQoOpq+yyJl4W3bJOEzAA+bFIzslVVmdLp2+/Dx2lCAQEMm0F0sO0cc
         o0a7xtqrsKsPg==
Date:   Fri, 5 Aug 2022 12:04:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Valentina.FernandezAlanis@microchip.com
Subject: Re: [PATCH v3 4/4] MAINTAINERS: add qspi to Polarfire SoC entry
Message-ID: <Yuz5RzEhwWa7xqlR@sirena.org.uk>
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-5-nagasuresh.relli@microchip.com>
 <9e3dbc0f-b04d-c67e-7f39-9cf936ec7252@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u0Pv/qHdI8e+zGNo"
Content-Disposition: inline
In-Reply-To: <9e3dbc0f-b04d-c67e-7f39-9cf936ec7252@linaro.org>
X-Cookie: Do not write below this line.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u0Pv/qHdI8e+zGNo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2022 at 08:50:37AM +0200, Krzysztof Kozlowski wrote:
> On 05/08/2022 07:30, Naga Sureshkumar Relli wrote:
> > Add the qspi driver to existing Polarfire SoC entry.
> >=20
> > Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>

> This should be squashed with previous patch.

It's perfectly fine to have a separate patch for MAINTAINERS like this.

--u0Pv/qHdI8e+zGNo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLs+UYACgkQJNaLcl1U
h9AHfQf/aRy8eONwtSRpPBhbbB0cSYO6+Gu5VT0wcGqEO5uI2plQ6QjP57V1n5e6
AWfl1yz4cY61+B9+LQiv6qGFvNY2N5wQ2EfrSLiFce2Z2BPsKGn9VmcZSzO88jf0
CqmI17CKUsGHQ16QC89Ug99EHS7yp5RyUuVGRKAjSYknPzeUEBk05LqXf3IQdJhE
okklAcTYGqHJzJhJq/U1g9fJjLz73eGM0aYQQryvv94jR8y3Xcn5l/baqhvzAfAg
QsV3rWCIP7ws1Jlubf0I2kwi9wEMrgGglIwflHDcBYzADn8tPLYkGltzY8Frgp+h
FI+HhT8c5T1BOIIPOx5uxO45oj2KqQ==
=boCL
-----END PGP SIGNATURE-----

--u0Pv/qHdI8e+zGNo--
