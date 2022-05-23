Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9C531EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiEWWfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiEWWe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:34:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBF2954A2;
        Mon, 23 May 2022 15:34:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6XFr3bm2z4xD8;
        Tue, 24 May 2022 08:34:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653345297;
        bh=I0QSm1nvgJNMhF+iErXb5XZtGLWtsr37a0tAocWjtyI=;
        h=Date:From:To:Cc:Subject:From;
        b=k+1YCUz0lKNImQqWAVhmlxFpafwuUkA8ZKz/xp4xMi9RNHvrE8Dlxv/Eo4c0AwbQU
         Xh5D+uBDjujSKX4QnbSsKEO6WMycNtoEqwCiaZ2QPGoBawKDBKEKpshUm5zGQOqD9Y
         BtYGSCuhQ7ybJw9bVP5R78R1ywMHNW9GtzSE1HqA8lwoG6Or6ILQW/9f3B4s0siKf5
         lBrgWBhZSNuOG0RsACAD+tcs8XSPM7MH5KwtCCa6J6R1yV/wsUpLEe8YJmwLanvuHy
         zoGx7NkrkjeFv+GHUspzjGA4ylXjBSUxMshex2Y2dEdf75XwLlH98pEEswsUAPoE1g
         FcnDdjaR1jc7w==
Date:   Tue, 24 May 2022 08:34:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the livepatching
 tree
Message-ID: <20220524083455.666052d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9E65Lrlik_8dz.XqhrsMcFY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9E65Lrlik_8dz.XqhrsMcFY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  1751eacf9794 ("livepatch: Remove klp_arch_set_pc() and asm/livepatch.h")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/9E65Lrlik_8dz.XqhrsMcFY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKMDA8ACgkQAVBC80lX
0GwYoAf/Q0qEGSHmMr8mjeefYgN+o2d9g1HzZA5deW7NGutO/42BSxLE8nkAp14i
iLIBgQgchFyY2OR/X1j/lH7DCr8DZStnjnD7BjCQccRo+Xt0WW1wzUC5GLjtcjhe
gvhQw+X+cKddDCFts2SQwIQIKwLyGLtr96w7ThrX6vqej72Q6nOYZqvltceZ2aPt
nHc7ZeTfx3lfCbmokC1oyenIjcAkPlWzPBqmu8dstwnv2AN+jRnTmZuDQxRAhzdD
C2JSecwAssLVFCvbWxsA7Nf21OlpNm8adVKmHFlE2Q6sgyXw8GH/xmBqAEzvjXUU
+Cp3qzVLpFOpc2vm4V20+PiyhXi8AQ==
=xapL
-----END PGP SIGNATURE-----

--Sig_/9E65Lrlik_8dz.XqhrsMcFY--
