Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B684C2AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiBXLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiBXLXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:23:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C4192CAE;
        Thu, 24 Feb 2022 03:23:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0B9111F44FB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645701795;
        bh=VJw6mZVAmZC+VKxisAwrP4T+wfXsA6twbj0C50Cz7yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyOkEPrNegieUIUIXa7pruA3UP/wQbGQxKYH8PyYlMi4m2aaKS0m8vVPRSXf5VYUg
         Zd6rtL1ohkfsaxPEPZ72klZ5DY6DOa57r2pXk+0T/J5Glduk4Jn4NRGBUKXRfDVCB/
         DMf+OLd5q+xGw3AkKJ55DJAXFmPwfOVKo2pd01LzNa5vrSjzdC7Sv/u2DyJdWPpTtC
         0969v7qzVJ0Bf+MXaGZ8AMBOJb+JSbEMdKCxI9w7BDc3bB19DQrEu9g7HRYhiHar0g
         9W+3OFhws5fTx1onwxj7diOtPnSbeHWnq9Tgt1h4zfCoZBfrWknX6EwWjJnvvdvRNs
         mkKxu+Wid01hg==
Received: by mercury (Postfix, from userid 1000)
        id AEB5C106049B; Thu, 24 Feb 2022 12:23:12 +0100 (CET)
Date:   Thu, 24 Feb 2022 12:23:12 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Nicolas Saenz Julienne <nicolas.saenz@prodys.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: sbs-charger: Don't cancel work that is
 not initialized
Message-ID: <20220224112312.cjbz4vt3spe2go4b@mercury.elektranox.org>
References: <6a6b4c9ce80b0edb4c4c6a52d8b9a618a4325d42.1644772001.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ygoevftfh7wcem6b"
Content-Disposition: inline
In-Reply-To: <6a6b4c9ce80b0edb4c4c6a52d8b9a618a4325d42.1644772001.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ygoevftfh7wcem6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 13, 2022 at 06:07:03PM +0100, Christophe JAILLET wrote:
> This driver can use an interrupt or polling in order get the charger's
> status.
>=20
> When using polling, a delayed work is used.
>=20
> However, the remove() function unconditionally call
> cancel_delayed_work_sync(), even if the delayed work is not used and is n=
ot
> initialized.
>=20
> In order to fix it, use devm_delayed_work_autocancel() and remove the now
> useless remove() function.
>=20
> Fixes: feb583e37f8a ("power: supply: add sbs-charger driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Thanks, queued.

-- Sebastian

--ygoevftfh7wcem6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIXaqAACgkQ2O7X88g7
+prs0BAAjuSg7QAMU7w16eluFO4vCWaCynHL/qF5kVwEHwXEH3HRKocFcUyRcQMr
45bPioFiSpR8xbHT860XD8muYw+pForHiZm6zXr9PsFVdiBsDNbQIaNHfDxxCWjB
hwqfzWxo/IYdZtUWvS3mcWhSHQBbI6b0hdLnjb898UvmYnrDUlR1g2aw6C4pk+lC
TkiLwXBNbVKcNUQElthTVYoDWu47jWj6j22vJqrWMmac8O4dTvavNVAHQTBUl0nj
i8oki+bkORmjNXmhGYcqSJCd/2SPCKWXPwbG/J4esis+ESK6UqLo1xrybDLNNl7k
it8KmKPa3TQSqgfvmjjJ8qNQDiKMczBue2DvGzAwqaEVId63qJ4loXznly90b5r1
QGYMyAm1SRnGdAdQL/xt2Ti3PsXTzR4IN6zhXEoRlLSerftLbk5M1RlkaLrJZAvK
NUElrVL03up50YT42DWmoY3NcZol1au5YvCAf8NOrnEgaxOJKpzSKoFRtDzkVB4S
Tn1iXtOIYHyUl5kc6o1Eidse4sMsW9DdIHkF5RfvsnQCUdSjA47UHk6KyXnPYYlu
w5Hj0urkBN9TrTqdiwSJTV3WmBNWfbJO7zJ9Y9FnCPONsVFC0R4K3YPJ0cMkXOGR
OrLsMjnAggxyKx0cGP2nWQ2X6hRmq4YqCLfbo1k4ZeMpV6oL/+I=
=T9P+
-----END PGP SIGNATURE-----

--ygoevftfh7wcem6b--
