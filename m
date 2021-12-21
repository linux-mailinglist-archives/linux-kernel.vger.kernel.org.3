Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BAE47C5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbhLUSJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbhLUSJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:09:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853A4C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:09:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 171C2616ED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4115DC36AEA;
        Tue, 21 Dec 2021 18:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640110164;
        bh=mE1Y2QnGMqwCGUQOY/F5U66oqxEWb7Isr36SaoqyxXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVDPl0y9ItMNxgfSKev+eFhe6gpS6z4pvW6lR9CqOkeW2GIKBzlxsuppW+IYawfd4
         O3/zO8TZAnDQu18GnSXbYlcWvk+bE9pukQ8F5DTCqWHxyVt+V9INqEyAT0GrJ7CtA4
         MSMKLCGhlhR3PwOyVqDMNEugRrQY1+MSL361uX3hBZ0Sv7cYaISxdtreTERAbGT5Bi
         X26Rtat2oU4BZnKu/SkmYl38DRqObVNeo5Qv9S31CE5XX6K2MKKcXV46iDYKdYfoTJ
         a9lfFXxp7e1F4ikRl/1v8qBdPLHaQBKX8Y1cX4nvFCuYFzACh+/a7oAVFry7itt5pJ
         kgMlz58vh0kag==
Date:   Tue, 21 Dec 2021 18:09:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 0/7] ASoC/SoundWire: improve suspend flows and use
 set_stream() instead of set_tdm_slots() for HDAudio
Message-ID: <YcIYT57YLpHR1+9A@sirena.org.uk>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jpNuGnQnWByU2nxH"
Content-Disposition: inline
In-Reply-To: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
X-Cookie: knowledge, n.:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jpNuGnQnWByU2nxH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 13, 2021 at 01:46:27PM +0800, Bard Liao wrote:

> The topics are independent but the changes are dependent. So please
> allow me to send them in one series.

What's the plan for getting these merged?  Looks like they're mainly
ASoC changes?

--jpNuGnQnWByU2nxH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHCGE4ACgkQJNaLcl1U
h9BcbAf7BO1nVJqZQ/uFs5ullpcNtIFVdkEaywvlbx547ARaOGph8bkObOP6RD6m
2ohdCpX1ZoetJeQ+PK37HR7SOMD/cRyd71kGI3DYG48b/FFckzm0JrVFIB6a3QYG
h8keelfWZsgp+byhIZrk1AQ9hYco3TUw65R1V1JpgpF9u46cl/ylcf5CcXqu/rV8
2+vuK6ReAbWt91LJiIimvqhd5ti4dOuq6QoMU5nwfCxSrUeTK7DjQ++lxE9N90RS
Fx6llzEgkQ50NTTd2Vzkj3cgnuO98wKVldPSG6pYeLtbJgxp+V00M6dBw5/q54wH
Xh4pjVYATviMV0596xPysypI9pbplg==
=vLY7
-----END PGP SIGNATURE-----

--jpNuGnQnWByU2nxH--
