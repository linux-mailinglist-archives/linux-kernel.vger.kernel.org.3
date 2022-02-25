Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B34C4C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbiBYRh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiBYRh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:37:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302D1CDDD7;
        Fri, 25 Feb 2022 09:36:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C39BF61DCC;
        Fri, 25 Feb 2022 17:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAFBC340F3;
        Fri, 25 Feb 2022 17:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810613;
        bh=55H8QnkGyEAbQODvLLv1iG3nCue5egT78H9wUUdabyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMv88cuvWCQOH6mGcVBbEzK6DWIpYvK4DnMLDdnVesDTCJ2xSdl4tsjVtFy/3CPty
         NewkLpFWycLmp2VHz6m054taatL1WcaIq3TWBuuTqlDuL2aEtaHZwT9z4JTlTQPSGF
         UV+TWxc26verVUXZ/YOrSa2etLOLN+rh5npH/qFYu7cMK1ISTv7AJRzL4Dgx+9fh9E
         SkVvVGG8ppsncrUALjroOF9SkbeHtw5AvZifOEvMLF7xo7i3hOBBLg3ng/8IqiVBok
         0wTjksjdA7NMtHOo9CVIp80OuzcO2T/ffuInbagScXHCscJlU/oAkg+ehZr7mxn6ML
         hMadthx1UJPvw==
Date:   Fri, 25 Feb 2022 17:36:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Subject: Re: [PATCH v4 0/2] Add power domains support for digital macro codecs
Message-ID: <YhkTrflXM2aI1qOu@sirena.org.uk>
References: <1645786624-12311-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B9sA1yustykLxY/n"
Content-Disposition: inline
In-Reply-To: <1645786624-12311-1-git-send-email-quic_srivasam@quicinc.com>
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


--B9sA1yustykLxY/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 25, 2022 at 04:27:02PM +0530, Srinivasa Rao Mandadapu wrote:
> This patch set is to add power domains support for RX, TX and VA macros.

This conflicts with some of the other work going on with these drivers
which got merged, could you rebase please?

--B9sA1yustykLxY/n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIZE6wACgkQJNaLcl1U
h9CTQgf+LVtyrqYcATwwJ43HX06LqU+W1JD8UoZhseiY/fovF4Sg5mRvGyw6pp7T
es9X9DBynLKonb4b3h/hDFxbWkrvhXby2zJvQuWLe7qGajh0lMdXFGClAk0spXV/
dxhBuQfeoQCeX6SdOTa81+7HSjfWADnMNQZuBe7Qr3RXPhtxAuBdWREzua9U3364
cvzHZldWHYRVSrQkHMmDGYcf+iD09/aoix8KsnsHGt0c3sNtUcttViYYUyaZHK8n
+NfT87FeTRKupxuwxrrlBGaP4F015+VX3AwIcSRxu6fLr2D8Iko4oc/M+HJQhXcN
lSn+Mhv7UFP4TFzJaR/0Jx1obJ8iAw==
=JP8I
-----END PGP SIGNATURE-----

--B9sA1yustykLxY/n--
