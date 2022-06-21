Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB075533C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350972AbiFUNhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351272AbiFUNhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:37:00 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6257E2CCAC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=4z8LIqSE2luIYKYQPL4O7016FE7X
        ACNUC8HzUXy/qdA=; b=01BO+r+v9RlUR+01A7bMVQzBsQhNNmJIvNZlxSGUGfBq
        Lqm9gGQAQH9l5Ovg8uCXA4Fb0ihlW/7nFgYGuPR6tBcbKeofmdfLu6jgdfaagLMx
        3xY98ygVqrniGO11M0EC7INENzj53fQR0ID8FOCv7ERwBl2iscYLOR2BWJdM4P8=
Received: (qmail 166667 invoked from network); 21 Jun 2022 15:35:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Jun 2022 15:35:31 +0200
X-UD-Smtp-Session: l3s3148p1@NDlbS/Xh2kJZD+65
Date:   Tue, 21 Jun 2022 15:35:30 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-mmc@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 0/2] mmc: renesas: Trivial fixes
Message-ID: <YrHJIjhDP0/Sur1M@shikoro>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3uiu3xecSU/IzmT8"
Content-Disposition: inline
In-Reply-To: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3uiu3xecSU/IzmT8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> This patch series adds trivial fixes to renesas mmc driver.

Did I miss if there is anything left to discuss for v2?


--3uiu3xecSU/IzmT8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKxyR8ACgkQFA3kzBSg
KbaE8g//SE/s4VlQCXBI+FKeQFbA8DLx3Kvl+RVRfKQBXRi00zNdF3soWSUCfIGZ
8UAkK9nthXXx/jCi9aiBo7fT0StSPiuact2ljH8MEjLRtmWV1Qzb//B4plgw0E0M
m4VfF+FMjfcpUc8zm/e9VXBOKEsm9C2DmCEP1piB7vXDBx0nECt+o8Khf8WNJ+J3
lpSlIlbxwNgk5c87oBS52m1TyvhZS0eGG0PH/AwIFoIqfKl4w1ZD9SYyB1EzIxem
qN4H8pbjpXkeYqOb6HqPb2bgzR2VryQ/akHGT9W9DS08wBaA6nKPwvuU469xh7Ck
3CW1/wyN55lWcceW0JAg+oKnAtScdRqaiHY8UKVIUmxowCNqMETt567T7JuWDeyF
4pHa+fZl+/X48unxFDpJJjxuTjR2z0iEyF26Amgnyhj+wazeCYrKvJhzURtzYOpF
1vIxCBSs8e5+sdrlUMQWGYxyC2ESE6v2cZPvd+hpxR3N1vNS7lLyesJ26Qlx3wOZ
iYDGoA2UKr6hZPlXgxU9W5e9Q4lM68adKZywSmdM9ouabMGWbPVVQiYMT/ETxJMW
3Lu68Xiuu8zJFxJ3Xcfzr+IID6Zecq9OV3+NF362S/xS70O7742bLYfW4mN9dL3k
qtyK/xX7DJ7LbCwjyPHH5wJuvPt0mZfWDpIJt9EjrPWVXJQgtlE=
=6vn6
-----END PGP SIGNATURE-----

--3uiu3xecSU/IzmT8--
