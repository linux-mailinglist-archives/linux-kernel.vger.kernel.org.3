Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735694F8871
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiDGUbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiDGUan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D52E1950;
        Thu,  7 Apr 2022 13:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E546761ED9;
        Thu,  7 Apr 2022 20:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90A8C385A0;
        Thu,  7 Apr 2022 20:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362498;
        bh=kya33u2/Q3PmqUIvxCYvFgzOfJo3FlI+HlcCLg5eXiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gP/tHuDIo1D1Tj0vB4qLeMut1Ts54cexT7bUOUahB6tLkbRxtLovOcHONjfledUsC
         K7ju1OZumTUzfNaa2SKK+2WPtgv47x3MHNFiDdmA27CBsIVKi3tlNv9HpzBczSOdKL
         qCRQ1idY5jrB12npuhjSYptxP0L7A9AzmO1CJte7AjpFlXTV5JuOiSO9HVKaDFjhnW
         PfWQq6irbzNYeWrRbFyfOVleBzJT6QzXw5RcwIxcXbJ7xIQxVZxWGMvOrF2o01Lp/p
         p+9TQWlvwjfTOxd1B3m6fsTw9Snq/kFWvjVL6USDzkBpFErEQAQRxZ9r+nlIcl1NLf
         lHyF6Yh1+TRng==
Date:   Thu, 7 Apr 2022 22:14:54 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] clk: si5341: use simple i2c probe function
Message-ID: <Yk9GPsJxsB2Z8u+/@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407151831.2371706-1-steve@sk2.org>
 <20220407151831.2371706-7-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mOQ4/RjLeTczIovH"
Content-Disposition: inline
In-Reply-To: <20220407151831.2371706-7-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mOQ4/RjLeTczIovH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 05:18:27PM +0200, Stephen Kitt wrote:
> The i2c probe function here doesn't use the id information provided in
> its second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--mOQ4/RjLeTczIovH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPRj4ACgkQFA3kzBSg
KbbpUBAApWCmyeGZ1RcYA3lldXM+R/SqgNeqhRxKDwhGII+kRuaUQVlZsEjMuGBO
x/qmOeOs8iALoBhzJ3LCx8CF77VIXERP4NV5NdZaEx36wWZ1g/5JKLRBsEuUXqb1
mwPRbWt88qclXJDFcfaHog3dNVfavy+yVUkgoGkJrwbpKwbGvvtlE+1Tkb+oXap6
bbC/4fZZ9AB+7HYBaup+ZmJQwBpJ4PfM6ZPGLv1u6x9AF7OyGxTsBBaeBB9QwTCz
HHJ8IZblJ3zTGf4rvrGD0xpga/VJJ8apgX/DvditZPDgZIPDiU4VWoDStOpSvU+K
ANa12YsoJsgrlG3hfVb+fGNghQKJwXPtFSJikYFLtPG5LkDZTU4V7aWH+UzF/3nn
XcvydEZLQJ9WfPCOWvCWr0OSI+6ra9ZUER3nyKDvn83ZIQnd+jsc+r1L+9JXB3j+
mqT6zOuMpROWetdWqHwBjGREiTRIEQHUcLSOx6KbHP+VyvghJB2vbGJpxW/mr2t7
kV2mHKouGiBZnnMRRMqFSCx0VFQ6pcSzzdPLy7x16tziaxAP87mm2g3PaGre4ueu
Hx1GLbYm5iVtLozh6ht8VHlGOTFGoCrTN4yOr8vBhuAxbtRMtrwCManLVEDWt5vW
2fgMXtARaD9iyVViDlsWwlDr5nPUF5Gopp1lG9wtlW6qNkJX93Q=
=kGiK
-----END PGP SIGNATURE-----

--mOQ4/RjLeTczIovH--
