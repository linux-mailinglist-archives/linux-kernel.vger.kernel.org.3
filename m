Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8105A4F8A03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiDGUlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiDGUkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:40:12 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34102357874
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=/DzCNuw1K0S8Qc22VHqjl8ySUIhp
        YJjf0kBvjKhVz3k=; b=l9xKMUGEprvhIgfx1LT3ILLwl24wHtZWpUzUz9P4gaxN
        +UmmuOkbEw7uvk4kFGvEdvnuVCxjDjiXaKl7zvW0DWRWwIJ0fa/eprtBwvGJpmat
        OD5/nOxO1Ioz+GgJQMZ3iLTa03vT2uZT0yurcI+95ZiDuAXcmwFayv4Db1kXufU=
Received: (qmail 3331153 invoked from network); 7 Apr 2022 22:26:28 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Apr 2022 22:26:28 +0200
X-UD-Smtp-Session: l3s3148p1@IWHwShbcCtAgAQnoAEUrAF1rv4rSPqUC
Date:   Thu, 7 Apr 2022 22:26:28 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/10] mmc: core: improve API to make clear hw_reset
 from bus_ops is for cards
Message-ID: <Yk9I9GDHBcYjpbYf@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
 <20220321115059.21803-9-wsa+renesas@sang-engineering.com>
 <CAPDyKFqwgxhRPBabxfUTC+8UVegWrTg3F0nRn3PoToiO2DWtvQ@mail.gmail.com>
 <Yk1JA4TWO9bTt0kb@ninjato>
 <CAPDyKFpMAE9mYXUBEsVSm-9EHAC-o5hTxgKNUjYYvo0dzqfEZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaalbi9RWUHNZPvN"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpMAE9mYXUBEsVSm-9EHAC-o5hTxgKNUjYYvo0dzqfEZg@mail.gmail.com>
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


--kaalbi9RWUHNZPvN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Perhaps one simply needs to make a patch to convert them (most of
> them) to take a "card" as an in-parameter to really see if that
> improves the understanding of code.

Might be worth it, but looks like a seperate patch to me, focused on
bus_ops, not on {h|s}w_reset. I might try it next.


--kaalbi9RWUHNZPvN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPSPQACgkQFA3kzBSg
KbYMNw//S5oncEujrr57DMlPnp0JRQPRfnkX2eKuWWduDURH0jgTSVBYVBS/Ocgx
TH9rOelWGErX604rRZetXRiDTbR/RzhLSXsBu0/esr3Pe6xCBtFDeJYeKx50kfqs
XvghmwimIl1gdwqL9W/kKHnruXmi3ehkrAf17HIguYl/WclSu3JZwOCwGg6QTN1P
9A+/sCfCFtkHGKfB+YIg9/QhXLpfdpBhXYS3tVHWsrxbUv1CeXNmzhRCgKscebfw
wdlNWZtlr4Prvd/Mzf5FmeenOkKJvvBehqthsmKMKBPXoLYdxlxhRcFKmrk/YsoG
tRdziMvuXa6n66uwR2dqY8icf8o9f+eTx26m3N8e076U6pfaBZlCb1xBtBQk19bN
+AXx0rQdZvTbtvf0c0Ud8nQAp5XCgqaT4LZGpa5ruHwxtHXEcM748emYu8QJ40a6
WA2mBlH/mIKeT4rdr2WECco7g4jipw+boT4MDTxGtOLXG0swJCdnel4XNkyeT3p+
cLVXtyWQyV7uWI1imOnXQ7wLt6aH68a75wkNd4RtoXmEKv7srfI1BWIOltfrsUvj
MPvA6IWgHOtTUiOXdfKDlexyD6Lv6fyX8UP3t/fHFoTj/vZ7V0R9NAadvzRviDFu
sYaTzbLul64ysYR+GXRWbx1jO2b63cnJV23igzKvpOnhkrniCqo=
=iuKv
-----END PGP SIGNATURE-----

--kaalbi9RWUHNZPvN--
