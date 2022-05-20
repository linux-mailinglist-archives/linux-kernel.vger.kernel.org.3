Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB22B52ED3B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347959AbiETNgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241938AbiETNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:36:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0BD3E0EA;
        Fri, 20 May 2022 06:36:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L4SRR0KlNz4xYC;
        Fri, 20 May 2022 23:36:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653053764;
        bh=rv1y2V0j2hffLl77o/ijD0s40MZpKA7qrdB4T1/IDzs=;
        h=Date:From:To:Cc:Subject:From;
        b=DA+qh8edn8yS1GBay0R5VWOjpa6Lipy99y9HOILQTztbIVLgr7WW/GPFvdzeDtyxJ
         L0bhR1sPSiVJHawzCWl2QiFCdJedAWwsOlzOpO8sk6gV+NbNJYjz3E+UZ0SkKDchmT
         90bzdvhRmCKgc3SvNFI5sr53uhQZ8+06289JryPrhafHU5hS5B+q35kY2KLkVx07up
         AFg4v9c8K94FaVO86vjapluavZHPH7WyfjzZhzBMb22zjOa1mHCYyj5anaIyExfPYB
         0GHK9jWP1iS0AFGbYoS6u/tC1Q+q8Si1dUzqeeP1KlG70wSS+6UzvM8qhBPuVnMpvJ
         0oWZIHoGbbppA==
Date:   Fri, 20 May 2022 23:36:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: changed messages in qemu boot
Message-ID: <20220520233602.2738d87c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fUjO3JqV/cTb15Tx6/q9Ay3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fUjO3JqV/cTb15Tx6/q9Ay3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next bboot of the powerpc pseries_le_defconfig build
produced these different kernel messages (diff from yesterday's tree):

- ftrace: allocating 33658 entries in 13 pages
- ftrace: allocated 13 pages with 3 groups
+ ftrace-powerpc: Address of ftrace_regs_caller out of range of kernel_toc.

I am not sure what caused this.

--=20
Cheers,
Stephen Rothwell

--Sig_/fUjO3JqV/cTb15Tx6/q9Ay3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKHmUIACgkQAVBC80lX
0GzcrAf/Ru8QL632jWscLmwjX6IVBqTFPdIpCEWCqrxblq0BBzBAexYJg1DPu/B+
XVp0lF5GiAjqrzrW8sNryi0y1pHJVZ+drhW0l/2Z/vs/WEycAds+58XMHOIiMXMc
L2WgYQYXcbljMrV3XWIorzyLUlDGQuSG+zAIJnJs0CwbAzq4MBiGdqKYC+lBJQCu
njvmwsJMz13J46nLWYb98iWpXjxDylsOXLx506vBOubp/4+H54tYGertlBGJo/Y8
kvVjRsoUpPnaxuSN5cAmqXK9KUFmKr7nwzHRLv1mWqoRuLQNsckXFBmowxD2+UIN
kr5pBQfQDh7rjQu54F4RRo8ToCvxIA==
=9ugd
-----END PGP SIGNATURE-----

--Sig_/fUjO3JqV/cTb15Tx6/q9Ay3--
