Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D77F4D2E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiCILfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiCILfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:35:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217C941F8E;
        Wed,  9 Mar 2022 03:34:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KD9842XTVz4xv3;
        Wed,  9 Mar 2022 22:34:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646825652;
        bh=NsQVPQVh1PgZx5a+T1En0yHz5TTdkRJ6c5YkvK6FJa0=;
        h=Date:From:To:Cc:Subject:From;
        b=SuVh6q4Gp6y7AT6sy4r2S2VHiYr/jAGcrrc0LxiTSnYz9K3HvvcnselntHF4RofV4
         LXQpqclizXExLrmpuXW+Y8ZUZ4cAJLbTmgmtViqsUVGkt3m65qcEvfZmttrQ7gb/tl
         z6cU99V2lrUrsAa/2tYul1PYgPcsCYZitTCwWN38dPFEkTzkT9hrTe66usqUxkjvQG
         q5OLWIrxx+r+eh5ZkH0ExQTu+oAAt37dz0R9Ommx6V10Pa1Ns4QfveXzaPEEDcw69v
         7SOOHgrP7zKZDGHKohha60N9o4rJTVv9902/9OvvpiznK0S5Xi/Xw/nPMRlEfmRDhQ
         oBfcVH20GbzwA==
Date:   Wed, 9 Mar 2022 22:34:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Huang Shijie <shijie@os.amperecomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the arm64 tree
Message-ID: <20220309223411.5492e665@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/okQUn0J9b9B.N_0uWaHAOmZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/okQUn0J9b9B.N_0uWaHAOmZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm64 tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/admin-guide/kdump/vmcoreinfo.rst:498: WARNING: Title underlin=
e too short.

MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_E=
ND
-------------

Introduced by commit

  2369f171d5c5 ("arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP ra=
nges")

--=20
Cheers,
Stephen Rothwell

--Sig_/okQUn0J9b9B.N_0uWaHAOmZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIokLMACgkQAVBC80lX
0GwFMQf+IGcbq4BbVduG8T4NeQYiFVTDifPkwKMMqdKX1V6wDbA82cyMRKImCccD
KDVjku24zu67uaqtqrx3OF8ZPqyQwYHHHzeQ0F/LYBdivYtyXoAsogNPbSsyoeLt
ulVrcNsDqGhHpnrPYwuiqlt+b/3fJIusaTaXXwy91/rDZ//V7K1snwnBYPrgdf7S
sTT+wti5Gti7jjk+Mv3fuTQeHMiz+1p5KN3z/qnrrqfxZqJ8ZQHjykFJcYX/lczi
qSFE5meYBL3OaBijH5CNy1WLckcOKu9PWVg9oPh2piaH+sogyohlFergUaT+Pemz
bj0Bm4JHwShB+nXY+r+leZc/X1yx+g==
=l2aL
-----END PGP SIGNATURE-----

--Sig_/okQUn0J9b9B.N_0uWaHAOmZ--
