Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71DC510D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356321AbiD0AOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiD0AOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:14:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E4E37BC5;
        Tue, 26 Apr 2022 17:11:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Knzg90bM8z4yST;
        Wed, 27 Apr 2022 10:11:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651018262;
        bh=rc6ouf0q7clHmR3t+iRyYoy2gBHvA2Kpy8t+RH03srM=;
        h=Date:From:To:Cc:Subject:From;
        b=i8DJb/m9la4nUh9WbxLUdksWkSHI/bnhEN52UKh75dhJXzwVzrx00/MsnkiLXv9gb
         mL5uUSdKpFPhlT25hsOkNPbOsN8ttkH3k8kusBxJP8G9n40MXiej4ci1f7Mr5pDmTD
         97eoLqWS3g2bU5a1hqtDoGeUakV/pbotw8iVH26VB2quS5Q7lwjU3t/GzOJyQRNKlI
         NqyOix/MB50Ecu3xGuYQ9NsFXHOp2W6pb059ZpCAUFxZKyrvtoyupORGloTRZvmPeV
         3r/r7ESLamega59/MqZwSlwqc/EQHIcbUU9xSPQatGInfFZqza5QE5n505fJ4L6bDK
         h6i62CQ4H8IcQ==
Date:   Wed, 27 Apr 2022 10:10:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tip tree
Message-ID: <20220427101059.3bf55262@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z_9JhSAR0Hmyk3B.PLdtIuD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z_9JhSAR0Hmyk3B.PLdtIuD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/virt/index.rst:7: WARNING: toctree contains reference to none=
xisting document 'virt/coco/sev-guest'
Documentation/virt/coco/sevguest.rst: WARNING: document isn't included in a=
ny toctree

Introduced by commit

  9617f2f48310 ("virt: sevguest: Rename the sevguest dir and files to sev-g=
uest")

--=20
Cheers,
Stephen Rothwell

--Sig_/Z_9JhSAR0Hmyk3B.PLdtIuD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJoihQACgkQAVBC80lX
0Gy45QgAgTABkU0bgbyt76BS5pG5oeSkJaoueIvA2Xd6e/n57oklURjTlVBCAL4e
994AFxZEswSqqS+oZtSEirOJMPXBm/b2vlR0CujkG7Cvy1cnrY7LLDlMtIl0Yxxx
z/8UCS6IZ0rqCf1lfYXIL8RqB0DwWmQRYw0kjTuNQlqIySab4+XZXGHHQn4Vmgw4
Nm6J+lMoyTXATIZ0hd3Rarl9In0459VZXMkbUcNj1/i6xnfttjy+Tbn0K1Tus1re
fXG/j8+hfec69oRCHzb7F6KR/BaQ4hc3O0WyoIlM5gsheVD6uaaZ9+3YFq6jABlg
N394+Xj97HT9EWx3gA92/H5V74kiTQ==
=ahdu
-----END PGP SIGNATURE-----

--Sig_/Z_9JhSAR0Hmyk3B.PLdtIuD--
