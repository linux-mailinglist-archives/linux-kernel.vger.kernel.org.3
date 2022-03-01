Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9284C8BF0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbiCAMrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiCAMrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:47:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EBC8D6AC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5202961161
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57318C340EE;
        Tue,  1 Mar 2022 12:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646138790;
        bh=nxk6HmZ+oziOwd4/ZlWqyk2FF1Rck5kB6obmq+t2JxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9qS1VryQH4aCd+igJlo2W9SYPDQ8QUQI/f9hD3h3KZ2yORYc+89/eeicK28W53GT
         3jyQIFNwIML/qzZyuT/hVubKT1RI5QbE7FHxNmNKWijHU0BAOW1w+NHBrGAb1rKMbP
         Fbn0dKC2HC1a6ZJw8EwBCs0THbU6o1ng5m93+CsJh6itVTdkmWQzPsH1GZO5SUKais
         3JPYgg1G/TBoEhSuBccwLTcSIrrzR6Zml+C/+sgTwJ737FJoJV1QTXB4v/whfXTvGh
         mHi+hTCgKqZ2YArogxUIwZ8qx5yA4VvMuaKArUf9iWy7B4b7ndeFuxvXyo+Rm62o6a
         ZKPAk2UNb15qQ==
Date:   Tue, 1 Mar 2022 12:46:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        codrin.ciubotariu@microchip.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: Handle errors for clk_enable
Message-ID: <Yh4VoWfDxUOBGRBg@sirena.org.uk>
References: <20220301090637.3776558-1-jiasheng@iscas.ac.cn>
 <Yh4BCPqPngcsvER1@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T6jZRfUnVsfwpi4G"
Content-Disposition: inline
In-Reply-To: <Yh4BCPqPngcsvER1@piout.net>
X-Cookie: You have a message from the operator.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T6jZRfUnVsfwpi4G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 01, 2022 at 12:18:32PM +0100, Alexandre Belloni wrote:
> On 01/03/2022 17:06:37+0800, Jiasheng Jiang wrote:
> > As the potential failure of the clk_enable(),
> > it should be better to check it and return error if fals.

> As I already replied to an earlier patch, this will never, ever fail,
> this patch doesn't fix anything.

OTOH it doesn't do too much harm to have the error checking and it means
people don't have to check if this is a case where it doesn't matter.

--T6jZRfUnVsfwpi4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIeFaAACgkQJNaLcl1U
h9A12gf/Z2ih09vgW44eyJevr+GSx5BKo89juYbnargXWju4kIefBm99v9d/V/iV
H72bbmH2hR1Ja5mbDlSKPvEnpQGknmuQl+CCcgMujjPOZ2xtnkriHaszCUkilvnq
sRswa4l2SYSXGAsz440VEgUA+QDAbObEn02uTqBv0Nf+kudu2WHqioSR6A75xlZ5
G3FTauzL+KDsFXhHQ36PydQUWb6W17kxYvvja/46qHvmNg2BejvbWCL/6T/j2myr
lnSc+4rw5jD6lB4ItVuUCS87enl5fqKkTZ7E4W5FciqpenCP7SGA8OsjuLSJ3roB
pRJmnX1i7THYcqMsjsjwAckc5MUE9g==
=s96X
-----END PGP SIGNATURE-----

--T6jZRfUnVsfwpi4G--
