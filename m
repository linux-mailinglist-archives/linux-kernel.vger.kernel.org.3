Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1D560FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiF3Dc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiF3DcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:32:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2503ED1E;
        Wed, 29 Jun 2022 20:32:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LYP5p5WTZz4xD5;
        Thu, 30 Jun 2022 13:32:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656559935;
        bh=bm/D9+00l5+LroFQaho4tdVbjPF9YfR6CwFjpotQAuY=;
        h=Date:From:To:Cc:Subject:From;
        b=SlbsscCWLSNA1+1WWKMjU8mALYQEGlqMpuBeHjwKGfzvxU7ZFN9X2138Uz8pJAr+V
         jW7n+YP0P67UUQcg5Khp3AnwssxW3XEoh7L9ygwzgs38VXykJuLZz5RgT/cSyTuUrN
         jLizknOzpMuOceV4pDMcFfC4OEnBf6Oicts0a07jVRxEGixVddvWHEwlIFhK6JmQJ0
         jH4lVIJW+RMjF4/9YSPF+ri1CS4uVZNkNYtBVEujWeOH2J4WAINTFeQreHMkHib3qm
         wqfvebZVqJmoz+lK6R/Yq/h68Sj1FMCPKSbki5d867kPYBY6IA9BobIC3G9TYDCqKd
         IoORuXpXeggTA==
Date:   Thu, 30 Jun 2022 13:32:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20220630133206.4fb988b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Bv6GQYlREk9VU3Ur3Rut2Gr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Bv6GQYlREk9VU3Ur3Rut2Gr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c0e9a439da6d ("mm/mmap: reorder validate_mm_mt() checks")

Fixes tag

  Fixes: de4583ed958b (mm: start tracking VMAs with maple tree)

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: ade97595a8fb ("mm: start tracking VMAs with maple tree")

--=20
Cheers,
Stephen Rothwell

--Sig_/Bv6GQYlREk9VU3Ur3Rut2Gr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK9GTcACgkQAVBC80lX
0Gzo4wf+MsZNj7t3faFaDGh0Cz0Y5qDASNp+SYwJ6rJRSXFW4m3qe5vIrWy6uki2
9pyf45z1/ljeGj9ZWbq8KDzmfZLh6jg3c9TJNMXwM5hdWd0/8FC/QH+3+3X1yRAU
Ol5Jll81tRnV0NDqt7SOQygkePAWG5+v9wEpnZxEdT53hPM/dQisV7gE2NhUP9wI
NGnkqrpRUtMM1DwrfDvVKImwlj+rd87gWNcrMX1C5MtH/b8IHzWeVndPN7JzszpF
q6w6fLr8qNJyo2lJBUQ5cPChFLYN4oA/7hHOfOZhGD0o0ahHTm5AWOp4JV9fG+NO
5sly+oZa2Si1yBFSHPqG0Gb1YksNCA==
=ECBf
-----END PGP SIGNATURE-----

--Sig_/Bv6GQYlREk9VU3Ur3Rut2Gr--
