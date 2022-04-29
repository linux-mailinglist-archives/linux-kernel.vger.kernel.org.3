Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E246514F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378412AbiD2Pab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378410AbiD2PaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:30:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B603D4CBE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06299B835C2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692DBC385A7;
        Fri, 29 Apr 2022 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651246020;
        bh=SUnUZkDd73soW1N/ykAh7VePtc9efFucR1Xq+G0eU5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbTA3k5bfn8df0zXd/SKQiv7+X7ycY//ernj8FINdGhn05rho2YIOD3JzuU71v0Bt
         J1KOFH+E4HK7MeWBoE9dopA+fBRoMsu/2UaevqzHDyWHUDSPqqezBu0DQOJroIV58t
         55rqTScvewit8sEj7TmEvQJ30MwNkVEq5AgWLDtQHHmIbbInBhd6ifMnFNIYRbRoD1
         fSplyjgGngXK3Wc+MthBuI4374fl/9dXoxZcCfGW75VxdTjMBYQGS/WsxD8WHGlZ/2
         G6Y118jKFUrVsuQcN5dJKHmSJg39o6u1r4lETQ0VQk5kqi2Ma4I1YQshXLokSz6uN7
         Ny0HM2GvRaW3Q==
Date:   Fri, 29 Apr 2022 16:26:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: hdmi-codec: Add option for ELD bypass
Message-ID: <YmwDv7poot/5pcgb@sirena.org.uk>
References: <1651245218-47201-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VckDS60gwZWkzTBt"
Content-Disposition: inline
In-Reply-To: <1651245218-47201-1-git-send-email-sugar.zhang@rock-chips.com>
X-Cookie: Are you still an ALCOHOLIC?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VckDS60gwZWkzTBt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 29, 2022 at 11:13:38PM +0800, Sugar Zhang wrote:

> So, add this option to allow user to select the manual way
> to output audio as expected. such as multi-channels LPCM(7.1),
> or HBR bitstream for these sink devices.

Please check this with mixer-test, it'll help validate that you've got
the control interface correct.

>  		.info	= hdmi_eld_ctl_info,
>  		.get	= hdmi_eld_ctl_get,
>  	},
> +	HDMI_CODEC_ELD_BYPASS_DECL("ELD Bypass"),

This is a true/false value so the name should end with Switch.

--VckDS60gwZWkzTBt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJsA74ACgkQJNaLcl1U
h9C18gf+LZXgJ4+4HfVLJqBdrahLBTFQtsuI72+qv9apcg2Z9VuDucQ1ebjWg88P
QhVy+TURKh0fHgty//mJGg0FqQ8aUCpdT1o0Yv6zhSbJnv3hQ5VuVJKelB4XO3iw
s5jXHY3DxSlQ5Ihv1zRoGRUmAgSe/NVUP9rOjBowYnUkgyBPhlYu8QSpxi/5iaO7
Wojcd8otdpJBu7NGESF54g2zrcd2yIn+CT5qbWvCIWk6CFFSJN7oywIVbRX0VOjB
tsC+qqkEeWY/d//ndjHIGrIfuKPLyJl+Ic5mhzNrWuqo6wbNb24IAcpnVGVK1LZ/
PNvKi/+9bxQ1mDF3pPhT+sLDeEBNEA==
=BM0O
-----END PGP SIGNATURE-----

--VckDS60gwZWkzTBt--
