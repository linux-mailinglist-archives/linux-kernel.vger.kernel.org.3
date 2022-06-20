Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EAD5522CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243267AbiFTRjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243005AbiFTRi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:38:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766BBB1C8;
        Mon, 20 Jun 2022 10:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35B13B812AA;
        Mon, 20 Jun 2022 17:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FF1C3411B;
        Mon, 20 Jun 2022 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655746734;
        bh=jCwwSbElt83m1PQ7z2IHVu8qIm0sTyIZfWwdyaDXEQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2q2bkioPo6HKogBWHFyliQxaUyYq4YadB4+we/O/kmjDp2ubf8jEByZzv2C1QZeg
         hrO8b1Tzg74CpGc68N9s8iDq6ieZyCQT1QkyAMjcBQZ4Y3DAKcu7akqiN6I+fn/U86
         NTHNCRCwRQwl8V9dLT2oQ0VoUib8vhdriDganxqrsl10KvsvypFY4QO1+j1AurQ62U
         56raSyAcpfFlQk4E7TbEJSGMydpmzHHI68czU4V/IoOWkyuupgdgnBVNShYSda2idy
         Gqum8+7O+1hv8lzELpb3UQQ+2fMw9sWBn0h5KgZEnHECBVoIldbeAxre/5y3xmJKUu
         OrcId64AICnaw==
Date:   Mon, 20 Jun 2022 18:38:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     Alifer Willians de Moraes <alifer.m@variscite.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8904: add DMIC support
Message-ID: <YrCwqKeHQJe/Tzzi@sirena.org.uk>
References: <AM6PR08MB437600972B26E3A56E1190C0FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fom1qi4IkRF41iWN"
Content-Disposition: inline
In-Reply-To: <AM6PR08MB437600972B26E3A56E1190C0FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
X-Cookie: Good day to avoid cops.  Crawl to work.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fom1qi4IkRF41iWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 20, 2022 at 03:30:45PM +0000, Pierluigi Passaro wrote:

> Just for my understanding, are you suggesting to set a device tree property to force a fixed behavior in the driver ?

Yes.

> WM8904 allows using both a DMIC and LINEIN, switching between one or the other and this is how we currently use it.
> Why the user should not be allowed to switch between DMIC and LINEIN ?

The device shares pins between the line inputs and the DMIC inputs so at
least some of the configuration is going to be determinted at system
design time, that will fix the usable values of at least one of the
controls which ought to be reflected in the runtime behaviour.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--fom1qi4IkRF41iWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKwsKcACgkQJNaLcl1U
h9CUdwf+JtglBbVYwWNdDwBJD3f6LDH+Nl/J2ZnnHyJ6UdOmqtk7L+sj0nDb4Q/U
2syrbcHJ/dHoJMRrdT/UXGhbeWCeZ4eQIbkY8hR8cRZQUteNZI73B9ccXbhMDAhf
GHiJAE4dQWqj0ziFIGLbR9uhsOL26AYd65dgKRDOnSvA1kyWM6f+UwvGH3Xs2Rfd
I8Ni+NwD2VBKJCzINFsEFqecPl7885vtD95jTnqu2eeDysBbEQ/Iuyh8h2G407gv
gSy6lMRRQUAHu8lX5vOOWKgAXi/5rv9jy+gI89b8iehRkMreEZ78kBHtIU6FnCMf
RPkRUcBSL7sTTTErsDGRhSUDVJmYBw==
=1FAH
-----END PGP SIGNATURE-----

--fom1qi4IkRF41iWN--
