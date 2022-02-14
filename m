Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90C4B55FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356351AbiBNQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:22:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiBNQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:22:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7989BC31;
        Mon, 14 Feb 2022 08:21:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26C5EB811DA;
        Mon, 14 Feb 2022 16:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A90C340E9;
        Mon, 14 Feb 2022 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644855713;
        bh=qEwq4Wh/5idQ4A2e+iKpPVSvtXQzvCrJ5eNIEXQ4q94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGlivWF52HwgMNQ80euf2rG0krx0swohHpXt/fikP7GtRmSM9p2qQWlh4ySIHpQWI
         M9NY94I6KPxgqyMXnPC1ga2oxdKEDmnzClX6/wQdTDdNQJLqFnp3zrY5/hROTew0f8
         8Lrm3FCC9zxJrAUMKTNqpuEE/K7DXStHKcULFjvgQGeDIHi5SJ/KfNfUUpSBGwoIsi
         C3Sfh4Y1XtZhUpnoGHgi0hlRgNWyWHPSwSqA/mexLkaUjBKxVI8pSKp546r1qlIotm
         Zx2L+7EnAiqHwSHuBRciD9y3q6hAz/LF8n0LaIH4ewbuucOtoBHEhg4zWvkG5uJdtc
         RO1YKv0Q925Tg==
Date:   Mon, 14 Feb 2022 16:21:46 +0000
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
Subject: Re: [PATCH v13 07/10] ASoC: qcom: Add support for codec dma driver
Message-ID: <YgqBmvAQvh9WRMj+@sirena.org.uk>
References: <1644832778-16064-1-git-send-email-quic_srivasam@quicinc.com>
 <1644832778-16064-2-git-send-email-quic_srivasam@quicinc.com>
 <YgppMcVjs0KuE5y8@sirena.org.uk>
 <669f2d39-8c14-68b9-6d89-a26e0e2e8857@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BgkULJaiFKZhJKvr"
Content-Disposition: inline
In-Reply-To: <669f2d39-8c14-68b9-6d89-a26e0e2e8857@quicinc.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BgkULJaiFKZhJKvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 14, 2022 at 08:10:20PM +0530, Srinivasa Rao Mandadapu wrote:
> On 2/14/2022 8:07 PM, Mark Brown wrote:

> > I only have this patch from both v12 and v13, which were sent very close
> > together.  Please check what's going on here.

> As only one patch has update, so sent only one patch. will do resend all
> patches if needed.

You should always send all patches in a series, sending only some
patches at best makes it very difficult to follow what the current
version of the series is intended to look like.

--BgkULJaiFKZhJKvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKgZoACgkQJNaLcl1U
h9BvMgf9FGQNXpy24DbHrBE271iFyFSYKquxP9pmvVBT6VapB9cXZsV8RFzyOWdY
67DkWKvbsS3CckRTRXsHc2byeDyD4knoyxOYSK8Igg6hcMdliSi6whxE2C9Qj4Ew
n5CimQJf7QkHVQQ+BodS6iqEalUyhU+pa8J54bdmXFikzd0Qi9nprpc6uhjaeS9A
3QewvdNGEz5dtUxLdClpef/2WCuGF8qY/iGNxleotra7EgTqGg2njfvrPflDQN0L
XEk/287Y2NOp8SMJVJWBdIBDWoEQ0CM5mLraYn8cyjg73J69E5Ss9P7SwoUZpq7o
64XObDdLEYmLdbb6/xB8pHwtRMMwOQ==
=Edqc
-----END PGP SIGNATURE-----

--BgkULJaiFKZhJKvr--
