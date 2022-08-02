Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404EE58820E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiHBSsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiHBSsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:48:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0042AEC;
        Tue,  2 Aug 2022 11:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D23DCB8205C;
        Tue,  2 Aug 2022 18:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74C8C433C1;
        Tue,  2 Aug 2022 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659466085;
        bh=O5FaYJYaqBUugib8EoE0cRmNpA3nJ2d0waB2Ao9BJyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpeBjSnm9N5Y+omIZ2yIZiQi0sehNejftcxcrCOc/fvKcmnJfGkVHb6tPEEMdQaG5
         Cwvl343AofPn4raKp7rlsg0Bir+0c3NlBCq9DQnWhA4khSu4xGM3VnBxPdN0dS03av
         rfISXX5/dTFv5I0hyBfc9FAz3q9Z8RpGlwMZ3pxGhs8Aw7OismXJRLgHx+vKeAl6H0
         tAq7qYoHxqm2DScZYEEc2+n7vP3+cVepIbBoHSzLof6nq+DlDPp/F4PBcHFFmf3oR5
         ypNX8ZWCkcxN0rTrI75QgKAyll8uIMV9YAFYUr7CYY1awajmQ0YWzeteitfXkGA92q
         ZFXSxZ5osUeEA==
Date:   Tue, 2 Aug 2022 19:47:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 01/11] spi: dw: define capability for enhanced spi
Message-ID: <YulxX3Zo168cWhwP@sirena.org.uk>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-2-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JCWDcbxgaPatzncw"
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-2-sudip.mukherjee@sifive.com>
X-Cookie: Stay on the trail.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JCWDcbxgaPatzncw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 02, 2022 at 06:57:45PM +0100, Sudip Mukherjee wrote:

> Some Synopsys SSI controllers support enhanced SPI which includes
> Dual mode, Quad mode and Octal mode. Define the capability and mention
> it in the controller supported modes.

> +#define DW_SPI_CAP_EXT_SPI		BIT(2)

This isn't at all descriptive, it'd be better to have a capability bit
for the various multi-line data modes (or possibly individual bits for
them, though board setup will stop us using things that aren't supported
in a given design anyway so it's a bit redundant) - that'd be a lot
clearer and avoid confusion further down the line when some other
feature gets added.

--JCWDcbxgaPatzncw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLpcV4ACgkQJNaLcl1U
h9C50Qf/S/F36nAYjerM4pLu2vLaAFMbKpfuHlweqnhHS+Gz67dQG9GstmvH2ZLi
1l8phYLEIhvOfw4Hc2R5b+OAzitqnz11UYrMcTO1qE4LeBXt6KQrvNiI1zoLLPyj
m0f3z9z6JFGNI3kt5+GnEnbujz+JRCg1JMWoUlrFEhDbehduJAghXu9howuP8P/6
eS3qk1f1DNxII57wzRtTh8iF1RtWZL8a05DK0NfSEpD5SY1mZe3c7XTPVcFZa6Lk
rp7MH/cndZwnI63WowgNFOmx53LaPxW3JoIqQkVfla+7aIuTz6oc40eTxmdxjiQ0
8ZnSbBOna81vBdY71+ug3SdGPeEiZA==
=8Nvd
-----END PGP SIGNATURE-----

--JCWDcbxgaPatzncw--
