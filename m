Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC304C6E01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiB1NWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiB1NWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:22:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0EB79397;
        Mon, 28 Feb 2022 05:22:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD0A561331;
        Mon, 28 Feb 2022 13:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8BCC340E7;
        Mon, 28 Feb 2022 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646054529;
        bh=z8UlMYS9HM8W4/LUvFSvEhzPSuQv09Li2PxhJIdtSmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABw/SJbTYZkDTZYNynoLLjkBDE0rUMGhKDO17cEPPQgsWHHlpRIzeX3LU9Ut+tzWC
         /DRw7Ewhgdo1+rMNp3f2m+v3miQUA8KTgIpT1U47jHLTw6xT2Fi9+Vq7eor6JrttlN
         JJ5lBoxtPhwT9JoMm4i9iSug41Vkxfmw6pC5VETJP/BTifpknYd7dADDbRONgdLHwz
         7YVqR3tvjfSkEJkDGEGLGO9Fa+vLcapS8Gj6DSjrX5OJa2fLmT1u3Yss+BOS/GE8PS
         ssuxrvVE5FHVPt+BQ9Otaz9BxpZM78a5TGkgBAxnX6Fnb8yL8bdSDLjvWpS3esH9p3
         prxgA1Ykku92w==
Date:   Mon, 28 Feb 2022 13:22:02 +0000
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
Message-ID: <YhzMeoNW7/OUJrMa@sirena.org.uk>
References: <1646035750-25635-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kK4kZyJyOJ4RsEpU"
Content-Disposition: inline
In-Reply-To: <1646035750-25635-1-git-send-email-quic_srivasam@quicinc.com>
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


--kK4kZyJyOJ4RsEpU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 28, 2022 at 01:39:10PM +0530, Srinivasa Rao Mandadapu wrote:

> +	ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
> +	if (IS_ERR(ctrl->audio_cgcr))
> +		dev_err(dev, "Failed to get audio_cgcr reset required for soundwire-v1.6.0\n");

Doesn't this need a DT binding update?

--kK4kZyJyOJ4RsEpU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIczHkACgkQJNaLcl1U
h9B0DQf/eqHBl2NodP/t4MJrv+UXLGpLCOMpY5mt7kVV4OLYSXYUpD5r/sAB/NmG
Mrl9LHy1D/5nXyG0PiUtkjPMuJBlKJv5eaMV3dUDrXDF6oLot3eEDEpamF9pvPL8
8um8g/HemA7ztGH7HXY1Gi8U5TJmt1IhGC/Bll19zCSyZAA5eH/f6WZ5CNJz+TzL
5gSY0ye5Jsu1ybuQ3rMBs+KJW6+dR/6FeMFZUVY3KM5Dcu6IR25mx7wOcrw26XI/
PupAgyOgXtO2uGAbnYYadNXdL262odddF/+2nrYKkOHi0mGqgxhV27IJM+zTOM+n
/2jzjVSC6xmClBcZ44WRiI14PMP0JA==
=flDI
-----END PGP SIGNATURE-----

--kK4kZyJyOJ4RsEpU--
