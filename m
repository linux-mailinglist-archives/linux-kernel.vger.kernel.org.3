Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B744EAADA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiC2J6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiC2J6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:58:10 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D40B9E9E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=pJFbieYuMliDkorM/V/PDbhfFVJI
        4OfwO+V1QhjgIjI=; b=FTCfDTMel3Y0xfBFes0gT9fT1cbL485/LVqU1dPzzEIX
        21iJL573t/oUpScLaRVSknihh7GZNAUreCGodX9U1P44S6Qv/CS4JWKX20C+Gsyr
        cdLnHadYSxGaOn6NzDhGY9/0wjy+kn567cy+XHOcT/rhhfoeHF8gsADLM6wPIVc=
Received: (qmail 1736111 invoked from network); 29 Mar 2022 11:56:26 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Mar 2022 11:56:26 +0200
X-UD-Smtp-Session: l3s3148p1@yf0ycVjbXKggAQnoAFHmAKNSQL+AeJes
Date:   Tue, 29 Mar 2022 11:56:26 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dung Nguyen <dung.nguyen.zy@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Mark Brown <broonie@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] memory: renesas-rpc-if: Fix HF/OSPI data transfer in
 Manual mode
Message-ID: <YkLXyoHnB3EucLnA@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dung Nguyen <dung.nguyen.zy@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ad6ef2af754c8163f825d3a199d64f910d63f802.1648545212.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1HwUNj8StJmyV25U"
Content-Disposition: inline
In-Reply-To: <ad6ef2af754c8163f825d3a199d64f910d63f802.1648545212.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1HwUNj8StJmyV25U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

thank you for this update!

>   - Update comments to match changed code,
>   - Add explicit {read,write}l() for the 4/8 byte case, to increase
>     readability,
>   - Remove redundant break statements,

I really like these changes and have nothing more to add:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I also tested writing on R-Car V3U and V3M, so:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Happy hacking,

   Wolfram


--1HwUNj8StJmyV25U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJC18YACgkQFA3kzBSg
KbZIQRAAkuzVjLW2JAhysnb/w5LhrCW28JB4+nAMveqOktOY8nICtFIKcYMBzKPz
8YPcWrsZw5vxhoO9U/QJLHGvqu1m2jcgVB5sQmHZK82PhBgHAWDH3bv01NCpau+C
6FQdyfi9UO1BJmsezDi/gBpLwSuQDGdWSdVZ8C6NCUUxjsZwqCmzahupWSCgzgHN
ZqI821Tl3L5P7ynMtgZ0C66ATZ62tmtLlG/Iby21e6VeEnIvrdu15G1v9GeqFScY
MQg89w38h15ZkU/nKOIuULw4ZwGqdKpFrTFG/GsUaiG8/qkRpqE99IMouIqO2svQ
aGqGDT8JCx1NE92uB357nAkgjywo2q3cZqFEH2brG7GREVUfhzrP2d4eJqnYDWbB
lrjiYPMgaMtDLjlW0RqcbETFQGQDVlVqHgU3dGBmSGzHm2R1hanTAuoxwyNUTtVv
3WxwDo91OP4RjS5QyY/6M2VE9nSyOSEY2XVB8pjw92OUoovU7CONwfIVgLm5FOcZ
m0RBpwRWXgdU9P/+11OfvDJmVaREcMK/hi0OVvvi52Ynebq35JfHtsNUAkynCwM4
1/81dieewJoPzABVqtuqzbSIktbaXFGCT1+kmaj+aRn1ywhoWKldmMGIm8lXKuvm
rZCYovg8BEKzTx2oQjxn25byetZGGRCIcbSWu1i3CEB65piiFFU=
=USGZ
-----END PGP SIGNATURE-----

--1HwUNj8StJmyV25U--
