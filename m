Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7009B53344B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 02:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbiEYA2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 20:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiEYA2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 20:28:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCA73796;
        Tue, 24 May 2022 17:28:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L7Bjn0w5Qz4xXF;
        Wed, 25 May 2022 10:27:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653438477;
        bh=h8jMTFzzRLDz5WEC/0XmzjbfMm7ffIIAkhGCF9w4eGk=;
        h=Date:From:To:Cc:Subject:From;
        b=b4SoyCArsOWuSAuGqni3th0h7lpDx+tTGtU1Dj4wUAD0vk/orXUI5TgaMMtvWwyQ5
         zEsKBxkvDIQjgQLxAJdBzhjAjGLlYtYfqWuSM/CvLFC5WT7VEu1SmuwFeAAz7a1bZI
         7fbZIBrmWv3tIF+vK5VHb/+QFCu1U7oUwsPCJFsYM1P4QTgXqy+z+n6oxoaEAVRjN/
         X+Yoy+YB9kN85nnCHxhYgCuHhfBPbVJvmP4TJx+JW+MwwdMXyvE29fi0Zv8nrQVRfc
         AfBsC/vWlztV5V44kLxdQCMA47DgigqvvW5ePxsKz96DsF1NSLTunaePqUT/kiEmkf
         f9naYKch0aklg==
Date:   Wed, 25 May 2022 10:27:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zi Yan <ziy@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20220525102756.368f6c02@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nWTtp/IluMnOfuCa7y+jZ.3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nWTtp/IluMnOfuCa7y+jZ.3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  29a8af92b874 ("mm: fix a potential infinite loop in start_isolate_page_ra=
nge()")

Fixes tag

  Fixes: b2c9e2fbba ("mm: make alloc_contig_range work at pageblock granula=
ri=3D

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").
  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/nWTtp/IluMnOfuCa7y+jZ.3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKNeAwACgkQAVBC80lX
0Gxxdgf/ekHKeqYB4UJLlnCz6LbNXMVC5RRoAUobMx6MnIBBtlZTVkbU84v/TEIc
I4JiIVYu7HKrgHx6ChtxJWgkyEaoRMYvsrjyBMUA7HVtqbk762gEeC9pEWg786zw
PPRknxd6zslDSouMsPDFBCdcktDoH+3k1GLutexnec+3AndjGHjVDf+X5U6sWADA
qe7mOmj6Vb085EXW1IzpUDFVjSkoViEbWKa0i/v6Frn0K5kZsFnVW0qYnX4ZKDo9
AUzCUzNdBikXEPkJNr+wADzpE22NyuBlUX1nfs7QwF1n+leRihgNJBcOSz/8cyZe
yzXg2aIeaTAamvWes3VfSMoJt6Tr9w==
=Kw3D
-----END PGP SIGNATURE-----

--Sig_/nWTtp/IluMnOfuCa7y+jZ.3--
