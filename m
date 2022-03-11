Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2368B4D5E89
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347600AbiCKJgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244357AbiCKJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:35:58 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E066C1BE0ED;
        Fri, 11 Mar 2022 01:34:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFLPQ21L3z4xcC;
        Fri, 11 Mar 2022 20:34:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646991290;
        bh=lwDxUp/hw1Ufl/I6V6gqcN35yraDwcV17dzlHziDAEA=;
        h=Date:From:To:Cc:Subject:From;
        b=EtVgwZeYBJhZeYmzoBTfpvi2AyPYddT+GZ2qqEEnPa8A+CPVW2p79QIG5nP3pgocX
         YDvu1XpImleNrbHVAZUJ2Z2uoaQAQnTiT3a2j7ngsT+reG+dlvT+K/ZIyA57WrttF+
         VjlU2zg8O78ux9V5xYN4sRrCbsH84qQl2aw6pD/l8SNd9gtBot82mEpEJ2+y3G9lF6
         O9z6EzCM6nlI3DFv5+/t0K+/MiHPBkVH5wwkbFBCtOEwGO/18C43akAVSP5AXbu8Wi
         1EGXLwmXiZXdousv3nbPOb+rtLzAm1akZpOT9pfao1B33smKo49AoxOyDFohAx/gvP
         wH3nWSpvBHZRg==
Date:   Fri, 11 Mar 2022 20:34:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: No tree today
Message-ID: <20220311203446.6d916402@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ep0E.32A17704ykWfvTBq/O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ep0E.32A17704ykWfvTBq/O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Due to a breakdown in our internal network this afternoon, I cannot
complete linux-next today.  Sorry about that.

Also there will be no linux-next release on Monday.

--=20
Cheers,
Stephen Rothwell

--Sig_/ep0E.32A17704ykWfvTBq/O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIrF7YACgkQAVBC80lX
0GyHDAf9GJoa2abEU7vsTMN3JWLa9dOJlp9W5L0Zc4jj8Z9DCg+b8A+AuVGqCD/Q
iS9wnt2FuqzUykp9RA4XXOcDDGOhasfLuSf+ypxcO+Cphtqv6YROaTlqnaO9S367
9Ej3T2919l+jUa1eJePrLepL0P357uU6R3trI9axdjktCV85t3tZA9PjNUfli9JM
lZ+Ivc277zddXUKF/rjp1UunGWhGg3yVaRxFq6/s2GKNN3GAA66whNEHRmWdHfwe
gSKM+BPZOcK6U+A5KALynd17VbNhMT/Fy4LVEAUqIWp7/l8jFMf2lItBEBWPIBog
qnf2q5rvJCUCRnZe2cSWhW9woB5IKg==
=p7L9
-----END PGP SIGNATURE-----

--Sig_/ep0E.32A17704ykWfvTBq/O--
