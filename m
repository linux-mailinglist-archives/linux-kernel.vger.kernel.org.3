Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF82D57C114
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiGTXpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiGTXpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:45:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4DF196;
        Wed, 20 Jul 2022 16:45:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LpC4B3PCFz4xCy;
        Thu, 21 Jul 2022 09:45:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658360714;
        bh=B6oBJpBn5kwOYuxtOQkLahb0ijspbEt8Qy8+bLJHnTU=;
        h=Date:From:To:Cc:Subject:From;
        b=X7n3BddCRkkS0HH5OGMinsjLvfRuehazHlZ8/wZn4crbZzI20rI0BRf4Y1uw4aFBz
         xwimYxGLndw7MqdGyfHrNx+GraON7RxI9YwYCXaxXUZ0C2+DJ5S1Oo+0hBXnaRtieg
         LwH4FtrNc+fGY8J+8m9Sdx6a10uAuQ11/0vaW2OpSOjj6eiJO+8ZVrq21N+y9Jj38S
         Fiu+OjLZ0xTkPXJ9RTvA35qX/C+UrWkZkCyEHUYuqtHJo1pJvh35VZCz+c3B1M8kqV
         TCW1OOtU+IAQAwKGQYrtOjTaQYP6QYNPA6jO8QJVwF2RwQMu/hhfOJnAcYxJOr9SLl
         qI7i9ulNJ60mA==
Date:   Thu, 21 Jul 2022 09:45:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Collingbourne <pcc@google.com>
Subject: linux-next: manual merge of the arm64 tree with the arm64-fixes
 tree
Message-ID: <20220721094512.5419f75f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KBXJMu5JXdPIEqwsVqetM.i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KBXJMu5JXdPIEqwsVqetM.i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got a conflict in:

  arch/arm64/kernel/head.S

between commit:

  f7b4c3b82e7d ("arm64: set UXN on swapper page tables")

from the arm64-fixes tree and commits:

  e42ade29e3bc ("arm64: head: split off idmap creation code")
  c3cee924bd85 ("arm64: head: cover entire kernel image in initial ID map")

from the arm64 tree.

I didn't know if the change from the former was still needed after the
changes in the latter, so I left it out for now.

I fixed it up (see above) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/KBXJMu5JXdPIEqwsVqetM.i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLYk4gACgkQAVBC80lX
0GwHowgAk/oYLn9GA3lAdx7Hm6kgOvo7F5ToYMQ+1f+Ghb7sPDyot4XSCRpSxBnL
gwL202IlYzVmm0I1lHkoqyGq7GymTP0jZQTnTY4OvnSjqHL9SLLUZfM+/B6Hq71e
LiT7yaLE4QTS+ZejBnLh71V+/PdEfPxQIXZJAD1pRhi/GELHxFyxPCWXvqHcDxwM
jIxSongxEzE6GsvH+6lAz8tSTLzdu3hGDO3JY/KChANmwqQ+8e7OPKWsduTwvu0z
WoIZkCSuQjnxuA1ldmcpAtX0lUJWlBV6b0xOruUtOVFlYKsSemyaSLsed2GzP1YT
YRB02JBCOWtYrhuk9NCfM+17lSSmpQ==
=RaKZ
-----END PGP SIGNATURE-----

--Sig_/KBXJMu5JXdPIEqwsVqetM.i--
