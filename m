Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00634C1A18
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243482AbiBWRpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbiBWRpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:45:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE3A41989;
        Wed, 23 Feb 2022 09:45:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 788E6B82120;
        Wed, 23 Feb 2022 17:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB1EC340EF;
        Wed, 23 Feb 2022 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645638310;
        bh=1r9SfSx7/nO9MV6j5ddvX/n3LarVOe+sjHrIT6ZK9fA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVBkCk7w/c4DZVbeBicjFjK5olhg87LsvDpdxtSV11yKd8ELyw4uWw3wLS20jFKte
         e1ME+a8aaC0c73K9bRmen1AFPBg0fpNUCoo2yjZDl8koygGXGGjdzJ56v+jkp5YleB
         NvFxzo3wkzF2vw0E2IexCTK4LZppG5bFOeM7zEuIza45c1+9SvBqPntPD1tAq4Xn3I
         wDpxUiloXysvO7piilxpfnjpbgRI3WiTO5wIAPTy11vUvs1wW1+X2AwzS6uNp98UxO
         AqvHyCUOf1nFyKrRUTwD9l/puj0h0dLVDVeBGw3coh3qOIK7cpY+00385iV4K8oGLw
         aZnVXv2GPdXJg==
Date:   Wed, 23 Feb 2022 17:45:02 +0000
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
Subject: Re: [PATCH v15 01/10] ASoC: qcom: SC7280: Update config for building
 codec dma drivers
Message-ID: <YhZynroGqrGZXeek@sirena.org.uk>
References: <1645630745-25051-1-git-send-email-quic_srivasam@quicinc.com>
 <1645630745-25051-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BgxGnRv0ITTKSGV7"
Content-Disposition: inline
In-Reply-To: <1645630745-25051-2-git-send-email-quic_srivasam@quicinc.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BgxGnRv0ITTKSGV7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 23, 2022 at 09:08:56PM +0530, Srinivasa Rao Mandadapu wrote:

> +snd-soc-lpass-cdc-dma-objs := lpass-cdc-dma.o
>  snd-soc-lpass-hdmi-objs := lpass-hdmi.o
>  snd-soc-lpass-platform-objs := lpass-platform.o
>  snd-soc-lpass-ipq806x-objs := lpass-ipq806x.o
>  snd-soc-lpass-apq8016-objs := lpass-apq8016.o
>  snd-soc-lpass-sc7180-objs := lpass-sc7180.o
> +snd-soc-lpass-sc7280-objs := lpass-sc7280.o

This will break the build given that neither of these source files are
present yet?

--BgxGnRv0ITTKSGV7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIWcp0ACgkQJNaLcl1U
h9CNAgf/fgT85WLXUxvPTW+bdBxpXXG4xGbT3a/xOpeZwtb9IGS8T8CEhrNyMMUy
M3Hugbmecjtc9uJkjidtB6gtcdDfSBdBndnS2a0GrbHUxF64xHsa5D/Af3zVVXzo
UgS4RSolole5NP1bZbCBLtp0PHiAqpEezwCNX46YPjtOyF+Z7Tq1hwJv6tI1DLda
t1lVDT3nN601EguQf/A0nzZXl7Iu0868+Eln49TGhVSHibUt3qE5w2kDSiElaWQ9
D8Dx/MhzXIAu7aQc9nsMHAa2xGX/7nEFdNmWMRFAT060DjaWFCAqvAade9y3HUGI
rSPDjjvk7U0+l+xqc9V/1Axp/NZSbg==
=LxWV
-----END PGP SIGNATURE-----

--BgxGnRv0ITTKSGV7--
