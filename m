Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A8957004A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiGKLXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiGKLWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:22:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAB637FA2;
        Mon, 11 Jul 2022 03:49:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LhLHK5lmXz4xXD;
        Mon, 11 Jul 2022 20:49:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657536574;
        bh=sUZIg/fS4jnuFTZnbWEUaFcFqhHRGZ8fwMtBDgUIf9c=;
        h=Date:From:To:Cc:Subject:From;
        b=ItykgBef6rptaGNkbeHj7o/om75/WKAGw0pWJIpBPh32/qUFqc5igzNVMQuOa2K5Q
         sXkllhYWkHQTyH/1fJw7lnRAU7wCU2/wR6wfj9S8TfUwzs7va2nFysby3T3rqVgL1C
         8LuczKivT4CrmzNf6sYn98VfiY2DNcTfnuv806XRDgDcVUk1+OtZZTJvp3ONuSjlw/
         FJLvvq0B54eAowe/wvOFDBxm79/uEplVarcBbwjSCE/WLqpC6UOrGYNRFQ535IIKTt
         AEa+f1vJx77Zh2T/8zZPQgPQp014/eCi2FhpS3m0ywWhTrbs04bVKdNlWfEWxcM73X
         FHJyOZ3WxeISw==
Date:   Mon, 11 Jul 2022 20:49:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the crypto tree
Message-ID: <20220711204932.333379b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nCM=dB/dX0wifWLX.Kzp7UJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nCM=dB/dX0wifWLX.Kzp7UJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (KCONFIG_NAME)
produced this warning:

Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentat=
ion.

Introduced by commit

  d4cfb144f605 ("crypto: qat - expose device config through sysfs for 4xxx")

--=20
Cheers,
Stephen Rothwell

--Sig_/nCM=dB/dX0wifWLX.Kzp7UJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLMADwACgkQAVBC80lX
0Gy5RAf8CczHwKTt7mCLsuIc5aln2zWjSMajKmTcWPD0M+jcSxWZsEs8DTKBbBBp
omFXGTlDbZBQUaYmT9bdOaiNWPuMLv+oaVFb3H0/BqRGDNb+pWLY5WeexdB99uvD
/N0Qksm/pSShsvyP+RcrzSvbVAHo5TEN6FCQ5auPgc+0KoXc/DUqoGeGeVR6cUGL
Tcy+KAezSgS2/PZ2SYKZ1UNyqxc20rYZjCqpaN6vaTqbTxtoyLs+GRvb+QZ9E8E3
V9BPK7LBoksCiE+bglAiX3e7AF/WaZm7xJe0dazBNXJHU/UOpCurlAsGKmi/hpN8
WFZPIkavPR4SgkeXUv9U53uaSqSqEg==
=P2ZC
-----END PGP SIGNATURE-----

--Sig_/nCM=dB/dX0wifWLX.Kzp7UJ--
