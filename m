Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A542457BB8C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiGTQkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGTQka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6834B4D4E9;
        Wed, 20 Jul 2022 09:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA90A61DB6;
        Wed, 20 Jul 2022 16:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73D6C3411E;
        Wed, 20 Jul 2022 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658335227;
        bh=b+4Mdy+zaQWf0sfSJ+jn3b1Brb1gCaAlNd6VwPCny14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxaA4Dnj5IA/8JIgvhcTsZhKqn6ay/yxmhOMsq/TGe5J4cXtwq0wEwQxsmPP435P2
         uuj9d3ZASh9idF0IdicDKmZbUkv+8gfcG7U/nux0csjgdaoKq2KwbhvrUhytDkD8Q0
         ULh2hOqSu9A+cHbCgT8sTjjO1o4lfpWMnFLLf3MohvYU5VSduSdFAaz+VaYdADhMTd
         4z+/jnenTc6cltH/6e67nQv7XcwqkOe5XUTE0VR81G1HzXTLnGOSuyzM04V90D70Z/
         z5O6XVrDdC1NtMPu34Euki9WWw95Mrp5GKM1MqBHNnTFuHWYxGaN+xLsRBdY9yiXuu
         UfavxWMNB4pYg==
Date:   Wed, 20 Jul 2022 17:40:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RESEND v2] spi: dt-bindings: qcom,spi-geni-qcom: allow
 three interconnects
Message-ID: <Ytgv9R3/hmxql0Lz@sirena.org.uk>
References: <20220720163841.7283-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6aPVaFpJBAl/A05J"
Content-Disposition: inline
In-Reply-To: <20220720163841.7283-1-krzysztof.kozlowski@linaro.org>
X-Cookie: I exist, therefore I am paid.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6aPVaFpJBAl/A05J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2022 at 06:38:41PM +0200, Krzysztof Kozlowski wrote:
> Recent Qualcomm Geni SPI nodes, e.g. on SM8450, come also with three
> interconnects.  This fixes dtbs_check warnings like:
>=20
>   sm8450-qrd.dtb: spi@a98000: interconnects: [[46, 1, 0, 46, 4, 0], [47, =
2, 0, 48, 12, 0], [49, 1, 0, 50, 1, 0]] is too long
>   sm8450-qrd.dtb: spi@a98000: interconnect-names: ['qup-core', 'qup-confi=
g', 'qup-memory'] is too long
>=20
> Fixes: 5bdcae1fe1c5 ("spi: dt-bindings: qcom,spi-geni-qcom: convert to dt=
schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

I'm assuming from the fact that I acked this that there's some sort of
dependency here which means I can't apply it?

--6aPVaFpJBAl/A05J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLYL/QACgkQJNaLcl1U
h9DoBQf8DkvrsLBykQ6d8Emjnz3J2rawA8+zPlrJDwoJCUjlJfQJQqu2ht1xPyZT
fzQBr5WWgEEFG4zBfuZEiM1HnK9pSbbnXL4+m6Y2i++YIhi557uirpQms42NCGP1
6RQP2KRe4X5vx8VdLPx2LRftBL1I4gj7orSTvi+BWwLXthxlxdRKZsgyWVni1p4R
ScbDhImVCr/+/PXDE6EPW+uPJ0NsVvAdNRSOEq/76Umb4dH7L6jZm2Oz4CqMerR7
V3ABWr/diYEjBrT4y1Poh34cTwJMe1GefDqcbB15+MYXFNCcZ3hdKtJBvuxNi25n
I2FYvlZ4/6as4+g6lfagmn2n1w9G1Q==
=kCy+
-----END PGP SIGNATURE-----

--6aPVaFpJBAl/A05J--
