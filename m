Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C4057FE8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbiGYLnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGYLnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:43:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49602AE49;
        Mon, 25 Jul 2022 04:43:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LryqF5dZDz4x1c;
        Mon, 25 Jul 2022 21:43:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658749417;
        bh=oNsR/iRPF8Qj28zfvZsfPnf3s9VgSDaqUV71drIQG64=;
        h=Date:From:To:Cc:Subject:From;
        b=K3f400Cq/iHQ3B5KMFjaTYA69wU1HDekP77Q798gN05WOOjk8MnounvTrvk7fZANb
         9+YHQmBbEjRFEV/3vFnLiO/G0T9KZy5phEQSwjtNt1jzG0bVjKyCwHS8cnz3O65P3M
         H7wKFiw2Wab4XaPrFYP6LAZJQnbcPwN789lp91uuCZ8kdRGBC7Mhg4DEDbf79DyapI
         +ZWJA6P/u6RuvSN4kCejsYyRuJMZ6UKuZCCdtArQNUuVbBBS+yYXLKQBF4LMXU5G+l
         EZcf0yBNbtZdWcqBvoNQlS1ZY2Hij3M96r5NiOJ9ORdrLghMywcxZAfxqU6jVHAAB6
         ZzIl26XhsU7ww==
Date:   Mon, 25 Jul 2022 21:43:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the hid tree
Message-ID: <20220725214336.6ffc050a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=Q_cUMPkaqnT9bB7dEWKc7m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=Q_cUMPkaqnT9bB7dEWKc7m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  7af32d156ad7 ("Revert "HID: nintendo: Fix unused-const-variable compiler =
warning"")

is missing a Signed-off-by from its author and committer.

Reverts are commits as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/=Q_cUMPkaqnT9bB7dEWKc7m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLegegACgkQAVBC80lX
0GzWrQgAmXaISJRtpoaR3CRxpySFySXDDlwtyFIeImQIgLLH51japMgsydd7Ggut
SSpiT6aEsUpzFU5Lor+c5prROVekQbglKFwtv2CQ1Tn3bMXXQGskXL4oJwcfw7XB
cTZRUg/m+ExULTgJ2SpyuZCKTHthcv4N6NHnwh7HLeUbv/Q47P1pqQG2m/zBGHx0
tNs61ttfv5NqY7yu4b1wARX8P8VvnjBmAouNC3MOj8k+OAm2BKRfGS+XyXyPUMBd
ZL1JZ2dZP8Tr8K55jZqgB/3vEHc0y/dqQPucHE86sNiwfc5hKnWstCmVPP5uCEbZ
4I0q2sSwgulc4sjB3pGgdhINylRfjw==
=OlB7
-----END PGP SIGNATURE-----

--Sig_/=Q_cUMPkaqnT9bB7dEWKc7m--
