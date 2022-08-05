Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1258AA7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbiHEMFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiHEMFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:05:43 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB53014028;
        Fri,  5 Aug 2022 05:05:41 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2D3281C0012; Fri,  5 Aug 2022 14:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659701140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cGB3l2vpUQ92DZgzQnHLrZK2T/Rz9oYZhaGPqQeYE8Q=;
        b=R3QJfuhLWDHrLc9VR8xDAUi27xsaR91EnhtLqCSrgGMcPpXw9KdQKG4EWp9Pj33u+7dX3F
        8kal8zQYK7LrjKKdtPwk2uIdbhYd5Z/MSasBTQ+o7SSeOU6o4NWQJ/JH13UKUsw1RHN9tm
        SG+vvaKNlvMVOtKxjJwAboTNl9o4nSY=
Date:   Fri, 5 Aug 2022 14:05:39 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] asus-wmi: Add support for RGB keyboards
Message-ID: <20220805120539.GA20036@duo.ucw.cz>
References: <20220805081909.10962-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20220805081909.10962-1-luke@ljones.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is a patch series to add RGB support for ASUS laptops.
> The laptops with this RGB tend to be the TUF series of gamer laptops.
>=20
> The first step is initial bringup of support using the multicolor LED API.
>=20
> These types of keyboards implement a slightly more complex interface than
> just RGB control however - they also have modes with can be static LED,
> blinking, rainbow, color cycles, and more. They also have some custom
> animations that can play depending on device state, such as suspended
> playing a fancy colour cycle, or playing a "wave" animation.
>=20
> Two of the patches add support for these features.

Please Cc: LED maintainers with LED patches.

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYu0HkwAKCRAw5/Bqldv6
8opGAJ0TmIgkoEvGmOxk6rWAkBNDhkblWACfbt1YUqtNTsrNobNQ3roJ+b2dS58=
=B1AL
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
