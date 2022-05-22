Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC9530013
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiEVArC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiEVArA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:47:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7A04A3D3;
        Sat, 21 May 2022 17:46:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L5MGx4dHpz4xYY;
        Sun, 22 May 2022 10:46:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653180410;
        bh=PzWpbljlaU30cowHirg0r+udzrSFYNJMiFwu1EJW0f4=;
        h=Date:From:To:Cc:Subject:From;
        b=XeJ5hg52Io9Ce6Fkx/WPG0zVX12hSjTMjCpmcephKyHut3ctZdrge1YCtGz/FHO5n
         hRtFD2i6Mck0wiJ79DcXNyPgKfunJsw1LeK6+MxQVS+U/GkOzLShzFERxLGFcLAuVs
         XrvyMUUtmbDWEWUS4cwD+9JJ7z2tFcO+K4UzUYeDXEHIcc2Y/8yw/N3XqFdcNAy7gY
         +EyvWsHzxG2RlkWEZjKj31+EN1PNWvrMfLcw/y/8ESwe7EsOLSPl7Ao2cJ/Jy6MWAt
         qbOV8WwweSdQodo2AZKvaUSkcunaenpgByUuCtxRVEVEKx5sMe0BvtBALwurAEQoV5
         E44/XZs5dQhLQ==
Date:   Sun, 22 May 2022 10:46:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20220522104643.21248cd7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7dDniTGeYNy4rw_fDLdD93x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7dDniTGeYNy4rw_fDLdD93x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  991d8d8142ca ("topology: Remove unused cpu_cluster_mask()")

Fixes tag

  Fixes: 778c558f49a2c ("sched: Add cluster scheduler level in core and

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.  Also, please keep
all the commit message tags together at the end of the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/7dDniTGeYNy4rw_fDLdD93x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKJh/QACgkQAVBC80lX
0GxMPAgAisu9nNjyDGjhLrXWn6WgMoQP4n6n/HqQOV+JYOaLoNdgh6sldm8VrIyF
uo5T9rwobTASlIz+ijUn4nbBv2fEDplKB2mHg7G9ltPJeWGVCF0wMt4qo00l/5Eg
LAYaqItMUniqIS/lKuCv6du7KnCGHabWoSD3ekb8DMvqHifL3e3i8knHWIuLTyim
9i3w250wZR47NZd7uFPKG6y/IIzhhm/W3D/axkVM5AyzQm1+DPTr33xEhpxvrt3Q
ph4UHrgB1yobfcpRf1E8Q65ltEyqSyC4RtAz7LjsRJ7M5xu0wMZHtvya9JqOdCyN
9AeobqyjoX7d5QfgwJ3Lu0nHlWjGdg==
=bfpq
-----END PGP SIGNATURE-----

--Sig_/7dDniTGeYNy4rw_fDLdD93x--
