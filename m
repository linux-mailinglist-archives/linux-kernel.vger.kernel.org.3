Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFB859522B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiHPFoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiHPFnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:43:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5644254A68;
        Mon, 15 Aug 2022 15:33:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M68Dl4Xdzz4xcR;
        Tue, 16 Aug 2022 08:32:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660602775;
        bh=Y1hgtDii/vNed4mKC6W7wNfhq2enxkj3lR421N7PvlI=;
        h=Date:From:To:Cc:Subject:From;
        b=n6zenz19snzObCw+b25c3+TEbmd/ixqiPNDSRElRnSiAwX/H9NxoF2f6wg3QZF2bu
         AooAl+Sa0g2Cwm46guPu5OZipVPzblv1+HypLTT+hUw3Q2MkEMUh8GtwWMPAcleX2/
         mt/huH43Bb2FdjcwdTh+XEthsl9kSOt3sIJ54+zoX5IPHiBwGf3EYjphOFVnD7a93B
         /fmSWoZdtsjTRPBT16WllT33EehWFSxz2o/Oqn2WiltZi6KXsMMBnpgT9OalHwRHeu
         F2ox7ixSfnW7spi4nicsMaKWIANUCJ2AsvaRPO4WgeRpBvzahxxduM/DPy4/yBZhSY
         0Z8H3XDUJXAxQ==
Date:   Tue, 16 Aug 2022 08:32:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>
Cc:     Hao Jia <jiahao.os@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the cgroup tree
Message-ID: <20220816083238.0aa28080@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YSKHpO==7.b2z.qN0AXBYwg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YSKHpO==7.b2z.qN0AXBYwg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6d73ba7928c0 ("sched/psi: Zero the memory of struct psi_group")

Fixes tag

  Fixes: commit 5f69a6577bc3 ("psi: dont alloc memory for psi by default")

has these problem(s):

  - leading word 'commit' unexpected.

--=20
Cheers,
Stephen Rothwell

--Sig_/YSKHpO==7.b2z.qN0AXBYwg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL6yYcACgkQAVBC80lX
0GzR4gf9EWeEspws2yRCpYNBEMiSi5JdZRl6ESTbcQMV/Yfu8mx3MERI52HBWRu3
fpqOlIsMTzaaHhVOmZ6uOggQsBjHK2zHFuGmqFvLV1y/bAriIuk4HiBKPzTiy0us
IgMQcVnVy5/UMi5jxiEE/exsx/V+Cm4D1Xwl4RUR+PV/FeBWPTLJs2vsOL+jB5Mn
5coKieEtTXQzOaYLxUSsGbQoXB3N9ZdPenWq9mk0KxPhhPNFAXreOJpLFTeOTyZo
j9ubanjc2sQDRR63ZeVqXp1imsU3Jqan4CDxlPQ66dUBuwSq/q9ZrLVr0R4/ixQB
yBgipwjOYale/ufSwaxCJvEqM8m6sw==
=3w1i
-----END PGP SIGNATURE-----

--Sig_/YSKHpO==7.b2z.qN0AXBYwg--
