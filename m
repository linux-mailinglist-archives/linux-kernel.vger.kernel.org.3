Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EF9524AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352811AbiELKtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiELKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:49:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729DF2211FB;
        Thu, 12 May 2022 03:49:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KzT6S3xBrz4ySd;
        Thu, 12 May 2022 20:49:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652352545;
        bh=yTsM/+HaPDvoDv8AsCougI1rz8Q6vAphRCqT5IXQamE=;
        h=Date:From:To:Cc:Subject:From;
        b=Q9SkqukWM5ejSJElGqvA8l2BWetEjApR508HRnPNvQnu97rwzB4YckzcqXatTGg0g
         lH6aHaBrs3jkKzqr5qmL8w0ycd/GO8f8qFqVtlo0j9SxhLb+uqT7L+1wVli2J1ZKE4
         fJtdMaI0hoojSbdD6OpnKbOtlFIVOFZsEzgiYz5qycQ+fqMvbS4dFhTqGaBGSahLio
         TBSiNA1wNvip7wBm4WnbEhnqfIH2A92tKpIJWOWOyppAokD+fekXTnTAhxNpCQPgF1
         GSyDJ32+lsL4TQlEOw7U4vqLMG1ljl3JyGcFrwi+d646sBNHG4EivGX3T4nEAWDGmu
         ON7uYY2mRBBgA==
Date:   Thu, 12 May 2022 20:49:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Delyan Kratunov <delyank@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20220512204903.1137b53d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ApqxkRzD2D2wIVJ.YCd9WmB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ApqxkRzD2D2wIVJ.YCd9WmB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9c2136be0878 ("sched/tracing: Append prev_state to tp args instead")

Fixes tag

  Fixes: fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting =
sched_switch event, 2022-01-20)

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Please do not include the date part.  I doesn't add anything.

--=20
Cheers,
Stephen Rothwell

--Sig_/ApqxkRzD2D2wIVJ.YCd9WmB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ85h8ACgkQAVBC80lX
0GwnGQf/eRLnXi+axws09S4GzsrU6Ckuos4Hl1kJngDk85bfMnN72KwuYkpE6Cby
ioeoSeBT0zInNQxQLKzAay6bA/Yo0ktfu+N7NYhQP3viMNe1QbHEoWQZxV6XsZqW
j8dFwXAYvqXQsnFHaLKQ4dsH/kh18FqG05jgJYlvbK+lehzBLwuyBYmGCj54xybV
J8tZOB8Nh8lvN18OQMxmD+Clm46BttFq6l5qpq4SRtKzxkAk308Enj7omI8/Y/pb
Q5a0IYD7HYFnlVZRw+TTwdtP8jXZjZZmruB1Nu4UKaLClcvdHkol24zhVjEV3rTW
5PQ2m+KKgFYqWizTVFOErr68Jra4nQ==
=dP1Q
-----END PGP SIGNATURE-----

--Sig_/ApqxkRzD2D2wIVJ.YCd9WmB--
