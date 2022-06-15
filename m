Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84C54C4D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348402AbiFOJhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348395AbiFOJhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:37:41 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC7118E22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=A8JpapYC9DelarnKbCdnoE7ZcbxO
        YJ05XpvR+2l5gBg=; b=G2Ew7R4b/D5LfmUTEhl28PVvQMGOpJJ2e6agJM9JyyzS
        jz+33i3y7zb57Gb0YQ8BgPjvuNqXCDHHN8KLIC6U8L+AGR5hZS06OhGLSG9wGPBV
        Kyy2TU2vX7/t4giZdAJ8WGOA+0lK04DUmcSKk9CANMqtVEEDamkN48zYyU0ZxGU=
Received: (qmail 2061927 invoked from network); 15 Jun 2022 11:37:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Jun 2022 11:37:33 +0200
X-UD-Smtp-Session: l3s3148p1@YqUORXnhbj9ZD+7R
Date:   Wed, 15 Jun 2022 11:37:29 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: spider-cpu: Switch from SCIF3
 to HSCIF0
Message-ID: <YqmoWYARVsXos3me@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220613131033.10053-1-wsa+renesas@sang-engineering.com>
 <20220613131033.10053-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdX-56GZmZJ-JvkFvZ6NsozsamtoKURPzsS-3+AYtZBhFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UDCmEr49IhCpzjc2"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX-56GZmZJ-JvkFvZ6NsozsamtoKURPzsS-3+AYtZBhFQ@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UDCmEr49IhCpzjc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

> I.e. the U-Boot on the Spider in Magnus' lab has "baudrate=115200"
> in its environment, while I can read the output from ICUMXA Loader
> to U-Boot, and Linux just fine.

Earlier U-Boot may have no HSCIF support. Recent ones have and the
installer suggests to set baudrate to highspeed. ICUMXA loaders never
worked for me in 115200.

I can keep my patch local if you prefer 115200.


--UDCmEr49IhCpzjc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKpqFUACgkQFA3kzBSg
KbZofg//cx3mCefnMBfyXbcioFsitCVQyAiT8kaeNlh19E52D1Nn0gpOqr4XV1hn
k+1SwLQem8+GPiuDgDWEATcnL43zMibpWR2PTAc4n4hfk8o6sFCZ9ukv3wbJuqPa
xA/uUE/KwX8Kpoj8+mYC+ZG+yHwPJPGYKvzz2Hbz4kcwpnTCH131hzOYmr65/Tya
LzMkQ4vyDjY7UEbyfh3qGc2hcyPfL9Sb0ksSwQA/3vwHp89SZY1pIeTp5pXCVFQX
CylLTOUdCrJpPl5bioPDqZ380zEKHAyKzM5Chy5wSstzlNIS11lEr27zigZGqdNt
c+Og9gpUK+rDPccN0DPulH4+w7uj9XcMCBWz3LaI1XusK83kxt0spEjl6CYtW31X
Q/JuyIiY4TQAPxaaBoHyE/NSgeAAj6UVvtV4UYKzX1g3vruoZP8q2G89XTFVa2y7
d7FO/02padMh7EitomAi9S9TVEEqCVwFBB5EobXA9b/1hKk+/BY7hFvQvyyi/Mu6
tutYpluRyAlsO0qp8AWnPGd2N8rP1BuZpjbViomo3jQJzJUk9uD0kRa6EIDxp7F2
xwtPTAfPyrlv7oYsLiXtgw0eO19iJxMALSBMbRdWpFuldxJ2nBe4PT3dzNu8GGEo
UujKBi3PKmVuNrlfwmNKgh6r0xYFRp97HBfcV2fsSxjhPILDW1E=
=m8gc
-----END PGP SIGNATURE-----

--UDCmEr49IhCpzjc2--
