Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA9451290B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbiD1BsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiD1BsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:48:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4779198F5C;
        Wed, 27 Apr 2022 18:44:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kpdhz1Z6Zz4xNl;
        Thu, 28 Apr 2022 11:44:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651110291;
        bh=HtXJIGyoTrKSKRAaPLhhcsMtrJTWRfbpZoCE6v8AEbg=;
        h=Date:From:To:Cc:Subject:From;
        b=Mv39L4HE6xHaDHu1iIOcaAJSCegNylaIPhOWOvUd8S9Uh5h5H4mSS8UeswUGAxvgj
         v7Mr7lrtpGSAndNWZWbi4q5LGpgYHmzyMfxSX8qXBz3dnATLHwM/s0oLnz7FkLI4SZ
         TBtXX/DeH1DtuvA4TILCxavSshRUQxe6/zpj333vLLWMjGBigxIPGaA38KFGxWF5mZ
         NMN4KOkRCf1D2i+4/26kVNrbrrR6lTe0AB8PFDVd4l2VGhR5aW/rjZWm2iAK0NSgVT
         ZqgRIFrRLw2/29wMiM1f697Whp+T/1BZwFjLZ3UXPyerEexMm+Qgkhi7QqVrOH9MOP
         x/60AVgarzB9g==
Date:   Thu, 28 Apr 2022 11:44:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20220428114449.4b2d2dd6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ne.rD_af4ZXlVFt5OYoEBKb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ne.rD_af4ZXlVFt5OYoEBKb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  57668f0a4cc4 ("raid5: introduce MD_BROKEN")

Fixes tag

  Fixes: fb73b357fb9 ("raid5: block failing device if raid will be failed")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/Ne.rD_af4ZXlVFt5OYoEBKb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJp8ZEACgkQAVBC80lX
0GwHeQgAoe5xbEsWz5sVl59f6z/hDkl7A+xF/HNm81EHFLPNrnb925Vw47nhgepD
XI5C0c/rdYAs2frnJv4vXQjqcPEQT1DKkm3Gl2BwHaEwLgXneCLylVkOJ0E3gfR7
TEd5gZmq2PXt+inUxH74CS9UqwGWbwHpx/WlpBUOOs57RUXTAHRia05RJ7mnGi7K
7boajEA6lP5AMdwaustU8r2SMieFKUvJd1DFhi2KIUQ/PMVxheGGguwMQAfcAUyK
pNfvpTGX/+fNKSNagtPXWBA+i6l6N1yXAPU90ENx4KiWsvypDhd5TXTx14E4Sc6K
YVlZMKe/RFwNRna3b4Rl2Mgdj2ZtmA==
=GV7/
-----END PGP SIGNATURE-----

--Sig_/Ne.rD_af4ZXlVFt5OYoEBKb--
