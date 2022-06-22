Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB22556EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377209AbiFVXVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359649AbiFVXVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:21:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A8B41F87;
        Wed, 22 Jun 2022 16:21:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LSzt00Vvlz4xZj;
        Thu, 23 Jun 2022 09:21:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655940104;
        bh=HYifQ3HmiCIehdNf6jNlAJGfOPLlA0jJLMStA/P3HYU=;
        h=Date:From:To:Cc:Subject:From;
        b=Kn3Bs9sE/Dfs/pPWUEUye1sPyCEt2bQR/osIaGCCKTquxu+QtenXJkfups+0RN3pj
         8i8vyWcOSL/b/CrmFJb+qD4cpYjzb95a463mtQTqClUwfL+EssOiqLKf7s2bZ1NfTK
         MjFvjU6yf9/286ga3z6LDZPGMugdBbUjSWEa3fbw0yhtaaWYWTbHWQ0DwcivgzBCaF
         IRHD9KM8uc+WikNbcJK/d0g5HNSJrorMb5gqBhhIMqch5asZ2Vnc+gFH2CCxX6JHse
         gPcir//edl9fKWZKjjF6wE+siehKowS2U2CfHldED7FRAMh9MwwxTlHCctyBPPmbGE
         I/PqwKDPiSr4Q==
Date:   Thu, 23 Jun 2022 09:21:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dylan Yudaken <dylany@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20220623092143.2b9d2e7e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WgINVQtuHRjWKk3hVb5KZ5O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WgINVQtuHRjWKk3hVb5KZ5O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1da6baa4e4c2 ("io_uring: move io_uring_get_opcode out of TP_printk")

Fixes tag

  Fixes: 033b87d2 ("io_uring: use the text representation of ops in trace")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/WgINVQtuHRjWKk3hVb5KZ5O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKzpAcACgkQAVBC80lX
0Gyljwf/a47aTnZfWrIiDtulH5zV2y2SSegar4GySA1vYOwK/WHucvy74m7zdh07
1NgZ3Buw1Ihaphb7zbXj2+7Ya53MqMyIdR1EB2A0FA0qY3cGp1hz+Txo+cregwpk
cp4x+AFKP2Ch5voPfvamLs1RwfEC4odf3/kzc9ugMMv0JpY+TtcatqqyI0X1x5Bz
AnIhXoXJk/o5p8noatn2LvItnK8/tz/+0AjKelkpNEVqzdhbI7VWBwC/ocOVeUJC
l2Iv34EWKTvD7lrhj059BxMnJgBs+TdFv7WG70QOfuipxWUaGFggaWyDaDVBZCPK
zdjlhIFCeRYU5wA3aa/TXBL0DNhe7g==
=QYer
-----END PGP SIGNATURE-----

--Sig_/WgINVQtuHRjWKk3hVb5KZ5O--
