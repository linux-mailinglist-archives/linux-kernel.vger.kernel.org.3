Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD45746FE95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbhLJKUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:20:01 -0500
Received: from www.zeus03.de ([194.117.254.33]:44866 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239943AbhLJKT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=s3LeDggvmW3ag8cnOWdEwafwGfd1
        5LxqD+plVt2oWuc=; b=bMTZHzdtIroFgIdg7n9H9Fll+PZt2rbXeRnKElX4ph3o
        4xCVNxwA9i5KmOynOai8rDatR1gsF3BZ/0T5NxNlNvKCOBruYi3981qIfueLP0hs
        AuJ9oDCHm97tipcfoQM0nptYAoMcSjNTU53rL/U2rIHHHj168/1OSMaXRdDgoqI=
Received: (qmail 1422109 invoked from network); 10 Dec 2021 11:16:23 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Dec 2021 11:16:23 +0100
X-UD-Smtp-Session: l3s3148p1@g8GpA8jS1JAgAQnoAEPjAJzPXF1eIEK3
Date:   Fri, 10 Dec 2021 11:16:19 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <YbMo8+1N2BKAE63Z@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20211123164902.35370-1-wsa+renesas@sang-engineering.com>
 <20211123164902.35370-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdUGOEmB8QeHufXVHifYpvZxNpu_kku05eGKk=+YRf+PsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="teEgrqnjjop4BLE1"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUGOEmB8QeHufXVHifYpvZxNpu_kku05eGKk=+YRf+PsQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--teEgrqnjjop4BLE1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Please preserve sort order, cfr. the (hilarious?) comment at the top
> of the list:

Ouch, yes. That's what you get for a last minute rename. Fixed in v6!


--teEgrqnjjop4BLE1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmGzKO8ACgkQFA3kzBSg
KbbT+xAAhcReZsn4U8iPxnddjusiCldpFdsenBANy9yQw/eFAXNLVEab8jm4xjst
vwy9csA9ETm3MfysPvMfXItJHuah9bi+vC6uWfqoW2NcDEPxDFLx/EqSbF6qv2qu
UKJQzhIBX6OvOqVYJ4eFE6z0Mey+1X8TijclmtIUfsDwEkXxRTsSs7gsmB4SawFD
z1vC3sL+0XOKofIhUbH5ki79g7eLYfFrWTvyeI8lovc6xVPqIySFV/xSNTOPByzF
mHVHxw5xjeYdEPiMjloCIgGqZi/N3f6ncKJsJBJKfq0tNLfO5lH+aldp29vpj33u
V2ttVhucM31H8/jBi9GiJWC3ajwAEbmcfsPu49GYlR8u5oKeBj6Z6/aQUhHfw1yK
jKwTS7KpCQw605PJ/UjNHuRDPBxn6IVujlnt419l58lfXZmbEq5pWTp2LqBO6GZD
+1V6G7MzHD4WyK2bQNiWbrolx3Dm+7Jsv7W1ubxelRfEGDXw6WYP568tgzsQVACg
V/n+4ZJsBKoHkennIDFyJeCvTnkqLOQgcHYlWM5KO0zjgJjoYaRqm89/6NqzkBEG
wnTgXZCAqT6Z/OxI/nXfRR91SrycSB5EbW6xnOJZMQxrIYyRxk25fewlPQSjZdu3
7T2doM5XS7jWXN+KUCN1L/f+G+CZvFS4wsGFLrHWfvPBmwEXsz0=
=OZgG
-----END PGP SIGNATURE-----

--teEgrqnjjop4BLE1--
