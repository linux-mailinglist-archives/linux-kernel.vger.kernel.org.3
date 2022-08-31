Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F845A8876
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiHaVvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiHaVvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:51:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BCDE833B;
        Wed, 31 Aug 2022 14:51:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHyY82ysQz4xDH;
        Thu,  1 Sep 2022 07:51:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661982669;
        bh=9AVJ4/cLcrc009ZqXyiDlHnV4P7HwRGKg/7HDhDcTEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KEyU0f2NTyL3driADOPi5VH2rJQcDdRXQI5AJ1XVndcno7rzv+YlioMsk0uiUKfAR
         wTurE0yGsD4GA2wqMhx9dXPWIMpS56eZfVIXlFnPlStuhYNAvOxDMLO4C8pmuCdha3
         QlpmCMQCrRsh37eAfxy/CsgJ+ZWRGeb8iaElQjTRL93l32gIL3WrKAKm5Q9oUvk0O7
         nJ7s81lbLCE6nCYoG6eFNqWAs30oFxggN/xRCi0crAg5vQ/5k2ElPHwnMksWbT0jNs
         U8uc7x2PxPHuQUkkUkU8AvosuElUYxcCzwsMHLKtE46cRD4nchmfVNeVn3UWwvNN9+
         PkEUDXgDscaxA==
Date:   Thu, 1 Sep 2022 07:50:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb.current tree
Message-ID: <20220901075048.7b281231@canb.auug.org.au>
In-Reply-To: <Yw9vYaqczVlWzONt@rowland.harvard.edu>
References: <20220831152458.56059e42@canb.auug.org.au>
        <Yw9vYaqczVlWzONt@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eBYnpi2IJuOXVNPTD=yToFs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eBYnpi2IJuOXVNPTD=yToFs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Wed, 31 Aug 2022 10:25:37 -0400 Alan Stern <stern@rowland.harvard.edu> w=
rote:
>
> On Wed, Aug 31, 2022 at 03:24:58PM +1000, Stephen Rothwell wrote:
> >=20
> > After merging the usb.current tree, today's linux-next build (htmldocs)
> > produced this warning:
> >=20
> > Documentation/driver-api/usb/usb:176: /home/sfr/next/next/drivers/usb/c=
ore/hub.c:6040: WARNING: Unknown target name: "pre".
> >=20
> > Introduced by commit
> >=20
> >   9c6d778800b9 ("USB: core: Prevent nested device-reset calls") =20
>=20
> I don't fully understand this bug report.  Would it be fixed by changing=
=20
> "pre_" to "pre_reset()" in the kerneldoc?

I would presume so.

--=20
Cheers,
Stephen Rothwell

--Sig_/eBYnpi2IJuOXVNPTD=yToFs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMP17gACgkQAVBC80lX
0Gy63gf/XRhLMumU4GmYGfYWd0vx4gSLG6StUI1GKHbCsSBN+PY8Td71Kr2nIA+G
uZBifP2CuQOv/qDViGtEc+a61jGagO/gplIUug+XpWBjJgISXnAFrLq3uulBoFwc
cTyiAQ+R2j3djw43w4CVlkV6ltCd6zqQdzHgI+NSgkC1kk+823iRFUx31RUTu2qM
s/huJgsQhm+A1l/YBqoROOzZPSv1Ub/M3nN0httH48R9+pV6rcwm6OD8pJiQMGTM
OsUuIbCyBSlOsdtoWEtkNEO8+JklcZB7Mk/V5hZKd05EtNoOcEWaT5DZ1god0lut
h9ecnWHRQFfJbL5QwDmxDSyKcCMoXA==
=Danu
-----END PGP SIGNATURE-----

--Sig_/eBYnpi2IJuOXVNPTD=yToFs--
