Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489514C2AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiBXLQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiBXLP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:15:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B549729455B;
        Thu, 24 Feb 2022 03:15:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 441A41F44FA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645701327;
        bh=Rp6AQqc+ilMu/vT7f9GQYHeGNO+h9uO2+4aZ+/clBZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkcbUtvONXAkCDJWwLOyhQraFnGGMR0b9Ni9FAEXQSUKhqXK//aDIg2mT65cJsgkw
         ssMcQqWR8xPq6aXsaPpugsTWZfB4VJF3u9Iwv543ZkEy3iH00XIJizmICOi/6IpUKl
         PKlYSbHSs/OqD2wdpA5trdhsPj0IP2vqLyHruM6PZgD9mWOH63QwMtw0XPLCav8iuW
         bq56U9n93PQBHcfpzKQA8NBlGjU+ySXnCrHgIBxx/VBN+TZPz6BhqePaaJO3aUJCYv
         Sae9A0Z6ymb0l2gz4mCtdxmvPteEoTUFMo0yPOWjDwZ2aYPSfU6v+7+Mi/OQjjgbFs
         8Wpqq2Q+6KGaw==
Received: by mercury (Postfix, from userid 1000)
        id B045F106049B; Thu, 24 Feb 2022 12:15:24 +0100 (CET)
Date:   Thu, 24 Feb 2022 12:15:24 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3 0/3] Introduces bypass charge type property
Message-ID: <20220224111524.rzqkumr47ytl5nho@mercury.elektranox.org>
References: <20220215000758.803501-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="posaq6tqktsqwtpx"
Content-Disposition: inline
In-Reply-To: <20220215000758.803501-1-rriveram@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--posaq6tqktsqwtpx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 14, 2022 at 06:07:55PM -0600, Ricardo Rivera-Matos wrote:
> This patch series introduces a new POWER_SUPPLY_CHARGE_TYPE for bypass ch=
arging
> operation.
>=20
> In fast charging ICs, the bypass operation is used to bypass the charging=
 path
> around the charging IC's integrated power converter to its load. This all=
ows
> for "smart" wall adaptors (such as USB PPS standard power adaptors) to ha=
ndle
> the power conversion and heat dissipation externally.

Thanks, queued.

-- Sebastian

--posaq6tqktsqwtpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIXaMQACgkQ2O7X88g7
+prL5A/9H8fCXkGpUZc/A8Y1XO9AhD0Ec6/ip4Ltd599hFUxoWWCwXMRqCvbzjDZ
E39kLMUmwuJYIIHsS1qYpa0rQf/jrpGThfel4A/GLBKP1OUM5TPWjpX+wrK1LziR
iibWGIQ274KO1fmZtKZy72obVZ+qqrb8BHbAtpkljb79oD6QcNIB3OGJ7Bx52Vte
Q6h330pMuFLDtNl8sSl16NLNt4oRndTDi6OEdIf2sEkUq0zTqd6TcbErrfJ/1pZy
lM/j2iHeoT9EiWE7qn7vld6q5H891EaIwT7ilchSkFlrHaI95QLUdo3m8f8QQpVf
AnoGc9ony9zDloQ9D5GdnpgF4yf1koVb2UsVMKvXV3GhbgaHO/KDj4RofjAqfMai
qGKxd7yeJJbOfQT+mK9EEO2ndbQ45yqq0hErnln/dHrk2dWK7bND5yNr2qlex0Tm
T+TFDnxyPBh1TTxorakoa3d3bQA0Vki3NnfSQhKMpP7qpaLB5YejucQaCqbA3OmM
fI1bMnntZkkaYPpYnHWPCLv6LP7Lx5xKJzsUbcJKEAbaarsREB37GrkywTPkofpe
tx9SnI50BgHJrmroB/Jb3UAMuRIFHj4KjfINF/8jG4plbOAEP4Qo2JICzRrJclEr
oXTdzganbfM+ApesVTNPYovEdj4HA1GipuUb7p0e/xxyWm/2zYM=
=fbKX
-----END PGP SIGNATURE-----

--posaq6tqktsqwtpx--
