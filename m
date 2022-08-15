Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4CD5936B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiHOShz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244095AbiHOSg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:36:27 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AFF2CE0A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:23:13 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EF2D11C0001; Mon, 15 Aug 2022 20:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1660587787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5wSMTIGBcrUjqUTnSeGz421jCyzZ5BYXN/xendLi44=;
        b=l4aWaTWky5jKwhxY/ClMtqopUDor6kx+DW01yjgtvKhmv4vy6TOUiWKkq1i64kfBx14ZtU
        5XmGU0+u8lPuLAqlum0TK8/L+xtQR3XqR49uzUsBeI+mc18KPjmYLqRwbe1eoQfIyw0/iJ
        9RpqFYnwnzXNE8EJQ0XL8dsNKfeqnR8=
Date:   Mon, 15 Aug 2022 20:23:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: boot stuck at starting kernel, due to __genpd_dev_pm_attach?
Message-ID: <20220815182307.GA4658@duo.ucw.cz>
References: <Yvpd2pwUJGp7R+YE@euler>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <Yvpd2pwUJGp7R+YE@euler>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> You might have already gotten this report, but I tried running v6.0-rc1
> on my BeagleBone Black and it gets stuck right after "Starting kernel
> ..." from U-Boot.
>=20
> A bisect pointed me to commit 5a46079a9645 ("PM: domains: Delete usage
> of driver_deferred_probe_check_state()").
>=20
> I don't have much more detail than that, other than I'm using the
> in-tree am335x-boneblack.dts device tree and I believe I had tested with
> the multi-v7-defconfig for this verification. I'm happy to test anything
> that might offer more information.

Well, standart next step is reverting 5a46079a9645 on top of v6.0-rc1,
and if it starts working, either you get fix in your inbox, or you ask
Linus to revert :-).

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYvqPCwAKCRAw5/Bqldv6
8rAKAJ0ec6bD30pSceC17zYQ2zAshBRlpwCff91TsAEmgjw5q4egvKGIH1XPd9k=
=lNot
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
