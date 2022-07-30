Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F67585C47
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 23:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiG3VWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 17:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiG3VWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 17:22:07 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103A513E23;
        Sat, 30 Jul 2022 14:22:07 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A17081C0001; Sat, 30 Jul 2022 23:22:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659216125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PpPSWaj5ChnWQref+Jd3xgvUVdo43Oncj2khKi1BPqU=;
        b=Wt1sV7o/E0jEIsZWhNKOiTpoa8+25ohZut7Gd+pYsN635CUhtOr611Njh6z/Z1KnZ0/JHb
        tKLnA43HMSIJS4NvEJz5UIdz7gDhK9U0Li7EJ87EVW91TptRZ3VTILUWt5tacSZe4HbYrG
        c9ZCNqTViXMrKUT1+BwJ3KfhyZuOO+4=
Date:   Sat, 30 Jul 2022 23:22:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andy.shevchenko@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v6 3/3] leds: tlc5925: Add support for non
 blocking operations
Message-ID: <20220730212205.GG23307@duo.ucw.cz>
References: <20220722081146.47262-1-jjhiblot@traphandler.com>
 <20220722081146.47262-4-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OFj+1YLvsEfSXdCH"
Content-Disposition: inline
In-Reply-To: <20220722081146.47262-4-jjhiblot@traphandler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2022-07-22 10:11:46, Jean-Jacques Hiblot wrote:
> Settings multiple LEDs in a row can be a slow operation because of the

"Setting"

> time required to acquire the bus and prepare the transfer.
> And, in most cases, it is not required that the operation is synchronous.
> Implementing the non-blocking brightness_set() for such cases.
> A work queue is used to perform the actual SPI transfer.
>=20
> The blocking method is still available in case someone needs to perform
> this operation synchronously (ie by calling
> led_set_brightness_sync()).

Why do this? We have other LEDs that are slow, and core already has
workqueues (etc) to deal with that...

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuWg/QAKCRAw5/Bqldv6
8ijwAJ4xkBZacmCrDEyqoF/SASmwU5ekkwCdG7WrhHOiAiGvF/bYqiDpalVn0j8=
=eCpz
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--
