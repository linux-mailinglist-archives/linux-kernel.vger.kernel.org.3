Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322114CB88B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiCCISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiCCISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:18:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42D5C34D;
        Thu,  3 Mar 2022 00:17:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K8P460kP7z4xdl;
        Thu,  3 Mar 2022 19:17:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646295463;
        bh=CPzmnLR+ho77uKWhDa8Y+eEe6N04grx16PnUHQlJvrs=;
        h=Date:From:To:Cc:Subject:From;
        b=q0LHXlNqsvbdzWe9vPg+d4bwteqv8ig69J0yGNuKSm9bXGRSf53/jyQo8HqrwqDls
         3gAMxZMkW9AZIvneMIShH+NqGOT+lFr+iwG5jt5YzLCz+5oEl+EilmmGPHsQxeAa+Q
         foDaJdbkJoPoIS3QpyE1F5GHO1PSAqOrCKQ3Q+ANgTD6U5iAxt6qobyVBcRvnjFxlC
         hHErlkNsGDJhU0HK0h1xOPvXFdF4iEYSPSteb1L6zhBIYNfN7uaO8TYvuhiHKdyCfp
         exAX5Z4tTt2rzxzCJ0g1gpNN+o1hFAA+spUrs4pHyv6Ph4TW+s98sy/5192OOUHolx
         6y7CbH0LS16DA==
Date:   Thu, 3 Mar 2022 19:17:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Alan Kao <alankao@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 asm-generic tree
Message-ID: <20220303191741.3055ac34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HLBxvijQmW7WCX/K3UnFyYe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HLBxvijQmW7WCX/K3UnFyYe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/nds32/mm/init.c

between commit:

  9f15ac318b83 ("nds32: Remove the architecture")

from the asm-generic tree and commit:

  311ca692496e ("mm: remove mmu_gathers storage from remaining architecture=
s")

from the akpm-current tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/HLBxvijQmW7WCX/K3UnFyYe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIgeaUACgkQAVBC80lX
0GyaxggAhcop8wjZXukrM3Q/Js1hZcLi8yhUYb4KyNq/nrTsa4EwCdXLYZgRl87b
frYT3Igr7q92DLW9SDdzXvGdCfW8Gl1jNEQUdEQ1JWNO2JRL50EaSv1M6lX54VRl
gM1hmCh4ljCwPV33E9YgceN4ufF1UpaCzSqHyDVrBfP61MMCuwTtPHdiGg27R65u
1TsjDnTCWhjp3WQPc1Qc10MBwiV5f8CKyM2XW51h41CzMakh7PPVN+YvDJhdJURG
ONnU4NlkVzafWk8jkh93MO3/ds6w5IFOXKNdjMJlLivYXd3fOW4IdR/h1lJAndgy
G3pvJjFeC1wDGttoPv6zluX0i0DhkA==
=U0YK
-----END PGP SIGNATURE-----

--Sig_/HLBxvijQmW7WCX/K3UnFyYe--
