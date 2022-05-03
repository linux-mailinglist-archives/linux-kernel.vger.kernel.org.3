Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CACA517EDF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiECH3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiECH3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:29:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ADB36692;
        Tue,  3 May 2022 00:26:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kss2c3dT6z4xR7;
        Tue,  3 May 2022 17:26:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651562776;
        bh=hhik5NJxEhsqkUYGQ5DJB3BUsR7PKS/ZPUlsKriqvZI=;
        h=Date:From:To:Cc:Subject:From;
        b=a6fyuLPS8RL+1q0UJod8RTDQqiq9jU2JEMXHOqkyOtdSwiBcfgEYCVQtl/ksQJemR
         tGNNX/bAscOva9jiRH3nVAU/3nrJAd0nqghIB61zHJCpPzLyX3cbHkP+oCO5lQA06v
         gzWNbUmHHctjWHbeMtyP6yyHxmTZj23OllrDSskJnO479O0csmoyvEi8W3+IgPslc9
         DifY40ulGpxNydCVtfUzhuLTVmzeW+BelUFSuoWeXxfYSJr/oHUnLCD4k+YrA7Q6JD
         F+42nD1ziSbRk/awXsYlbB3MEttoozAW6QBo0NIiuirhMusc1LUFcn41r6ZSe+kc9T
         B5p5eLFiRap3g==
Date:   Tue, 3 May 2022 17:26:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the folio tree
Message-ID: <20220503172615.1a5f1c52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5qRXg0rnPfbIM_kljiubDeT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5qRXg0rnPfbIM_kljiubDeT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the folio tree, today's linux-next build (htmldocs)
produced these warnings:

fs/jbd2/transaction.c:2149: warning: Function parameter or member 'folio' n=
ot described in 'jbd2_journal_try_to_free_buffers'
fs/jbd2/transaction.c:2149: warning: Excess function parameter 'page' descr=
iption in 'jbd2_journal_try_to_free_buffers'

Introduced by commit

  13e184c175b2 ("jbd2: Convert jbd2_journal_try_to_free_buffers to take a f=
olio")

--=20
Cheers,
Stephen Rothwell

--Sig_/5qRXg0rnPfbIM_kljiubDeT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJw2RcACgkQAVBC80lX
0Gxi+wf/RSbzYsrV6vz/nc9cwAJzcKDQDCp376MJixWIaC/f+xJ4heCoCCC4W074
oKjFsOKPjOwlKwyWZcJv32BxPXad2Oa1gQgz4+WduCVyNDbmEbiQyy2E1hDMfkf6
9XNXZ/ZfN1xN8nlhD5Cv1Fvm9k6yJnVZDdKnzo8RXjbLWQaFEdB2Tp7/wDlkAEa4
0WWgfLOyXvgcInG8XGbhGAzyUfSmJSZShmT8GsDSgF4s94UTjCow0fqoObsNB2Bm
I0a9JAkuRf2hY4zmBgd7u+CEWuMyrLhiKXUza9jXpsKTeuZXRu+hFjPUgfJx1+W9
zI5VsQGTz9GlR7wgpmIsHZ04BMfgKQ==
=kqKd
-----END PGP SIGNATURE-----

--Sig_/5qRXg0rnPfbIM_kljiubDeT--
