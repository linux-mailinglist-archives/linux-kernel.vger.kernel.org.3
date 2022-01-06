Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556AF4866F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbiAFPpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiAFPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:45:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD88EC061245;
        Thu,  6 Jan 2022 07:45:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JV9fv2JtDz4xd4;
        Fri,  7 Jan 2022 02:45:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641483943;
        bh=bwoSqF0boW0Hn0Lyd2XQ0v0GgQB1austW82Fc7xFja0=;
        h=Date:From:To:Cc:Subject:From;
        b=BYi9+GkbtZf87oClIqWemtjLITbVjdtfbvEG9ysX+7/amFI7fXWIPXIEyx05BB3Wf
         +ipz5GBpudl1BjsaKxjShCvMvqPHrNVdPQ+mSQV2ifgPJ6eqVf+JgeDtAic9JcNX7j
         wFLy9AZpf/b6UJBp1zds5xBDC23fzqU8ZTUvG+tDjGmH+Xo5JiGm56+XQxwnpFvKil
         NhqSuBzRrmpCX10HgmeezKLUb1XNfEawww3QJYrqKjONo63+vS0xaoaOgi9B2ojb19
         Seduz06QFVMKIQ8whuZ1RsbHdq05oG6FQD9GbzbwzTYYQgEV7LYuEz9EYwvPQgXolr
         2s1C2cs7Vg+NQ==
Date:   Fri, 7 Jan 2022 02:45:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20220107024541.1256d609@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Jswjkwtzg1Gyvjk0_OM.NLy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Jswjkwtzg1Gyvjk0_OM.NLy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/admin-guide/sysctl/kernel.rst:798: WARNING: Malformed table.
Text in column margin in table line 7.

=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
bit 0  print all tasks info
bit 1  print system memory info
bit 2  print timer info
bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
bit 4  print ftrace buffer
bit 5: print all printk messages in buffer
bit 6: print all CPUs backtrace (if available in the arch)
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commits

  934d51cad60c ("docs: sysctl/kernel: add missing bit to panic_print")
  addc64999934 ("panic: add option to dump all CPUs backtraces in panic_pri=
nt")

--=20
Cheers,
Stephen Rothwell

--Sig_/Jswjkwtzg1Gyvjk0_OM.NLy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHXDqUACgkQAVBC80lX
0Gzbuwf/URiu7AYrOb0eB7Onur5tBza2cGLgB/IGjGUyqz5FYeGcIvdYqlNNAshx
ywRwB+ZRmlGDUai7lfAI9zCeonfHS2MDfM7AwvZYUWoH3bkSHZd+XRSW2dJj6BFe
5VMNVLk2R+z5qJwKqT66V/xbyexaXveJsrNBQibBk+ljFlSvdmmuOAt48RMZJRne
N8YxiMzAz2yEDy1xAupKRH7rVYJj0FzKGZinrbPEuQ5LtJMeIbG6djWaqami/kAm
2BPbszM+cRfdgj9v4C/uvBHLD3SgiLQgVHN2sUo4mj7O0sqBEbzcvgpzE95kAq8O
MC+UXs0evwl0P+jwRwHUHAXzXwKGcw==
=EyHq
-----END PGP SIGNATURE-----

--Sig_/Jswjkwtzg1Gyvjk0_OM.NLy--
