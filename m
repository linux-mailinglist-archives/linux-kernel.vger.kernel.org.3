Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508104F8897
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiDGUb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiDGUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815582E933C;
        Thu,  7 Apr 2022 13:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE1E61EDF;
        Thu,  7 Apr 2022 20:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A2C385A4;
        Thu,  7 Apr 2022 20:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362527;
        bh=YcLjImFP4RaQwQQLM+DUBkeXsMZ0ABelfYLt5rl8ZJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LxDS4vSJbwyGtlTWwUEa9MZHPxat/S9yBdUFdRmlQdzVNh229fNGLLRkMpbI+WyAn
         KdUSvA2B7If3Eah5orDFv7LgjXho5M8PIK8CZfjo6GkF6JPXrXkKOp6RWBVa1eZsTf
         ssVTuZg9kumoezcEKhEX8RjAAZeZAoi+YGasnurvvrJg8wP6nzzFDrsT5e8jlzX0he
         Tg5+o1LmDdQrCUvVHmgtccvCT52X8hasgqI270M3290WPiViofNTMkmDU8diau3vOg
         gHLoNV4YhURTK5ApJ8O4ox2/UxviiRh6b2Z0cvP5ElYsDECnKF8M6pbjHJbh8Lj4vM
         zEnQVSuItl/ag==
Date:   Thu, 7 Apr 2022 22:15:24 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] clk: cdce706: use simple i2c probe function
Message-ID: <Yk9GXDF5MOF574CG@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T6soNZcCxtM6oc+D"
Content-Disposition: inline
In-Reply-To: <20220407151831.2371706-11-steve@sk2.org>
 <20220407151831.2371706-10-steve@sk2.org>
 <20220407151831.2371706-9-steve@sk2.org>
 <20220407151831.2371706-8-steve@sk2.org>
 <20220407151831.2371706-7-steve@sk2.org>
 <20220407151831.2371706-6-steve@sk2.org>
 <20220407151831.2371706-5-steve@sk2.org>
 <20220407151831.2371706-4-steve@sk2.org>
 <20220407151831.2371706-3-steve@sk2.org>
 <20220407151831.2371706-2-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T6soNZcCxtM6oc+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 05:18:22PM +0200, Stephen Kitt wrote:
> The i2c probe function here doesn't use the id information provided in
> its second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--T6soNZcCxtM6oc+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPRlwACgkQFA3kzBSg
KbYrUQ/+JSPUvf5QADstvq1hDha/ZuwVQmf9RTz5K1BNOgS2w8qnDr6zqe+ve6GK
WGIv0iC3l9PJPs6bXgf2mnjVPd/JaXPTAtsU7q72J4k+Qiqv/vVoUJEQtxZDBjps
fhFAXEy0a6YiSKIwsg7LnJ7IqqnBRkju6pp0LWpZ2z73tOhrFXtNwz6IlwSK4lN3
oEDOgrNRYZh1/KmotDVuWcBrhCI5KvkaamRaEH5u3ZoDR6tannXSVDmowkQ6uYYv
NDqo1Qj5EzpuggzJYZ34/iwMSaSsO7RMh/7IzE5o62+IeBp0x59L88Ncs9rRuntd
d5/IEiEkKEKZU3GgBMN0P3k9Xa360WEuvKcRdKJhDBcL/56ACG+uarKzEcrBN3wH
4OvVBYk3hXdhTiQa8TtyVMNtpvnSQCVGQUpe9Lw4BaYtyM4IAYbKnR4fc39WVtCA
qLgHYnGkibKn26jYEKLX6AqHTIcd3G/2gfxCo9Hps8ff3uN6sqgwqg66biNcXrZE
ZHRnTZ7gWKpuyK29AJ4bhLIZiMllcfr7sIr6YrMRIh8Cf6+kjHMM813RlNYLUxOp
mOhrOqe8L5QSeAJAwuyVxcw5WFWYc5AXi3yBUYACMHPF2BDGk239Ygj56dFldJvP
DjFrviBmAZu3qWnQyKt/aFMW3YM5D1YiIKMTBApUZhBv5Lk/ZhQ=
=1TtR
-----END PGP SIGNATURE-----

--T6soNZcCxtM6oc+D--
