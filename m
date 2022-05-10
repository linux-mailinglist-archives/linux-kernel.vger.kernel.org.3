Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA7652161F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbiEJNBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242097AbiEJNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BDC25C2B4;
        Tue, 10 May 2022 05:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B73D861426;
        Tue, 10 May 2022 12:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8CEC385A6;
        Tue, 10 May 2022 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652187420;
        bh=tvwLfOxXKndhTvGa084ydZQFrDEYjgjF9bSCciYJaJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9evE9ev47KHYn/HoEss5mWYpgA/f/Cj5sEt7Ex3l3ynlfTMHncK6GHH0NydIERkD
         bedBj+SaB+1/4BcVBkGWhL+HsxRG/eUAwz+U+ceYXtRhXU8hQGT+aq/wevqGqhWq5O
         zephFMntRvuaGMR0xoTzGtIHT02yvKwpqytDVdpAu0jykb7nJZTECsQYK3fiygxafO
         F4JB7xnHHTm1W/GNy7YgZV7IS1RPKoaLbfDWYRcHNZuXn2J5MqPVSeZ14OlMY92s5L
         MzF8Wvktd6GNnzu3pT0ZNPoppVfnhuBxJCjUWs4BJbM1LrMHUimUUDFDGcPciqCDVB
         BJGFHWsEcFXsQ==
Date:   Tue, 10 May 2022 13:56:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        matthias.bgg@gmail.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org
Subject: Re: [PATCH] Revert "serial: 8250_mtk: Make sure to select the right
 FEATURE_SEL"
Message-ID: <YnphFjs4E4EYafT4@sirena.org.uk>
References: <20220510122620.150342-1-angelogioacchino.delregno@collabora.com>
 <YnpeYGbo7JJK0lDk@sirena.org.uk>
 <b13b019f-f766-60df-3764-d375f64ea7d3@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DWrGk7+uHbpfpcFM"
Content-Disposition: inline
In-Reply-To: <b13b019f-f766-60df-3764-d375f64ea7d3@collabora.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DWrGk7+uHbpfpcFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 10, 2022 at 02:46:28PM +0200, AngeloGioacchino Del Regno wrote:

> Sorry for missing this tag, and also I'm sorry for the noise.

Hey, if nobody broke anything all this testing stuff wouldn't be worth
it!

--DWrGk7+uHbpfpcFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ6YRUACgkQJNaLcl1U
h9ChPAgAgjpz5OhurZbZHuhdBiMyrE29fnjE3J1/HD4uJY691mclFsX5//4n0HIb
jASN6LgjuO5TJczCcQCXSDSx3QmKdbwDX18iU9uetLryBPQVFzJvoJsSCzR0PSba
5e7AV9wpNsi/R26eIjjlJqDaPJKAdJu/Wb/gHh9/1VbkvD4LdczwLJ1lpNGmf7Ao
hxRfoJ5zun+rnnwcXCeyOgcH4ihu3w4RdzrB6bp6cSRO6Pvt/lvp4X6RFHlLU/R1
kzGHfS2je52R7tFENOvF+l4YVh/jKl7XdID1Vm4Pq2VtVA2va2zbO0FMZVno++Ig
7wQ4RpeO8ILo9rxR3Ra+LzAMDoNgZQ==
=VL44
-----END PGP SIGNATURE-----

--DWrGk7+uHbpfpcFM--
