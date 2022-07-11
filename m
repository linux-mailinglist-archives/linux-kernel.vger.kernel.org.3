Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE1C5707B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiGKP4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiGKP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:56:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB502A263
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91B61B81031
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D788C34115;
        Mon, 11 Jul 2022 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657554961;
        bh=8HV9yZZGFBJidulDHDzfWS4Ajwr3bhBQMRksoe8XUHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDIxfWkN7FUIOBu2c4cTc5keVGVoKO2v+NQgGOoloxL6OwZ0VNankrbwYB3yBk7pk
         TSFHe2oY+KK0YR7zfpizEhsXxn0wbAhNnNKmqyBCCaE8mncbW134UskBO4J8gmY/6L
         2xHvfMTI7f3VV2PQM3arYmPQrV2zsKU2Y0LZd2umyPXMPPtdw2DsjmkMF6xU63sj8g
         7djIbycrg4FC4RKZmUXtLnaeiOSHXpZh6p/Aoowqy+L41xsSyo1DNrwgEiWV/a52vO
         5dekxUddpSXcHrEvl6jwjgYqJ4nWHmo8xjwF3GJVAyIenm0zM1heexVSuuykMWNGKk
         AnxZ5mZxddM8A==
Date:   Mon, 11 Jul 2022 16:55:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, judyhsiao@chromium.org
Subject: Re: [PATCH] ASoC: rockchip: i2s: Fix NULL pointer dereference when
 pinctrl is not found
Message-ID: <YsxIDCaMf0Z0BnxH@sirena.org.uk>
References: <20220711130522.401551-1-alexandru.elisei@arm.com>
 <Yswkb6mvwUywOTLg@sirena.org.uk>
 <YswoOE/sP088lius@monolith.localdoman>
 <Ysw2mzhw4pyrxirc@sirena.org.uk>
 <Ysw+3Hg+GbDjXuTn@monolith.localdoman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tg1MdlMwJWKMRNAi"
Content-Disposition: inline
In-Reply-To: <Ysw+3Hg+GbDjXuTn@monolith.localdoman>
X-Cookie: I am NOMAD!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tg1MdlMwJWKMRNAi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 11, 2022 at 04:17:37PM +0100, Alexandru Elisei wrote:

> Do you want me to respin the patch with an abbreviated splat?

It's fine, just leave this one.

--tg1MdlMwJWKMRNAi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLMSAsACgkQJNaLcl1U
h9DfVAf3fsWaAiN9qpjwm1k+G3+bQFU/BeOTROHaL2wDeSqy50zlg6PJy+C8/DWW
FLEDtXUo/3Y+fuC9hjkEhpElWej3xK292MXE0d3gkc+pZe3FQzOYn6JTNvOeUS3u
MQIZKwXplY4jbXBYnDzt9JKl7Hc8ZdVYfngtQkOj/bJiU5IrqRQIrQpivaNi6Jpz
wRNdd01A/z5Rk09lWCQz6uTg8XxLpI8pxrL3BL6Q0TjA5J8rIp8ki5UMYhkcmi78
8tMo/IOyLGRLJCJij+wAilMpUZPIoAgexZhuSJlZyWyuHf0qWEFZSSK+z0g7Ybfn
KE6lm2sRo6syEO4ln0OneVdgv/9a
=vq9L
-----END PGP SIGNATURE-----

--tg1MdlMwJWKMRNAi--
