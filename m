Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C0A57F75F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 00:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiGXWix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 18:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXWiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 18:38:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33C2101D9;
        Sun, 24 Jul 2022 15:38:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LrdPj12rKz4xD0;
        Mon, 25 Jul 2022 08:38:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658702329;
        bh=tlpiA8Dj0C/cMGLGKWtIpwaAlWjhYbc27MOlk80d/Gk=;
        h=Date:From:To:Cc:Subject:From;
        b=QiV80Owjbz6gsGFZ/xKksBZBXBGngj+N5yix8wRNNp+ToYi2HHhIlrRMipKNPlqyb
         /vu2UF8nRKWNDlYdpdu5cMsmfupBSQUZoILp8MW8uAUvZmTERexMborDIjfrXRUeXd
         YRhqoB70peUBJ/3gV7sWb+N7Y147Q+KrcBG24MKAbtn9GL4AeX1PnhoZ6Pr7b9KtBg
         CrCywVR6lGUwtM62IBec98SrqxDJimmNGhIy3y9oWjHXfgb8wLg/4sEzQ3tkAyFUZT
         8T1TVGzTQ+5hz25S73c7gQR0hj0sZGvT7VPoJ3EGySJP8jOsWGgr2j3Rpa3vTtiUGd
         ZlfCXp+E756qQ==
Date:   Mon, 25 Jul 2022 08:04:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Artem Borisov <dedsa2002@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the hid tree
Message-ID: <20220725080432.30a7c497@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3tVgL.jF8mH107T6=j7r/d.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3tVgL.jF8mH107T6=j7r/d.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1117d182c5d7 ("HID: alps: Declare U1_UNICORN_LEGACY support")

Fixes tag

  Fixes: 640e403 ("HID: alps: Add AUI1657 device ID")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/3tVgL.jF8mH107T6=j7r/d.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLdwfAACgkQAVBC80lX
0GyrjQf/XHEFFRwMcx9Gnm6CHF7eIfZA0OkaZFERjuyZxiti4IskYA1lgSaySnwZ
9ovaqkvPV+aIZKlrfyCjIcTLhrIKYKQ0cwjdfvBEaBE1z4bvCWxX7/AEl/WdOEcS
R7NFb+xHdNRWUPZZ2cXhwRKfhrG8DDAETxtJ+GXN/3sKAl2NntSJEknPLokSD06s
vzjBLA1NaWFdtK9EKv3xFK2jd0nhfRzAxnspf2+cIDSrehftM9Twek4lC5f0P11m
WBYAQO2ctrQo0Tb6PJerw/bUjrwYe1RMHeSuYU8ev2qI0avDDX9s1sSp8rGi8QKU
MZLypbJKz8jt8LbBOhUrgbo61KZO0Q==
=Iu/Z
-----END PGP SIGNATURE-----

--Sig_/3tVgL.jF8mH107T6=j7r/d.--
