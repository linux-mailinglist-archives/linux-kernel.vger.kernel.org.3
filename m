Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A16A4AF622
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiBIQKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiBIQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:10:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87963C05CB82;
        Wed,  9 Feb 2022 08:10:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2313D61727;
        Wed,  9 Feb 2022 16:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ECBC340F0;
        Wed,  9 Feb 2022 16:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423002;
        bh=5nzAqPwBH84omUc0AIW6FL5cJDjIdsWfCrgfze7zbUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mi9s8rv/4/h4NILE2YwLOY9uaVZjrV7XIrlRDngQlVJ7PP8zztsrvKeksKgwMdIxi
         XE+NAHH2dQI7oZtjIo3EmI3uHpUBE0JyDtAXp3V8io98yD+wo6EQMiChd36x3Di5L5
         rKGoluQXbh4syjYu4l1IWz1tqrivRrVf+D37Hqu6Y0b5gmkfr6CEUixYGxt+uPxtyu
         9SWi5tlcaioi7/pXU9JTvOw2zrO3mY+lm4t/54+BdfDMsYcTaqu2oNgsciAuijQMA7
         JSFOsywDOtZ0pu/k8f2M26fHtWDD67QXzpzenGnBDQ+Ia0oyCDyU1xO2PM6UCNjQkB
         vYIqy7cO7o+MA==
Date:   Wed, 9 Feb 2022 16:09:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Subject: Re: [RESEND v8 3/3] ASoC: qcom: SC7280: Add machine driver
Message-ID: <YgPnU5FyBCoRbeJn@sirena.org.uk>
References: <1644413181-26358-1-git-send-email-quic_srivasam@quicinc.com>
 <1644413181-26358-4-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g65DA8fS0KcKTr33"
Content-Disposition: inline
In-Reply-To: <1644413181-26358-4-git-send-email-quic_srivasam@quicinc.com>
X-Cookie: Disc space -- the final frontier!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g65DA8fS0KcKTr33
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 09, 2022 at 06:56:21PM +0530, Srinivasa Rao Mandadapu wrote:
> Add new machine driver to register sound card on sc7280 based targets and
> do the required configuration for lpass cpu dai and external codecs
> connected over MI2S and soundwire interfaces.
> Add support for audio jack detection, soundwire init and MBHC.

This breaks an x86 allmodconfig build:

/mnt/kernel/sound/soc/qcom/sc7280.c: In function 'sc7280_snd_hw_params':
/mnt/kernel/sound/soc/qcom/sc7280.c:151:15: error: implicit declaration of function 'snd_soc_dai_get_sdw_stream'; did you mean 'snd_soc_dai_get_pcm_stream'? [-Werror=implicit-function-declaration]
  151 |    sruntime = snd_soc_dai_get_sdw_stream(codec_dai, substream->stream);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |               snd_soc_dai_get_pcm_stream
/mnt/kernel/sound/soc/qcom/sc7280.c:151:13: error: assignment to 'struct sdw_stream_runtime *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  151 |    sruntime = snd_soc_dai_get_sdw_stream(codec_dai, substream->stream);
      |             ^

--g65DA8fS0KcKTr33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmID51MACgkQJNaLcl1U
h9DS4gf+L0cOXgst1DdnBnb2JFSFrCKPgpHBMo8eofDL6SXXGaIUcPLNvzLc8uBy
X7Z6cYbejzsLGdX+HfOoInYVNP+WBxT/3pAzDpcE6L1m1mAsDYGjDuR4//WPdyLB
e3nBRZhE7rWi0p+3mvck4FKdNcMyweg2gh+fhuUU66JVjw2/fffnKK6/GJ1xRDEL
ETO4wFphMMd5qO+S12Z0V5NM/OsUEsANCbVCBPAmhnse9KBOm8BLHVXzd/du9fbM
mA15l7zrGMpJ9u+KkNSsUJAtfFuC8dmz2YPqWlsylvN+Aw2ut53O3MKay7o3bRT9
JOBRMZAbW4EfADIyZEo64LutfFiAOg==
=PdJe
-----END PGP SIGNATURE-----

--g65DA8fS0KcKTr33--
