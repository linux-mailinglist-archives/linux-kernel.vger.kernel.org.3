Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9D94EA235
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 23:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiC1VEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 17:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiC1VEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 17:04:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7FF74DDD;
        Mon, 28 Mar 2022 14:02:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KS4sG5GK3z4xLS;
        Tue, 29 Mar 2022 08:02:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648501363;
        bh=yZhNu91Zd8diqqHoyabFv/F8VJ4qCrFzdnqAdDhFlqI=;
        h=Date:From:To:Cc:Subject:From;
        b=diOdb2EU12ZiBw8RS366UYgLY9qC9iJDN29EMYmFwuh0d3H6Vr5Zs+DqwPhsm2jit
         xzFpey+dCUgkJeWg3V4HlV2D2baY6jNPKUUwneGdXUJT/SiswxeokuxRh3mfbYbjNy
         6IYpNtLWHpZh0kAVV5tC9kp+hVfkV5zBSnA9PXAobniuxnQ5FIJanFHKorHxb1CN88
         BwaobhjpsQDVdhCLIA+Y9KaUEhMtFbDITsjkxRPBx2E3GQjkdWBieTGzNI3mZE7j3I
         YOkuz6RVhOaYUdyc2ESnKvXsCeid/2FgLNDkFCHCv/QK4Rx8pSNgzX28Mcszif+7zU
         //aST0vOb56dA==
Date:   Tue, 29 Mar 2022 08:02:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20220329080241.2f4f9fe1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iChPM7XBw2cL9ZXtR5jZfw_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iChPM7XBw2cL9ZXtR5jZfw_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  15583a563cd5 ("block: restore the old set_task_ioprio() behaviour wrt PF_=
EXITING")

Fixes tags

  Fixes: 5fc11eebb4 (block: open code create_task_io_context in set_task_io=
prio)
  Fixes: a957b61254 (block: fix error in handling dead task for ioprio sett=
ing)

have this problem:

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/iChPM7XBw2cL9ZXtR5jZfw_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJCInEACgkQAVBC80lX
0Gy7twgAhZRlvOZyFPpN1sEttl7CELzCdCNRlv2F3/kBW2E98n/wErCYOIG/NbyI
nWK8Ka/pA1h1hdyAjhOp1EdiyPWl/We7DuaSQ02ltPGdrKsU29SdkPpzM0Cmbhr9
ZExic7B2fUniIzsREiyMNSx8jNNLC+eh/Xzy7bOUlzoTm5aT/us8+ltF+jL5Ifl8
oeL8m7eTVuWjazDWkLD6rBr1u4aCr6FqEuYL8JdPjSXwtoofdcXgob8EQPc3VCvP
ppXC6SvoJrriGGYcRFRSTBxhagiwza07fo8F1Ho78nPHdV+oEtmo3OVMe6AcI0GL
rpa2BE15jgTZBEPHr/zQEOFuyOOjuA==
=TdZE
-----END PGP SIGNATURE-----

--Sig_/iChPM7XBw2cL9ZXtR5jZfw_--
