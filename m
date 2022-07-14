Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222F15757E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 01:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiGNXMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 19:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGNXML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 19:12:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA14E13EB5;
        Thu, 14 Jul 2022 16:12:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LkVcj1klCz4xj3;
        Fri, 15 Jul 2022 09:12:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657840325;
        bh=5H/p7fC0T7O0CKL7lcUQrsN0T83Ij9Fuk1Fp22Ad9xs=;
        h=Date:From:To:Cc:Subject:From;
        b=T1t65oLaJwVKZsIJdfInsG64wh/mNEFDLOf3MPQE1biuH7YpHnJ95Z+Jov0YI4HhD
         GXtvpKaLK6JOfAN1bn825Q0s8WODDqO0CXhEcBXrwTbsVcMNRMW8aI5ocWqZ/Le/Ue
         l9jb8BqoRQdvNaizMj8BQRssyWBLNfiBMDwdSB1/nX4FQcEHUbLOWdGRo9olUVO/E9
         HGJPqYMPGG60JM4tm+JRmuloAyywb380F/6ekF5sRPpQpN/NphCC+hYN41frRRPvvE
         24XNRz4KFcGFT7PcPhpBZ0EhgkSvgjDm3UjP6HKZVP7y36qbZaWI6suaQ3cJUCTdHh
         EHc0690fohrjA==
Date:   Fri, 15 Jul 2022 09:11:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the integrity tree
Message-ID: <20220715091149.3136235c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yloJtg/GQj0hytyyf=AnVtt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yloJtg/GQj0hytyyf=AnVtt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  47e766ce0c21 ("kexec: drop weak attribute from functions")
  0ce9331cf85a ("kexec_file: drop weak attribute from functions")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/yloJtg/GQj0hytyyf=AnVtt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLQorYACgkQAVBC80lX
0GzLAAf/ap/GewdHdNr+KFZX/j2nooyvOcb6Na8NOTnx05yWjkZxy4Uf1pJdelm5
MDVGDrYC8q2gEkHYrx+GX3ZfxabZ5pBS7OVwbRu35QG+fwuLCUGNPufyfO7Vi2ZY
IlEJvRLnU0njIfu7DNPCUHxpYhE2Q5n1HaJZg65qTtuMyRyB5nosJhbnT2e6gxRd
aG8DNAN5EVTQW8o0QhmKdQpEAQKY4Q1TDc/UUiNR/aMqOV1WLkHGah5uMZS39xdD
YRa/FXHrdC/6CIcj4daNNOtzYvnl/hWNj+eX5ijQA0OyDUML+IfhMgXUBZeG94zN
k3AT1HW9S589A6l7FGi87wgfrK1lNQ==
=aHTc
-----END PGP SIGNATURE-----

--Sig_/yloJtg/GQj0hytyyf=AnVtt--
