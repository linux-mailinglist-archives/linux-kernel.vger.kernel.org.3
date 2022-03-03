Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61EE4CBA2C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiCCJ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiCCJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:28:58 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E0FC6268;
        Thu,  3 Mar 2022 01:28:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K8QdR6CYYz4xZq;
        Thu,  3 Mar 2022 20:28:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646299691;
        bh=2FQ6U2QtxcB1os1Dz8+0mUT9sISieoMoFVa0NsKN7gM=;
        h=Date:From:To:Cc:Subject:From;
        b=GtS7//ZXNeX00rBWzUUeEUYADUJN0n/GxCR0vi0By3BNQ367YORB6+JBcgkX4g3xt
         /h7UGaDHUNr/pghdv7Ld7ykJa2pEBPc4xGxnWyBDLm8BgsodEy12PRPldz9SMyvIPm
         diVdcErXH84j/nF8z725Jl14bKg4fkfcwEHtPSWExHPAGBT8dFlORKrAj5qa9u2mY2
         i3syUaAySV6QrcoCutVEc6ftVmW11Nc06BAhNxthQfdq08qzTRNGXzhFeOid1X3zAc
         p96AZDt/OlsrVWt+aZkOYUbkiXp6TliVBehn+WQUNlXH+nVjGBZCsAM3rhJd/Sz4ZP
         S2wV/O2AE1QBg==
Date:   Thu, 3 Mar 2022 20:28:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the fscache tree
Message-ID: <20220303202811.6a1d53a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YU4j33txWGzPWZNF1Ak5Vus";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YU4j33txWGzPWZNF1Ak5Vus
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the fscache tree, today's linux-next build (htmdocs)
produced this warning:

Error: Cannot open file fs/netfs/read_helper.c

Introduced by commit

  ad9e5adb388f ("netfs: Rename rename read_helper.c to io.c")

Documentation/filesystems/netfs_library.rst needs updating.

--=20
Cheers,
Stephen Rothwell

--Sig_/YU4j33txWGzPWZNF1Ak5Vus
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIgiisACgkQAVBC80lX
0GyJbQgAk1CyV11Ddf+zELCsOcnbDa40MySk0TnTRzdFl+brzvzgRnx4yrgc2QR4
+9OEQSSHuGbxEwJhTARedB6+w/DMN1PzWjt4pXDlmruezEMO1VoqbZTc6Dn5JGUU
AAl+1C+EhtEoyKTQTvYFGpgIekOyTQpXsY4MPG/c0SS6Zb8ZZrMUjpG2gtjLKfQN
kLPRXhS88LPa5VfgSLGVLU7oPySqQLupE1SIzSV5FvzalAnp2skyUHt0GpYmVQaE
akNGqsKRtLp3kcCSNXuEQzTdnkHgVbVgWA3pXuPn2fGEfcsmqVs3OMl5ZJP1WE1r
/lIWrFpUSqglr0KYfs0Na+GrA08gBw==
=AsZ8
-----END PGP SIGNATURE-----

--Sig_/YU4j33txWGzPWZNF1Ak5Vus--
