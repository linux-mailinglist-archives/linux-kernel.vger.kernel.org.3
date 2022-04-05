Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17EE4F38DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377345AbiDEL2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbiDEIua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A78F11C36;
        Tue,  5 Apr 2022 01:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82853614E4;
        Tue,  5 Apr 2022 08:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F022C385A1;
        Tue,  5 Apr 2022 08:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649147899;
        bh=5oEKvyvDsm4nX1f5sd5X9vxlvOxfYV0575LO2WUqqGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3NTkZV7kSPJrt2W33ieNRkzNEKcCCZ8f9a0rAbjXtGXYd5QerIahjqwE0fg8mzoA
         c0t5Z8xkhPKUhHrVD9SUFI3hk202bDJ0wb1DvP/zUJxbKQ8XXKJeCbUmqSQ5VvLK0E
         W6w7dJ0Sd0B7ufNRXK9FG+Z/KnbWt3v73UhdPz6guUUKKRef7qyGzAGwpW3kLHO0p4
         fOTUoVjACDLAB5Co/UgnYKYiznriPXfsYQH1gB3NkOTkqHiQ7qJGezCpG1OMusqs0B
         iEgaXreNEj46/pkZWsWq3AQkJyoC5LfkkRWJPvahHSMiiS7E3PEZDIWV1MRiBtJIIR
         9yVLR3IKQe3iQ==
Date:   Tue, 5 Apr 2022 09:38:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: qcom: update maintainers (drop Akash and
 Mukesh)
Message-ID: <Ykv/9gB01cFRdQiT@sirena.org.uk>
References: <20220405063724.12850-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MzPEjjyGDoi8R4A1"
Content-Disposition: inline
In-Reply-To: <20220405063724.12850-1-krzysztof.kozlowski@linaro.org>
X-Cookie: diplomacy, n:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MzPEjjyGDoi8R4A1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2022 at 08:37:24AM +0200, Krzysztof Kozlowski wrote:
> Emails to Akash Asthana and Mukesh Savaliya bounce (550: Recipient
> address rejected: User unknown in virtual alias table), so switch
> maintainer to Bjorn (as active Qualcomm platform maintainer).

Acked-by: Mark Brown <broonie@kernel.org>

--MzPEjjyGDoi8R4A1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJL//UACgkQJNaLcl1U
h9AwrQf/aOVI3k9H5QjN71ONU/w9xjBiWoqyUl3Nsg8bH38SG/SpKjiyIEuI65zS
L5OjehWZO0GLFJcayYCsJFPNhePpsc06H1FNspExegH9oeWfbiMech6FFRfK54Ku
i2fqAeLUt+OLAMyxcIwT3N7vPpXP92eHhLgDm8C3646BgWjpUQtnRC3u5tJBkFSr
TGNK1KG6n0SBRVKsLqsCLVy6caFt3aPij2TR6zfpQlyucY9CqZEU8m6LmxS3nQLX
TVOt7LYt68nNgJSfdPvWsMXlcSmYeaUpFO9f+fFGx7q+4db+MRPZueNm/gQMQNTi
TvfIg3ee7IKdHuoNZSc0UhWnHN1+Qg==
=UYIt
-----END PGP SIGNATURE-----

--MzPEjjyGDoi8R4A1--
