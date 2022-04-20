Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44945082F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376580AbiDTH54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376586AbiDTH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:57:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4388E1140;
        Wed, 20 Apr 2022 00:55:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KjtHm60KTz4xL3;
        Wed, 20 Apr 2022 17:55:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650441300;
        bh=7DqJZLk9JJ2luoJ4/Lv5FieQn4ef6HXW5YFKn1HV/j8=;
        h=Date:From:To:Cc:Subject:From;
        b=BZDshJ7ODeEiJVB7Or/0tWR7PqG5efI47v1giQX2I5DC35lRLsYYuQQr71vSLcw61
         CAb50Tfw2ucIEgYIGVrF1mQr0QgAT2DArVWcv2OdkVRLTsrJtLGcXHSkp5qy/fiewV
         JZS9KlC3Bnx36gc1b7widY/ISEm9clUrkc13bjbRqJbCBoclggv9IXB4dfi644M1JD
         2eJ9FW/54VbIiF36x1V/ZdD/TlxdDjcwi8jwMFAUghzgNskdE8vx0x283aNTh9r0HV
         DAmJuNrSjn3hZLoHKGeIS1DS4rrbeEyDSlA9f2HhhsFF7iQvp4YMAl4dztFUGif1Wm
         Y32PGUGcamsow==
Date:   Wed, 20 Apr 2022 17:55:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the bitmap tree
Message-ID: <20220420175500.240e4eb3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WYh/yvE9rIn74qrixDodstz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WYh/yvE9rIn74qrixDodstz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bitmap tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/core-api/kernel-api:87: /home/sfr/next/next/include/linux/bit=
map.h:425: WARNING: Unexpected indentation.
Documentation/core-api/kernel-api:87: /home/sfr/next/next/include/linux/bit=
map.h:426: WARNING: Block quote ends without a blank line; unexpected unind=
ent.
Documentation/core-api/kernel-api:87: /home/sfr/next/next/include/linux/bit=
map.h:431: WARNING: Unexpected indentation.

Introduced by commit

  6f46c24da767 ("bitmap: add bitmap_weight_{cmp, eq, gt, ge, lt, le} functi=
ons")

--=20
Cheers,
Stephen Rothwell

--Sig_/WYh/yvE9rIn74qrixDodstz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJfvFQACgkQAVBC80lX
0Gw9pggAiyjb08xshT06M1IV8SEaekXyKg+ZHBMWRGynTqR0Iuv/SVlP4j1xMKlN
9T4J2J4JQbhU+OstBsR3NPZqSaaH/FOfULu1b+VlJLdNKDgZDuvdPua5S5nc+oMj
WC0Ejf25H4K/ItXBQ3UpMB+uiQ92sI/jCGritMqogUdv3PtI4YxhzNty2SExzJ0b
AuH0+hp1vKLRfjraVEcxwuJFhFIZZa4akzlulkZNLUNYs0IHLSx3xjMz/OlU0S+B
iOAIvrRjDg/Sc/ydEzoaJLoLKqbogM3RfZchvUKVBSKQSN12KWBI+IQU4BfS8mA2
E3xxEI4QPkDoHF8UgJ7MX3LOwJEaGw==
=PmVI
-----END PGP SIGNATURE-----

--Sig_/WYh/yvE9rIn74qrixDodstz--
