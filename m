Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0140E57F753
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 00:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiGXW3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 18:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGXW3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 18:29:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5E31055B;
        Sun, 24 Jul 2022 15:29:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LrdBJ6fG9z4xD0;
        Mon, 25 Jul 2022 08:28:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658701737;
        bh=iilW9+TMDH6h08GDQ0vnPlEO5em55dNSW7JqlGE5XOs=;
        h=Date:From:To:Cc:Subject:From;
        b=TnqEBHqCq0J0a0GBWe9t8fs3D2GtwNv5uaZzkziLlibR31lYswYNvwQR+9E6h86bL
         rJiEGGKoxiutlY4CU/wTfEUXVCBP62DzlrmM2Hmgse9DvzFLt3rbnJEJyQUNkN8EFl
         T6ENYUBlrbJFyTmZLyVquXU1c2IjvGU+2mAqxxnoVsrv7tscp4OBhCurO679xaRaRx
         D6v1kDoxAo+StLnKFdibVqrU1Mt3e4nY2B6Hrrv/QqRBdPx1oYaoniyjVMY34FGZ9L
         n5D6R1E30hOP8X1KtEEx75zI7lhMvfN9w3gJlBZh2RZh+H5T9XNhjo4jD/GW4ASLdJ
         B5EhRb1fJ1Rdg==
Date:   Mon, 25 Jul 2022 07:53:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Zhengping Jiang <jiangzp@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the bluetooth tree
Message-ID: <20220725075350.64662d13@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K+8jN29FuRw4ve93x75mLCU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K+8jN29FuRw4ve93x75mLCU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  68253f3cd715 ("Bluetooth: hci_sync: Fix resuming scan after suspend resum=
e")

Fixes tag

  Fixes: 3b42055388c30 (Bluetooth: hci_sync: Fix attempting to suspend with

has these problem(s):

  - Subject has leading but no trailing parentheses

Please do not split Fixes tags over more than one line, just use:

  git log -1 --format=3D'Fixes: %h ("%s")' <commit>

Also, please keep all the commit message tags together at the end of
the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/K+8jN29FuRw4ve93x75mLCU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLdv24ACgkQAVBC80lX
0GwR1Af+PfgV4gXNe+1QBqB6P/Kzzteb/3Tu/4CUBoztO1Hvjlm+za+rGsY5aF8b
47cb6hjHNT3gfxTvVR3WVLHkUdeV4R6B74EoEylxflVusaGVV0nQV5n/deK5urQi
cnBzGCymSqC4X7l9HxGK2PV0GZp60oc85gwPzSxvdh+WyWZID0YLLutlvjH1zHh+
FkoCJy+8Q6KjBVZahMchJlG6UJ8Mp08h5+gZVKLWmBC6RJDxrs54Ak1Qct5I5WfL
MGLyi/v1Fc1HYETVfChJzNGtnFPpNskoaPZEl/bEy+WoTjp7yDJeiPHjKo4duMSO
sFiyNXfA3KRiN8YXD05tYJc+/EIxjA==
=4ig3
-----END PGP SIGNATURE-----

--Sig_/K+8jN29FuRw4ve93x75mLCU--
