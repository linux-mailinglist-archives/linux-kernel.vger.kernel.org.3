Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F231852E012
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245550AbiESWmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiESWmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:42:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FD95676D;
        Thu, 19 May 2022 15:42:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L44bs4CCHz4xD8;
        Fri, 20 May 2022 08:42:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653000121;
        bh=GIVENiCMlvc6aPH0Jy6HumlSK7xSBXFznM7oT3mXn2I=;
        h=Date:From:To:Cc:Subject:From;
        b=ArI0K3cRM22z01h3o5rMH0hUgavM6mt0JIkEi5d9ZH2o/0juFVuv1LkvgU+0CDYuL
         hiBbKwoKLZYieDcCHWbhayJxh2VFh6i46sshF+2IIJuYbVkjzBC+3TUlzO7O/Ommq9
         pNpOJiBlNA59N03oe1o5eOBm1sfNgOwpQhcFc6GUMvkaIgjUCvosycHvYOofM+LJA6
         OhZGlPFJDODzEro6WnU5QutvKPBqVAfpX4z61R15IkKDLz2P2zOUTNMJ7rHqP+hIxR
         9enG79y0FN8J3i0uSzUOLSgpYXQgmlhdFEluim1exGOhPO6ZFaG0R88UgV7kMgR3B6
         To49bGxCg7tOQ==
Date:   Fri, 20 May 2022 08:42:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ext4 tree
Message-ID: <20220520084200.7262142d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Inb/zo2=/phR0AxxSqv7dGb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Inb/zo2=/phR0AxxSqv7dGb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  cb8435dc8ba3 ("ext4: reject the 'commit' option on ext2 filesystems")
  6493792d3299 ("ext4: convert symlink external data block mapping to bdev")
  9558cf14e8d2 ("ext4: add nowait mode for ext4_getblk()")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Inb/zo2=/phR0AxxSqv7dGb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKGx7gACgkQAVBC80lX
0GxeAAf+MYIRZ+Ah5ankEfdLLI0I8SuHl6sjo6iivOzcM4kYV6bEbNvIyCSXze7p
7iv4xNs2FDlKFTfnbGbjlOyzRPmlkv4lgxsMMMYWbu6SUhfCDmC/4QeOzK0ZCDGF
ulpQQn8wRm+4MWoPpwj37gGaXpjhS/2nOpUA1ia4uN7R9Lq+3LUfFrK8tx3KeECx
TwrNibcY6p34HPNFC3YjPTnqt0wJnIs49dURkHqYbARxw7ziQ32CzTqvSzjA4dpH
O7VfO2lEYgoRrXu9H7nfCm/v7Pw0zrAHYwurRv/+qkZY/KE0kPA1vrVyX7OOHIkt
X5oaWbAXMk/J8KTmXWoAvFRd5VG+dQ==
=T+am
-----END PGP SIGNATURE-----

--Sig_/Inb/zo2=/phR0AxxSqv7dGb--
