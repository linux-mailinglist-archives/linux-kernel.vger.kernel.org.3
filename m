Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F5519039
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbiECVb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiECVb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:31:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050674162E;
        Tue,  3 May 2022 14:27:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KtCjb589Xz4xXg;
        Wed,  4 May 2022 07:27:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651613267;
        bh=MlslygHg+ZIm0HDbSi/5ulCiI1C3HY1jnz5QkaqB3i8=;
        h=Date:From:To:Cc:Subject:From;
        b=ar7XZRr2deUzgEjudZefwQbcenETm2jikNtdIlmwzdFuBeG4/WKOsRDj57bVw6A0q
         FlvgeyA+2ImdmPnL1joJM213D0fufBZVPgRfAUzy+6xuheey2KutJcMJfEXTwm0KO/
         7WlJjlCEBuc+DUXfN1ywv8NvwOcxlfzfPPbr1dq1plFTWZbPFZ5wfP8AnSj1q+0OXG
         8u0HzXhbVVOQRaQeziC5kRYu9230l1m0I/atrue6BsoisoJuAGBHZxMIRB7IgU19da
         0O6eAkbB99baDO1W6s8TGN4N/k1v/W6D2Cv3rP+GBg+0EDDUnx/6ngOIirRugH0AzY
         ruiObDLXHS4qA==
Date:   Wed, 4 May 2022 07:27:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the stm32 tree
Message-ID: <20220504072746.0f59f2d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LR6sDwWRFFlp8hfR5pzjMQz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LR6sDwWRFFlp8hfR5pzjMQz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ee5596ec15d8 ("dt-bindings: rcc: Add optional external ethernet RX clock =
properties")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/LR6sDwWRFFlp8hfR5pzjMQz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJxnlIACgkQAVBC80lX
0GwncAf/dmpuimEmXhlqOYlm9viNzHNw4fXvR8usQ8KqSrbrPNHJPtEErfyUuV5b
91Sy7iOZHQ/lEeSjXClHs1IhpBPWkXJXE74yYM3RFFv40evn0ZR+VBmRpWeACQf3
ewi4rPZEHJiKCaEnozbbBfPRYHCe+OEeEvgA6xrdGhLEGQlpiqzPXnnAo/cLNNxm
se3CeZMHGGhpboso7SocupLJILxre1R17fVvoj8wet2kor/8o+UQsUjizYI+OGFS
nAJFgBb+jLcGBLuNTmOl1+HG+n0TzK3EViVfu6qTXrpF0c+57K09OZir/8GXMQfC
kBckFaaFml36vGcW9B2s//k2WwlSWw==
=f0KK
-----END PGP SIGNATURE-----

--Sig_/LR6sDwWRFFlp8hfR5pzjMQz--
