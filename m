Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41DE55C60E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242605AbiF0W3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242599AbiF0W3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:29:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B7C1D329;
        Mon, 27 Jun 2022 15:29:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LX2TH4Gbnz4xD7;
        Tue, 28 Jun 2022 08:29:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656368963;
        bh=foNE8+STetKHLW9gvq5OjeihNJs/X332ytzxq19xnus=;
        h=Date:From:To:Cc:Subject:From;
        b=L7m1x7SZZ25836svGrCtZOBtgom0bXVsDID3AvFGqzFHQtpXhE7ZcF8I1xVyDufEV
         KlvqSLlJq14N2eipApiXG0jEQss9fpym9tFQwo1BWvqpb49Ls6rWI0aU7bEPNpI3T9
         G5LFdFWdXOzAX+sBj1CEl4NeAHGF2cYcHCMTcRl52eG9rl6YeZTmTcRLygtNBvwPc0
         COFaUl7d0RQKLvjSpP2/8ud1jynp38U6qUCWY+NyU2zRgz8eq9dwa39VR4X37KePNu
         fM0IIQS7Oa13fmxOqjc4xaY6rRONk6iwb5QjRNMpWoGAGDwtWAAUP0s85d9LrfnDfX
         RaIKTujT2ri7Q==
Date:   Tue, 28 Jun 2022 08:00:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm-stable tree
Message-ID: <20220628080011.66159fd8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HQ0_MObXkoKx1unRwB_hdEa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HQ0_MObXkoKx1unRwB_hdEa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/HQ0_MObXkoKx1unRwB_hdEa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK6KGsACgkQAVBC80lX
0GwK+Qf/Tzy8+EflJLhmYkZobpd25QjBAoO6fVeQ78Nl0kGvJS1FZaG3HpvaoRfC
ga6jAQNsvhjL6+VJYjolKE0eV9EcRy2GzHDJ3AgT/DJ2lgn2abSZ6/WEd9XoBVPg
mIT/JkNrRFUSYUXbZU3MiwHc4SAMOZhHJLELXB9Tqw4fQLR7r0ybhnZNfmw4SGu0
lzz9RHqoGjeCW7drjFwG5xc6wBYgOU3ngBEzTeLmuAY2U2ug9V+aZ2weG411hz5d
4x7WPU53ofD3eBFUYG10AAmej1un0ry8GG2PFLj9ZAGMpLahnp+3MY/C1Tg9zK07
K9c7pMdWJwlfv9Y82vgTMdipZFyTLA==
=Essg
-----END PGP SIGNATURE-----

--Sig_/HQ0_MObXkoKx1unRwB_hdEa--
