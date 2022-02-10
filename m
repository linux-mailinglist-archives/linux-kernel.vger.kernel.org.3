Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654FC4B0352
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiBJCZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:25:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiBJCZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:25:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7904822BCC;
        Wed,  9 Feb 2022 18:25:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvLF41rmvz4xcZ;
        Thu, 10 Feb 2022 13:25:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644459913;
        bh=D+DjfAKMXi5ZeAZiu2dE72zIwqk88EIi86SvqawOGw8=;
        h=Date:From:To:Cc:Subject:From;
        b=W6Jfedq8r5SZVRHpVoRk67DH9Fa4nwuN+h8A1CELYz+0QVAC3tkLYyU5TXBoMDeSp
         Qq/fmHvAUqxqUD+YWrgyrh7efCTRwvnor+ttJm1UnVe+WzNsWxc/ROZh2vy+S4JJjM
         MGassANnWlFmf46Radn9zbrtPz8Clj3JVspbLDzcAx7jaQ/NoJJBtiHadI3MqKOhuG
         RpbnkMwhiOfA4JMfRw2LDREKmeJBzZGfoEcPSDJmr6gb8G5nS67NADQ/AFFE3SCZmc
         dSe7z1XcfT7xUMF4aAtVuuFHvFAFy3c8phrhPtjBahCF20z3kcbtWUy2j5xDUWgtJb
         hcBrWEoIkaeAg==
Date:   Thu, 10 Feb 2022 13:25:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: linux-next: manual merge of the spi tree with the hwmon-staging
 tree
Message-ID: <20220210132506.051144fb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pZxQmqOA4f0WuT9GPIXjHtV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pZxQmqOA4f0WuT9GPIXjHtV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the spi tree got a conflict in:

  drivers/hwmon/adt7310.c

between commits:

  9c950b125f78 ("hwmon: (adt7x10) Remove empty driver removal callback")

from the hwmon-staging tree and commit:

  a0386bba7093 ("spi: make remove callback a void function")

from the spi tree.

I fixed it up (I just used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/pZxQmqOA4f0WuT9GPIXjHtV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIEd4IACgkQAVBC80lX
0Gz+XggAhrfUjMFc0bg3rXBvjg7x8CqRjr9IVh5JO3IPPsRGZfcxAa1XsVoZ22IA
Pepvi5L47TFuxW/SQF5g3IlV4fzM5URGcrBpkV6K1qUwIpU3glXGmny9qlp4YPy1
tSy4MfoiAi4oWx5e9h19saPvyXGNbDMy5v9viEsbTnhmxhDlnScXqRxGB9daRj+X
mhdZ2uncZoliWF9cJMl1/O6laPISMD2rZrslPZu4oLBemZP4GFF5ii7bDSr4fXUH
fB14dlJuB4jHjJ9pCSYPGff34st1vAHti0zA2TX1ztA0FVMGOM+jKyDlLF5y5DmA
n8h7q/t62gQnlRF3tWRJcW4r4zrNYg==
=SiyM
-----END PGP SIGNATURE-----

--Sig_/pZxQmqOA4f0WuT9GPIXjHtV--
