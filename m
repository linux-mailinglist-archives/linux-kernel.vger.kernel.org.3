Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB2F4C3629
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiBXTvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbiBXTvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:51:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDBF254558;
        Thu, 24 Feb 2022 11:50:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6050F61792;
        Thu, 24 Feb 2022 19:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50395C340E9;
        Thu, 24 Feb 2022 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645732234;
        bh=8xsZGWwjXv7cnRarGpQnyDw9mQoGNr7rSbI+e2asYPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+7+mnurlkrzPUi/r78FbvehdnSEeF8WqcKgku78MYtyKCxkVSejeIRIC9sguz6qK
         zzENdoFMyCuSXm/2Yaf8b/Z0FJ1w2qGpH/8QMjfsuxlKBqxb+HR/mvAi7ubSJaxCvY
         W1omnMVv2zxFweonRgjVOB7b3crbLsQqK+0CzXQ7V4P+J9CdRwTL4QdHHSMO+5V5md
         YC+QzPPKvrEfl7NZ5yW5r0nT0HXMqPRvbOup9e1oPooYS4BRwN0foSSwxFDaET/gyq
         Q/JfWSy23nth1KCMjEJY6gZWYqF86wfXVsSZz8WncIMCtzAnB5iltaAS0NF2vEnftA
         rDNV7dQIaBZpQ==
Date:   Thu, 24 Feb 2022 19:50:26 +0000
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
Subject: Re: [PATCH v3] ASoC: codecs: Add power domains support in digital
 macro codecs
Message-ID: <Yhfhgrvl38WcNOFu@sirena.org.uk>
References: <1645708759-8833-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7N28iCaW0tsV26lc"
Content-Disposition: inline
In-Reply-To: <1645708759-8833-1-git-send-email-quic_srivasam@quicinc.com>
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


--7N28iCaW0tsV26lc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 24, 2022 at 06:49:19PM +0530, Srinivasa Rao Mandadapu wrote:

> +	l_pds->macro_pd = dev_pm_domain_attach_by_name(dev, "macro");
> +	if (IS_ERR_OR_NULL(l_pds->macro_pd))
> +		return NULL;

Shouldn't there also be a DT binding update for the users?

--7N28iCaW0tsV26lc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIX4YIACgkQJNaLcl1U
h9Ar2gf+P1DXI3jrG/N8JSEhOsEnIRpZ3hzB1gV86SjrpMkT9QH9/z/RD5pyWp49
EC4g6Qdwatg7wK62yEeqfrXP0VgbP5she7silonyEFCznDycxQgBTy8p3Twn4OXq
nsaVoeEHQkvtKNaleckz7pgfDyNkLdM8HxiS/xldfVFGkpjq/whXEjOgQwGq2t/B
SPbvRiYnEZDIxBEOjJXtmi5wTQe1MsbG/1aOxz6SQDfVECf6drS6FUwW71Li+Ggv
Alv09mzQeaGRCDCSUlDSn2wR/UazmQ92TBngzBl17QKjLeiJ7BWQIKyCHG34vjvR
VAIXMWWSCKxwmkHShmvqZbHd9SzNYQ==
=qS1/
-----END PGP SIGNATURE-----

--7N28iCaW0tsV26lc--
