Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6415549F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiFVMZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiFVMZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9CA344CE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7103618EC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EB3C3411B;
        Wed, 22 Jun 2022 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655900709;
        bh=66Ai0jmOleHM0/MLlKM55knutcIWjWBHUpIcmAG661g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwqvsZlMirwNizSWpNzV4Qc2aF0KxrS2tE8whw6bU1qMGpWPWVv+5/qkVXX70YqI5
         YZeJ+sy8OAQ2VgmbejeCsE5I4ND5eIHwD8dlNUb4eGmkY+avUjFOKJvsQJ/Pyy6J/j
         sG4hn6UJbs7G9wVcvScBrVtPjAp8RzSiuf3eN28sKK1u6v1Ka2Gqzd3gvwHIXvPlhM
         AL69frrV7Rx48JJyHCaOYWI+jdr89GwpHqT7Iz8soqUI8vi3/T5e25fDWAPIhQw/lV
         cczWPnorSF4dx4VwTVZkd2gBn2VEIe8JZMJMZpECuvtAz/ocpaXHVyq56WnxX/TCbN
         4qW5QYVaRcNkA==
Date:   Wed, 22 Jun 2022 13:25:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
Message-ID: <YrMKINPtKfmnxLep@sirena.org.uk>
References: <20220620134758.1286480-2-aisheng.dong@nxp.com>
 <YrCM0reni+x/KWsG@sirena.org.uk>
 <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCXILblKsp6DuN3@sirena.org.uk>
 <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCznap77OyHu4bO@sirena.org.uk>
 <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrHkXH1M4NydBfQT@sirena.org.uk>
 <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <abbc4d80377dcf5393afa143f9d3542cd2cd45a7.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2exi8FfNrXBHFDBX"
Content-Disposition: inline
In-Reply-To: <abbc4d80377dcf5393afa143f9d3542cd2cd45a7.camel@pengutronix.de>
X-Cookie: Truckers welcome.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2exi8FfNrXBHFDBX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2022 at 10:08:10AM +0200, Lucas Stach wrote:
> Am Dienstag, dem 21.06.2022 um 18:16 +0000 schrieb Aisheng Dong:

> > 1. There's a warning dump if using cache_only without cache
> > void regcache_cache_only(struct regmap *map, bool enable)
> > {
> > =A0=A0=A0=A0=A0=A0=A0=A0map->lock(map->lock_arg);
> > =A0=A0=A0=A0=A0=A0=A0=A0WARN_ON(map->cache_bypass && enable);
> > =A0=A0=A0=A0=A0=A0=A0=A0...
> > }
> > 2. It seems _regmap_write() did not handle cache_only case well
> > without cache.
> > It may still writes HW even for cache_only mode?
> >=20
> > I guess we may need fix those two issues first before we can safely
> > use it?

> Why would you write to a cache only regmap. The debugfs interface only
> allows to dump the registers, no?

One of the use cases is where you've got settings that can be changed
while the device is idle and just map those directly onto the registers,
syncing the cache to the device when it gets powered up for actual use.
This can only be done when there's a cache, and won't apply to a lot of
devices.

There is debugfs code to do writes but you have to modify the kernel to
enable it, there's no config option for it upstream.

> I think it wouldn't be too hard to fix this for the blk-ctrl drivers.
> I'll give it a try today.

The other thing is that even with the bodge to just turn debugfs
presumably any case where the driver would try to write to a powered off
device is still a bug that needs fixing anyway - having a regmap in
cache only mode will translate it into a warning rather than a write
that goes AWOL or otherwise fails.

> > > That's a different thing, that's due to us naming the directory
> > > after the struct
> > > device but syscons being created before we have that struct device
> > > available.

> > Yes, but syscon has the same issue that the system may hang if dump
> > registers
> > through debugfs without power on.
> > How would you suggest for this case as syscon is also a common
> > driver?

> This is a general issue. If something uses a syscon that is inside a
> power-domain where the runtime PM is controlled by some other entity,
> how is it safe to use the syscon at all? Every access might end up
> locking up the system. So those syscons really need to learn some kind
> of runtime PM handling.

Right.  If you can interact with the device safely there's no need to
put it into cache only mode and you don't need to worry about managing
things (this should be the normal case for system controllers).  If you
can't interact with the device without powering it up then you still
have to worry about doing that regardless of what regmap is doing, if
anything I'd guess the warnings from regmap might be easier to debug
than the hardware misbehaviour.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--2exi8FfNrXBHFDBX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKzCh8ACgkQJNaLcl1U
h9DYzgf+PvdXgiM8kQsAwpjkZSdPzQQkLyVwJ2psQabROP7ycvk7NPs2Ds6Z21M2
tAKQL5jHOE3jvs+08LkWLS5necn05+kY8w+KDUKM2lSSdGQC9hvyPWSokLMqaCSb
vEDoL084fdJahjZWmQDZMfkQc9QjzD/JAIF6qIppnUa9oXiOu7AinSHU7CjehOSv
oJ6AUG3IhAWVQ39X9Tm4OkKeIYPF4f2b8WGkSWp2lCZmlclt8sok/T9VLBQVFJDH
/q6AigrZ96xZdMHCFQf8dUNOammOY9wkGJNFKomLws23qPLhh7qecJxuW9KvUknr
mRhNTdjgaBBDUrzJN9jfSCM/kv7Mcg==
=1ahr
-----END PGP SIGNATURE-----

--2exi8FfNrXBHFDBX--
