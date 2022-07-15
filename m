Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038E15760E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiGOLvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiGOLvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:51:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974AC3CBE9;
        Fri, 15 Jul 2022 04:51:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LkqSP4kTmz4xbm;
        Fri, 15 Jul 2022 21:51:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657885861;
        bh=sEZnAtFKxzXrnnH3YiF0Dd1JQDy4Mlwf0qaKprj8sWc=;
        h=Date:From:To:Cc:Subject:From;
        b=PMYDnEj+JOO5WcIRsgZy7MicDwsV+ipjlc4883LSw61KDAxDmvqqNa6Wy2CJkfkm0
         SKf2bVxmXHaKkNIY8HVhp41Ro64NY2OsMpxx2Cifb1HzXOzN91mIQG8/x/oc8YYzb8
         OJCeMWfZ0sgawVc+S2WrUH40htlEhQEI2foy6secVNAe4nXT+E7H+UrT8H5Dy1hbK4
         v5nm5vR4M12lAmh9+fI2+rFNxzfb4MuE8k/+ovyNcvq7nQfDNlLbD4z+fsjYk1W3ZL
         yaVLVDzBpzQdtl/mnRqCWIV4uGauyq2BkPz+km9g96SVpZM4Ib0dw5dB+8fCI8a7kn
         ns1g94rDWiWlw==
Date:   Fri, 15 Jul 2022 21:51:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the block tree
Message-ID: <20220715215100.6d9ee25f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Km/2CkKUA5.t25zEFvBD0jB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Km/2CkKUA5.t25zEFvBD0jB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (htmldocs)
produced these warnings:

fs/buffer.c:2756: warning: Function parameter or member 'opf' not described=
 in 'll_rw_block'
fs/buffer.c:2756: warning: Excess function parameter 'op' description in 'l=
l_rw_block'
fs/buffer.c:2756: warning: Excess function parameter 'op_flags' description=
 in 'll_rw_block'

Introduced by commit

  1420c4a549bf ("fs/buffer: Combine two submit_bh() and ll_rw_block() argum=
ents")

--=20
Cheers,
Stephen Rothwell

--Sig_/Km/2CkKUA5.t25zEFvBD0jB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLRVKQACgkQAVBC80lX
0GzFCgf+K4vIS/vL4hQ4d6gFvXE0P8XcMuqsfro/Aau50V0/+MnSrbitzOLXkO7p
qU6qf5ODIpMw9shQuDkG8CdSBOti4g0f/8e7bKePSLPfp+AFm+bux5Ido0S/DtjO
ga9aOAkNlseN/6qM2nuDYhIlWauN1kPMV8iNMXgu+RJE32Wdo0UH6bsSm1nHElTd
v79KS4Od9QqZBYe/TZgeEtYpCeUcZE/0SBkLAx9LdJodbe9kxOtWdd/QHZIg0Wlz
B3Om5tKeDEhkC4tio2luLIUX/+OrtDdPBAiZ5sI+aajZ6WRODz+Z802DSIsGoW9R
tEbxwz7YGWtjF0fShUhyEVJIbompMg==
=rTmL
-----END PGP SIGNATURE-----

--Sig_/Km/2CkKUA5.t25zEFvBD0jB--
