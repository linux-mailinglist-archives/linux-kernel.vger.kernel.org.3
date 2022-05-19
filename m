Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211B252E001
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiESWc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbiESWcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:32:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888B4B2278;
        Thu, 19 May 2022 15:32:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L44Nf37HFz4xDB;
        Fri, 20 May 2022 08:32:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652999538;
        bh=HsQ3C+KXpMZzUUB1bcGRf24npFJKXVif+oFEDfFYg/U=;
        h=Date:From:To:Cc:Subject:From;
        b=hhTX3+FNE9kINdQxIXA3nBvIDv8k6ROmGJXsPNRdnx3hMHmHqvDT9r/RFdE7+NR/h
         eYkH8mqvzPWsOVWcJVoJx+3Tk2/KPLW+lYdkvnRc4h0r93BebEyOvv4lT306KbNPTl
         pUfZW7Ehm7rZCZxAILZ9oJ2DaA+prhfmw/cvAlS9mAIGAPCI8JYcnk03sVir3B28/M
         2IAOIOHoIyIYkz1tJOHctMGCBP2nOb5bckcJDvxbcDNf0yXxSIoviESKr+NjISfld7
         UFGIo5RM8TQeQKJawFfpVSqPvHMW1w11wh3vwn+jKsNr5BiugEPtMPFsL5GVK4Vh3d
         URQ7bPHMwjYRA==
Date:   Fri, 20 May 2022 08:31:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the powerpc tree
Message-ID: <20220520083150.57e953fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ndsHKp=ZuOV6h9zKNpo9eGL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ndsHKp=ZuOV6h9zKNpo9eGL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  03a2e65f54b3 ("KVM: PPC: Book3S Nested: Use explicit 4096 LPID maximum")
  18827eeef022 ("KVM: PPC: Remove kvmppc_claim_lpid")

are missing a Signed-off-by from their authors.

The first is just "Signed-of-by" misspelling.  The second is missing.

--=20
Cheers,
Stephen Rothwell

--Sig_/ndsHKp=ZuOV6h9zKNpo9eGL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKGxVYACgkQAVBC80lX
0GyDoAf9E20H9DPEXMUmMGq6Fl+hHTneXt69+Z6XYed7k/bxZw87kUKvSB/91h1E
pYDW4UMClBEKDKp19992vnl47QyuyI75rSLqcLzBeiOi1zdQpXkpmBNJ4kJTmH4B
UEQrH/NycFvH6mFuHjGGaE5hfqc8ETFqfvekLlJPRrR1Ujl4oVC9ime2tknaJUA8
GLm0BHCcGU8pleu6jRg9kvikIJr/ivFADd0fIIX0yAZBWEflfaUFQUd53sdYYzyI
eedhkAGE7wrAz61cfPjMvgDFc1T42MQfjXUP7oEQ4b4SpgiPwpXd0XNSVBHZc/zq
4qgkWrwEkwhsA9FI5Ih//86jaF2R2w==
=q8SX
-----END PGP SIGNATURE-----

--Sig_/ndsHKp=ZuOV6h9zKNpo9eGL--
