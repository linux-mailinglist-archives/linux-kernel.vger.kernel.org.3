Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47265775B4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 12:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiGQKW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 06:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiGQKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 06:22:26 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D114018;
        Sun, 17 Jul 2022 03:22:23 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 756D41C0003; Sun, 17 Jul 2022 12:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1658053341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C24lRPvgfQ0aRPm/iVNf09abZ83+jvm2un6bvI2eZho=;
        b=fRzoXjj72YbjZbspZXb7EkLYyf7uWc8QWnpQj2Ohmy+TkgP1qVWsnng9kORlsAj+tWv5T1
        /tnR1NhkU+K9IW2s3nBd4vdMHdPsVzgrbxeG86RL6zC4pJ/jl3V/Z+dBgmlt2TtjYfpGlF
        tvGIuA0VzxxThHmLGlgt16lRviyBi5o=
Date:   Sun, 17 Jul 2022 12:22:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Randy Dunlap <rdunlap@infradead.org>, nm127@freemail.hu
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: clevo-mail: fix Kconfig "its" grammar
Message-ID: <20220717102221.GB14285@duo.ucw.cz>
References: <20220715015948.12643-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20220715015948.12643-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-07-14 18:59:48, Randy Dunlap wrote:
> Use the possessive "its" instead of the contraction "it's"
> where appropriate.

Thank you, applied.

Hu. Hmm. Wow.

What is that? Kconfig describes very non-standard kernel interface,
and has several other typos in the it. I can fix the typos; but is
there someone still using this who would be willing to fix it?

Best regards,
								Pavel
> @@ -456,7 +456,7 @@ config LEDS_CLEVO_MAIL
> =20
>  	  The driver supports two kinds of interface: using ledtrig-timer
>  	  or through /sys/class/leds/clevo::mail/brightness. As this LED
> -	  cannot change it's brightness it blinks instead. The brightness
> +	  cannot change its brightness it blinks instead. The brightness
>  	  value 0 means off, 1..127 means blink at 0.5Hz and 128..255 means
>  	  blink at 1Hz.
> =20

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index acd4f754c919..eaba0a8347fa 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -447,12 +447,12 @@ config LEDS_LP8860
=20
 config LEDS_CLEVO_MAIL
 	tristate "Mail LED on Clevo notebook"
-	depends on LEDS_CLASS
+	depends on LEDS_CLASS && BROKEN
 	depends on X86 && SERIO_I8042 && DMI
 	help
 	  This driver makes the mail LED accessible from userspace
-	  programs through the leds subsystem. This LED have three
-	  known mode: off, blink at 0.5Hz and blink at 1Hz.
+	  programs through the LEDs subsystem. This LED has three
+	  known modes: off, blink at 0.5Hz and blink at 1Hz.
=20
 	  The driver supports two kinds of interface: using ledtrig-timer
 	  or through /sys/class/leds/clevo::mail/brightness. As this LED

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYtPi3QAKCRAw5/Bqldv6
8vVPAJ0c+/9lBN+yClhEwM/AphtNXuM4UgCgk8JzdYGXLETG9A3hXK7gJzwXM+4=
=cgYu
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
