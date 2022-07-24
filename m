Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661AE57F758
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 00:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiGXWcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 18:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGXWcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 18:32:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BD96176;
        Sun, 24 Jul 2022 15:32:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LrdG93mP9z4xCy;
        Mon, 25 Jul 2022 08:32:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658701937;
        bh=I5e4aBxRs5TMjZ/ACc3C4ic9n5kgHpVQS1/Ropn6vWA=;
        h=Date:From:To:Cc:Subject:From;
        b=T/VAJSez0hsUFvi2AbdlTH1IFLqr3mSdvh6PDKYRPAT8TzJARGyX3v3WILJ5hs+tp
         zfZiibugx+Jm9ob/I/2uYFI6K8dj+hP2bI1C+lK+m3njeQN+7HTYtr+m1ULurjCg3v
         E5TeSfSS8M5zbtZA63o/rd+3Hh5/MSl/ongGpkQp4225WJW3ahvJN3I1DXsKyAUJM7
         9XePrOyllHLfRNt2/ZW2Q4bTS/wS8uGNjrxI4W+XG1syq8n23+B43+xCzpPH7e6Wg4
         uM5NcbABoESYSznwJdN5g9fHddQvqL2lo+v96aDEUwhljxZvFvuMOOy3QlwbPlcpld
         TA/pMP76w6ZVQ==
Date:   Mon, 25 Jul 2022 07:57:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bluetooth tree
Message-ID: <20220725075728.499066c9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7HtodeEoraReSeU8=7BfyxS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7HtodeEoraReSeU8=7BfyxS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  a5133fe87ed8 ("Bluetooth: use memset avoid memory leaks")
  9111786492f1 ("Bluetooth: fix an error code in hci_register_dev()")
  4f17c2b6694d ("Bluetooth: hci_bcm: Add BCM4349B1 variant")
  88b65887aa1b ("dt-bindings: bluetooth: broadcom: Add BCM4349B1 DT binding=
")
  359ee4f834f5 ("Bluetooth: Unregister suspend with userchannel")
  0acef50ba3b5 ("Bluetooth: Fix index added after unregister")
  877afadad2dc ("Bluetooth: When HCI work queue is drained, only queue chai=
ned work")
  ab2d2a982ff7 ("Bluetooth: hci_intel: Add check for platform_driver_regist=
er")
  629f66aaca81 ("Bluetooth: clear the temporary linkkey in hci_conn_cleanup=
")
  af35e28f0fea ("Bluetooth: hci_bcm: Add support for FW loading in autobaud=
 mode")
  0b4de2523f28 ("dt-bindings: net: broadcom-bluetooth: Add property for aut=
obaud mode")
  bde63e9effd3 ("Bluetooth: hci_qca: Return wakeup for qca_wakeup")
  c69ecb0ea4c9 ("Bluetooth: btusb: Add support of IMC Networks PID 0x3568")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/7HtodeEoraReSeU8=7BfyxS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLdwEgACgkQAVBC80lX
0Gw37ggAlO2okb2BD10+8PpN4kA7qplqt5kYuVarJRphpz1PxYbvEDuFc/Bl7nl7
u6C5SyQU1jX35wKSzqJy6GUS3ccLCSK/Ym/ziSqU5eY3pUF+vb1tl2XgqhVtzVPC
97D9bA1XyPjJKhLJ5yiXmPXIwzK0ODY1wDk46WhiOD3D7010mdcDXO4A7RY8GxN+
UFGM7eRZWmyqTEKftgmFsze9I/mQ1zlYMGWKOmKIV0kxxazLebNGXAiKB2BOuH/u
BjMr+IFr4Ei9o3eJFzTnzThNHcYRJpJ555KVGLNxKEngduepeJYFVxBnV3z+yc6x
URuDacePofYqKDmNt3uV0y8UXb9AHw==
=vQWZ
-----END PGP SIGNATURE-----

--Sig_/7HtodeEoraReSeU8=7BfyxS--
