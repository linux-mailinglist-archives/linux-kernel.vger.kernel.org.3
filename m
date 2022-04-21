Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEC450AB8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442501AbiDUWfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiDUWfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:35:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD00E3ED13;
        Thu, 21 Apr 2022 15:32:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KksjY3pm7z4xR1;
        Fri, 22 Apr 2022 08:32:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650580337;
        bh=2RMjU/1nKzReQocXsyl+iN2xG30gdfdtJe7bu8gpSdY=;
        h=Date:From:To:Cc:Subject:From;
        b=ayRZsorVlG6v55fzlmPpR0/VvsqSDAUVb/hvkpCTj31zdjppEXRcvOAZ1dfL0tyHp
         ZUNyMbeVlQ+hArhJFQL3ze+qwaTozagQtQac0L8iKb8mIKS6JFpIXClP3jUc19oe7y
         V1THY1cJKn2HY7pRbmCn7xVl+pJ/TtBEC7nw8VApUO7Xq3zlWvfrPBYbKV7zpjkbWp
         2B+SRQamaUQk87w/trPeOeZzJUIhXMI4aQ9NqwbArp/Pvwf5QWaYgtoW2wHRvxSUIE
         TKTJX4/ub6gC1WzLBoiFeDcQKIfq2n2t+3AkECWI9cCOIgtc5lmPasCVYZc8Dfhlsr
         Lg+rORNl7DYoA==
Date:   Fri, 22 Apr 2022 08:32:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pinctrl tree
Message-ID: <20220422083216.304dd75c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cY55d0FL/FIVt/P=qUWCFDs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cY55d0FL/FIVt/P=qUWCFDs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c04c391aa743 ("dt-bindings: pinctrl: add rockchip,rk3036-pinctrl compatib=
le string")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/cY55d0FL/FIVt/P=qUWCFDs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJh23AACgkQAVBC80lX
0GyZMQgAntM0q1s0qEl7MsSBxEJqM2idix0YDTmIf9J3NO+dvbjVqnI5OyhGkkgT
F0s1Gn6+04nW3tZEfTDZnuLtM+ASsMhV2bOoqh/egDvYwTevaKccQrLdISQ1dkYK
B3NIjPkhlpCQDV6WleT36rlw1ZBXkwx+XRJWkPR2kZnNi8vq4p6HDKJ6s+68UWcN
aOPthXhRpRDih2zsQKj4RgWpKV14YUMWdmE2h7cs2r1g1A3edtx/zKsP/YQMMq5c
lTSCpWorP1vWQha2sDBDLbAfI1iLB8ID9VlEgKyK1axjyeDQY2Us0/jmjkR9nEmb
XMhisWngOtJYmxmLbAX/8CU0+Cr10Q==
=3RZN
-----END PGP SIGNATURE-----

--Sig_/cY55d0FL/FIVt/P=qUWCFDs--
