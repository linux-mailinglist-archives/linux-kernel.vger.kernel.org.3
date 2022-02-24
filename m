Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4B54C2B83
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiBXMQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiBXMQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:16:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DD52325D3;
        Thu, 24 Feb 2022 04:15:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0E22B82189;
        Thu, 24 Feb 2022 12:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8962C340E9;
        Thu, 24 Feb 2022 12:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645704943;
        bh=9EYwuXUUNe4s56JSespRsmrf4WVo2K2M5a/Ux3TMvqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EO20dRI6IsJOnpEYkrjAoI8Gfmbt38X+lccQKIlTplkGD+mQ39K3JwP5YURGYwyM+
         bipJHv7pDLoOpYdsF9A4LJf5cwubCHeEtD8dGw9MLIL/sM9jfBbRKaide45qafv78J
         I/SqNA0SLapUbLI9tNOp8kmck8xHVZW+p/khy9R2ri5yuhICOVMl38CDiVBxib9tnL
         hyIM3Gguyjxmfx6/opYrxLAIw6xmGnYUUmy5Omjq4HQZU5zz3/LtVmORuo9g16IjSk
         dmLGWDPW6VmWy4Ldc7h0vDUlv1LPE1/nRhAwEt+LMWm9RKjoSQ/4Mbkbdt0JWxpjzh
         /aPqggDSVmVQQ==
Date:   Thu, 24 Feb 2022 12:15:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v15 6/10] ASoC: qcom: Add regmap config support for codec
 dma driver
Message-ID: <Yhd26Cbe6ecbiVYH@sirena.org.uk>
References: <1645630745-25051-1-git-send-email-quic_srivasam@quicinc.com>
 <1645630745-25051-7-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FvdNv5j3qU77ttYL"
Content-Disposition: inline
In-Reply-To: <1645630745-25051-7-git-send-email-quic_srivasam@quicinc.com>
X-Cookie: You will soon forget this.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FvdNv5j3qU77ttYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 23, 2022 at 09:09:01PM +0530, Srinivasa Rao Mandadapu wrote:
> Update regmap configuration for supporting headset playback and
> capture and DMIC capture using codec dma interface

This breaks an x86 allmodconfig build:

/mnt/kernel/sound/soc/qcom/lpass-cpu.c:976:29: error: 'lpass_va_regmap_config' defined but not used [-Werror=unused-variable]
  976 | static struct regmap_config lpass_va_regmap_config = {
      |                             ^~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/sound/soc/qcom/lpass-cpu.c:966:29: error: 'lpass_rxtx_regmap_config' defined but not used [-Werror=unused-variable]
  966 | static struct regmap_config lpass_rxtx_regmap_config = {
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~


--FvdNv5j3qU77ttYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIXdugACgkQJNaLcl1U
h9DUDAf+O6sb93bAoBGhzMwOIQTlMCUY6RbjN6tCvv7xqIeI3FKZu9UXYMvTvRqr
oozDPOY5L+qBqOgtN4YDhD5ocrIt7MD6P+vEiXxPZc7nSDJZiiu17gTIrQNAHkOJ
aiTh9Ur/Kabr3RogUR0sKm2XwLrsxBvHNpfBKG+0cKTCKCP2gcmbeA6W0AJJMesI
q+Nuh5wO0oOEA8gUyx3qAxS9JAunaHmTPrvlGx/wGoXyDJ3kx30ON/rMyrWIFCQp
ZOEJ4wqTVfc52iIHPI/GssqOwAQRuhNt/wLiAMcla4rIMS2JAu4xjUK2z1KGoyHH
f6iH6riNaGRSyCi2k2zz6Sfj9nXxeg==
=jFE4
-----END PGP SIGNATURE-----

--FvdNv5j3qU77ttYL--
