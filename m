Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735A25A26D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245154AbiHZL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiHZL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:27:15 -0400
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 04:27:13 PDT
Received: from pokefinder.org (pokefinder.org [135.181.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D4F1C743C;
        Fri, 26 Aug 2022 04:27:13 -0700 (PDT)
Received: from localhost (dynamic-046-114-176-008.46.114.pool.telefonica.de [46.114.176.8])
        by pokefinder.org (Postfix) with ESMTPSA id 93843A4079C;
        Fri, 26 Aug 2022 13:20:22 +0200 (CEST)
Date:   Fri, 26 Aug 2022 13:20:17 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pinctrl tree
Message-ID: <YwiscXaIDER6SnBf@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220826152650.2c55e482@canb.auug.org.au>
 <CACRpkdYZOK9NhEqqU4Wkg1XHCHEQk=AR6w9730qo_tHmgGrorA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3p7vEnOaM5CiwDdJ"
Content-Disposition: inline
In-Reply-To: <CACRpkdYZOK9NhEqqU4Wkg1XHCHEQk=AR6w9730qo_tHmgGrorA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3p7vEnOaM5CiwDdJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

> How typical, the ideal way to resolve it is if there is an immutable
> branch with the > basic changes I can pull in from the i2c tree

It is already there:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/make_remove_callback_void-immutable

Uwe (originator of the series) spread this information. Sorry that it
did not reach you.


--3p7vEnOaM5CiwDdJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMIrG0ACgkQFA3kzBSg
KbbrfxAAsc1NtFpnpn4HBwPM0TiCgIM0xgl7SbitH/M5J7P+PZ+0ycNpzAVvMHgQ
efeWpodBYPlprIvbHsVYD9del1MG0CoHEzwEMpD4VIupirhBWqZZn0BY7zvWX6WD
n4wxs7lU8qThnDVAdtdfp0DkoUfmSyp2ELkRGnutdUbDCcDGYX/t35SQ4ynOeXVz
IC8oJmdEvCywzQkHvQgs567IvA9fj+Qm+r8glOr+3waog/efPkUkGHhaZxZaa3R+
4oTU1m95mq+hNW/1r83nR4cHboCoy8rP/65Zs4ki3wYLDYiFXdm4E2HKcerZzykF
OK+gtC5F63DBvN7r/YVBq2dk8Pc90jxFCbXGt2Zv/x552VcHj+TRcjLPnib2lf7e
mZhrrcXC3q7h2mfZYxDrbl2clkXww4go61pRJRUj/EMo1azaWexY3jFaFquDTIZW
7FoAmQ59tsLee0uqbufA9OVfBwkyXhz4Rj92ZKR0dcdvIak261NlOdvrbpA0b64m
fVMR+FPfWWzrKvYdJNUiT+6Pq4McmNsN6n7VA9la12YWYbCvtDqgysWzqU6RSVH5
OVS/pBq+fGUv4zRQiJGVyu/gfzJdzcCP/5nIaglZVMGv9QfLIjmN+2axgwYng7Co
ixTWdEOJVPs+z40dZwCSPDlaSxtHqTNPUipGoATTtOuCta/U6VE=
=aKln
-----END PGP SIGNATURE-----

--3p7vEnOaM5CiwDdJ--
