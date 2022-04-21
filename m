Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575555098C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385612AbiDUHON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385603AbiDUHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:14:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C1615A2E;
        Thu, 21 Apr 2022 00:11:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KkTGs13Wtz4xPw;
        Thu, 21 Apr 2022 17:11:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650525077;
        bh=S1lft9PBkR3rmXHsCaJf2k1NukatZyVGgp0UoVBJgc4=;
        h=Date:From:To:Cc:Subject:From;
        b=AFmFAUAWv+cwByvFx6l0ZTSHROEDMja2VYA1DyN45r06mDL4O+JCcW6Q0rGPnIlB5
         feV0YnTRtM/1wQNLE6j2xLBWcVnF2yHdBEhPf65vj/6WK4j5DRCkgCRasYHM2DWBhs
         2E/4SbDfPoIcC3NKJwElN/H+cA9w3qk657wp0TT+S51Wo4gVroYvd/17a0dt9vVqur
         ajhEDzz+8KG/njvUOxBVPM97S9oH+1b/nl2dpMmDgfLw6QcrIo+9hKmZ8NW26AUtG5
         mQEtKqe2LV4gcsmatBqtjP53XHZZcRA6un3AZXnWCw1eTZUvhwz6wHLWCWlrjwC0FX
         jhJpUiuRtdh9g==
Date:   Thu, 21 Apr 2022 17:11:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the pinctrl tree
Message-ID: <20220421171116.6dbe87cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h55M/XjbUb7SQqjhoVE0LEw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/h55M/XjbUb7SQqjhoVE0LEw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pinctrl tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/gpio/driver.h:507: warning: Incorrect use of kernel-doc forma=
t:          * @of_gpio_ranges_fallback
include/linux/gpio/driver.h:518: warning: Function parameter or member 'of_=
gpio_ranges_fallback' not described in 'gpio_chip'

Introduced by commit

  a9491df0c4ae ("gpiolib: of: Introduce hook for missing gpio-ranges")

--=20
Cheers,
Stephen Rothwell

--Sig_/h55M/XjbUb7SQqjhoVE0LEw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJhA5QACgkQAVBC80lX
0GxWtQgAgho4Xlny7Sp7e7d2gT/sGGNkC0FcIRij+FRUfRwsgr/iT/rY33U29YmQ
5gb7zXN+TXhVYELmDosyWB2vpva65vFeimB6MpY6fiRR2EOvd5oX2wkj3g0ut+sd
WnVGOZfvO+/mzy5EJj9H/EN0iHNAsDph9sCmGj/ljLPQQklCHm3ouo8HYewN8PR0
R7jFqif0zOMRyA/bSK79sZJaMWp+ERF8lkC0i88hCM4JBAddfCINSKuUA9sZ9KGV
vPhqZ/yJdH3GOrzhx8ASuoGNZ7kOeWFrMRIzwdn/WJctQWwgc1Do2KEJgTOJdz/0
g08ltGZzenHjq8Dgda0b0hPsOOhSBA==
=rQCA
-----END PGP SIGNATURE-----

--Sig_/h55M/XjbUb7SQqjhoVE0LEw--
