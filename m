Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311F84F888B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiDGUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiDGUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727074406BA;
        Thu,  7 Apr 2022 13:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0687C61EE6;
        Thu,  7 Apr 2022 20:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0527C385A0;
        Thu,  7 Apr 2022 20:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362745;
        bh=eSaQA+T0kiICEi6MwytkW/5H9T6sKRV1tLfDYgfjnGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nfYFb4/vFmU9dGeEv00VQctlopj+JrO8lvVSTVnO134Db2XJP7cA7f3Bos70ntD5b
         npqVUdc/8kpgNz0FgkCwJmUwA9TmbytGplWx4fy/+9DYOGkDRQ01kA1cPjStRGygaJ
         iETRKgmEAhSAzhw5issHdfl/19dnrcCqsrMZ2fVrczG7djkBt7cdTxYXakgCV+ESMK
         qJowHjY2m8zp9ynaa+75YKBHTbVpkaizBqm6JFzOhhOOuiz8ySvr58JyXkun9YCNUn
         i5lgifZUSLXpRiuIvlutN6iDDwyJmlS7HBPcTXuH5CPXjtOTaVFqADIoVmYZGyrnCR
         wIUf40icxDq/A==
Date:   Thu, 7 Apr 2022 22:19:02 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] clk: si544: use i2c_match_id and simple i2c
 probe
Message-ID: <Yk9HNhwc3PjiigMg@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407151831.2371706-1-steve@sk2.org>
 <20220407151831.2371706-9-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kh38zvkhHChfbwIB"
Content-Disposition: inline
In-Reply-To: <20220407151831.2371706-9-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kh38zvkhHChfbwIB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 05:18:29PM +0200, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--kh38zvkhHChfbwIB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPRzYACgkQFA3kzBSg
Kba2eBAAtK4esh57V7wiRZfEi3MRcfAs4EeRxZh4AHvRDJhQRq9cohOQL3O18lR/
5Fp+vzzfUri+pDk4xy2lf/yVrIzDP28RFC2EbaC3goAMRNEfM8uhak1fJ/xn8oCx
FDHo9Vi08ZHdtJ4gFFO8nnMUO/Zb/mtl4IMLurNgKwNF37Ja2yiGRrRV8Um+eAdL
ACNOvZAvCihdPLZ7NwCNHWQz6WRWQIWwkZiO9Bwb3jh/5MU/Won2URNw1Frfse2H
lBEQkOUNg+OpEmFdKD/MdBqhNs44RYJG1xzQvQVxP55MFsdqKFYKCJELz7uP6Znb
BK7RAkCBOPgqDuh711DE7z3YYfBWI/L/mqf3Uzt9SHBvdNzJSvBRDCwGNG3AOaGA
LJ0RDobUkRQwECLenKK/sdV4WgyFd7OvlIVy1KgpmMcvA/yUfQgxOi1KiFAZBpCL
78gm31kVNaDmnhbC3w8AijITOfCSEVx/uqafhs65Lrmkl8TP1iHrHrSSWN+Rm8ZE
tUnii6d0BjUWNqZ+O5GLt6IXUprs9NMAoh/ZG+PWoTb9D2La2bgW/NkPwtIpsISZ
e0GfIXIV+epyaxbb0H4sWKr2aO0zU5c1WyHiNs3szGfAJ5SSr1GVPrijQZXS41YW
AChpUH3IC2oRKox0BfefFM283ylv5kmsidUVfZAe9ttmkPAPksA=
=3Wnt
-----END PGP SIGNATURE-----

--kh38zvkhHChfbwIB--
