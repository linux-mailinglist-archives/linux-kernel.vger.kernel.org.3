Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B4554514B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbiFIPyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbiFIPyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:54:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788691E3C2;
        Thu,  9 Jun 2022 08:54:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 149BB61E86;
        Thu,  9 Jun 2022 15:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E221C34114;
        Thu,  9 Jun 2022 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654790045;
        bh=d6IpKcReOM0BAzYys8GQhWOY3da05wd4CwqGIOwNcnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Db15ot9lABxO3UDTeilr4THVUTIhS5xY67yd39M0pz3GRSLiVbaUWWzAqu3M8vDpl
         eZ1Jw4GN7i49o6r941HRcZ31gj0EcToE6PjyDn/1IT39g3MDPXc7Ef+EHdo5+XThCj
         65tGwXPC/wqgbmiUQ5mdFDio+QFPuNpFZBUIjyIBHSzrf/6C9K3cQCkva6OzChTm3J
         i8hgY7BZkrDYydCMFPTWdPam//3L6igIRKdTXs+KseTpoZvFoagI5jImY+D1s6dVji
         XgJzO9/uuSA4lR/zr4S+fJBUDBoSGMpzCnECkyjAVWIHS+nFuuT5amgxmWlYN4rjjC
         0ITOxZtE8FWiw==
Date:   Thu, 9 Jun 2022 16:53:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev
Subject: Re: [RFC PATCH v2 0/5] Apple Macs machine/platform ASoC driver
Message-ID: <YqIXlwTzQWwtzbdN@sirena.org.uk>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="th3PZ0FiY0ufDWny"
Content-Disposition: inline
In-Reply-To: <20220606191910.16580-1-povik+lin@cutebit.org>
X-Cookie: Space is limited.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--th3PZ0FiY0ufDWny
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 09:19:05PM +0200, Martin Povi=C5=A1er wrote:

>  - The way the platform/machine driver handles the fact that multiple I2S
>    ports (now backend DAIs) can be driven by/connected to the same SERDES
>    unit (now in effect a frontend DAI). After previous discussion I have
>    transitioned to DPCM to model this. I took the opportunity of dynamic
>    backend/frontend routing to support speakers/headphones runtime
>    switching. More on this in comments at top of the machine and platform
>    driver.

This looks roughly like I'd expect now, there's some issues from myself
and Pierre but it's more around the edges than anything big picture.

--th3PZ0FiY0ufDWny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKiF5YACgkQJNaLcl1U
h9AlNgf7BPncxFpRN1RmT8l9lbVRvoJyMKLO0MWxXCBeHx7bbO/8GXmDIpg/VmXO
J2vqhrtWSMijrffbeG4efWXldQMGhUAhz/GgB1FFgAdwzgE+6ndaNCEP8HGG9dIP
xUlcJxbPK9XGpJEgqG+ihrsaA9WjcXD0HaH96yjCoL687emR3fOXtKSjOC/Dqebp
GOg1+ilWEn1BRvCdj+CtBWLiPWcrY9AD8ObLl0fYql8FH5KYoF2FWNsfaGWE5Qh8
He2vyrMlaFwsqPZcUuznV0PPE8tF/cq8syXxk4ReXHeq8WPp1ttG+egBd0fTlRys
YKpwyOdMaqdnrDwryruzRc9I0CrW/g==
=YWSx
-----END PGP SIGNATURE-----

--th3PZ0FiY0ufDWny--
