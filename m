Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B810E49CACB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiAZN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:29:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45388 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiAZN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:29:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC65D60F39
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82922C340E3;
        Wed, 26 Jan 2022 13:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643203767;
        bh=mT467lBcrkRN4C1rEJBsO2WswZT4g34rFOdg2XuL/QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POt3supP7bahwATNplivNqDPiUs/ZuZkvO418KhR8QTMp38J2I3KXes17ltjd6ufX
         WqVxgLVzkRrL4izM2zOqqcsgvZqeYva61AteYLR71Tzv5Lj92lpJNZgM9Bsb7jhYo+
         whiOgnS4ldS47IkmfYqbOAOXKcH7HAiLl4qNpW380c7Chp1uwle9Yb4vJZLy2tJDmw
         GSF+AaKhn6El/64oCIZOCVKLkWv4INpmunw0t0csAajvtaTuLTlrunV0yUcyM6xbtz
         kjlwBDvpTjCbg9ww5P496scGrRwjtPxP3ANwjiny4pPMCgAY645OaOaQ/cM5F/RLjv
         LDRI5zSLCLtlw==
Date:   Wed, 26 Jan 2022 13:29:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
Subject: Re: [PATCH 0/4] ASoC: qcom: fixes for Qualcomm codecs and q6apm
Message-ID: <YfFMsvoqrJLbw28Q@sirena.org.uk>
References: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="laBfigsUZbIoY+DU"
Content-Disposition: inline
In-Reply-To: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
X-Cookie: Use only in a well-ventilated area.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--laBfigsUZbIoY+DU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 26, 2022 at 11:35:45AM +0000, Srinivas Kandagatla wrote:

> Some recent testing found few issues with wcd938x and lpass-tx codec drivers.
> WCD938x was accessing array out of boundaries resulting in corruption and
> system crashes along with not handling kcontrol put return values correctly
> and rx-macro had incorrect sidetone registers offsets. One final fix in q6apm
> to add a check if graph started before stopping it.

You probably want to run the new mixer kselftest on these devices,
including with the patch I posted the other day testing out of bounds
writes.  It doesn't cover change notifications yet, you might want to
set up some automation for that for whenever someone gets round to
adding coverage.

--laBfigsUZbIoY+DU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHxTLEACgkQJNaLcl1U
h9A24Qf7BSQjv9pYcwSdLpOiHP11HMd2IlRIWbcDJy4eIix5+yG1DfVCcVSCkKqd
XPzTl/dv9Iam0MY4gIRFLq6yk0ZPU3VZwGpUm4f31FHnhm0ChLscUesrSKFhmBGi
O7ffonEWdZyx90ROp6QdQMt1Qbn6S9TsxZWIarmslMb4uzjlx+w5QO+sPA5qpvXD
JDpyl3/0qpzPvNtRCpYJd6APUD2VZFWIg2uYDbhnN7l+ctGmXH+VZK52aC/XR+It
CWBDK5d8y3DG9qtG+dYpja22pgVgQhCG/PXeT3UhNYKnJ8y4NC4VotmQY2qFu/AS
A5ida18UnF5VaQ1OFimDJDWNAepAZQ==
=4is7
-----END PGP SIGNATURE-----

--laBfigsUZbIoY+DU--
