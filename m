Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5355B4D0415
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiCGQ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbiCGQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:26:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48B591AC4;
        Mon,  7 Mar 2022 08:25:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7798EB81632;
        Mon,  7 Mar 2022 16:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3A6C340E9;
        Mon,  7 Mar 2022 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646670354;
        bh=KpKI6qgGwDUwwLWxU1qaL2a44GAcKr4iZtGWpWGYJMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CpH6ITx2pU0aJmp+sjZpLmce+nHz3VuHJ4vSd0yJFz7JN+yIbVvVTI7mMZvpazB5y
         2DOmmBplhkuHluzAoQQVGK80dcizAl8vdKoeCwXw0WWpv1gcLOMcmUPPbJ5d9wqrIW
         ChgohkIkSD0DTszRgc6XGXAml/QmqQzK1OyvxxWp4cp0uh/i1+gA4wCMKF1P1NuPzQ
         2PhwsFeOPqcimMgw4z2RtTFONcCdp/oTfAp/Ep9u7MuwyOY23p1Zl8V6kk6eXp9lTE
         eyLob+D7IiUflZ4KBqoYAcDIERFu5MljuYGci1vczIr08puMtYjO/OfhtvU1iJl7K9
         fVshh7WBcCxvA==
Date:   Mon, 7 Mar 2022 16:25:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alifer Moraes <alifer.m@variscite.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, eran.m@variscite.com,
        festevam@gmail.com, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com,
        patches@opensource.cirrus.com, perex@perex.cz,
        pierluigi.p@variscite.com, robh+dt@kernel.org,
        shengjiu.wang@gmail.com, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Re: [PATCH 4/4] ASoC: wm8904: add DMIC support
Message-ID: <YiYyC1MVd+oCMU4x@sirena.org.uk>
References: <20220307141041.27538-1-alifer.m@variscite.com>
 <20220307141041.27538-4-alifer.m@variscite.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1iwP804p5/iDUb1W"
Content-Disposition: inline
In-Reply-To: <20220307141041.27538-4-alifer.m@variscite.com>
X-Cookie: Whatever became of eternal truth?
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1iwP804p5/iDUb1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 07, 2022 at 11:10:41AM -0300, Alifer Moraes wrote:

> +static const char *cin_text[] = {
> +	"ADC", "DMIC"
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(cin_enum,
> +			    WM8904_DIGITAL_MICROPHONE_0, 12, cin_text);

Why would this be runtime selectable?  I'd expect the decision to use
an analogue or digital microphone to be made in the hardware design.

--1iwP804p5/iDUb1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmImMgoACgkQJNaLcl1U
h9CVtwf+Nl6A9aOjLebqzdwWyr4hAKLag1cq9s4w8/dqa2QzayNcPU+m11c7Pc+v
LCTqp1AlwYRMPznHYVXQbIP6Vy3rK6XHJpfU5vlib/7VUfOCE3Od3rmsD+1OtvDX
QYgjz3RZz1TgeQaKHk5O77GUIhmw1xRSQI+kxuUu2I6JKmETEkOkcvgbF6NyR1oN
NBtwQe7cJhJ1QHhB0PoNrB5cK6LIPlNgrxB6rqFsXyz1tOYN+/ObjvgJHsC9kCUc
vr3cIPI1Hy5lw3vEyFJuqnP0FKcO/CZjb4Wbk0ZFqTBDkBiqFLJTaFWLsRzngEk+
Nnu6Iq3gFIdDvBfmoAUHTBmB7dsKhw==
=Rd11
-----END PGP SIGNATURE-----

--1iwP804p5/iDUb1W--
