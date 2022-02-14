Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910B94B5373
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344075AbiBNOhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:37:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355221AbiBNOhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:37:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43CB488B3;
        Mon, 14 Feb 2022 06:37:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 698D5B80EB5;
        Mon, 14 Feb 2022 14:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7992DC340EE;
        Mon, 14 Feb 2022 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644849464;
        bh=7uGTSlji43xblW8vzuNtXrxrIzg7u5IZDnAHQMRFfy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuBxlbtWemgT9gDaejkAssU7jfN57PVaadz8VR1/p+T1VR2mPKt5001xMXDQWXDoC
         db4C2ADVZuMy61WeD1Ur7v6j88sJfYbDQrnv9jfxFCJYbDKpaPIhXBOrg9c6bUyS2q
         3aDzA/Fg9T+sKtdugn5mCUFPNQeEAUNpgVuMOavckr1EZ6cWAigtfRA9JZuFbrDNHI
         HnivbFqYa4cAnV1y78PtHfeXOfcOdYwPiaxjsz3Nddk96zPbgoBRT1vKNf19fT/Gs2
         2qzj/VHdDYD/7LNt1az7uqKiKvDqeNVfKhtgxzAU2V2hZKLqXfo0WDiXE9mNNPyMro
         a2O+CQ4kijoUw==
Date:   Mon, 14 Feb 2022 14:37:37 +0000
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
Message-ID: <YgppMcVjs0KuE5y8@sirena.org.uk>
References: <1644832778-16064-1-git-send-email-quic_srivasam@quicinc.com>
 <1644832778-16064-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ENCpgcVgsVe4ho/f"
Content-Disposition: inline
In-Reply-To: <1644832778-16064-2-git-send-email-quic_srivasam@quicinc.com>
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


--ENCpgcVgsVe4ho/f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 14, 2022 at 03:29:38PM +0530, Srinivasa Rao Mandadapu wrote:
> Upadate lpass cpu and platform driver to support audio over codec dma
> in ADSP bypass use case.

I only have this patch from both v12 and v13, which were sent very close
together.  Please check what's going on here.

--ENCpgcVgsVe4ho/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKaTAACgkQJNaLcl1U
h9Cwdwf8CJGx4PtC4wR4ufOx84pwuwbbYynp2DcpVJFjC76NcVBhaEqx19667vck
WsmU8Jp4CNLYKBy05Vg4iKOpEH55eT28aHvN0AmgM3UiYylekQz2Z2gj+4LJ83bS
KFdPwNtMOsAO0sqmvhm3UZTw5kN7vGvyTzUkox1IXyLe+xRvaEDvX6gOYsjPwXo9
v8K/ibp00fXbkeLM7XhPMqfOYUtincOOFKv2naoBer3Uw24NO2xcXV3TYFg7lsNo
Fsc0Z1xxrwkEqBWNm1zT3X3i0hc2ElKbqZvF0GkMVoqPEFH0dGUw4Bfb+EaLyAM6
YtCrzLveyRc73XEAOFVPoz6S4aq+Hg==
=8TpA
-----END PGP SIGNATURE-----

--ENCpgcVgsVe4ho/f--
