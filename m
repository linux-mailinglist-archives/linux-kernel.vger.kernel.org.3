Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D16C54A97D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352225AbiFNGbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352215AbiFNGaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:30:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C3937AAD;
        Mon, 13 Jun 2022 23:30:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMdqJ3cvPz4xZC;
        Tue, 14 Jun 2022 16:30:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655188253;
        bh=2+7hOK7gai0sj/jHj1GNsLi8oVlT7BdZ+2vF94lvkBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BBYxG8ZDO43GhHop6xv5xDXEfJ6Z6LjQ4pvj9+Z59wKhgqTTF9NmRbEaEzLS5GisG
         nEo81W4pcx2eOFb4BWGYGXsiKVU/5BcI0Y4DgHxJ/B/RAS/i3ybciVjkWP1q48TB1p
         O12sCQGTVk7o+89SW4ZrAv5aKmdYunChMTyUwR6rwsrjvF6c8tZ8OQCeGJGQANibl8
         NRlyaw1BZ17s7oLAHWvYQtc4LW2uT4vK4GAirml9KmUuBF2HLOmHbN0hDq9v3ljhWv
         3AW2kpzpXf+guzr91WMdNL7Lu5QPTK0Eq9UkNbL+78stGxugMs2ByybDw4sKzowXOU
         nkR1+7Pdi4xZA==
Date:   Tue, 14 Jun 2022 16:30:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Greg KH <greg@kroah.com>, Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <20220614163048.0e49ab29@canb.auug.org.au>
In-Reply-To: <HK0PR06MB32025AFD8869F26343CE22AB80AA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220614120833.06cec8e7@canb.auug.org.au>
        <HK0PR06MB32025AFD8869F26343CE22AB80AA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PXhiYUj6=hjtLQ2dUprUMMK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PXhiYUj6=hjtLQ2dUprUMMK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Neal,

On Tue, 14 Jun 2022 02:41:41 +0000 Neal Liu <neal_liu@aspeedtech.com> wrote:
>
> > After merging the usb tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> >=20
> >=20
> > Caused by commit
> >=20
> >   2cee50bf4590 ("ARM: dts: aspeed: Add USB2.0 device controller node")
> >=20
> > I have used the usb tree from next-20220610 for today.
>=20
> Looks like the same patch is already merged by Joe, how's that coming fro=
m?
>=20
> commit c9cb67c3a650 ("ARM: dts: aspeed: Add USB2.0 device controller node=
")

Its in Linus' tree before v5.19-rc1

--=20
Cheers,
Stephen Rothwell

--Sig_/PXhiYUj6=hjtLQ2dUprUMMK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKoKxgACgkQAVBC80lX
0GyvEwgAhcPXESyXubSuFlGqRoUh1roPZF9UvdANLYp0JITZOXdT6vZiddfqctco
G0kkBA4wyA3CUmsKl4OjwohZFyIvR3ijGIJJKKg2AIsKQR+K94ZA7KaWof+jfdYH
sOrjONuwY/zII//NlkjZaw4nsUqL2K+pQx397nkCONAQJbdSaTYPT2/Aocg0B9r6
jRKnT+ZQvXcXfeGCe2EU7QNSevuT65D8sVU1LGBIiEXP5oGBq168FdsMVICQ1Dzb
ZNWDGUGW2cUlMyq1Fzys7pXT1dLNMvErT+6VfMwJX+tQSLN4qcIrKTQmmfK/hu75
afSd7uaxekdm/7tiQhJeqJ/RJt4SfQ==
=illB
-----END PGP SIGNATURE-----

--Sig_/PXhiYUj6=hjtLQ2dUprUMMK--
