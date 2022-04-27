Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DB25119D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbiD0NpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbiD0Noy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:44:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C0118A623;
        Wed, 27 Apr 2022 06:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 332A9B82753;
        Wed, 27 Apr 2022 13:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B36C385A7;
        Wed, 27 Apr 2022 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651066899;
        bh=JvnuE53/WDyOKYiC36PoY+sIAe3A9YYBJuCSYXsQ12U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DNC48r6Cs5njO786Vb4JFy1oedi9Zbawu+/HJOwWE1H4AIYR/gA62sDwBTlkVYUlg
         MiJadURXFWRoVycgCVjBcBstSepTsV7EW4qWNAktWwFRQPTj728Rx2LdrkTLq3FDPb
         2ux2qnvW7Kq/YjxzG5OqcXb9QeFwqAF/C4c+JsOn+U/L+RmNRwqipvS3N07ZwEjq7c
         7jpyu3UDabC5tQ5s29EvBhOQ3p7aD5jiuwHugj52SGrMvGFkiA2D9Yb0SpNm0kgobR
         59VYGhZ1kG3lONEVOW7eowBCIxcLJkKvBUF9XYJXY4QuA9Bvh62nwtGQDGZPeax6/4
         R112T5iTRTuSQ==
Date:   Wed, 27 Apr 2022 14:41:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] regulator: dt-bindings: qcom,rpmh: update
 maintainers
Message-ID: <YmlIDn1aHSrcoeoJ@sirena.org.uk>
References: <20220426105501.73200-1-krzysztof.kozlowski@linaro.org>
 <20220426105501.73200-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SmmnhEWlYdM7amTZ"
Content-Disposition: inline
In-Reply-To: <20220426105501.73200-2-krzysztof.kozlowski@linaro.org>
X-Cookie: Buckle up!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SmmnhEWlYdM7amTZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 26, 2022 at 12:54:59PM +0200, Krzysztof Kozlowski wrote:

>  maintainers:
> -  - David Collins <collinsd@codeaurora.org>
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Bjorn, are you OK with this?

--SmmnhEWlYdM7amTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJpSA0ACgkQJNaLcl1U
h9DwqQf/QWvVpu1E4Y2lmTqpoWMjhHl74TYz1z9mqhTZzyBQnq38ic0K7K6RcbpA
KU2o+cwOoShzLOQlBtADE0Jl/+ua5TeepGWi7yFAjHn1hkJEhMP0zgV0ozWiRlo4
8l7/HbMXuOBQWEFTe5mBBfEC2XbjTLJpVcqJc324vnXVMTSbaI2CLqbp0AKk4LIW
gAHphDaqjm9syRrunsZIIzfhLtHoSJR2CQMOlUWyEnfZJadDEmWtIUpPXz17QxJ1
uK0ZR7trr6uh9DO6CKbvIV1+e5Y9RHGdBPVxRWoQZSP91Rgc2DNVbPrMb3diRaLJ
ApBhfQnyWdO/lWAXspDKhQ9gwE9FUA==
=cdZn
-----END PGP SIGNATURE-----

--SmmnhEWlYdM7amTZ--
