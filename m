Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6D0599A23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347790AbiHSKv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346527AbiHSKv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:51:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33956E2C7C;
        Fri, 19 Aug 2022 03:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E480AB8274C;
        Fri, 19 Aug 2022 10:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF97C433C1;
        Fri, 19 Aug 2022 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660906278;
        bh=nX+wpzz52PCLNX9F8IQQbzAoFFoiLltf9HzoZBUYRKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrJbrcLEcwKa9UR8OXzPh5NUxJ3JHEOlXPaY30ZTqwgKTOkhJvJQZ3/wIrP3/2Otw
         Ibn4wAf+ODS51XgCfrZtcvltxNQBrzB7+584wMm/dt1lnmSUrEgeALIGfuKsC+CeEZ
         Rth9ntgKmW1QDKOY++8xCRkaDue+ZRF+FEwpXYyNNwSiMn7qJTivpwdBSWtuKdXpA8
         gaobfr/+mpOLp+FVKkM6kvLT0oL7mVGqhqbf1uLVhHq9x2x13yi+oFSzC1nt8cp/fH
         Z23N1kvmBQ20Yq2xzSjUgjPU66ddzyTHmFArhHg4XLnUMpTjXVXAgy4cXlio1KIBfJ
         wthpsFbfG3Dmw==
Date:   Fri, 19 Aug 2022 11:51:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: qcom: sm8250: move some code to common
Message-ID: <Yv9rIGE+GNEzzizz@sirena.org.uk>
References: <20220818135817.10142-1-srinivas.kandagatla@linaro.org>
 <20220818135817.10142-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jrntzq7HWj3xMCPD"
Content-Disposition: inline
In-Reply-To: <20220818135817.10142-3-srinivas.kandagatla@linaro.org>
X-Cookie: Price does not include taxes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jrntzq7HWj3xMCPD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 18, 2022 at 02:58:16PM +0100, Srinivas Kandagatla wrote:

> +	}
> +	*stream_prepared  = true;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(qcom_snd_sdw_prepare);

The ASoC framework is all EXPORT_SYMBOL_GPL(), things that depend
directly on it should be too.

--jrntzq7HWj3xMCPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL/ax8ACgkQJNaLcl1U
h9Ax5gf8C1poXrMNlinxwQ+Bq6QSKD91O3BR4rTm8vj2gncSQp2y7+H4HY+T+tbP
WGLHZHiGtb+fVqRFr2zzATokVvbJ9ceQ8N0T4be7Ggjd3tLcJcuuXM26BUwr3u4N
0H6ocIUsZP7z949gOSW3V0d7CH6Z7gfBmVq9ytsXvyapjoMOlxPPc8OyL64NL/1o
HkfoKIq43c2gvF6AWK06VBmGv8vaw0Sxy5DPIVoHlBeK44xmYNV91s8LMw2VqYiB
nM2iNfQd4OC476R0bc+BG8NgJltT6j9c8KaaBh6tioASQmMm4uaMRoxAg1RhJcd/
UvE/Novy91JE54HT1FvQxA6vhFKPpg==
=HP4+
-----END PGP SIGNATURE-----

--jrntzq7HWj3xMCPD--
