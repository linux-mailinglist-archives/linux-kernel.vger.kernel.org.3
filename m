Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A464DC2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiCQJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiCQJhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:37:05 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10616BCF7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=M1kfGq35Txrk2/WrFn9836CKxulS
        Oplyo3itJGzIWE4=; b=uXofC98gbVT4ydrsrX5gFPPoKnGP/6ko4aJu+gGeEemb
        qbvsr3V6SDd1BJ8TfF3i1GnVBm7NbVKI1Ba4uCwoLmaFFUuIWOySo4FvwqyJtJlz
        Ec0faaMo0ZUwaCmAoGiZUD+sMQLoDRop5iBkWmldGcytdxDM9mhvJD+nM+XZZfg=
Received: (qmail 3395135 invoked from network); 17 Mar 2022 10:35:45 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2022 10:35:45 +0100
X-UD-Smtp-Session: l3s3148p1@OP0ewWbaYs0gAQnoAEd5ADwsgXkBgqk7
Date:   Thu, 17 Mar 2022 10:35:45 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, Lad@rox.of.borg,
        Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] memory: renesas-rpc-if: Fix HF/OSPI data transfer in
 Manual mode
Message-ID: <YjMA8TuXWj3HvQkD@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, Lad@rox.of.borg,
        Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <27107f2d578b198078df841ee2e4d7b71b183898.1647017136.git.geert+renesas@glider.be>
 <31a776ed-3371-55d6-747b-8e70e72619d7@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncIMMMuhdN5FBkyZ"
Content-Disposition: inline
In-Reply-To: <31a776ed-3371-55d6-747b-8e70e72619d7@canonical.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ncIMMMuhdN5FBkyZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Some reviews and tests will be useful. Anyway it's too late upcoming
> cycle, so I will pick it up after merge window.

We just discussed on IRC a better solution. So expect a new patch for
this issue. Thanks!


--ncIMMMuhdN5FBkyZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmIzAO0ACgkQFA3kzBSg
KbZeSQ/+MMP9kyqwgaotyBIzZLr6O0gU5dbxHE74xNpiw7rr5PZ9YUswaMGLygJV
BVmc3GfYxm7acBfKA7voUvAVPsLx0p06kTutWWZ8xiFoRsm/3a/v+r81jl9n2atY
B91VTUco3ZXhYRyiNWoy7ChIHf+/XUzeookt/+CTnMvirTeUprLcESyJ3+X+KwfC
/L3kBy1MrrBVLImocz8xhHo6YmiNupujT5kmFqskkPdAnbYkQKXXuGKFQ2Ff6hc/
4DxCCinV1dc8RjvYhLNHFyhdXPZ+wz6FX+mhhoXgddyzx2y2QnSyeQtfTjK0e41b
23yritvWTnHgmvjjf8lZs5sExsOx8zUS9QRyUvLQciL+7MzqPAyzZ9LuzT8rLG3M
L5Zt/aLUIuSBU7AiVs/JS4+83n4PqOBCObb1xalSFI4kq7Bk7yDOXMGBUMQhPLF5
3iVKR/+4mlrAlRb967YwN6bn/SNFGMLfQ1QH456X6QLpORxfXY3Lu7b1hDANTbrV
D66nO/3PPwn/u6fGEnLeA2o4c06vsaVegYZzUe/5kd74OHxBA6XNLV7j7JqFe1ZS
3O7usINcPdSM+Fe5GIBN61CCLfnUwvP+kSjTJHdpwHoY9HEi2IImKIGdeEHGNlg2
3xRFm/dTmKsm2IckwBInpvo9ldoTUKR8RxoHJ+xGoMemBVKjLE8=
=nfHW
-----END PGP SIGNATURE-----

--ncIMMMuhdN5FBkyZ--
