Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC8251A2E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351656AbiEDPEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351635AbiEDPEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:04:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E6714007;
        Wed,  4 May 2022 08:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B8A61B33;
        Wed,  4 May 2022 15:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF16EC385AA;
        Wed,  4 May 2022 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651676469;
        bh=lq7MGiE/uWdKExD7GZm6qB1OLQ/BOLnq+9H9OKNCI9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3YGRO5x7g0G2kuoSOD5un+woBYe9Byxaa1Z/8j5ja2yflMPOeV7DJXCt4YZAx8gb
         rcxXCc4rKiv6oWyCxFaxooRz/BqU8uz+gGWmMNX/YmoIS5TkA4xQIYnBxpkdPNqkpu
         V+yKghw+rrjStX0LDKvN1ngCjpcTbBHO0zzqFh+Yz3htNxZ6zeZCfFxpM/JJRIOrje
         KSe6QERHJDYNMqQsYDdpIXoL0WfN4YcdEOcxmrjAS8ibSVoRYO+Bx9wIAzjkO6cPkR
         el77K9dJaEdthvq9L3gs1ilT7fZ1gTagePZQXiSSjSNrSon+ssw3DbRnJF3DvKiIVC
         BsummrlNnAtZA==
Date:   Wed, 4 May 2022 16:01:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: qcom,spi-geni-qcom: allow three
 interconnects
Message-ID: <YnKVLxmz0hhQGNzI@sirena.org.uk>
References: <20220504125119.190526-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WALsIl/4pd65GNpK"
Content-Disposition: inline
In-Reply-To: <20220504125119.190526-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Chess tonight.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WALsIl/4pd65GNpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 04, 2022 at 02:51:19PM +0200, Krzysztof Kozlowski wrote:
> Recent Qualcomm Geni SPI nodes, e.g. on SM8450, come with three
> interconnects.  This fixes dtbs_check warnings like:

This doesn't apply against current code, please check and resend.

--WALsIl/4pd65GNpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJylS8ACgkQJNaLcl1U
h9BpLgf/dcTXk+ErdRCTFDJSRozps/gDg+xuxVHRZ7Qgv6577zzfqY06zM4HCDz8
C235svq5OBM00PHmu4BG44hZQnVf0AbSt8Yhg+vp0F6BUWcsIgL9vvxX3ZMQHaJ8
RcQsyw3eQgl9EB4lvq8CHWwDktv0seMYwVFD2KO9o9mfcI3L5KIHxx6AT0Er2ycx
NJM+QW4Ivt3JDh3zACZ+hRwg9oK8xodudjTzjYNMOxGvKHNIpnLzfz9eNfn+GJ9s
/KrW3zrUqcgr7+XXSag1uDGafpgNFwkbesHjCuS5evMPRoPLbNp55tqG48HbmswW
l4oYNnFhsK11NLaFN02raNKij5y/fA==
=Qh1y
-----END PGP SIGNATURE-----

--WALsIl/4pd65GNpK--
