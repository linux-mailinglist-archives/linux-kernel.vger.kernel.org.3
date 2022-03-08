Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6C4D1220
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345010AbiCHIWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344998AbiCHIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:22:43 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D33F896
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=pFZRpIjvFctGByZOgyIdEPWulwvq
        U03zZv0a9N5bE7Y=; b=AGbSdQ83+SuVei9Z7ZPPr24TAwfOyfLWTWDHX/24mw09
        rO71h6O10q53mGbsm24FdjT4jjjbSsdwSRLZjlOdrYbpGiEvWtPJgY6RdTsoOY1w
        w30khDmqi5tCSE4KZssQ64VItqcXNloj4Gc+J+9NQzTidjQZeYtY4aZUItysWPM=
Received: (qmail 2308500 invoked from network); 8 Mar 2022 09:21:30 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Mar 2022 09:21:30 +0100
X-UD-Smtp-Session: l3s3148p1@/S//qrDZyKofEkvD
Date:   Tue, 8 Mar 2022 09:21:29 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: Re: [RFC PATCH] memory: renesas-rpc-if: Correct QSPI data transfer
 in Manual mode
Message-ID: <YicSCZfl4wLUzvEJ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
References: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
 <163282533892.34438.1878675609177525004.b4-ty@canonical.com>
 <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FPccZbRjvw/M929x"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FPccZbRjvw/M929x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Wolfram: which platform did you use for QSPI testing, so I don't
> break that again?

I did my refactoring using an Eagle board and once this worked, I
enabled QSPI on Falcon. All remotely. Condor was another candidate but
it was broken in the lab at that time.

>     Without that (e.g. old H3 R-Car ES1.0), it crashes with an

Frankly, I wouldn't trust ES1.0 as a reliable source for QSPI. Could you
start with the newest Gen3 board you have and then go to previous ones?


--FPccZbRjvw/M929x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmInEgUACgkQFA3kzBSg
KbYR+Q//ZXmb3mWakveqBQdKlN2uTtnInBpejlbuUORLfw7p9rvFx7BXHEpxWPaY
W6U/08wItSe0A6sdovDxdpUt9rk46D10/69dr3BqFMvGf/AduEncm3BGLdZ14gxX
WWjUX6Vh7GMHKbYrHBvPKJOVpJ+2xV2F/4s8VUrsMyOoKOWUrGpFYGMFSC/3aOo0
6m5kYXNRCbDyU8sNf/OUuLLJijMkCjhGA/+K0XI2OdLd406MiBy5ZeKEr6xy61hq
Q/ELsVckikjlzFDpKmTC9VUYt5l0diD5DU7NuUonshFdk9E0lO63lGODg08g5r+y
c++GfysVqmeSYp+BHxw0pasLyVeVe19XMDSHb8znove6uYBxT5MEc9Far750S9EP
PvgIkn6+PKY/rwTxdpJ+Cf4PUXpEBio4Pw1JBKv3EfCA07YW9JHXEtLOS5jD5c5d
IdKAhaXDLE09BoJZcQP/iKm9bwMzke+XrWc2qWnUhdv7WRk3wBF9UdVPl9/F79Z2
iBQCBw1VcxgH6/X46giXBuxjRSRZ00JchN1lXqD1zLexTPLrrk/K/at+HIbbSeiW
7FmCA1LZhYP6vxCC9BXmiZVyG+VqVV4NO/c1xv6ixufgRZeOOQ1XtsZGDIKgks6y
YQvCDZx8kHR0gnFE69Rs5iFA6LKVMsEO6icDTRhtL781qMKsfy4=
=EP7f
-----END PGP SIGNATURE-----

--FPccZbRjvw/M929x--
