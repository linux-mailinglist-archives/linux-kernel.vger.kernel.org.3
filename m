Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B0551C5E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382598AbiEERRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382582AbiEERRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A965D187;
        Thu,  5 May 2022 10:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE6861EDF;
        Thu,  5 May 2022 17:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C79C385A4;
        Thu,  5 May 2022 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651770832;
        bh=4Cw2v6gdwkXljm2f8UrPWlUHep2z7zYACGpDeVD+35M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOOFj9t9lLuJHoacWEg5paZ2PXpqB2J56xRUC4oWfs5KoGF86XoZgBffPber8YJ10
         AlE/FF6HAJIytHkfFVbVjeoyOuqW0JdXGjqQ3odpkKfQVN3lYYrNKPKOsAirDu40hI
         A6Okk4m+aFTpXJs6oeOTjTrQLO379rwX3R0/og5wiGpDs+mT4NyXc5ZUml/PUJF386
         SurtgZjdmvc2N8buL0CKoj1ofOoA5C9cA+quUTbllndOW0LJqyhBvjqb3iWPOb/OiX
         vO3GmrUK33DWYh3M91SzF9TOYnk/VfqkdJCGegOXHKi1Jy9dEa0VTQ2Myk1+NKqlp3
         zhuDwpvIZWDiw==
Date:   Thu, 5 May 2022 18:13:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: dt-bindings: qcom,spi-geni-qcom: allow three
 interconnects
Message-ID: <YnQFy96kjgmlSgDB@sirena.org.uk>
References: <20220505065233.28476-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="27YKxtB+W51W2fUF"
Content-Disposition: inline
In-Reply-To: <20220505065233.28476-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Adapt.  Enjoy.  Survive.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--27YKxtB+W51W2fUF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 05, 2022 at 08:52:33AM +0200, Krzysztof Kozlowski wrote:
> Recent Qualcomm Geni SPI nodes, e.g. on SM8450, come also with three
> interconnects.  This fixes dtbs_check warnings like:

Acked-by: Mark Brown <broonie@kernel.org>

--27YKxtB+W51W2fUF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ0BcoACgkQJNaLcl1U
h9CWXwf+PpSWEjCCcXFisV3Uq8feNv9iLaRSWwAvqMI76vND/kUcEAjVbOuf7fz4
gED3jM5cY1KGncVvwoY7gWjQaP+SRQDdmGPUjoXl/X5cgNSQW6+oYOzuplcMZXrm
HKThWqlVKr9uYlYJzV1FPdV4OQd9sLLUQF/w0LjgDqkzW64UmLwfyD76Sfex9A/8
ncliJYQqgaAjD0pUum5ECcaex06AHmrhdm58gHG8YgdUkkRSPZhaVDAgy1+8eeoR
PzbVw31OYr0GzrAvgXWLnjCWbxD9WewHW6g5TDL3h3IARMxlLSmRV0gV+F5ewQAy
WYsoeZYVX/x5e8EjnP2afdloEB+0sQ==
=Yxe0
-----END PGP SIGNATURE-----

--27YKxtB+W51W2fUF--
