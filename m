Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F2D4F1059
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377844AbiDDH4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiDDH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:56:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE873B036;
        Mon,  4 Apr 2022 00:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06C0CB80EF3;
        Mon,  4 Apr 2022 07:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D907C2BBE4;
        Mon,  4 Apr 2022 07:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649058859;
        bh=9I488zZRdf3y8rptDyd/PdxuRxtgedkj52VGVooM250=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9j/dkoXZMhh+kn9Knt376p0j0yjA8DlWi4KDYxli3V4RkdnrCkp5HU4ZK1TFY6D1
         kq3h3OL+E2Fiv/ZQ55Gqo3KwxqaeBwAr6gqcYCsm8w0yj3V/UlJqm2P+sPMIoldG9V
         YwLrcLJUbX6inRsAPSRyE0ULEYzc4TwGgEpp81JvCOhoWoUCf/rONSlb8H0gFgHOWo
         GETHS3hLs1NAT6rQBoTh4VIhOjjqJCQ0YPOmM/07YiqfCE+e+k0APMVQwYJ8jlLdzZ
         wIUjn/6hQ90JkftU2Hl/+QqBiXG9udGAM23/p0VzUmFCxcE8CXhWENdxrA9thHdOdA
         LmmkT3niV8n9A==
Date:   Mon, 4 Apr 2022 08:54:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>
Subject: Re: [PATCH v2 4/4] spi: dt-bindings: qcom,spi-qup: convert to
 dtschema
Message-ID: <YkqkJgLd4LdxF883@sirena.org.uk>
References: <20220331155320.714754-1-krzysztof.kozlowski@linaro.org>
 <20220331155425.714946-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NbkpDTQWQL5ps1uY"
Content-Disposition: inline
In-Reply-To: <20220331155425.714946-4-krzysztof.kozlowski@linaro.org>
X-Cookie: Custer committed Siouxicide.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NbkpDTQWQL5ps1uY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2022 at 05:54:25PM +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Universal Peripheral (QUP) Serial Peripheral
> Interface (SPI) bindings to DT Schema.

This doesn't apply against current code, please check and resend.

--NbkpDTQWQL5ps1uY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJKpCUACgkQJNaLcl1U
h9D/1Qf+OY9LAMKRVjV65ar+QH6KqiiS3zqvywaKuAHc4osZLy2zoSTe33UK900A
OV2VpZPbMRmCNpfa5T5vjaLJh2pQUCrH4r/9YDGu9aD8+Y6v4Ip71oaCtu4moLpU
frJsF1IkJrfMi0iwChCm4/QluTj2TI9eE4gHkCo5agFzGxF2Pxl6mxFKAoazZACB
yn/i4tUC+am6XnNUo3QDnn2hidC3L8ddR4ZXA22IhGB404uqSerI1DOCHOosV8GS
sIheYKgmZF5XHDNck3jZVvoLAfzZThAtQuDC93gB9uVwRAji1Y27ivg3S59f93dP
ZBPK0mlAZYrs8KfYANsOKwlB23li0g==
=tKYI
-----END PGP SIGNATURE-----

--NbkpDTQWQL5ps1uY--
