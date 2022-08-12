Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D685910CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiHLMdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiHLMdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33FDAA4D2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA3661712
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D419C433C1;
        Fri, 12 Aug 2022 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660307614;
        bh=FUfc1TFo94swYywRR9ki3WQ1R4VUwdEZ+9NUnE3thjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4KOADSOuJUBf44A8BVVm9ZGOfi3J+RRo3RCr8qQQBV1gTQPgGscyjU+VsRWfko7x
         cOZwfNKqBcU4N/wYGexx3EPC+IPHBFpwKMNc3Qq6CI+4NJqt4g7Jy8u7mozZM/rUCk
         wxD/yvnyfxyRttL7D+ZUcvGc7fnff2WPSlomPe/1COUP5/6rCtzT7wcRt+pWv0q1z2
         GLGWHlHoRNfBymjNYt0BFbMclTHfymRnLj04KhNMbxpsQ/J4hx9gK1rJtMwgk1qPbg
         cdG+sshiD3X77prvAUPcBdnMkgaXdk5BjzqGMI8NVzB4Rt0ZWmMdruFr3rhayRtgu4
         YEwhJKQIV+Pdg==
Date:   Fri, 12 Aug 2022 13:33:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Syed Saba kareem <Syed.SabaKareem@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        mario.limonciello@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/13] ASoC: amd: add acp6.2 init/de-init functions
Message-ID: <YvZImUY5VUgnqNGk@sirena.org.uk>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-4-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B0pljCE077v7zEjS"
Content-Disposition: inline
In-Reply-To: <20220812120731.788052-4-Syed.SabaKareem@amd.com>
X-Cookie: No foreign coins.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B0pljCE077v7zEjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 12, 2022 at 05:37:21PM +0530, Syed Saba kareem wrote:

> +	/* power on */
> +	ret = acp62_power_on(acp_base);
> +	if (ret) {
> +		pr_err("ACP power on failed\n");
> +		return ret;
> +	}

It would be better if you passed the device in so messages like this
could be dev_err() rather than just pr_err().

--B0pljCE077v7zEjS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL2SJgACgkQJNaLcl1U
h9DlOQf9HdVqSnXnN96Td4SQOGqazW0R4j9ss0dhrbUPKYN9e/+jEcE184D1mqqi
v1xQCwSPhsHWIp0E6CcV7j7j6gZP9mN8S+IZbtlbCRX+OryIXtBnmqvQA74j4Eod
7H5+FsPWXNpni76NvzfFiEaNXTZZMGUb7jmjqJ78D1mWYju46F5yHpbFgilVvHkf
j343RbHp3Xj+iZBPcmapv8tVIInoLBYv2nqfpioycJG/WAIi1k5rLNDJ6C0TyhAw
q6LwW4vmo/jptfJsaWYNwI7mCZh992XmhlGctC7sUy1Uxe+iwAnDvIrM/AHkV2qW
XAei8F1c0rFanUkRCuzPEkVJtoNZvw==
=EBfU
-----END PGP SIGNATURE-----

--B0pljCE077v7zEjS--
