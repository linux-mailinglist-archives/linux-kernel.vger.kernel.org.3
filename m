Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14650936C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383132AbiDTXNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383122AbiDTXNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:13:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9550B2AD5;
        Wed, 20 Apr 2022 16:11:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KkGcc0L9Pz4xPw;
        Thu, 21 Apr 2022 09:10:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650496257;
        bh=UEENmFCiIHc6YhyKwFZra1jHcWhXySN9kSsLIlKLjUw=;
        h=Date:From:To:Cc:Subject:From;
        b=o+ONvwfnDuKmbB7SEilZ0xzNQcuYYiu4R8QcUxan71bpCSH0mXe69+Am9Lsy/a4IF
         NuAvWz45K0MXOPUK39Vl+4QeUCCUal1aSxfUwlqhyjLTmdwvbAYK7MXBu35Pe92Dgu
         q/+yHwS/EdktLrXe181hwGPhgYxqQgpAs4DTzboH/y13uhfLJ4XVIEUzdCuxCi92Of
         XIwqi7JB/otHmoiwo+W/8C5JSkN2pP9oeTTXxkiPU2KfqkbOZx33sTlypVEWvyWNbv
         bMB2BlDf+7UPZTSPpja2c+M6N5aPcMd9AckC+LJOj+5RMM4Cbyqk2eSRbFaSpIPk03
         As17ZcS9WZaJg==
Date:   Thu, 21 Apr 2022 09:10:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Caleb Connolly <kc@postmarketos.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tags need some work in the pinctrl tree
Message-ID: <20220421091055.12d6465c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uhSgl1LpokmC_rfP9NDKK0j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uhSgl1LpokmC_rfP9NDKK0j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6548c9dc711d ("pinctrl/rockchip: support deferring other gpio params")

Fixes tags

  Fixes: e7165b1d ("pinctrl/rockchip: add a queue for deferred pin output s=
ettings on probe")
  Fixes: 59dd178e ("gpio/rockchip: fetch deferred output settings on probe")

have these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/uhSgl1LpokmC_rfP9NDKK0j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJgkv8ACgkQAVBC80lX
0GxROggAmKk1godPw5I1KXjFoE+D+O6KnZEuzJCu3Ixj8f03fidnY1u3f+aebD/T
JkXNXcEEbyUh3Cz6539vqWfYL7xANz1iUhqX73g+6We3knLzFLlKLTc5n6/0Q2Bt
KfIxS+6SBUkIwmByLPyHmVMFKNec/Y8Hv9E2BLRJ0hZXitLeK0UiVEjERhpCgUtG
GpmANl75OM8WqeVfSuqf6oZtE7MEGIw8P8TrvHJQU70u4GZYm9o8X+a5n0xXD9r7
qqrxRlcuS3P1AwYMUh2GkNh/nYPKU3tx5oXk3feWIViXTq78jhhmbzLwjlgLide3
ccqCZxVaOJhO/F1fKXa0b9xNXyOTSQ==
=MGJp
-----END PGP SIGNATURE-----

--Sig_/uhSgl1LpokmC_rfP9NDKK0j--
