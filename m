Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6775B20A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiIHOf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiIHOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:35:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37564E60E;
        Thu,  8 Sep 2022 07:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 898FAB820F1;
        Thu,  8 Sep 2022 14:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6C0C433D6;
        Thu,  8 Sep 2022 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662647720;
        bh=PqNEivvRBkbJb/bbw9l3rUVufBVDSk0Ladwi3ZMei4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvPM9/MNiL2AWkrZCDCQVlyvRmAPn1sJ4jgnmoRTJlPISCsQEe9eeLoIZGUSbxYEW
         OQRLRbrrEFn6jS/IIvO4GE02egOz6aFNlk+QyYm+QkWAP7ETaVKx65Y9ahuutZ5yj6
         s+k+djMhH6IbfT6n3C0sfrpgah04rNWTh0pmxzoXeGwy55xu2cQ6ZCHsTfEU/ij5pN
         kzpaTmeUjvJ29PFAncIm0P4H9UMRabQZR6POxAK1hsQWOozBSg7c7QPUAjv0lEfiV0
         wj5a/oI/IIX1Qehx3JE+TbSPKXDhS20frkeySg1/YHZXUcM33TGeOw1sKZzkmf+igW
         iRmd+OyjXQhlA==
Date:   Thu, 8 Sep 2022 15:35:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Astrid Rost <astrid.rost@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@axis.com,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound: ts3a227e: add control of debounce
 times
Message-ID: <Yxn9o1MVMPnFO3PM@sirena.org.uk>
References: <20220907135827.16209-1-astrid.rost@axis.com>
 <2b81d814-f47a-e548-83dc-b1e38857e8ce@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EM1t5E+8UNLJ5GtZ"
Content-Disposition: inline
In-Reply-To: <2b81d814-f47a-e548-83dc-b1e38857e8ce@linaro.org>
X-Cookie: Metermaids eat their young.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EM1t5E+8UNLJ5GtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 08, 2022 at 02:20:42PM +0200, Krzysztof Kozlowski wrote:

> Anyway new properties cannot be accepted. This has to be converted to DT
> schema (YAML).

Doing a whole binding conversion feels like a bit of a steep requirement
when people are just adding a simple property, it's a lot of stop energy
to figure out the tooling, do the conversion and deal with all the
bikeshedding that the tools don't catch.  It's definitely nice if people
want to look at that, for more complex binding changes it gets more
reasonable but for trivial properties it's disproportionate.

--EM1t5E+8UNLJ5GtZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMZ/aIACgkQJNaLcl1U
h9DbfAf/SjeLoEAMFhlUsKxoxGL1+jQv4Ma3wez0+Bs/BrWB8l3ltKTI8q2/mf79
OtmVsUbz7odAzUgR5Kim/NroXNhPrNSF54TPxCnnDNfYjpQ5lhpuZynnzC7t6MBB
kUWFp2bUcqTNkJdAm8LMQQ/V9E4Hhs4R3FnJj/rp5t4DhfKPRRQ655Euf2RuQLVo
c0zRwdfrEctvDWlXMDpSMmvnAOA6W+X7LHZNLq6mGpaplYC762+ZQ1oZanV+DpTc
FEWB53nfh0lrj+Khe2umbtQiADFitdIOQLZa60fkw9YQAM9zSYr9I4BekdeDVBBQ
czc028DwfmOyoAEm9lCr7Cr9NwZX1g==
=XuqR
-----END PGP SIGNATURE-----

--EM1t5E+8UNLJ5GtZ--
