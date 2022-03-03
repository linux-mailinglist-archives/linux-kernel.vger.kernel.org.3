Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF494CBAA0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiCCJtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiCCJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:49:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE6D137039;
        Thu,  3 Mar 2022 01:48:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K8R4p4qz2z4xNm;
        Thu,  3 Mar 2022 20:48:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646300907;
        bh=j+b0561ydDIoxcNEvHSmXvQ9Kwr/WfIPJlHjarMlLbs=;
        h=Date:From:To:Cc:Subject:From;
        b=RyGXyaVCeKeKYQ0ikwLudnDxnxSOuqTn7RD7yBXRSEOfl8sd8mzN+8h7IFmnsG5LE
         YYxANjgEYvNZahvry4WdcOwshQDEdTGFR7WPwJCKrxYmLr0POZJRfI5lHgYl+B0hVp
         6t/kIScP8/V5T689Nz4LTQIVKUyywhb35YpTB7DjKRB6cYA8ABw3VYLu8AClzUYnp1
         EFS8wV9EhWonD7pGHLlO0BT3jYx+aHUqsh4qWmFcW0FQxING8TiwM+AFv8AfhetU4l
         h0H7RMWtkxDLQ1S2dAFT/tW7gHiFHOF2/XxtyLNtWkIeMZuLI6r+rJsBnxILshlxza
         ytBfxi/chUM+Q==
Date:   Thu, 3 Mar 2022 20:48:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20220303204825.3c795a17@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r1OVF7ThqUpRx/4wHEi2ypz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r1OVF7ThqUpRx/4wHEi2ypz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cedd3614e5d9 ("perf: Add irq and exception return branch types")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/r1OVF7ThqUpRx/4wHEi2ypz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIgjukACgkQAVBC80lX
0GyD9Qf9G7yntj+/XgJWbztCR7eDDbu2P3inhmIAlEN/hvNoac7bUvFOd3/sAe/e
BHx7/DqztcJKddzpGIMChk+0+tJVfinjjMWbUv1R4vuPFrcbPri5TfJtUuPL1XgG
OzHUHEj2+zG0jZyVBsvH03ogDuOxmB8OVr6JKuH11rfFh2n8LXLvPQFQnDX1v6wz
OlGRN/vPE+G8VGQSLYSg7syDCJH+EdRLTx09lltxeKEz+grRoQ8LeIZtRTQK7eCW
MMbrR/K5sLcR2Kr3LIB7ztHqiTLUHC2AaPTC4R2UE3ETdOen598olU8YzjrwPA3i
QJ6GAhSEkIiZxKpZ+CESGM20Jl7PIQ==
=skYm
-----END PGP SIGNATURE-----

--Sig_/r1OVF7ThqUpRx/4wHEi2ypz--
