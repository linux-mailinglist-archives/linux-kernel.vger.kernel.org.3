Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554475B29C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIHXBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiIHXAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:00:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0882D07;
        Thu,  8 Sep 2022 16:00:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MNvjk2MpSz4xXy;
        Fri,  9 Sep 2022 09:00:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662678042;
        bh=qz5Lrx2c2MWmCIq3Hyin3A1WrMqejpf+YarrcGYBbn0=;
        h=Date:From:To:Cc:Subject:From;
        b=utB4jikDc4Intsv00aOcxrVAHne534vhEsl19iI+cu3t8SFhNbN+gvwMf1AfG4Dn/
         NJGY3ag5EXI+Zo6vtRDu7pE9w828DkMyhrX4XmUq8ZFFQ8AQU8RdagBR22LGJcQeT8
         DHrfk7sGngH4uY0jRYRDg92BcGMb30KkIJHKe7DNJDKXdRS/ebmuo7Ti/56fSgUPuY
         HLcHXW8vPn4qKvA8eOCtkghEMHAMoebqaJp2vyXmkdVvHNo3/ngEA9BDp7Jx39tyhP
         wwUyUpZMrRTw5XZ3JOcxTZNs2YmB/wJmSYSKuYODUZCWyGDMwmAgBZ9IKw+VsuDJg6
         +5aTbXy9pt8nw==
Date:   Fri, 9 Sep 2022 09:00:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20220909090024.47458048@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tPggPsWl9sMS8..1Hq4NAsW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tPggPsWl9sMS8..1Hq4NAsW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (x86_64
allmodconfig) failed like this:

make[2]: *** No rule to make target 'objtool/objtool'.  Stop.
make[1]: *** [/home/sfr/next/next/Makefile:1361: tools/objtool/objtool] Err=
or 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:222: __sub-make] Error 2

I have used the kbuild tree from next-20220907 again (with the last 4
commits reverted).

--=20
Cheers,
Stephen Rothwell

--Sig_/tPggPsWl9sMS8..1Hq4NAsW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMadAgACgkQAVBC80lX
0GxYlgf/WFIvsoLgERjoCYJU6/7AeD3JgNkhwpMiwjvMf+a/rGg8whpxgfwfKEYE
NC0dPX9BivtM/FQypROMgMEhp6uoMgMA7wx744sG4+kvbftKANJqMiFSRxtph7Kn
Tot+jLC5GiFRHh6Su2LjVYLuQAvsCJ8qwIwJdUiuAqKj27L9OXODe7z0D4J3/Uyu
tOhliNiG/3fgbP7YBjI8Xl22+8tKrTXG7qPoRf+kXDUoJZdDB8SjB8/QMYJZyRsf
vfZyMnVmGiKfTDhOSPz95663zAYUfxXJfB1KQTOjQOXg6hSJU1q3kdCqsZzdTpxV
wR+b3hLu65kVXGHmp/9tiF+UojN8VQ==
=KtgH
-----END PGP SIGNATURE-----

--Sig_/tPggPsWl9sMS8..1Hq4NAsW--
