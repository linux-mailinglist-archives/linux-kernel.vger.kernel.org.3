Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BAE5A950E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiIAKuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiIAKuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2E9558A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E63461927
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA7DC433D6;
        Thu,  1 Sep 2022 10:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662029398;
        bh=wKFMMfnuRIQQI7rqABKA55OwIWyE3Mwfmgae2/Kf0Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmCSJ4SGlev7lbJaeVzzrJnIjErt4gK17fzswIRtez7/ZLJxRCGYsUZqTTlHsBOYH
         Lj1iWOAuY6EIjMtCrUIfzFHyfrA3GPhDOeTZMzyJPtsXILxQ9dyRxDoR28RDhqn+Ul
         WUD3PLe29+V0eciJJbk8wjApGtRQmqsyy4eod7uJmU6jSescJMS9bctbA4W86Q2+MP
         rhs8wgwdvAwgGBdUUWh55XS5DrwoKPj8qs2F7553EzJaCSOQ09miYgZZvsDgnxXdzF
         WqxM8zCEMwbKqCc0jEsNWNrtfAIRdh5NF5qF7julVA23BSXqdNPdedsWIgEsSn9jTP
         79Cb/HyRXewZA==
Date:   Thu, 1 Sep 2022 11:49:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [broonie-sound:for-6.1 66/75] ERROR: modpost:
 "slim_stream_prepare" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
Message-ID: <YxCOUjE9jTQQS98u@sirena.org.uk>
References: <202209011500.c78NSKsw-lkp@intel.com>
 <039bf8da-5f20-4395-eb37-d60d4a358b0a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O0LcY6628I6XRamR"
Content-Disposition: inline
In-Reply-To: <039bf8da-5f20-4395-eb37-d60d4a358b0a@linaro.org>
X-Cookie: This bag is recyclable.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O0LcY6628I6XRamR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 01, 2022 at 12:53:24PM +0300, Krzysztof Kozlowski wrote:
> On 01/09/2022 11:02, kernel test robot wrote:

> >>> ERROR: modpost: "of_slim_get_device" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!

> I guess Mark that finally proves your point that these devices are too
> coupled for compile test.

> I can fix it up... or maybe just drop these two commits?

Either works.

--O0LcY6628I6XRamR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQjlEACgkQJNaLcl1U
h9AW0Af/fRfBKFTbHVUGUbE6BR0HLD/KDc90q7yKgQTai092BP3HswRAfLvOTm71
OMkfhiwiSlxx534iG3rrvRGKLt4MuhllGNDymZyL9ewRHqiPJ/mNS/X2i4FC4xzq
M81Ks+C+ayvNpR9DDysLutZshxl5qU8QiaTfcT3y2ogORHmiOc+t0uCNcTg/x4d0
sSsYoSAhlS1jvxRIK4og5OnlhlVi7mpgVS3me8A2RK8yseIa4/7NG0UAIZgWVwXY
PTGwIK4l8jg8kK+1kTV63iP5gR8DmK0UUuGJSO6jwmjGq2ucFVQexGgNq2wTjW4o
Pkb3LedYQWVeq0pV7o4CvKdaBoqkpg==
=rrMH
-----END PGP SIGNATURE-----

--O0LcY6628I6XRamR--
