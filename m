Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0487A5A025E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiHXT4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiHXT4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:56:47 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234447C319
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=XfI2zVgSybuOFKHs2O2v3i5/yydH
        RuHPYDuh8ZRgJUs=; b=Swji6jBeHIh+BLay/t9qq7wLzAC/ChVuYStJRqnbb/cA
        5gK9jYsPk/78DkcmgW6d5/dIHHexz6Zt/vLFijqHvZv/P/VlZlgo5wFZQ6IhigE5
        95s/clSwPPp1KPeAdT7qYOymeivsKP+G4IKpw/TayHSnAbEJZVoa08pqab/HuyU=
Received: (qmail 2364728 invoked from network); 24 Aug 2022 21:56:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Aug 2022 21:56:40 +0200
X-UD-Smtp-Session: l3s3148p1@P0dLFALn3r4gAwDtxwoDABxA2q3xYuRb
Date:   Wed, 24 Aug 2022 21:56:39 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Duncan Sands <duncan.sands@free.fr>,
        Felipe Balbi <balbi@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH] usb: move from strlcpy with unused retval to strscpy
Message-ID: <YwaCd6BkBMKMv6kj@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Duncan Sands <duncan.sands@free.fr>,
        Felipe Balbi <balbi@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
References: <20220818210116.7517-1-wsa+renesas@sang-engineering.com>
 <Yv9TWTnYc4T3tkqA@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v5ByJUCPpsV/XVJP"
Content-Disposition: inline
In-Reply-To: <Yv9TWTnYc4T3tkqA@kroah.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v5ByJUCPpsV/XVJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>   =E2=9C=97 BADSIG: DKIM/sang-engineering.com

Strange. When I save the message into a file and check locally, it seems
OK. I also never received a similar report from other b4 users.

=3D=3D=3D

$ cat message | dkimverify
signature ok


--v5ByJUCPpsV/XVJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMGgnMACgkQFA3kzBSg
KbZ0cw/9FAwUMwXibHECPDn27lqmPu+9+JcL1bW+8klud63Gu9NuQelmHjOeQiW/
mK08FGs/unPDv4AYzZjtuPcii4BjA2BKMDM3FR87lkTVYOf5JGRHKzz8OeqTuIsi
Rtz/b+qS0vdzNQfByCCvjUSIp2aygxY5n28eOlLzNQsESO/hH8btVqUY9Kc3+i1b
8fgwnkblqfk5rsR0bo2rf99gMbmxflfLL16EUPryAp6os1QtC7UV5IWfV4D4z965
tycqvPES1/HxJO0+6KRjN7umL8qZoWDkWEbU0tyE/HWQCDia/RB/hqMlDOKgeO+a
rOWRI4YoY2oJRxQ9wtGc/5662ASs05pcHAky/J7BALv96+PbopbiAK2PdByBAGgF
3GfCwUvEAZRLb0ZRp8vaBRunwbNXBur3NSJWi/wDRQy4Rx0t75pvTIqb0plPlZVn
WdNmYyMjV9Yw9gEe0ecbAh0UPIy8H7xMS+2sLTgOeGkRdc52EDYgzAoTu7rfTSSv
K9SmrX7Asff8TDStQMhwgOaOK5bkXY//242EMnoIxyTgNULe89+M7oitNdnBDYj1
J6EJKVEN+6ZOtdoPlJmi5nU0IAQ0q0sLdkXZ0rLEPp7P5hGHHnM0r7PhLKhpFOJg
efRTKdLWHExE6jJMmAD2+As3Q6dNNzMySYXNvyr1iJ6yh40piPs=
=qKuh
-----END PGP SIGNATURE-----

--v5ByJUCPpsV/XVJP--
