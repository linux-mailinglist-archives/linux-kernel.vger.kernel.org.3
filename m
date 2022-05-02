Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651CC51792E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387712AbiEBViH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387702AbiEBViE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:38:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F70E0C8;
        Mon,  2 May 2022 14:34:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ksbvn1w8fz4yT1;
        Tue,  3 May 2022 07:34:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651527269;
        bh=Zb9upvI+Lrp6u72XrNiYUQEEMkDSCqtY4CeR8dgoyvI=;
        h=Date:From:To:Cc:Subject:From;
        b=GyL80XVAUpeAbVy+pHGPEbEe/RQlR8YWFylJWN2ET7xG9vq/tjygWO6oPZh/6y/D6
         H569a//x2yy7kBOE/Uzza3lklE+o1gghJ2yUAfuD8FGNwW8eRy82llG06yMVgqt9cU
         g18SMJ+EOuBwO7Sg8fhQqZbhIiwDDQLQQwZLNQMmdje9WwKUgTs/tVbXy21K6ya3JA
         2rVOH7keIbegWqNxH7DZMGVcZfZy2QHCDHr1URIp4fvIdtbf1epyBOF3AXxeJZc91E
         7qbNBe7jS2h8aT+2X44webi3/s+MOUJHOFdz4zf/zQh8IQeANRNsW9GUgwAHwhbQ3M
         XCyM8fexLCN4Q==
Date:   Tue, 3 May 2022 07:34:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Florian Klink <flokli@flokli.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the hid tree
Message-ID: <20220503073428.219a0ed8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uEO4_PF7ZidGswDN1vKG/.C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uEO4_PF7ZidGswDN1vKG/.C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  5c9b8fae88bc ("HID: lenovo: Add note about different report numbers")
  a0a5c2a69699 ("HID: lenovo: Sync Fn-lock state on button press for Compac=
t and TrackPoint II keyboards")
  24401f291dcc ("HID: lenovo: Add support for ThinkPad TrackPoint Keyboard =
II")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

--Sig_/uEO4_PF7ZidGswDN1vKG/.C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJwTmQACgkQAVBC80lX
0GyWpgf/dsKshnrCUKoWrnB+/d/fW1M3/Iaq/rj4zyCadOfV6BMsF4OENBM1coyE
u4RpONfTWwybjUVT2b8iWLYxFrzSmwLbB75wEdf71yyil5jC1GHDPi6+eQSTcmMO
zukJxD1AxErDnGawRThT+4phWvbIKYjvjQnIDcp+Vu02bKvAlP8BGeYSlAfsByCE
KINxXa/0bb098o08H7bafa/UhcYVu02AUJgcRniTIIZwOKH/O5f+yiLfFXz/l+4/
wK46lDGEoyT+DHR3PY4otEmICO6+fo82ides0spbZ5YJrCnSXzJ6+Nvv5nowJCzL
LmZBEf8JXwliF3iNoDxUeYp8C30Z5g==
=QpUl
-----END PGP SIGNATURE-----

--Sig_/uEO4_PF7ZidGswDN1vKG/.C--
