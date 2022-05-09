Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4618D51FB02
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiEILOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiEILOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:14:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CDD1A35AD;
        Mon,  9 May 2022 04:10:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kxdk63Qrpz4xVP;
        Mon,  9 May 2022 21:10:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652094606;
        bh=/qHqi6CIlVAK8cEtoXLHzVPPEY/m87bHDdtlNB5349Q=;
        h=Date:From:To:Cc:Subject:From;
        b=n7Q8jjFxtz/r9vgYGv3BI9yqnzHQ/uHvrQdlDzdx0bCyR+I3UJFErc/og3hF4Os6l
         pFeZBnTpL16hA3lkvYSkBYuWQWAt7iOpVYqOnCi2mA13rKbMPuI2OgRILUn1QUHd64
         Cm+16z2ftD+Bs+R+SqD8wBMRf/5LOUW6TWfq+gwMeLangYUXdgbzKLIaAuJmB10L2f
         47fNiQFDXjq8SRUdIndgeXamgh2tQIrU4UVyKJWrTify/qM0esAU9IYIcpVvvbqIR8
         jK3JzFZ1daWT8IeT0twj1moXnF43VB9PlOTqh4NvfKrqqGIvS8tozN1Otgtb2ETjXL
         v78VaT6EKAAMQ==
Date:   Mon, 9 May 2022 21:10:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20220509211004.2c2073ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dJ8ZH9q2ElXtmQQNIpu.DHQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dJ8ZH9q2ElXtmQQNIpu.DHQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (powerpc
pseries_le_defconfig) failed like this:

ccnI8W1t.s: Assembler messages:
ccnI8W1t.s: Error: .size expression for aes_p8_set_encrypt_key does not eva=
luate to a constant
ccnI8W1t.s: Error: .size expression for .aes_p8_set_encrypt_key does not ev=
aluate to a constant
ccnI8W1t.s: Error: .size expression for aes_p8_set_decrypt_key does not eva=
luate to a constant
ccnI8W1t.s: Error: .size expression for .aes_p8_set_decrypt_key does not ev=
aluate to a constant
ccnI8W1t.s: Error: .size expression for aes_p8_encrypt does not evaluate to=
 a constant
ccnI8W1t.s: Error: .size expression for .aes_p8_encrypt does not evaluate t=
o a constant
ccnI8W1t.s: Error: .size expression for aes_p8_decrypt does not evaluate to=
 a constant
ccnI8W1t.s: Error: .size expression for .aes_p8_decrypt does not evaluate t=
o a constant
ccnI8W1t.s: Error: .size expression for aes_p8_cbc_encrypt does not evaluat=
e to a constant
ccnI8W1t.s: Error: .size expression for .aes_p8_cbc_encrypt does not evalua=
te to a constant
ccnI8W1t.s: Error: .size expression for aes_p8_ctr32_encrypt_blocks does no=
t evaluate to a constant
ccnI8W1t.s: Error: .size expression for .aes_p8_ctr32_encrypt_blocks does n=
ot evaluate to a constant
ccnI8W1t.s: Error: .size expression for aes_p8_xts_encrypt does not evaluat=
e to a constant
ccnI8W1t.s: Error: .size expression for .aes_p8_xts_encrypt does not evalua=
te to a constant
ccnI8W1t.s: Error: .size expression for aes_p8_xts_decrypt does not evaluat=
e to a constant
ccnI8W1t.s: Error: .size expression for .aes_p8_xts_decrypt does not evalua=
te to a constant

Caused by commit

  b52455a73db9 ("crypto: vmx - Align the short log with Makefile cleanups")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/dJ8ZH9q2ElXtmQQNIpu.DHQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ49owACgkQAVBC80lX
0GyQ4QgAoNjkcducKaeQumbLOUCXvejE/P/q1srJ5cIUU+6mYUlZScpENVQiyGN6
AGPeQ7q7L4Z9TLkCnHTVMR8PH8JqwJmwLTSXOlMxbdR5MH9sct5nzEWGBTRWFz6+
TCqJRPvhQ1+VUsqZ5qW2cjZnXd14lSetMLyiS+lLpqMLPu6IqyIU6nzSUIZ9Lwv6
8j7KuqAyCGSe738sT/9oG5ciflRx4IreQkN0SO8+FTG8XneF8HnxlJiRbj8STgAb
cRggfSMgFki3feL68+WdJYwy9h9PjatoDtzEEDI3VcG1+oUV85oZwFy8UJTUq537
ia6jTe6cwg9B1TJ+ysZ0dRNEvs8t0g==
=hUec
-----END PGP SIGNATURE-----

--Sig_/dJ8ZH9q2ElXtmQQNIpu.DHQ--
