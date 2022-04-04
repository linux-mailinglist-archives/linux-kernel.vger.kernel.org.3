Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CA94F1D66
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382554AbiDDVbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379932AbiDDSX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:23:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B8422B20
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=DB+oqqX2BdWPTg/dtocUXs3l7PC4
        0npL8K8kL0ZHmzQ=; b=lohcyTOHrTWVIEDzzR9KnDU0oDhuv9u0in73/MFITsOl
        ldUu6LI1W0gEOuriBB60kN3DPEvGF5zyQKMjv4UFC/xtG9rYDGT9NY6doa0aLisL
        9McdJh34OVe0R6C/uuh+YbIcxwoK549IxilHRB4yLXP7JGvGRrxkPA+KiF2Jx88=
Received: (qmail 1971161 invoked from network); 4 Apr 2022 20:21:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Apr 2022 20:21:56 +0200
X-UD-Smtp-Session: l3s3148p1@2roINNjbrKwgAQnoAHNmALK3JllQBOZM
Date:   Mon, 4 Apr 2022 20:21:55 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-mmc@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 2/2] mmc: renesas_internal_dmac: Fix typo's
Message-ID: <Yks3Q75ZrUkXSjwz@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-mmc@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404172322.32578-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z7c7psLg3iS6VUgr"
Content-Disposition: inline
In-Reply-To: <20220404172322.32578-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z7c7psLg3iS6VUgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	/* This DMAC cannot handle if buffer is not 128-bytes alignment */
> +	/* This DMAC cannot handle if buffer is not 128-bytes aligned */

Well, as we are here now, I think this can be further improved.


--z7c7psLg3iS6VUgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJLNz8ACgkQFA3kzBSg
KbYEJxAAgE3tWV3U+f4TTD+KxfEn+jkr4asi2WSlwCxNMIJ3tQJ1VMrQzRAcU7S9
nFzV/FPLtE+Tz2etKMfQ6S/sF+nl85sA/KL7FxC/pycOjN5CRAT1JpkLuVUaZeNx
ZaLWoVSCd3sEyKjkRWkOlZIH3nmIbc9/t7eMf3ra8ZyWektqy5G8gLo/IL4P8+y2
YX8ZDCD7wrA7mHnCjx6lNc20InEAdmfqB5nFHIoLxD6+HaDxuWlwkI2l2NpADwkb
xM0O9e21nJs0LckiBppmOka5uEBqMRRtsGpRq0vloHDnyURq2xv/Qa9mFmam2CXM
UniXvARbZ0hoZymwJ0rUA1BDSNoTtdyO72urAEt4RqhxpXpAw09h4n/Lu9dXh+NF
RFzehHeCmmqTY/Otq0ADbnKccLrjZvfvwPqynMBHRcKY9b6MkY5Z5kE/mFkUFN8J
fhG9TLY7xHz/nXDCXjhDtNyxPjT1Eldp924STlqJPBjjEueckjNfy5p38ET8RxDZ
415PVK/E3rzuxLnBFSd0yUE1Zhwb93jLd4KDy6xILFSmw8R6Z58pyMBr3QsNLNjZ
S+gWLvg/LwLvZLPMQ7JwE15RhHsLaiHFD73VT6qPIWH/TB18pXmWIg3IrZr+2+Ac
szhLdZv35LfVSybUITCqJpvnOQWng1HlvtuRZ1xgjBjklDax64E=
=gpu9
-----END PGP SIGNATURE-----

--z7c7psLg3iS6VUgr--
