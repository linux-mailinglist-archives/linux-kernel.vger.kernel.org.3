Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA85251C3E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381316AbiEEPaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344763AbiEEP36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289D82182B;
        Thu,  5 May 2022 08:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4BE961D11;
        Thu,  5 May 2022 15:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0F4C385A8;
        Thu,  5 May 2022 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651764378;
        bh=0k1tO5axREF/4p/FKv3ZbViryXBR4aYYf04SAPimw2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUOT97NqXTW5U1EvAcCEkgmVXpdTPe8VucAPSAymvGiXQZ2hoxqLyvPeS2HgLGrBh
         i1OVA/b5AZStqoFiLrbgQbd00yJg0AOOtQhBYavAxVGEZCigcVBAclXSmtsg5Zd+Xd
         mVvIW9mIxcIF91ensVGsOhlZqqqWf5cPJfRbgBXt2WOmV4wKRISyDeOA0Bsp+YVS/G
         401eP7/4CSNTwlZqY7lZTNL3cBdk9H5vyRl5pkzpVIa75h2SAvWEEwiCRUy2K2f6Qc
         LHyYPpcTsoV+hZazK+7qwd1cC6s4LiFzKXjSzaA3hJkFzCSIekR9tm7q0jV9w5sCjR
         A51apK5XBwXFg==
Date:   Thu, 5 May 2022 16:26:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: qcom,spi-geni-qcom: allow three
 interconnects
Message-ID: <YnPslKE9klw/Mair@sirena.org.uk>
References: <20220504125119.190526-1-krzysztof.kozlowski@linaro.org>
 <YnKVLxmz0hhQGNzI@sirena.org.uk>
 <cfba178d-ff36-910b-3067-ce32b701b643@linaro.org>
 <YnKZyCogvngR7zfc@sirena.org.uk>
 <a099eb33-91a0-0262-f6c0-a77dc7aec146@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bFKPx0PKehbSOEUY"
Content-Disposition: inline
In-Reply-To: <a099eb33-91a0-0262-f6c0-a77dc7aec146@linaro.org>
X-Cookie: Real programs don't eat cache.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bFKPx0PKehbSOEUY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 05, 2022 at 11:00:26AM +0200, Krzysztof Kozlowski wrote:

> I don't know, Mark. The confusion was not intended. The second patch in
> the set depended on SPI patch, so probably after three weeks Bjorn just
> took entire set.

> https://lore.kernel.org/all/20220404064017.68634-1-krzysztof.kozlowski@linaro.org/

Ah, so this was part of the pile where I was waiting for Bjorn to say if
he was OK with adding him as a maintainer.  Bjorn, please don't just
apply patches without some sort of handshake when people are clearly
around and replying to mail - it causes confusion like this :(

--bFKPx0PKehbSOEUY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJz7JQACgkQJNaLcl1U
h9BI8Af+NVvL8/LWcbqmAd3UbedPPsrdmc4E7WXxCKiDCeeuC1g2+eb4Fw6w14rV
4wtO1EZutitVEnvnAcw4V6prNrlHF3JCQxZyJiAPgmXzOf4FZCMPdsxOKLwMM8cj
hpwl7i5dNyCnymFC08V4ZkRsuo/7QaLpqaola7PuuMCckdcNco801AG5tGoJAhaK
iTXU/hXLxoW2xK/u/q17Cow8bawsw44X/M3WmTrmjlBA12VwAFZUBW41UVfvU/o9
C40BBVE66Jz44aOFVA/wwZKFykCfKZLKBF8qgQmZ5WuTBVUM8v9ExOhLZl0JrqPm
OM/8eUYLRm0bx9dni4uCzL1wh1KSlQ==
=r72j
-----END PGP SIGNATURE-----

--bFKPx0PKehbSOEUY--
