Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C91546C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347907AbiFJSjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347017AbiFJSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:39:45 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CBD2E9D4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=UU5YjojlQCeCu9qlG2U4gDtMpva3
        cln2VaeHsGNEyGs=; b=CQbK9ijqe4r2UR1IviVxCEjgV8Zkq+S0aZIbbUPhO1mo
        rJSVajB1cDtUtJBuiTHDpV9iRHvNUKeQYAWLx/RXNp4ix870jRwybTJ5O+hBecPM
        3F2wMESvrrDFKBTjFKfgVNeV3kcwrPMg3DGsw4zgAQ0D+CjjTQK0/s2fZMMuFGA=
Received: (qmail 344059 invoked from network); 10 Jun 2022 20:39:36 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jun 2022 20:39:36 +0200
X-UD-Smtp-Session: l3s3148p1@tXaWQhzhzGxZD+3R
Date:   Fri, 10 Jun 2022 20:39:35 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: thermal: rcar-gen3-thermal: Add r8a779f0
 support
Message-ID: <YqOP51pNPTtXQTMQ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220609194154.12829-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdXg3rC++RBp+aZM1Q_EkYyTxot-9LZnMfJFRz7cp0NLoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CN9TMHG+L/SSyQsL"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXg3rC++RBp+aZM1Q_EkYyTxot-9LZnMfJFRz7cp0NLoQ@mail.gmail.com>
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


--CN9TMHG+L/SSyQsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Unfortunately not:
>=20
> arch/arm64/boot/dts/renesas/r8a779f0-spider.dtb: thermal@e6198000:
> reg: [[0, 3860430848, 0, 512], [0, 3860463616, 0, 512], [0,
> 3860496384, 0, 512]] is too short

Okay, I managed to find the missing dependency to finally update my
dtschema. I'll send a new version which I then tested myself.


--CN9TMHG+L/SSyQsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKjj+MACgkQFA3kzBSg
Kbb3CRAAjhxA1Oulpxyo+WFjBsKSfz1oGJ+Y/Scd3X0Q9obSO7qA2aMyYoi/gCSa
bjvhdz68XgfJQi96qu4v/dWUL2Z+5OhE4tFcfFx1aoxKD8Ovgnc3e/sJtpb+qEER
IYO20H5V9GHLxL9daX6Jvgr7YXo+Nk7Q2HAv8v9NTuj1rorksto2TiUriAWhOFqo
BdTae1Vaa/3uL+EXfqH5sKmGM9QNdkV+vh17VIifVMxQpuzXRVqZpetv66fP/uRK
olWyAQ9anMTkazCqW854YoQFt9+CNOrOu8nXrP5lD3ypUfIgfGkanqOBrOG0KR7N
yazpd7v6aO+ql00ek4QkzZS4GnOfXQVOxJZWA33hH+a4c4q5RZgXx4MqxT5b+IO3
i9G7EBu735qxkmY/HQW+p0GFNQ+Wel6mzqVOhEymCqxldmVqoe3EZWtJD7q8JlXV
v+hjLyjh6YsQqdFp4hfhgcLBNiTgzuAxeVEsJyRedvGMIqPR6Hwrcf9VT0SVBEBS
3p+Ct5qS/JyQxLfxbTePwbwvnz2fi23KflkvQ17a9+5MM3Zth70kQFmiC2t0zmnU
AOHcnik0WkmlbGSlpdmWf+yKZQluwWwkPs3EpVBJcC0P9xtCuk0Y4EhNrt+AInQm
gkcqsYNJAmkGVD6OrY5wJU8oMh3FYgjxbizi/tmbihIojPTefcY=
=h7HU
-----END PGP SIGNATURE-----

--CN9TMHG+L/SSyQsL--
