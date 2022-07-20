Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5957AF85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiGTDdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiGTDdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:33:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445AF4AD6D;
        Tue, 19 Jul 2022 20:33:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lnh9b4vxQz4x7X;
        Wed, 20 Jul 2022 13:33:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658287987;
        bh=yeT0T8sl3f5CMlfElIi35zvn/RyvABpe2VQN0nmmo2o=;
        h=Date:From:To:Cc:Subject:From;
        b=TssjS2cfHeUzTMlN7CWzsdUy+8ymfIsCdx2oIaj1L3LJeoupxsZPugncaAkk8GGb6
         XfmK9FO34z0GqPTCad6ih1oWPQYgbgqLqM7pOB6Ypit86j8hjYMMT0t0SXy0Wms2H+
         WB5zrkk/ag+DTLbSWOYvI/sVyfceOgZQ1oR/93bzpXMUMYGKbJOr79afCfE3akPU5t
         jBYi0ShwU0xZHcbBhIGLGYWnbgz03SPn3ez+mTUN6Wzr/AFvvd0ezO8lk1Qa0NuOiu
         IDb9Cj0QcuN5n1h6EMqgKVDzRAeIthEOMEkM98wmgyRNzwc93kQMnCGFCMPoyFJVB7
         xTEFt0jXYEqlg==
Date:   Wed, 20 Jul 2022 13:33:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20220720133306.5f708750@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GVlv/sUkjc4xueo0.6sgqv/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GVlv/sUkjc4xueo0.6sgqv/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

io_uring/net.c: In function 'io_sendzc':
io_uring/net.c:980:41: warning: cast from pointer to integer of different s=
ize [-Wpointer-to-int-cast]
  980 |                                         (u64)zc->buf, zc->len);
      |                                         ^

Introduced by commit

  bb4019de9ea1 ("io_uring: sendzc with fixed buffers")

--=20
Cheers,
Stephen Rothwell

--Sig_/GVlv/sUkjc4xueo0.6sgqv/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLXd3IACgkQAVBC80lX
0GwF3gf/YOFbnIPc4zS6C0YqScH6jM4tYQHH0stbuoYzNEV4CFZ17A4ncQM0Mugs
I0gsKTEha0scQqzqgpW4vw0fR38XHsh/FahxNHw/JXjLcKlGnwINZt+LE1BlP9k5
K3nmV+OHLuIxYEnVY7W6rsUwOWcaDRa8Iz+SUfCiTL5HjDQrRsm17ZZczlBl4gSY
MD9ZD8UFSKWZwLyYAwwQlEvpiSRmytxX41OzXxpBw3vtLWgt//W32lK4nVHTwdM8
77bgN7IaGp7c7jQOmwgkbqZCP4a2Xv98WSrO90rpC1NSPkpVO2lhvh9rwPJ5sjDD
1wB8o5U/X0dnQfYjAbQldI4l4WeuSg==
=Yj1k
-----END PGP SIGNATURE-----

--Sig_/GVlv/sUkjc4xueo0.6sgqv/--
