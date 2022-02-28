Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8114C6E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiB1Nll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiB1Nli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:41:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAAA7CDC0;
        Mon, 28 Feb 2022 05:40:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A27E61387;
        Mon, 28 Feb 2022 13:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6611C340E7;
        Mon, 28 Feb 2022 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646055658;
        bh=VA89CeUxKMxAiD5e2iQqCNZGN2aSPDh90kmOOEXOGeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHR0qat24ix1x9tEH+Xc54AYjZuVSLKMiH/fflbfGvXMcG4DuAJiJARPGOtP3uZmr
         nCOuHHKREe40joEkERig1pzZRh7TKEX+qYLCHKlFZgkxqZ//zt0btI4DoDz0FCyT+Y
         HgFSPe2B2L3ZnD4XIwUs7A2eikHWYoNGLY0ftWsKU16HuxdnFB2mIIJlkXNktBDnlj
         +Kb6d+FD9xdbyS01jj/745en/anIT2Db2f3xGt17lpo07A7H/JLTtGCd39/xRfQaV9
         YcApXpvsLLfBmrOGx/JYvoiMuYzyHfhDQTHsUVR504n/qfmV5r+3gvL9F9F8Ij6Suw
         edMkZS3/bGR/A==
Date:   Mon, 28 Feb 2022 13:40:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: soundwire: Add support for controlling audio
 CGCR from HLOS
Message-ID: <YhzQ40svWd/ytyHE@sirena.org.uk>
References: <1646035750-25635-1-git-send-email-quic_srivasam@quicinc.com>
 <YhzMeoNW7/OUJrMa@sirena.org.uk>
 <2de96a40-82c1-7ff2-a293-295267058fd3@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UMh4YcLiIRHdmZcN"
Content-Disposition: inline
In-Reply-To: <2de96a40-82c1-7ff2-a293-295267058fd3@quicinc.com>
X-Cookie: Killing turkeys causes winter.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UMh4YcLiIRHdmZcN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 28, 2022 at 06:57:55PM +0530, Srinivasa Rao Mandadapu wrote:

> DT binding included in another patch which was sent recently. As this pat=
ch
> depends on clock driver patches didn't=A0 mention the below dependence.

> https://patchwork.kernel.org/project/alsa-devel/list/?series=3D618579

This is all getting far too messy and complicated - you're sending lots
of different versions of multiple patch serieses with various
interdependencies and conflicts some of which you're forgetting to
mention and some of which are against things that haven't even been
posted yet.  Please slow down a bit here, take a bit more care and try
to rate limit the amount of stuff you're sending out at once.  It'll
make things a lot easier to manage and probably take less time and
effort overall.

--UMh4YcLiIRHdmZcN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIc0OIACgkQJNaLcl1U
h9D40Af+KP9WixHc82GfzMRI8RejCkjKeOju9FcCVKIAq9u9tzYSpuGab/lbjtK4
Q98w68/Z3JqC1kzSw3WwR+fOy0DO0A7t+Skapwqc4WutGEFET4Z4SAeHZU9peiEV
Hb/5pQtHVLhLEtnNdQKGJI6sojkbUiXZDDISeMEHsdjXiOikcxPfT13pgxLceC8a
teDHRU530pcTiAIKNxdUu9NWTRNNQNd6Pe6FP+OIfngnCYqLgwlrt9wIHAUgYhWA
uxDMFfdWTXBBbL5Uoc0B+c6jmaROn0O9XBMVnRBe4PUZ/k8rZtx6vS/snRKYyr/+
ZQhj0ptzrE1kN9uoP6d3f8svSHp3tQ==
=DeDG
-----END PGP SIGNATURE-----

--UMh4YcLiIRHdmZcN--
