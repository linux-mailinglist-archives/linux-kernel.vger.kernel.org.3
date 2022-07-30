Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E79585C9C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 01:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiG3XSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 19:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiG3XSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 19:18:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C2F14D09
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 16:18:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oHviv-0000xF-M9; Sun, 31 Jul 2022 01:18:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oHvit-000nio-30; Sun, 31 Jul 2022 01:18:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oHvis-008ag0-I9; Sun, 31 Jul 2022 01:18:18 +0200
Date:   Sun, 31 Jul 2022 01:18:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        deller@gmx.de
Subject: Re: [PATCH -next] video: fbdev: imxfb: fix return value check in
 imxfb_probe()
Message-ID: <20220730231815.dzuscf2x2sgj66bg@pengutronix.de>
References: <20220729024134.159942-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ng6o4jptt6kmqcf"
Content-Disposition: inline
In-Reply-To: <20220729024134.159942-1-yangyingliang@huawei.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2ng6o4jptt6kmqcf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 29, 2022 at 10:41:34AM +0800, Yang Yingliang wrote:
> If devm_ioremap_resource() fails, it never return NULL, replace
> NULL test with IS_ERR().

Oh, thanks for cleanup up behind me. Did you find this using some static
analysis tool? I would consider it interesting and fair to mention this
in the commit log.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2ng6o4jptt6kmqcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLlvDUACgkQwfwUeK3K
7Ako3Af/TZuLdIkfkINPaoUzB/bri5XttulHS5ntQGhaGktA+CMqub9bRyuCSl90
qaiq3UlI7ialUmjLRtnPEf1SkIm5IJLObD9uOrF/lFR0sdHog1iKVu+1OKehN5Qt
W374CaiG0NJjAf2LmVH78hDXk0yzOifRAjdpcWIDyvlSGqAq9A9sI4B9RIam8LCD
/tPlavR02meG7gT0if0Wfyn0BDKGztyZLzmrMZihDLjiGPrsQZvRc5yydMnLm/+k
4kG5v4dHLBQnVXubhnFzFYigRvDRWbkUm7W5jKJnjGmQONXGvgzZZ92xqh4sDiDs
G2pfgN1p+VNYIwUc2TKfWTMc2FfTNw==
=or3n
-----END PGP SIGNATURE-----

--2ng6o4jptt6kmqcf--
