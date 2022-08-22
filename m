Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950E659CA5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiHVUu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiHVUux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:50:53 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6896C50040;
        Mon, 22 Aug 2022 13:50:51 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A3F7E1C0005; Mon, 22 Aug 2022 22:50:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1661201449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fZ/pgSVExMd0u5k55JxcceZ7T5/ac1VGYLI2Pl48nAw=;
        b=BjtHnrzjejjTBlfHYD7qko+43NbC0qN1C1K4S0mY7A24qVUxhC1tCg0mIqxqpEUrnPgVla
        srBaus38/LBTcnsHCLDzt12gsBpbBgyexLT6miJ+oRzX/rw1I+IX/k2JaQXXJYjwcuxFqI
        v7Jn4drq8K1FyUHs5S63KguG+ySahcg=
Date:   Mon, 22 Aug 2022 22:50:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        icenowy@aosc.xyz, martijn@brixit.nl,
        kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: Re: gc2145 camera driver (front camera on PinePhone)
Message-ID: <20220822205049.GA18272@duo.ucw.cz>
References: <20220822180531.GA27226@duo.ucw.cz>
 <20220822182058.xnpwfdjm7zmoid7y@core>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20220822182058.xnpwfdjm7zmoid7y@core>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I'd like to mainline support for gc2145 camera on pinephone. So far I
> > did trivial cleanups over the Megi's driver. I started with 5.15
> > version from Mobian.  I guess yaml description of the binding needs to
> > be provided, too? (Would someone have a good starting point here?)
> >=20
> > Any hints? Are there better starting points?
>=20
> Here's some reverse engineering work: https://xnux.eu/tablet-hacking/#017
> that went into it, that may be helpful.

Thanks for pointer. I was able to find register descriptions (etc) on
the web, but I assume you already know about these?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYwPsKQAKCRAw5/Bqldv6
8rDwAJ4gLtDlsznXiPxQoOv8TKYRJ6siuwCbBH6YrDQfUFBZ8FoTiPkbEnHrQps=
=2MYQ
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
