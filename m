Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD34F885D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiDGUdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiDGUct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:32:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0CC2FB198;
        Thu,  7 Apr 2022 13:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DC9EB82980;
        Thu,  7 Apr 2022 20:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDE7C385A4;
        Thu,  7 Apr 2022 20:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362158;
        bh=A4/AzbWjitUbjirM7/ydBpWaRSNBSrPwtnLuXdyc/MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyH4Q2P4HkDYq7/TtiyUjfK8WuBdDRj/YgcBTUanXsjyLBeKqldFbQMYUGrdMS9/H
         EbgL4P5fr3DZCq1epjuIo4EhOGnS2dd2T54sT7SbJqaLcGgHJvZ2eCVb51FdZVzBnd
         Vm43695JfJA1VCOV+fOJANgAq2pkvkFwUVlK07R2xsQllKtzV4IQriHNLqCyHAh0/k
         dGy0FZT1KxLH5oXVnuX1HO3kPeyDF8KpRDyMuSSnbiP+WILhz4sqll2jTZzMQ1vcmy
         H+eylayuhm1/n/hHQwLp6mniElSPnhQPs0nzATpDRo+NIWxwhAHGOr+UzsA834x/s4
         SprzIvE8eTRng==
Date:   Thu, 7 Apr 2022 22:09:15 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] clk: cdce706: use simple i2c probe function
Message-ID: <Yk9E6wOtIxnmCwkm@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407151831.2371706-1-steve@sk2.org>
 <20220407151831.2371706-2-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X/S6ZsKhA/2CDvFL"
Content-Disposition: inline
In-Reply-To: <20220407151831.2371706-2-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X/S6ZsKhA/2CDvFL
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


--X/S6ZsKhA/2CDvFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPROYACgkQFA3kzBSg
KbZnCA/8DPZitLAB9IgjOgu6tWf0yjJPWfSk8iS/jSOQ/ZNjIBWR6mFqaVFAkGYS
JV7yMM7aBL/hx3mqM5oo1KvR061AHn7x1HMdaSmTiKQMIMCfiFki9BKBv6ougd69
RtOo97FGq+pNwYQsXc28DkZKH/H2ddJK2sCOXBxPML2yIZUzcnPZFpFMp1Dv1DZ1
Wruq9RXl9c3mr3GnoWD1IXbSbEBIv7OQOdQEWr8W5SeWhsbmbJejb0ks1xn580jm
8nOI0ZYI6q2ytjOor8irtikMbPrCEUKs5NmLG8HyXeBrEACsYmgFJeqXXULgJpEa
fTAR2stu1HlFkriLlsRfn5OOM+tIyq9ICR0YCVIe1mdrjs2cM9EadJcJz6ketTdZ
7f7BPQJlG1BF9RHAK32EoYhFi09GJwj70jtUmh/I/p4+TG7wTdTNgwNRSyZd9iS9
TmAPrYYWrtU69btf4PADSSmGolLAi+yrszSklQTTwTpMGvOhQhDzP59eI4PCr/ua
KsSJ3is7u7gJUsXbG3puChMzJMvGcT4jhWlpNXC5wAoJh5i1V2+0cK8741dYxrp1
41YhbfNmfGQ7nrdOtHJlyeANlDvleClCoH1u3HeBHm+14dW40xOQQE+NzKKf/VyS
cmrvC4ZKfCvYe9DB/VEGGJR+Th/0LjeoVH8JOZ/gBRnQUoYP6mc=
=9I0p
-----END PGP SIGNATURE-----

--X/S6ZsKhA/2CDvFL--
